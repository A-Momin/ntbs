# Databricks Interview Cheatsheet

## Table of Contents

1. [Core Concepts](#core-concepts)
2. [Architecture & Components](#architecture--components)
3. [Delta Lake Deep Dive](#delta-lake-deep-dive)
4. [Spark on Databricks](#spark-on-databricks)
5. [MLflow & Machine Learning](#mlflow--machine-learning)
6. [Unity Catalog & Governance](#unity-catalog--governance)
7. [Performance Optimization](#performance-optimization)
8. [Security & Access Control](#security--access-control)
9. [Data Engineering Patterns](#data-engineering-patterns)
10. [Monitoring & Troubleshooting](#monitoring--troubleshooting)
11. [Common Interview Questions](#common-interview-questions)

---

## Core Concepts

#### **What is Databricks?**

-   **Unified Analytics Platform** combining data engineering, data science, and machine learning
-   **Cloud-native** platform built on Apache Spark
-   **Collaborative environment** for data teams
-   **Lakehouse architecture** combining data lakes and data warehouses
-   **Multi-cloud support** (AWS, Azure, GCP)

#### **Key Value Propositions**

-   **Unified Platform**: Single environment for all data workloads
-   **Performance**: Optimized Spark runtime (Photon engine)
-   **Collaboration**: Real-time notebook sharing and version control
-   **Scalability**: Auto-scaling clusters and serverless compute
-   **Integration**: Native cloud service integrations

#### **Databricks vs Alternatives**

| Feature           | Databricks    | AWS EMR        | Snowflake     | Synapse            |
| ----------------- | ------------- | -------------- | ------------- | ------------------ |
| **Management**    | Fully managed | Semi-managed   | Fully managed | Fully managed      |
| **Compute**       | Spark-based   | Multi-engine   | SQL-based     | Multi-engine       |
| **Storage**       | Delta Lake    | HDFS/S3        | Proprietary   | Data Lake/SQL Pool |
| **ML Support**    | Native MLflow | External tools | Limited       | Azure ML           |
| **Collaboration** | Built-in      | Limited        | Limited       | Built-in           |

---

## Architecture & Components

#### **Databricks Architecture**

```
Control Plane (Databricks Managed)
├── Web Application
├── Cluster Manager
├── Jobs Scheduler
├── Notebook Server
└── Security & Governance

Data Plane (Customer Cloud Account)
├── Compute Clusters
├── Storage (Delta Lake)
├── Network (VPC/VNet)
└── Security Groups
```

#### **Core Components**

**1. Workspaces**

```python
# Workspace organization
Workspace/
├── Users/
│   ├── user1@company.com/
│   └── user2@company.com/
├── Shared/
│   ├── ETL Pipelines/
│   ├── ML Models/
│   └── Data Analysis/
└── Repos/
    ├── data-engineering-repo/
    └── ml-experiments-repo/
```

**2. Clusters**

```python
# Cluster types and configuration
cluster_config = {
    "cluster_name": "analytics-cluster",
    "spark_version": "11.3.x-scala2.12",
    "node_type_id": "i3.xlarge",
    "num_workers": 2,
    "autoscale": {
        "min_workers": 1,
        "max_workers": 8
    },
    "auto_termination_minutes": 120,
    "enable_elastic_disk": True
}
```

**3. Notebooks**

```python
# Multi-language notebook example
# Python cell
df = spark.read.format("delta").load("/path/to/table")
display(df)

# SQL cell
%sql
SELECT customer_id, SUM(amount) as total
FROM sales
GROUP BY customer_id

# Scala cell
%scala
val df = spark.read.format("delta").load("/path/to/table")
df.show()

# R cell
%r
library(SparkR)
df <- read.df("/path/to/table", source = "delta")
```

**4. Jobs & Workflows**

```json
{
    "name": "ETL Pipeline",
    "tasks": [
        {
            "task_key": "extract",
            "notebook_task": {
                "notebook_path": "/Shared/ETL/extract"
            }
        },
        {
            "task_key": "transform",
            "notebook_task": {
                "notebook_path": "/Shared/ETL/transform"
            },
            "depends_on": [{ "task_key": "extract" }]
        },
        {
            "task_key": "load",
            "notebook_task": {
                "notebook_path": "/Shared/ETL/load"
            },
            "depends_on": [{ "task_key": "transform" }]
        }
    ],
    "schedule": {
        "quartz_cron_expression": "0 0 2 * * ?",
        "timezone_id": "UTC"
    }
}
```

---

## Delta Lake Deep Dive

#### **What is Delta Lake?**

-   **Open-source storage layer** that brings ACID transactions to data lakes
-   **Built on Parquet** with additional metadata layer
-   **Schema enforcement** and evolution capabilities
-   **Time travel** for data versioning
-   **Unified batch and streaming** processing

#### **Key Features**

```python
# ACID Transactions
df.write.format("delta").mode("overwrite").save("/path/to/table")

# Time Travel
# Read data as of specific version
df_v1 = spark.read.format("delta").option("versionAsOf", 1).load("/path/to/table")

# Read data as of specific timestamp
df_yesterday = spark.read.format("delta").option("timestampAsOf", "2023-12-01").load("/path/to/table")

# Schema Evolution
df_new_schema.write.format("delta").mode("append").option("mergeSchema", "true").save("/path/to/table")

# Optimize and Z-Order
spark.sql("OPTIMIZE table_name ZORDER BY (column1, column2)")

# Vacuum old files
spark.sql("VACUUM table_name RETAIN 168 HOURS")  # 7 days
```

#### **Delta Lake Operations**

```python
# MERGE (UPSERT) Operation
from delta.tables import DeltaTable

delta_table = DeltaTable.forPath(spark, "/path/to/table")

delta_table.alias("target").merge(
    source_df.alias("source"),
    "target.id = source.id"
).whenMatchedUpdate(set={
    "name": "source.name",
    "updated_at": "current_timestamp()"
}).whenNotMatchedInsert(values={
    "id": "source.id",
    "name": "source.name",
    "created_at": "current_timestamp()"
}).execute()

# DELETE Operation
delta_table.delete("age < 18")

# UPDATE Operation
delta_table.update(
    condition="category = 'electronics'",
    set={"discount": "0.1"}
)
```

#### **Delta Lake Optimization**

```python
# Auto Optimize
spark.sql("""
    ALTER TABLE my_table SET TBLPROPERTIES (
        'delta.autoOptimize.optimizeWrite' = 'true',
        'delta.autoOptimize.autoCompact' = 'true'
    )
""")

# Liquid Clustering (Preview)
spark.sql("""
    CREATE TABLE clustered_table (
        id BIGINT,
        category STRING,
        date DATE
    ) USING DELTA
    CLUSTER BY (category, date)
""")

# Change Data Feed
spark.sql("""
    ALTER TABLE my_table SET TBLPROPERTIES (
        'delta.enableChangeDataFeed' = 'true'
    )
""")

# Read change data
changes_df = spark.read.format("delta").option("readChangeFeed", "true").option("startingVersion", 1).table("my_table")
```

---

## Spark on Databricks

#### **Databricks Runtime Optimizations**

-   **Photon Engine**: Vectorized query engine for faster SQL queries
-   **Adaptive Query Execution (AQE)**: Dynamic optimization during execution
-   **Auto Loader**: Incremental data ingestion from cloud storage
-   **Delta Engine**: Optimizations for Delta Lake operations

#### **Performance Features**

```python
# Photon Engine (automatically enabled for SQL warehouses)
spark.conf.set("spark.databricks.photon.enabled", "true")

# Adaptive Query Execution
spark.conf.set("spark.sql.adaptive.enabled", "true")
spark.conf.set("spark.sql.adaptive.coalescePartitions.enabled", "true")
spark.conf.set("spark.sql.adaptive.skewJoin.enabled", "true")

# Auto Loader for incremental processing
df = spark.readStream.format("cloudFiles") \
    .option("cloudFiles.format", "json") \
    .option("cloudFiles.schemaLocation", "/path/to/schema") \
    .load("/path/to/source")

df.writeStream \
    .format("delta") \
    .option("checkpointLocation", "/path/to/checkpoint") \
    .start("/path/to/destination")
```

#### **Cluster Configuration Best Practices**

```python
# Cluster configuration for different workloads

# Data Engineering Cluster
data_eng_config = {
    "node_type_id": "i3.xlarge",  # Storage optimized
    "driver_node_type_id": "i3.xlarge",
    "num_workers": 4,
    "spark_conf": {
        "spark.sql.adaptive.enabled": "true",
        "spark.sql.adaptive.coalescePartitions.enabled": "true"
    }
}

# Machine Learning Cluster
ml_config = {
    "node_type_id": "r5.2xlarge",  # Memory optimized
    "driver_node_type_id": "r5.2xlarge",
    "num_workers": 2,
    "spark_conf": {
        "spark.sql.execution.arrow.pyspark.enabled": "true"
    }
}

# Streaming Cluster
streaming_config = {
    "node_type_id": "r5.large",
    "autoscale": {
        "min_workers": 1,
        "max_workers": 10
    },
    "spark_conf": {
        "spark.streaming.backpressure.enabled": "true"
    }
}
```

---

## MLflow & Machine Learning

#### **MLflow Components**

-   **Tracking**: Log parameters, metrics, and artifacts
-   **Projects**: Package ML code for reproducibility
-   **Models**: Deploy models to various platforms
-   **Registry**: Centralized model store with versioning

#### **MLflow Tracking**

```python
import mlflow
import mlflow.sklearn
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# Start MLflow run
with mlflow.start_run():
    # Log parameters
    n_estimators = 100
    mlflow.log_param("n_estimators", n_estimators)

    # Train model
    model = RandomForestClassifier(n_estimators=n_estimators)
    model.fit(X_train, y_train)

    # Make predictions and log metrics
    predictions = model.predict(X_test)
    accuracy = accuracy_score(y_test, predictions)
    mlflow.log_metric("accuracy", accuracy)

    # Log model
    mlflow.sklearn.log_model(model, "random_forest_model")

    # Log artifacts
    mlflow.log_artifact("feature_importance.png")
```

#### **MLflow Model Registry**

```python
# Register model
model_uri = "runs:/{}/random_forest_model".format(run_id)
model_details = mlflow.register_model(model_uri, "customer_churn_model")

# Transition model stage
client = mlflow.tracking.MlflowClient()
client.transition_model_version_stage(
    name="customer_churn_model",
    version=1,
    stage="Production"
)

# Load model for inference
model = mlflow.pyfunc.load_model("models:/customer_churn_model/Production")
predictions = model.predict(new_data)
```

#### **Databricks AutoML**

```python
from databricks import automl

# Run AutoML experiment
summary = automl.classify(
    dataset=training_df,
    target_col="churn",
    primary_metric="f1",
    timeout_minutes=30,
    max_trials=20
)

# Get best model
best_model = summary.best_trial.load_model()

# Register best model
mlflow.register_model(
    model_uri=summary.best_trial.model_path,
    name="automl_churn_model"
)
```

#### **Feature Store**

```python
from databricks.feature_store import FeatureStoreClient

fs = FeatureStoreClient()

# Create feature table
fs.create_table(
    name="customer_features",
    primary_keys=["customer_id"],
    df=features_df,
    description="Customer demographic and behavioral features"
)

# Create training dataset
training_set = fs.create_training_set(
    df=labels_df,
    feature_lookups=[
        FeatureLookup(
            table_name="customer_features",
            lookup_key="customer_id"
        )
    ],
    label="churn",
    exclude_columns=["customer_id"]
)

training_df = training_set.load_df()
```

---

## Unity Catalog & Governance

#### **Unity Catalog Hierarchy**

```
Metastore
├── Catalog (e.g., production)
│   ├── Schema (e.g., sales)
│   │   ├── Tables
│   │   ├── Views
│   │   └── Functions
│   └── Schema (e.g., marketing)
└── Catalog (e.g., development)
```

#### **Unity Catalog Operations**

```sql
-- Create catalog
CREATE CATALOG IF NOT EXISTS production;

-- Create schema
CREATE SCHEMA IF NOT EXISTS production.sales;

-- Create managed table
CREATE TABLE production.sales.customers (
    customer_id BIGINT,
    name STRING,
    email STRING,
    created_at TIMESTAMP
) USING DELTA;

-- Create external table
CREATE TABLE production.sales.external_data (
    id BIGINT,
    value STRING
) USING DELTA
LOCATION 's3://my-bucket/external-data/';

-- Grant permissions
GRANT SELECT ON TABLE production.sales.customers TO `data-analysts`;
GRANT USE CATALOG ON CATALOG production TO `data-team`;
GRANT USE SCHEMA ON SCHEMA production.sales TO `sales-team`;
```

#### **Data Lineage & Discovery**

```python
# Data lineage is automatically tracked
# View in Databricks UI: Data Explorer -> Table -> Lineage tab

# Search for data assets
# Use Data Explorer search functionality
# Search by table name, column name, or description

# Tag data assets
spark.sql("""
    ALTER TABLE production.sales.customers
    SET TAGS ('PII' = 'true', 'Department' = 'Sales')
""")
```

#### **Row-Level Security**

```sql
-- Create row filter function
CREATE FUNCTION production.sales.customer_filter(region STRING)
RETURNS BOOLEAN
RETURN region = current_user();

-- Apply row filter to table
ALTER TABLE production.sales.customers
SET ROW FILTER production.sales.customer_filter ON (region);
```

#### **Column-Level Security**

```sql
-- Create column mask function
CREATE FUNCTION production.sales.mask_email(email STRING)
RETURNS STRING
RETURN CASE
    WHEN is_member('sensitive-data-readers') THEN email
    ELSE 'REDACTED'
END;

-- Apply column mask
ALTER TABLE production.sales.customers
ALTER COLUMN email SET MASK production.sales.mask_email;
```

---

## Performance Optimization

#### **Query Optimization Techniques**

```python
# 1. Use appropriate file formats
# Parquet for analytics, Delta for transactional workloads
df.write.format("delta").save("/path/to/optimized")

# 2. Partition data appropriately
df.write.format("delta").partitionBy("year", "month").save("/path/to/partitioned")

# 3. Use Z-ordering for better data skipping
spark.sql("OPTIMIZE table_name ZORDER BY (frequently_filtered_column)")

# 4. Cache frequently accessed data
df.cache()
df.count()  # Trigger caching

# 5. Use broadcast joins for small tables
from pyspark.sql.functions import broadcast
large_df.join(broadcast(small_df), "key")

# 6. Optimize Spark configurations
spark.conf.set("spark.sql.adaptive.enabled", "true")
spark.conf.set("spark.sql.adaptive.coalescePartitions.enabled", "true")
spark.conf.set("spark.sql.adaptive.skewJoin.enabled", "true")
```

#### **Cluster Optimization**

```python
# Auto-scaling configuration
autoscale_config = {
    "min_workers": 2,
    "max_workers": 20,
    "target_workers": 4
}

# Instance type selection
# Compute optimized: C5 instances for CPU-intensive workloads
# Memory optimized: R5 instances for memory-intensive workloads
# Storage optimized: I3 instances for I/O-intensive workloads
# GPU instances: P3/P4 for ML workloads

# Spot instances for cost optimization
spot_config = {
    "availability": "SPOT_WITH_FALLBACK",
    "max_spot_price": 0.50
}
```

#### **Storage Optimization**

```python
# Optimize table layout
spark.sql("OPTIMIZE table_name")

# Vacuum old files
spark.sql("VACUUM table_name RETAIN 168 HOURS")

# Analyze table statistics
spark.sql("ANALYZE TABLE table_name COMPUTE STATISTICS")

# Use appropriate data types
# Use appropriate precision for decimals
# Use date/timestamp instead of strings for dates
# Use appropriate string lengths
```

---

## Security & Access Control

#### **Authentication & Authorization**

```python
# Single Sign-On (SSO) integration
# SCIM provisioning for user management
# Service principals for automation

# Token-based authentication
token = dbutils.secrets.get(scope="databricks", key="access-token")

# OAuth integration
# Azure AD, AWS IAM, Google Cloud Identity
```

#### **Network Security**

```python
# VPC/VNet configuration
vpc_config = {
    "vpc_id": "vpc-12345678",
    "subnet_ids": ["subnet-12345678", "subnet-87654321"],
    "security_group_ids": ["sg-12345678"]
}

# Private endpoints
# AWS PrivateLink, Azure Private Link, Google Private Service Connect

# IP access lists
ip_access_list = [
    "192.168.1.0/24",  # Office network
    "10.0.0.0/8"       # VPN network
]
```

#### **Data Encryption**

```python
# Encryption at rest
# Customer-managed keys (CMK)
# Databricks-managed keys

# Encryption in transit
# TLS 1.2+ for all communications
# Certificate-based authentication

# Secrets management
password = dbutils.secrets.get(scope="database", key="password")
api_key = dbutils.secrets.get(scope="external-api", key="api-key")
```

#### **Audit Logging**

```python
# Audit logs capture:
# - User authentication events
# - Cluster creation/termination
# - Job execution
# - Data access patterns
# - Permission changes

# Export audit logs
# CloudTrail (AWS), Activity Log (Azure), Cloud Audit Logs (GCP)
```

---

## Data Engineering Patterns

#### **Medallion Architecture**

```python
# Bronze Layer (Raw Data)
bronze_df = spark.read.format("json").load("/raw/events/")
bronze_df.write.format("delta").mode("append").save("/bronze/events")

# Silver Layer (Cleaned Data)
silver_df = bronze_df.filter(col("event_type").isNotNull()) \
    .withColumn("processed_timestamp", current_timestamp()) \
    .dropDuplicates(["event_id"])

silver_df.write.format("delta").mode("append").save("/silver/events")

# Gold Layer (Business Logic)
gold_df = silver_df.groupBy("user_id", "event_date") \
    .agg(
        count("*").alias("event_count"),
        countDistinct("session_id").alias("session_count")
    )

gold_df.write.format("delta").mode("overwrite").save("/gold/user_daily_metrics")
```

#### **Streaming Patterns**

```python
# Auto Loader for incremental ingestion
stream_df = spark.readStream.format("cloudFiles") \
    .option("cloudFiles.format", "json") \
    .option("cloudFiles.schemaLocation", "/schemas/events") \
    .option("cloudFiles.inferColumnTypes", "true") \
    .load("/landing/events/")

# Structured streaming with Delta
query = stream_df.writeStream \
    .format("delta") \
    .outputMode("append") \
    .option("checkpointLocation", "/checkpoints/events") \
    .trigger(processingTime="1 minute") \
    .start("/bronze/events")

# Stream-stream joins
impressions = spark.readStream.format("delta").table("impressions")
clicks = spark.readStream.format("delta").table("clicks")

joined = impressions.join(
    clicks,
    expr("""
        impressions.ad_id = clicks.ad_id AND
        clicks.timestamp >= impressions.timestamp AND
        clicks.timestamp <= impressions.timestamp + interval 1 hour
    """)
)
```

#### **Change Data Capture (CDC)**

```python
# Enable Change Data Feed
spark.sql("""
    ALTER TABLE source_table SET TBLPROPERTIES (
        'delta.enableChangeDataFeed' = 'true'
    )
""")

# Read changes
changes_df = spark.readStream \
    .format("delta") \
    .option("readChangeFeed", "true") \
    .option("startingVersion", "latest") \
    .table("source_table")

# Process changes
def process_changes(batch_df, batch_id):
    # Handle inserts
    inserts = batch_df.filter(col("_change_type") == "insert")

    # Handle updates
    updates = batch_df.filter(col("_change_type") == "update_postimage")

    # Handle deletes
    deletes = batch_df.filter(col("_change_type") == "delete")

    # Apply changes to target system
    # ...

changes_df.writeStream \
    .foreachBatch(process_changes) \
    .start()
```

---

## Monitoring & Troubleshooting

#### **Cluster Monitoring**

```python
# Cluster metrics available in Databricks UI
# - CPU utilization
# - Memory usage
# - Disk I/O
# - Network I/O
# - Spark UI integration

# Custom metrics
import time
start_time = time.time()

# Your processing code here
df.count()

end_time = time.time()
processing_time = end_time - start_time
print(f"Processing time: {processing_time} seconds")
```

#### **Job Monitoring**

```python
# Job run monitoring
from databricks_cli.jobs.api import JobsApi
from databricks_cli.sdk.api_client import ApiClient

api_client = ApiClient(host="https://your-workspace.cloud.databricks.com", token=token)
jobs_api = JobsApi(api_client)

# Get job runs
runs = jobs_api.list_runs(job_id=123, limit=10)

# Monitor job status
for run in runs['runs']:
    print(f"Run {run['run_id']}: {run['state']['life_cycle_state']}")
```

#### **Performance Troubleshooting**

```python
# Common performance issues and solutions

# 1. Small files problem
# Solution: Use OPTIMIZE command
spark.sql("OPTIMIZE table_name")

# 2. Data skew
# Solution: Use salting or repartitioning
df.repartition(col("skewed_column"))

# 3. Inefficient joins
# Solution: Use broadcast joins for small tables
large_df.join(broadcast(small_df), "key")

# 4. Memory issues
# Solution: Increase driver/executor memory or use disk-based operations
spark.conf.set("spark.sql.adaptive.enabled", "true")

# 5. Slow queries
# Solution: Use Photon engine and optimize data layout
spark.conf.set("spark.databricks.photon.enabled", "true")
```

#### **Error Handling Patterns**

```python
# Robust error handling in notebooks
try:
    # Data processing logic
    result_df = spark.sql("SELECT * FROM complex_query")
    result_df.write.format("delta").mode("overwrite").save("/output/path")

    # Log success
    dbutils.notebook.exit(json.dumps({
        "status": "success",
        "rows_processed": result_df.count(),
        "timestamp": str(datetime.now())
    }))

except Exception as e:
    # Log error details
    error_details = {
        "status": "error",
        "error_message": str(e),
        "error_type": type(e).__name__,
        "timestamp": str(datetime.now())
    }

    # Send notification (email, Slack, etc.)
    # ...

    dbutils.notebook.exit(json.dumps(error_details))
```

---

## Common Interview Questions

#### **Architecture Questions**

**Q: Explain Databricks architecture and how it differs from traditional Spark deployments.**
**A:** Databricks uses a **control plane/data plane architecture**:

-   **Control Plane**: Managed by Databricks (web UI, cluster manager, job scheduler)
-   **Data Plane**: Runs in customer's cloud account (compute clusters, storage)
-   **Key differences**: Fully managed service, optimized Spark runtime, collaborative features, integrated security

**Q: What is the Lakehouse architecture and how does Databricks implement it?**
**A:** Lakehouse combines **data lake flexibility** with **data warehouse performance**:

-   **Storage**: Delta Lake provides ACID transactions on data lakes
-   **Compute**: Optimized Spark runtime with Photon engine
-   **Governance**: Unity Catalog for centralized metadata and security
-   **Benefits**: Single platform for all data workloads, cost-effective, scalable

**Q: How does Delta Lake differ from traditional data lakes?**
**A:** Delta Lake adds **enterprise features** to data lakes:

-   **ACID Transactions**: Ensures data consistency
-   **Schema Enforcement**: Prevents bad data from corrupting tables
-   **Time Travel**: Access historical versions of data
-   **Unified Batch/Streaming**: Same API for both processing modes
-   **Performance**: Optimizations like Z-ordering and data skipping

#### **Performance Questions**

**Q: How would you optimize a slow Databricks job?**
**A:** **Multi-layered optimization approach**:

1. **Cluster optimization**: Right-size instances, enable autoscaling
2. **Code optimization**: Use appropriate transformations, avoid shuffles
3. **Data optimization**: Use Delta Lake, partition appropriately, Z-order
4. **Spark configuration**: Enable AQE, use Photon engine
5. **Caching**: Cache frequently accessed datasets
6. **Monitoring**: Use Spark UI to identify bottlenecks

**Q: Explain the benefits of Photon engine.**
**A:** Photon is Databricks' **vectorized query engine**:

-   **Performance**: 2-5x faster for SQL queries
-   **Compatibility**: Drop-in replacement for Spark SQL
-   **Optimization**: Vectorized processing, code generation
-   **Use cases**: Best for SQL-heavy workloads, reporting, BI queries
-   **Automatic**: Enabled by default in SQL warehouses

**Q: How do you handle data skew in Databricks?**
**A:** **Multiple strategies**:

-   **Salting**: Add random prefix to skewed keys
-   **Broadcast joins**: For small tables
-   **Adaptive Query Execution**: Automatic skew handling
-   **Repartitioning**: Redistribute data evenly
-   **Z-ordering**: Optimize data layout for better performance

#### **Delta Lake Questions**

**Q: Explain ACID properties in Delta Lake.**
**A:** Delta Lake provides **full ACID compliance**:

-   **Atomicity**: Operations either complete fully or not at all
-   **Consistency**: Data remains in valid state after transactions
-   **Isolation**: Concurrent operations don't interfere
-   **Durability**: Committed changes are permanent
-   **Implementation**: Transaction log tracks all changes

**Q: How does time travel work in Delta Lake?**
**A:** Time travel uses **transaction log**:

-   **Version-based**: Access specific version number
-   **Timestamp-based**: Access data at specific time
-   **Use cases**: Data recovery, auditing, debugging, A/B testing
-   **Retention**: Configurable retention period (default 30 days)

**Q: When would you use OPTIMIZE and VACUUM commands?**
**A:**

-   **OPTIMIZE**: Compacts small files, improves query performance
    -   Run after large ingestion jobs
    -   Use Z-ordering for frequently filtered columns
-   **VACUUM**: Removes old data files, reclaims storage
    -   Run periodically to manage storage costs
    -   Respects retention period for time travel

#### **MLflow Questions**

**Q: Explain MLflow components and their use cases.**
**A:** **Four main components**:

-   **Tracking**: Log experiments, parameters, metrics, artifacts
-   **Projects**: Package ML code for reproducibility
-   **Models**: Deploy models to various platforms
-   **Registry**: Centralized model store with versioning and lifecycle management

**Q: How do you implement model versioning and deployment with MLflow?**
**A:** **Model lifecycle management**:

1. **Training**: Log model with MLflow tracking
2. **Registration**: Register model in MLflow registry
3. **Staging**: Promote model through stages (Staging → Production)
4. **Deployment**: Deploy using MLflow serving or batch inference
5. **Monitoring**: Track model performance and drift

#### **Unity Catalog Questions**

**Q: What is Unity Catalog and why is it important?**
**A:** Unity Catalog is **unified governance solution**:

-   **Centralized metadata**: Single source of truth for all data assets
-   **Fine-grained access control**: Table, column, and row-level security
-   **Data lineage**: Track data flow across pipelines
-   **Cross-cloud**: Works across AWS, Azure, GCP
-   **Audit logging**: Complete audit trail for compliance

**Q: How do you implement data governance with Unity Catalog?**
**A:** **Comprehensive governance strategy**:

-   **Organization**: Catalog → Schema → Table hierarchy
-   **Access control**: Grant permissions at appropriate levels
-   **Data classification**: Tag sensitive data (PII, PHI)
-   **Row/column security**: Implement fine-grained access controls
-   **Monitoring**: Use audit logs for compliance reporting

#### **Troubleshooting Questions**

**Q: How would you troubleshoot a failing Databricks job?**
**A:** **Systematic debugging approach**:

1. **Check job logs**: Look for error messages and stack traces
2. **Spark UI**: Analyze stages, tasks, and resource usage
3. **Cluster logs**: Check driver and executor logs
4. **Data issues**: Validate input data quality and schema
5. **Resource constraints**: Check memory, CPU, disk usage
6. **Configuration**: Review Spark and cluster settings

**Q: What are common causes of out-of-memory errors?**
**A:** **Memory-related issues**:

-   **Driver memory**: Large collect() operations, broadcast variables
-   **Executor memory**: Large partitions, inefficient joins
-   **Solutions**: Increase memory, optimize queries, use disk-based operations
-   **Prevention**: Monitor memory usage, use appropriate instance types

#### **Best Practices Questions**

**Q: What are best practices for notebook development?**
**A:** **Development best practices**:

-   **Modular code**: Break code into reusable functions
-   **Version control**: Use Repos for Git integration
-   **Documentation**: Add markdown cells explaining logic
-   **Error handling**: Implement robust error handling
-   **Testing**: Write unit tests for critical functions
-   **Parameterization**: Use widgets for configurable parameters

**Q: How do you implement CI/CD for Databricks?**
**A:** **CI/CD pipeline components**:

-   **Source control**: Git integration with Repos
-   **Testing**: Unit tests, integration tests
-   **Deployment**: Automated deployment to different environments
-   **Monitoring**: Job monitoring and alerting
-   **Tools**: Databricks CLI, REST API, Terraform

---

## Quick Reference

#### **Essential Commands**

```python
# Cluster management
dbutils.fs.ls("/")  # List files
dbutils.secrets.get(scope="scope", key="key")  # Get secrets

# Delta Lake operations
spark.sql("OPTIMIZE table_name ZORDER BY (column)")
spark.sql("VACUUM table_name RETAIN 168 HOURS")
spark.sql("DESCRIBE HISTORY table_name")

# MLflow tracking
mlflow.log_param("param", value)
mlflow.log_metric("metric", value)
mlflow.log_artifact("file.txt")

# Unity Catalog
spark.sql("SHOW CATALOGS")
spark.sql("SHOW SCHEMAS IN catalog_name")
spark.sql("SHOW TABLES IN catalog.schema")
```

#### **Performance Optimization Checklist**

-   ✅ Use Delta Lake format
-   ✅ Enable Photon engine
-   ✅ Configure adaptive query execution
-   ✅ Partition data appropriately
-   ✅ Use Z-ordering for frequently filtered columns
-   ✅ Cache frequently accessed data
-   ✅ Right-size clusters
-   ✅ Monitor and optimize regularly

#### **Security Checklist**

-   ✅ Enable Unity Catalog
-   ✅ Implement proper access controls
-   ✅ Use secrets for sensitive data
-   ✅ Enable audit logging
-   ✅ Configure network security
-   ✅ Encrypt data at rest and in transit
-   ✅ Regular security reviews

This comprehensive cheatsheet covers all major Databricks concepts and common interview scenarios, providing both theoretical knowledge and practical examples.
