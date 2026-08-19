# AWS Athena Interview Cheatsheet

## Table of Contents

1. [Core Concepts](#core-concepts)
2. [Architecture & Components](#architecture--components)
3. [Data Formats & Storage](#data-formats--storage)
4. [Query Performance Optimization](#query-performance-optimization)
5. [Security & Access Control](#security--access-control)
6. [Cost Optimization](#cost-optimization)
7. [Integration & Data Sources](#integration--data-sources)
8. [Advanced Features](#advanced-features)
9. [Monitoring & Troubleshooting](#monitoring--troubleshooting)
10. [Common Interview Questions](#common-interview-questions)

---

## Core Concepts

#### **What is Amazon Athena?**

-   **Serverless interactive query service** for analyzing data in Amazon S3
-   **Pay-per-query** pricing model (no infrastructure to manage)
-   Uses **Apache Presto** distributed SQL query engine
-   **ANSI SQL** compatible with support for complex queries
-   **No data loading** required - queries data directly from S3

#### **Key Features**

-   **Serverless**: No servers to provision or manage
-   **Standard SQL**: ANSI SQL support with advanced functions
-   **Multiple Data Formats**: Parquet, ORC, JSON, CSV, Avro, etc.
-   **Integration**: Works with AWS Glue Data Catalog
-   **Federated Queries**: Query data across multiple sources
-   **Machine Learning**: Built-in ML functions

#### **Athena vs Other AWS Services**

| Feature            | Athena           | Redshift             | EMR                          |
| ------------------ | ---------------- | -------------------- | ---------------------------- |
| **Infrastructure** | Serverless       | Managed clusters     | Self-managed clusters        |
| **Pricing**        | Pay-per-query    | Pay for cluster time | Pay for EC2 instances        |
| **Data Location**  | S3 only          | Local storage        | HDFS/S3                      |
| **Query Language** | SQL only         | SQL + extensions     | Multiple (Spark, Hive, etc.) |
| **Setup Time**     | Immediate        | Minutes              | Hours                        |
| **Best For**       | Ad-hoc analytics | Data warehousing     | Complex processing           |

---

## Architecture & Components

#### **Athena Architecture**

```
User Query → Athena Service → Presto Engine → S3 Data
     ↓              ↓              ↓           ↓
Query Editor → Query Planning → Distributed → Results
     ↓              ↓         Execution        ↓
Results UI ← Query Results ← Result Storage ← S3
```

#### **Core Components**

**1. Query Engine (Presto)**

-   Distributed SQL query engine
-   In-memory processing for fast queries
-   Supports complex joins and aggregations
-   Automatic query optimization

**2. Data Catalog (AWS Glue)**

-   Metadata repository for tables and schemas
-   Automatic schema discovery
-   Partition management
-   Data type inference

**3. Storage Layer (Amazon S3)**

-   Stores actual data files
-   Supports multiple file formats
-   Partitioned data organization
-   Lifecycle management integration

#### **Query Execution Flow**

1. **Query Submission**: User submits SQL query
2. **Query Parsing**: Athena parses and validates SQL
3. **Metadata Lookup**: Retrieves table schema from Glue Catalog
4. **Query Planning**: Creates optimized execution plan
5. **Distributed Execution**: Presto workers execute query across S3 data
6. **Result Aggregation**: Combines results from all workers
7. **Result Storage**: Stores results in S3 for retrieval

---

## Data Formats & Storage

#### **Supported File Formats**

```sql
-- Parquet (Recommended for analytics)
CREATE EXTERNAL TABLE parquet_table (
    id bigint,
    name string,
    created_date date
)
STORED AS PARQUET
LOCATION 's3://my-bucket/parquet-data/';

-- ORC (Optimized Row Columnar)
CREATE EXTERNAL TABLE orc_table (
    id bigint,
    name string,
    amount decimal(10,2)
)
STORED AS ORC
LOCATION 's3://my-bucket/orc-data/';

-- JSON
CREATE EXTERNAL TABLE json_table (
    id bigint,
    data struct<
        name: string,
        email: string,
        preferences: array<string>
    >
)
STORED AS JSON
LOCATION 's3://my-bucket/json-data/';

-- CSV
CREATE EXTERNAL TABLE csv_table (
    id bigint,
    name string,
    email string
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
    'serialization.format' = ',',
    'field.delim' = ','
)
STORED AS TEXTFILE
LOCATION 's3://my-bucket/csv-data/';
```

#### **Data Partitioning**

```sql
-- Create partitioned table
CREATE EXTERNAL TABLE sales_partitioned (
    transaction_id string,
    customer_id string,
    amount decimal(10,2),
    product_category string
)
PARTITIONED BY (
    year int,
    month int,
    day int
)
STORED AS PARQUET
LOCATION 's3://my-bucket/sales/';

-- Add partitions manually
ALTER TABLE sales_partitioned ADD
PARTITION (year=2023, month=12, day=1)
LOCATION 's3://my-bucket/sales/year=2023/month=12/day=1/';

-- Discover partitions automatically
MSCK REPAIR TABLE sales_partitioned;

-- Query with partition pruning
SELECT customer_id, SUM(amount) as total
FROM sales_partitioned
WHERE year = 2023 AND month = 12
GROUP BY customer_id;
```

#### **Compression Support**

```sql
-- Specify compression in table properties
CREATE EXTERNAL TABLE compressed_data (
    id bigint,
    data string
)
STORED AS PARQUET
LOCATION 's3://my-bucket/compressed/'
TBLPROPERTIES (
    'parquet.compress'='SNAPPY'
);

-- Supported compression formats:
-- GZIP, SNAPPY, LZO, BZIP2 (for text formats)
-- SNAPPY, GZIP, LZ4 (for Parquet)
-- ZLIB, SNAPPY, LZO (for ORC)
```

---

## Query Performance Optimization

#### **Best Practices for Performance**

**1. Use Columnar Formats**

```sql
-- Convert CSV to Parquet for better performance
CREATE TABLE optimized_sales
WITH (
    format = 'PARQUET',
    external_location = 's3://my-bucket/optimized-sales/',
    partitioned_by = ARRAY['year', 'month']
) AS
SELECT
    transaction_id,
    customer_id,
    amount,
    product_category,
    YEAR(transaction_date) as year,
    MONTH(transaction_date) as month
FROM csv_sales_table;
```

**2. Implement Proper Partitioning**

```sql
-- Good partitioning strategy
-- Partition by frequently filtered columns with reasonable cardinality
CREATE EXTERNAL TABLE events_optimized (
    event_id string,
    user_id string,
    event_type string,
    properties map<string,string>
)
PARTITIONED BY (
    event_date date,  -- High selectivity
    region string     -- Low cardinality
)
STORED AS PARQUET
LOCATION 's3://my-bucket/events/';

-- Query optimization with partition pruning
SELECT event_type, COUNT(*) as event_count
FROM events_optimized
WHERE event_date BETWEEN DATE '2023-12-01' AND DATE '2023-12-31'
  AND region = 'us-east-1'
GROUP BY event_type;
```

**3. Optimize Data Types**

```sql
-- Use appropriate data types to reduce storage and improve performance
CREATE EXTERNAL TABLE optimized_types (
    id bigint,                    -- Use bigint instead of string for IDs
    amount decimal(10,2),         -- Precise decimal instead of double
    status tinyint,               -- Small integer for status codes
    created_at timestamp,         -- Timestamp instead of string
    metadata map<string,string>   -- Use complex types appropriately
)
STORED AS PARQUET
LOCATION 's3://my-bucket/optimized/';
```

**4. Query Optimization Techniques**

```sql
-- Use LIMIT for exploratory queries
SELECT * FROM large_table LIMIT 100;

-- Use approximate functions for large datasets
SELECT
    approx_distinct(customer_id) as unique_customers,
    approx_percentile(amount, 0.5) as median_amount
FROM sales_table;

-- Optimize JOIN operations
-- Put smaller table first in JOIN
SELECT s.*, c.customer_name
FROM small_customer_table c
JOIN large_sales_table s ON c.customer_id = s.customer_id;

-- Use EXISTS instead of IN for better performance
SELECT customer_id
FROM customers c
WHERE EXISTS (
    SELECT 1 FROM orders o
    WHERE o.customer_id = c.customer_id
);
```

#### **CTAS (Create Table As Select) Optimization**

```sql
-- Create optimized table with CTAS
CREATE TABLE sales_optimized
WITH (
    format = 'PARQUET',
    parquet_compression = 'SNAPPY',
    external_location = 's3://my-bucket/sales-optimized/',
    partitioned_by = ARRAY['year', 'month']
) AS
SELECT
    transaction_id,
    customer_id,
    amount,
    product_category,
    transaction_timestamp,
    YEAR(transaction_timestamp) as year,
    MONTH(transaction_timestamp) as month
FROM raw_sales_data
WHERE transaction_timestamp >= DATE '2023-01-01';
```

---

## Security & Access Control

#### **IAM Policies for Athena**

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "athena:StartQueryExecution",
                "athena:GetQueryExecution",
                "athena:GetQueryResults",
                "athena:StopQueryExecution",
                "athena:GetWorkGroup"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": ["s3:GetObject", "s3:ListBucket", "s3:GetBucketLocation"],
            "Resource": [
                "arn:aws:s3:::my-data-bucket",
                "arn:aws:s3:::my-data-bucket/*"
            ]
        },
        {
            "Effect": "Allow",
            "Action": ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"],
            "Resource": ["arn:aws:s3:::my-results-bucket/*"]
        },
        {
            "Effect": "Allow",
            "Action": [
                "glue:GetDatabase",
                "glue:GetTable",
                "glue:GetPartitions"
            ],
            "Resource": "*"
        }
    ]
}
```

#### **Workgroups for Access Control**

```sql
-- Create workgroup with specific settings
CREATE WORKGROUP analytics_team
WITH (
    result_configuration = (
        output_location = 's3://analytics-results-bucket/',
        encryption_configuration = (
            encryption_option = 'SSE_S3'
        )
    ),
    enforce_workgroup_configuration = true,
    publish_cloudwatch_metrics = true,
    bytes_scanned_cutoff_per_query = 1073741824  -- 1GB limit
);

-- Query execution in specific workgroup
-- This is done through the console or API, not SQL
```

#### **Data Encryption**

```sql
-- Encryption at rest (S3 bucket level)
-- Configured at S3 bucket level with SSE-S3, SSE-KMS, or SSE-C

-- Encryption in transit
-- Automatically handled by Athena (HTTPS/TLS)

-- Query results encryption
CREATE WORKGROUP secure_workgroup
WITH (
    result_configuration = (
        output_location = 's3://secure-results/',
        encryption_configuration = (
            encryption_option = 'SSE_KMS',
            kms_key = 'arn:aws:kms:us-east-1:123456789012:key/12345678-1234-1234-1234-123456789012'
        )
    )
);
```

#### **Column-Level Security**

```sql
-- Use views to restrict column access
CREATE VIEW customer_public AS
SELECT
    customer_id,
    first_name,
    last_name,
    city,
    state
    -- Exclude sensitive columns like SSN, credit_card_number
FROM customer_full;

-- Row-level security with WHERE clauses
CREATE VIEW regional_sales AS
SELECT *
FROM sales
WHERE region = '${aws:userid}';  -- Dynamic based on user
```

---

## Cost Optimization

#### **Understanding Athena Pricing**

-   **$5.00 per TB** of data scanned
-   **No charge** for failed queries
-   **No charge** for DDL statements (CREATE, ALTER, DROP)
-   **Compressed data** reduces costs significantly

#### **Cost Optimization Strategies**

**1. Use Columnar Formats**

```sql
-- Cost comparison example
-- CSV: 1TB scan = $5.00
-- Parquet (compressed): 100GB scan = $0.50
-- Savings: 90%

-- Convert to Parquet
CREATE TABLE cost_optimized
WITH (
    format = 'PARQUET',
    parquet_compression = 'SNAPPY'
) AS
SELECT * FROM expensive_csv_table;
```

**2. Implement Partitioning**

```sql
-- Without partitioning: Scans entire dataset
SELECT COUNT(*) FROM sales WHERE date = '2023-12-01';  -- Scans all data

-- With partitioning: Scans only relevant partition
SELECT COUNT(*) FROM sales_partitioned WHERE year=2023 AND month=12 AND day=1;  -- Scans 1 day only
```

**3. Use Projection Pushdown**

```sql
-- Bad: Scans all columns
SELECT * FROM large_table WHERE date = '2023-12-01';

-- Good: Scans only needed columns
SELECT customer_id, amount FROM large_table WHERE date = '2023-12-01';
```

**4. Query Result Caching**

```sql
-- Athena automatically caches query results for 24 hours
-- Subsequent identical queries return cached results at no cost

-- First execution: Charges for data scanned
SELECT region, COUNT(*) FROM sales GROUP BY region;

-- Second execution within 24 hours: No charge (cached result)
SELECT region, COUNT(*) FROM sales GROUP BY region;
```

**5. Set Data Scan Limits**

```sql
-- Configure workgroup with scan limits
CREATE WORKGROUP cost_controlled
WITH (
    bytes_scanned_cutoff_per_query = 10737418240  -- 10GB limit
);
```

#### **Cost Monitoring Queries**

```sql
-- Monitor query costs (requires CloudTrail)
SELECT
    query_id,
    query,
    data_scanned_in_bytes / 1024.0 / 1024.0 / 1024.0 / 1024.0 as data_scanned_tb,
    (data_scanned_in_bytes / 1024.0 / 1024.0 / 1024.0 / 1024.0) * 5.0 as estimated_cost_usd
FROM information_schema.query_history
WHERE creation_time >= current_date - interval '7' day
ORDER BY data_scanned_in_bytes DESC;
```

---

## Integration & Data Sources

#### **AWS Glue Integration**

```sql
-- Create table using Glue Crawler discovered schema
-- Crawler automatically creates table definition

-- Query Glue Catalog tables
SHOW DATABASES;
SHOW TABLES IN database_name;
DESCRIBE table_name;

-- Update table schema
ALTER TABLE my_table ADD COLUMNS (new_column string);
ALTER TABLE my_table CHANGE COLUMN old_name new_name string;
```

#### **Federated Queries**

```sql
-- Query data from multiple sources
-- Requires Lambda-based data source connectors

-- Example: Join S3 data with RDS data
SELECT
    s3_data.customer_id,
    s3_data.transaction_amount,
    rds_data.customer_name,
    rds_data.customer_tier
FROM "s3_catalog"."default"."transactions" s3_data
JOIN "rds_catalog"."sales_db"."customers" rds_data
ON s3_data.customer_id = rds_data.customer_id;

-- Supported connectors:
-- Amazon RDS, Amazon Redshift, Amazon DynamoDB
-- Apache HBase, Amazon DocumentDB, Amazon Neptune
-- Custom connectors via Lambda
```

#### **Integration with Other AWS Services**

```sql
-- QuickSight Integration
-- Connect QuickSight directly to Athena for visualization

-- SageMaker Integration
-- Use Athena as data source for ML model training

-- Lambda Integration
-- Trigger Athena queries from Lambda functions
```

---

## Advanced Features

#### **User Defined Functions (UDFs)**

```sql
-- Create UDF using Lambda
USING EXTERNAL FUNCTION my_custom_function(x varchar)
RETURNS varchar
LAMBDA 'my-lambda-function-name'
SELECT my_custom_function(column_name) FROM my_table;
```

#### **Machine Learning Functions**

```sql
-- Built-in ML functions
SELECT
    customer_id,
    ml_predict('customer_churn_model',
               features(age, tenure, monthly_charges, total_charges)) as churn_probability
FROM customer_features;

-- Anomaly detection
SELECT
    timestamp,
    value,
    random_cut_forest(value) OVER (
        ORDER BY timestamp
        ROWS BETWEEN 100 PRECEDING AND CURRENT ROW
    ) as anomaly_score
FROM time_series_data;
```

#### **Geospatial Functions**

```sql
-- Geospatial queries
SELECT
    store_id,
    ST_Distance(
        ST_Point(store_longitude, store_latitude),
        ST_Point(-74.0059, 40.7128)  -- NYC coordinates
    ) as distance_from_nyc
FROM store_locations
WHERE ST_Distance(
    ST_Point(store_longitude, store_latitude),
    ST_Point(-74.0059, 40.7128)
) < 50000;  -- Within 50km
```

#### **Array and Map Functions**

```sql
-- Working with complex data types
SELECT
    customer_id,
    cardinality(purchase_history) as total_purchases,
    array_join(favorite_categories, ', ') as categories_list,
    map_keys(preferences) as preference_keys,
    preferences['notification_email'] as email_notifications
FROM customer_profiles
WHERE contains(favorite_categories, 'electronics');
```

#### **Window Functions**

```sql
-- Advanced analytics with window functions
SELECT
    customer_id,
    transaction_date,
    amount,
    SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY transaction_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as running_total,
    LAG(amount, 1) OVER (
        PARTITION BY customer_id
        ORDER BY transaction_date
    ) as previous_amount,
    RANK() OVER (
        PARTITION BY DATE_TRUNC('month', transaction_date)
        ORDER BY amount DESC
    ) as monthly_rank
FROM transactions;
```

---

## Monitoring & Troubleshooting

#### **Query Performance Monitoring**

```sql
-- Check query execution details
SELECT
    query_id,
    query_state,
    data_scanned_in_bytes,
    engine_execution_time_in_millis,
    query_queue_time_in_millis,
    total_execution_time_in_millis
FROM information_schema.query_history
WHERE creation_time >= current_timestamp - interval '1' hour
ORDER BY total_execution_time_in_millis DESC;
```

#### **Common Performance Issues**

**1. Large Data Scans**

```sql
-- Problem: Scanning entire dataset
SELECT * FROM large_table WHERE date = '2023-12-01';

-- Solution: Use partitioning and column selection
SELECT customer_id, amount
FROM partitioned_table
WHERE year=2023 AND month=12 AND day=1;
```

**2. Inefficient Joins**

```sql
-- Problem: Cartesian product
SELECT * FROM table1, table2;

-- Solution: Proper JOIN conditions
SELECT t1.*, t2.name
FROM table1 t1
JOIN table2 t2 ON t1.id = t2.id;
```

**3. Data Type Mismatches**

```sql
-- Problem: Implicit conversions
SELECT * FROM table1 WHERE string_id = 123;

-- Solution: Explicit casting
SELECT * FROM table1 WHERE string_id = CAST(123 AS varchar);
```

#### **Error Troubleshooting**

**Common Errors and Solutions:**

```sql
-- Error: HIVE_PARTITION_SCHEMA_MISMATCH
-- Solution: Ensure consistent schema across partitions
MSCK REPAIR TABLE table_name;

-- Error: HIVE_CURSOR_ERROR
-- Solution: Check S3 permissions and file accessibility

-- Error: SYNTAX_ERROR
-- Solution: Validate SQL syntax, check table/column names

-- Error: EXCEEDED_MEMORY_LIMIT
-- Solution: Optimize query, use LIMIT, or increase workgroup limits
```

#### **CloudWatch Metrics**

```sql
-- Key metrics to monitor:
-- - DataScannedInBytes
-- - QueryExecutionTime
-- - ProcessedBytes
-- - EngineExecutionTime
-- - QueryQueueTime
```

---

## Common Interview Questions

#### **Architecture Questions**

**Q: Explain Athena's architecture and how it processes queries.**
**A:** Athena uses a serverless architecture built on Apache Presto:

-   **Query Submission**: User submits SQL through console/API
-   **Query Planning**: Athena creates optimized execution plan
-   **Metadata Lookup**: Retrieves schema from AWS Glue Data Catalog
-   **Distributed Execution**: Presto workers execute query across S3 data in parallel
-   **Result Aggregation**: Results are combined and stored in S3
-   **No infrastructure management** required - fully serverless

**Q: How does Athena differ from traditional databases?**
**A:** Key differences:

-   **Serverless**: No servers to manage vs. traditional database clusters
-   **Storage Separation**: Data stays in S3 vs. database-managed storage
-   **Pay-per-query**: Only pay for queries executed vs. always-on costs
-   **Schema-on-read**: Schema applied at query time vs. schema-on-write
-   **Immutable data**: S3 data typically immutable vs. mutable database records

**Q: What is the role of AWS Glue Data Catalog in Athena?**
**A:** The Glue Data Catalog serves as Athena's metadata repository:

-   **Schema Storage**: Stores table definitions, column types, partitions
-   **Automatic Discovery**: Glue Crawlers can automatically discover schemas
-   **Centralized Metadata**: Shared across multiple AWS analytics services
-   **Partition Management**: Tracks partition locations and schemas
-   **Data Classification**: Can identify and tag sensitive data

#### **Performance Questions**

**Q: How would you optimize a slow Athena query?**
**A:** Optimization strategies:

1. **Use columnar formats** (Parquet/ORC) instead of CSV/JSON
2. **Implement partitioning** on frequently filtered columns
3. **Select only needed columns** to reduce data scanned
4. **Use appropriate data types** to minimize storage
5. **Compress data** to reduce I/O
6. **Optimize JOIN order** (smaller table first)
7. **Use approximate functions** for large aggregations
8. **Check execution plan** for bottlenecks

**Q: Explain the benefits of using Parquet format in Athena.**
**A:** Parquet benefits:

-   **Columnar storage**: Only scan columns needed for query
-   **Compression**: Typically 75-90% smaller than CSV
-   **Predicate pushdown**: Skip irrelevant data blocks
-   **Schema evolution**: Add columns without rewriting data
-   **Type safety**: Strong typing reduces errors
-   **Cost reduction**: Less data scanned = lower costs

**Q: How does partitioning work in Athena and when should you use it?**
**A:** Partitioning divides data into separate folders:

-   **Partition pruning**: Only scan relevant partitions
-   **Cost reduction**: Dramatically reduce data scanned
-   **Performance improvement**: Faster query execution
-   **Best practices**: Partition by frequently filtered columns with reasonable cardinality (date, region, category)
-   **Avoid over-partitioning**: Too many small partitions can hurt performance

#### **Cost Questions**

**Q: How is Athena pricing calculated and how can you optimize costs?**
**A:** Athena pricing:

-   **$5.00 per TB** of data scanned by queries
-   **No charges** for failed queries or DDL statements
-   **Cost optimization strategies**:
    -   Use columnar formats (Parquet/ORC)
    -   Implement partitioning
    -   Select only needed columns
    -   Compress data
    -   Use query result caching
    -   Set workgroup scan limits

**Q: What's the cost difference between CSV and Parquet formats?**
**A:** Significant cost differences:

-   **CSV**: Scans entire file even for single column
-   **Parquet**: Scans only needed columns
-   **Example**: 1TB CSV table, selecting 2 of 20 columns:
    -   CSV cost: $5.00 (scans full 1TB)
    -   Parquet cost: ~$0.50 (scans ~100GB)
    -   **Savings: 90%**

#### **Security Questions**

**Q: How do you implement security in Athena?**
**A:** Multi-layered security approach:

-   **IAM policies**: Control access to Athena actions and S3 data
-   **Workgroups**: Isolate users and control query settings
-   **Encryption**: At-rest (S3) and in-transit (TLS) encryption
-   **VPC endpoints**: Private connectivity without internet
-   **CloudTrail**: Audit all Athena API calls
-   **Column-level security**: Use views to restrict sensitive columns

**Q: Explain workgroups and their security benefits.**
**A:** Workgroups provide:

-   **User isolation**: Separate teams and projects
-   **Cost control**: Set query scan limits per workgroup
-   **Result location control**: Enforce where results are stored
-   **Encryption enforcement**: Mandate encryption settings
-   **Monitoring**: Track usage and costs per workgroup
-   **Access control**: IAM policies can restrict workgroup access

#### **Integration Questions**

**Q: How does Athena integrate with other AWS services?**
**A:** Key integrations:

-   **S3**: Primary data storage and query results
-   **Glue**: Metadata catalog and ETL processing
-   **QuickSight**: Business intelligence and visualization
-   **SageMaker**: Machine learning data source
-   **Lambda**: Programmatic query execution
-   **CloudFormation**: Infrastructure as code
-   **Step Functions**: Workflow orchestration

**Q: What are federated queries and when would you use them?**
**A:** Federated queries allow querying multiple data sources:

-   **Use cases**: Join S3 data with RDS/Redshift data
-   **Implementation**: Lambda-based data source connectors
-   **Benefits**: Single query across multiple systems
-   **Supported sources**: RDS, Redshift, DynamoDB, HBase, etc.
-   **Considerations**: Network latency and data transfer costs

#### **Troubleshooting Questions**

**Q: What are common Athena errors and how do you resolve them?**
**A:** Common errors:

-   **HIVE_PARTITION_SCHEMA_MISMATCH**: Run `MSCK REPAIR TABLE`
-   **Access Denied**: Check IAM permissions for S3 and Athena
-   **SYNTAX_ERROR**: Validate SQL syntax and table names
-   **EXCEEDED_MEMORY_LIMIT**: Optimize query or increase limits
-   **File format errors**: Ensure consistent file formats in partitions

**Q: How do you monitor and troubleshoot Athena performance?**
**A:** Monitoring approaches:

-   **CloudWatch metrics**: Track data scanned, execution time
-   **Query history**: Analyze slow queries and patterns
-   **Cost analysis**: Monitor spending trends
-   **Execution plans**: Identify query bottlenecks
-   **Workgroup metrics**: Compare performance across teams
-   **S3 access patterns**: Optimize data layout

#### **Best Practices Questions**

**Q: What are the best practices for table design in Athena?**
**A:** Design best practices:

-   **Use columnar formats** (Parquet/ORC)
-   **Implement logical partitioning** strategy
-   **Choose appropriate data types** (smallest possible)
-   **Compress data** for storage and cost efficiency
-   **Organize S3 structure** logically
-   **Use consistent naming** conventions
-   **Document schemas** and data lineage
-   **Regular maintenance** (update partitions, optimize layouts)

**Q: How do you design an efficient data lake for Athena?**
**A:** Data lake design principles:

-   **Layered architecture**: Raw → Processed → Curated
-   **Partition strategy**: By date, region, or business dimension
-   **File sizing**: 128MB-1GB files for optimal performance
-   **Compression**: Use appropriate compression algorithms
-   **Schema evolution**: Plan for changing data structures
-   **Lifecycle policies**: Archive old data to reduce costs
-   **Access patterns**: Design for common query patterns
-   **Governance**: Implement data cataloging and lineage

---

## Quick Reference Commands

#### **Essential DDL Commands**

```sql
-- Database operations
CREATE DATABASE my_database;
SHOW DATABASES;
DROP DATABASE my_database;

-- Table operations
CREATE EXTERNAL TABLE my_table (...) LOCATION 's3://bucket/path/';
SHOW TABLES;
DESCRIBE my_table;
SHOW PARTITIONS my_table;
DROP TABLE my_table;

-- Partition operations
ALTER TABLE my_table ADD PARTITION (year=2023, month=12);
MSCK REPAIR TABLE my_table;
```

#### **Performance Optimization Checklist**

-   ✅ Use Parquet or ORC format
-   ✅ Implement partitioning strategy
-   ✅ Select only needed columns
-   ✅ Use appropriate data types
-   ✅ Compress data files
-   ✅ Optimize JOIN operations
-   ✅ Use LIMIT for exploratory queries
-   ✅ Monitor query costs regularly

#### **Cost Optimization Checklist**

-   ✅ Convert CSV to Parquet
-   ✅ Implement partitioning
-   ✅ Use column projection
-   ✅ Enable compression
-   ✅ Set workgroup scan limits
-   ✅ Use query result caching
-   ✅ Monitor data scan metrics
-   ✅ Archive old data

This comprehensive cheatsheet covers all aspects of AWS Athena that are commonly discussed in interviews, from basic concepts to advanced optimization techniques and real-world scenarios.
