import boto3
import json
from abc import ABC, abstractmethod
from datetime import datetime, timezone
from typing import Dict, List, Optional, Union, Any
from dataclasses import dataclass
from enum import Enum
import time


class LogLevel(Enum):
    """Log levels for filtering"""

    ERROR = "ERROR"
    WARN = "WARN"
    INFO = "INFO"
    DEBUG = "DEBUG"
    TRACE = "TRACE"


@dataclass
class LogEntry:
    """Represents a single log entry"""

    timestamp: datetime
    message: str
    level: Optional[str] = None
    request_id: Optional[str] = None
    source: Optional[str] = None
    metadata: Optional[Dict[str, Any]] = None


@dataclass
class LogFilter:
    """Filter criteria for log retrieval"""

    start_time: Optional[datetime] = None
    end_time: Optional[datetime] = None
    log_level: Optional[LogLevel] = None
    filter_pattern: Optional[str] = None
    limit: Optional[int] = None


class AWSLogsException(Exception):
    """Custom exception for AWS logs operations"""

    pass


class BaseLogExtractor(ABC):
    """Abstract base class for AWS log extractors"""

    def __init__(self, region_name: str = "us-east-1", profile_name: Optional[str] = None):
        """
        Initialize the base log extractor

        Args:
            region_name: AWS region name
            profile_name: AWS profile name (optional)
        """
        self.region_name = region_name
        self.profile_name = profile_name
        self._session = self._create_session()
        self._logs_client = self._session.client("logs")

    def _create_session(self) -> boto3.Session:
        """Create boto3 session"""
        if self.profile_name:
            return boto3.Session(profile_name=self.profile_name, region_name=self.region_name)
        return boto3.Session(region_name=self.region_name)

    @abstractmethod
    def get_log_group_name(self, **kwargs) -> str:
        """Get the CloudWatch log group name"""
        pass

    @abstractmethod
    def get_log_stream_names(self, log_group_name: str, **kwargs) -> List[str]:
        """Get log stream names for the given log group"""
        pass

    def _convert_to_milliseconds(self, dt: datetime) -> int:
        """Convert datetime to milliseconds since epoch"""
        return int(dt.timestamp() * 1000)

    def _parse_log_event(self, event: Dict[str, Any], source: str) -> LogEntry:
        """Parse a CloudWatch log event into LogEntry"""
        timestamp = datetime.fromtimestamp(event["timestamp"] / 1000, tz=timezone.utc)
        message = event["message"]

        # Extract log level from message if possible
        level = None
        for log_level in LogLevel:
            if log_level.value in message:
                level = log_level.value
                break

        return LogEntry(
            timestamp=timestamp,
            message=message,
            level=level,
            source=source,
            metadata={"ingestionTime": event.get("ingestionTime")},
        )

    def get_logs(self, log_filter: LogFilter, **kwargs) -> List[LogEntry]:
        """
        Get logs based on filter criteria

        Args:
            log_filter: LogFilter object with filter criteria
            **kwargs: Additional service-specific parameters

        Returns:
            List of LogEntry objects
        """
        try:
            log_group_name = self.get_log_group_name(**kwargs)
            log_stream_names = self.get_log_stream_names(log_group_name, **kwargs)

            if not log_stream_names:
                return []

            return self._fetch_logs(log_group_name, log_stream_names, log_filter)

        except Exception as e:
            raise AWSLogsException(f"Failed to retrieve logs: {str(e)}")

    def _fetch_logs(self, log_group_name: str, log_stream_names: List[str], log_filter: LogFilter) -> List[LogEntry]:
        """Fetch logs from CloudWatch"""
        logs = []

        filter_params = {
            "logGroupName": log_group_name,
            "logStreamNames": log_stream_names,
        }

        # Add time range filters
        if log_filter.start_time:
            filter_params["startTime"] = self._convert_to_milliseconds(log_filter.start_time)

        if log_filter.end_time:
            filter_params["endTime"] = self._convert_to_milliseconds(log_filter.end_time)

        # Add filter pattern
        if log_filter.filter_pattern:
            filter_params["filterPattern"] = log_filter.filter_pattern

        # Add limit
        if log_filter.limit:
            filter_params["limit"] = log_filter.limit

        try:
            paginator = self._logs_client.get_paginator("filter_log_events")

            for page in paginator.paginate(**filter_params):
                for event in page.get("events", []):
                    log_entry = self._parse_log_event(event, self.__class__.__name__)

                    # Apply log level filter
                    if (
                        log_filter.log_level
                        and log_entry.level != log_filter.log_level.value
                    ):
                        continue

                    logs.append(log_entry)

            return sorted(logs, key=lambda x: x.timestamp)

        except Exception as e:
            raise AWSLogsException(f"Failed to fetch logs from CloudWatch: {str(e)}")


class GlueJobLogExtractor(BaseLogExtractor):
    """Log extractor for AWS Glue Jobs"""

    def __init__(self, region_name: str = "us-east-1", profile_name: Optional[str] = None):
        super().__init__(region_name, profile_name)
        self._glue_client = self._session.client("glue")

    def get_log_group_name(self, job_name: str, **kwargs) -> str:
        """Get CloudWatch log group name for Glue job"""
        return f"/aws-glue/jobs/{job_name}"

    def get_log_stream_names(self,log_group_name: str,job_name: str,job_run_id: Optional[str] = None,**kwargs) -> List[str]:
        """Get log stream names for Glue job"""
        try:
            if job_run_id:
                # Get specific job run log streams
                return self._get_job_run_log_streams(log_group_name, job_run_id)
            else:
                # Get all log streams for the job
                return self._get_all_job_log_streams(log_group_name)

        except Exception as e:
            raise AWSLogsException(f"Failed to get Glue job log streams: {str(e)}")

    def _get_job_run_log_streams(self, log_group_name: str, job_run_id: str) -> List[str]:
        """Get log streams for a specific job run"""
        log_streams = []

        try:
            paginator = self._logs_client.get_paginator("describe_log_streams")

            for page in paginator.paginate(logGroupName=log_group_name, logStreamNamePrefix=job_run_id):
                for stream in page.get("logStreams", []):
                    log_streams.append(stream["logStreamName"])

            return log_streams

        except self._logs_client.exceptions.ResourceNotFoundException:
            return []

    def _get_all_job_log_streams(self, log_group_name: str) -> List[str]:
        """Get all log streams for the job"""
        log_streams = []

        try:
            paginator = self._logs_client.get_paginator("describe_log_streams")

            for page in paginator.paginate(logGroupName=log_group_name, orderBy="LastEventTime", descending=True):
                for stream in page.get("logStreams", []):
                    log_streams.append(stream["logStreamName"])

            return log_streams

        except self._logs_client.exceptions.ResourceNotFoundException:
            return []

    def get_job_runs(self, job_name: str, max_results: int = 50) -> List[Dict[str, Any]]:
        """Get job runs for a Glue job"""
        try:
            response = self._glue_client.get_job_runs(
                JobName=job_name, MaxResults=max_results
            )
            return response.get("JobRuns", [])

        except Exception as e:
            raise AWSLogsException(f"Failed to get Glue job runs: {str(e)}")

    def get_logs_by_job_run_id(self, job_name: str, job_run_id: str, log_filter: Optional[LogFilter] = None) -> List[LogEntry]:
        """Get logs for a specific Glue job run"""
        if log_filter is None:
            log_filter = LogFilter()

        return self.get_logs(log_filter, job_name=job_name, job_run_id=job_run_id)

    def get_logs_by_time_range(self,job_name: str,start_time: datetime,end_time: datetime,log_filter: Optional[LogFilter] = None) -> List[LogEntry]:
        """Get logs for a Glue job within a time range"""
        if log_filter is None:
            log_filter = LogFilter()

        log_filter.start_time = start_time
        log_filter.end_time = end_time

        return self.get_logs(log_filter, job_name=job_name)


class LambdaLogExtractor(BaseLogExtractor):
    """Log extractor for AWS Lambda Functions"""

    def __init__(self, region_name: str = "us-east-1", profile_name: Optional[str] = None):
        super().__init__(region_name, profile_name)
        self._lambda_client = self._session.client("lambda")

    def get_log_group_name(self, function_name: str, **kwargs) -> str:
        """Get CloudWatch log group name for Lambda function"""
        return f"/aws/lambda/{function_name}"

    def get_log_stream_names(self,log_group_name: str,function_name: str,request_id: Optional[str] = None,**kwargs) -> List[str]:
        """Get log stream names for Lambda function"""
        try:
            if request_id:
                # Get specific request log streams
                return self._get_request_log_streams(log_group_name, request_id)
            else:
                # Get recent log streams
                return self._get_recent_log_streams(log_group_name)

        except Exception as e:
            raise AWSLogsException(f"Failed to get Lambda log streams: {str(e)}")

    def _get_request_log_streams(self, log_group_name: str, request_id: str) -> List[str]:
        """Get log streams for a specific request ID"""
        log_streams = []

        try:
            paginator = self._logs_client.get_paginator("describe_log_streams")

            for page in paginator.paginate(logGroupName=log_group_name):
                for stream in page.get("logStreams", []):
                    # Lambda log streams typically contain the request ID
                    if request_id in stream["logStreamName"]:
                        log_streams.append(stream["logStreamName"])

            return log_streams

        except self._logs_client.exceptions.ResourceNotFoundException:
            return []

    def _get_recent_log_streams(self, log_group_name: str, limit: int = 50) -> List[str]:
        """Get recent log streams for the function"""
        log_streams = []

        try:
            response = self._logs_client.describe_log_streams(
                logGroupName=log_group_name,
                orderBy="LastEventTime",
                descending=True,
                limit=limit,
            )

            for stream in response.get("logStreams", []):
                log_streams.append(stream["logStreamName"])

            return log_streams

        except self._logs_client.exceptions.ResourceNotFoundException:
            return []

    def get_function_info(self, function_name: str) -> Dict[str, Any]:
        """Get Lambda function information"""
        try:
            response = self._lambda_client.get_function(FunctionName=function_name)
            return response

        except Exception as e:
            raise AWSLogsException(f"Failed to get Lambda function info: {str(e)}")

    def get_logs_by_request_id(self,function_name: str,request_id: str,log_filter: Optional[LogFilter] = None) -> List[LogEntry]:
        """Get logs for a specific Lambda request"""
        if log_filter is None:
            log_filter = LogFilter()

        return self.get_logs(log_filter, function_name=function_name, request_id=request_id)

    def get_logs_by_time_range(self,function_name: str,start_time: datetime,end_time: datetime,log_filter: Optional[LogFilter] = None) -> List[LogEntry]:
        """Get logs for a Lambda function within a time range"""
        if log_filter is None:
            log_filter = LogFilter()

        log_filter.start_time = start_time
        log_filter.end_time = end_time

        return self.get_logs(log_filter, function_name=function_name)

    def get_logs_by_strem_limit(self,function_name: str,stream_limit=1,log_filter: Optional[LogFilter] = None) -> List[LogEntry]:
        """Get logs for specified number of latest log stream of the Lambda function. 
        By default it returns the most recent log stream.
        """

        if log_filter is None:
            log_filter = LogFilter()

        log_filter.limit = stream_limit

        return self.get_logs(log_filter, function_name=function_name)


class LogManager:
    """Manager class to handle multiple log extractors"""

    def __init__(
        self, region_name: str = "us-east-1", profile_name: Optional[str] = None
    ):
        self.region_name = region_name
        self.profile_name = profile_name
        self._extractors = {}

    def get_glue_extractor(self) -> GlueJobLogExtractor:
        """Get or create Glue log extractor"""
        if "glue" not in self._extractors:
            self._extractors["glue"] = GlueJobLogExtractor(self.region_name, self.profile_name)
        return self._extractors["glue"]

    def get_lambda_extractor(self) -> LambdaLogExtractor:
        """Get or create Lambda log extractor"""
        if "lambda" not in self._extractors:
            self._extractors["lambda"] = LambdaLogExtractor(self.region_name, self.profile_name)
        return self._extractors["lambda"]

    def register_extractor(self, name: str, extractor: BaseLogExtractor):
        """Register a custom log extractor"""
        self._extractors[name] = extractor

    def get_extractor(self, name: str) -> BaseLogExtractor:
        """Get a registered extractor by name"""
        if name not in self._extractors:
            raise AWSLogsException(f"Extractor '{name}' not found")
        return self._extractors[name]


# Usage Examples
if __name__ == "__main__":
    # Example usage

    # Initialize log manager
    log_manager = LogManager(region_name="us-east-1")

    # Get Glue logs by job run ID
    glue_extractor = log_manager.get_glue_extractor()

    # Example 1: Get logs for specific Glue job run
    job_name = "my-etl-job"
    job_run_id = "jr_123456789"

    glue_logs = glue_extractor.get_logs_by_job_run_id(
        job_name=job_name,
        job_run_id=job_run_id,
        log_filter=LogFilter(log_level=LogLevel.ERROR),
    )

    # Example 2: Get Glue logs by time range
    from datetime import timedelta

    end_time = datetime.now(timezone.utc)
    start_time = end_time - timedelta(hours=24)

    glue_logs_time_range = glue_extractor.get_logs_by_time_range(
        job_name=job_name,
        start_time=start_time,
        end_time=end_time,
        log_filter=LogFilter(limit=1000),
    )

    # Example 3: Get Lambda logs
    lambda_extractor = log_manager.get_lambda_extractor()

    function_name = "my-lambda-function"
    lambda_logs = lambda_extractor.get_logs_by_time_range(
        function_name=function_name,
        start_time=start_time,
        end_time=end_time,
        log_filter=LogFilter(filter_pattern="ERROR"),
    )

    # Print results
    for log in glue_logs[:5]:  # Print first 5 logs
        print(f"{log.timestamp}: {log.level} - {log.message}")
