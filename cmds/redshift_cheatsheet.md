# AWS Redshift Interview Cheatsheet

## Core Concepts

-   **What is Amazon Redshift?**

    -   **Cloud-based data warehouse** service by AWS
    -   **Columnar storage** with **massively parallel processing (MPP)**
    -   Based on **PostgreSQL** but optimized for analytics
    -   **Petabyte-scale** data warehouse solution
    -   **OLAP** (Online Analytical Processing) workloads

-   **Key Features**

    -   **Columnar Storage**: Data stored by columns, not rows
    -   **Data Compression**: Automatic compression algorithms
    -   **Massively Parallel Processing**: Distributes queries across multiple nodes
    -   **Result Caching**: Caches query results for faster retrieval
    -   **Automatic Backups**: Point-in-time recovery
    -   **Encryption**: At-rest and in-transit encryption

-   **Cluster Architecture**

    ```
    Redshift Cluster
    ├── Leader Node (1)
    │   ├── Query Planning
    │   ├── Query Coordination
    │   └── Result Aggregation
    └── Compute Nodes (1-128)
        ├── Node Slices (2-32 per node)
        ├── Local Storage
        └── Processing Power
    ```

-   **Node Types**

    | Node Type        | vCPU | Memory | Storage         | Network       |
    | ---------------- | ---- | ------ | --------------- | ------------- |
    | **ra3.xlplus**   | 4    | 32 GB  | Managed Storage | Up to 10 Gbps |
    | **ra3.4xlarge**  | 12   | 96 GB  | Managed Storage | Up to 10 Gbps |
    | **ra3.16xlarge** | 48   | 384 GB | Managed Storage | Up to 25 Gbps |
    | **dc2.large**    | 2    | 15 GB  | 160 GB SSD      | Up to 10 Gbps |
    | **dc2.8xlarge**  | 32   | 244 GB | 2.56 TB SSD     | 10 Gbps       |

-   **Leader Node Functions**

    -   **Query Parsing**: Parses and validates SQL
    -   **Query Planning**: Creates execution plans
    -   **Query Coordination**: Distributes work to compute nodes
    -   **Result Aggregation**: Combines results from compute nodes
    -   **Metadata Management**: Stores table definitions and statistics

-   **Compute Node Functions**

    -   **Data Storage**: Stores table data in slices
    -   **Query Execution**: Executes query segments
    -   **Data Processing**: Performs joins, aggregations, sorts
    -   **Local Caching**: Caches frequently accessed data

-   **Redshift Spectrum**: It Allows Amazon Redshift to **query data directly in Amazon S3** without loading it into Redshift tables.

    -   **Query external data**: Enables Redshift to run SQL queries on structured or semi-structured data stored in S3 using the same SQL syntax as for local Redshift tables.

    -   **External Schema**: You define an _external schema_ in Redshift that maps to an AWS Glue Data Catalog or Hive metastore — this tells Redshift how to interpret data in S3.

    -   **Data formats supported**: Commonly supports **Parquet**, **ORC**, **JSON**, **CSV**, **Avro**, and other columnar or text formats.

    -   **Compute vs. Storage separation**: Spectrum decouples storage (in S3) and compute (in Redshift cluster), allowing you to **query petabytes of data** without ingesting it.

    -   **Performance optimization**:

        -   Pushes as much computation as possible to the Spectrum layer.
        -   Reads only the required columns and rows using **predicate pushdown** (minimizes data scanned).

    -   **Integration with IAM**: Requires appropriate **IAM roles and permissions** so Spectrum can access data in S3.

    -   **Typical use case**:

        -   Querying historical data or infrequently accessed data in S3 without copying into Redshift.
        -   Joining Redshift local tables with external S3 datasets.

    -   **Cost model**: You pay **per terabyte of data scanned**, so optimizing file formats and partitioning in S3 is critical.

-   **Redshift Parameter Group**: It Acts as a **configuration container** for Redshift database engine parameters — similar to how RDS uses parameter groups.

    -   **Configuration template**: A parameter group defines how your Redshift cluster behaves at the database engine level (e.g., query performance, timeout, logging).

    -   **Default vs. Custom**:

        -   **Default parameter group**: Automatically assigned to new clusters; cannot be modified.
        -   **Custom parameter group**: You can create and modify one, then associate it with your cluster.

    -   **Examples of parameters**:

        -   `enable_user_activity_logging` → Enables query logging.
        -   `statement_timeout` → Sets max query runtime.
        -   `wlm_json_configuration` → Defines Workload Management (WLM) queues and slot allocations.
        -   `query_group` → Controls query routing in WLM.
        -   `datestyle`, `search_path`, etc. → Affect session-level SQL behavior.

    -   **Application scope**: Changes to a parameter group apply **to all databases within the associated cluster**.

    -   **Dynamic vs. Static parameters**:

        -   **Dynamic** → Can be applied immediately.
        -   **Static** → Require cluster reboot to take effect.

    -   **Management via AWS Console / CLI / API**: You can manage parameter groups using AWS Management Console, AWS CLI (`aws redshift modify-cluster-parameter-group`), or SDKs (e.g., boto3).

    -   **Best practice**: Always create a **custom parameter group** to fine-tune performance and logging, rather than modifying the default one.

-   **Snapshot & Restore**: Snapshots are **point-in-time backups** of your Redshift cluster used for **data protection** and **disaster recovery**.

    -   **Types of Snapshots**:

        -   **Automated snapshots** → Created by Redshift automatically at regular intervals (based on retention period).
        -   **Manual snapshots** → Created by users; retained until explicitly deleted.

    -   **Storage location**: Snapshots are stored in **Amazon S3**, managed by Redshift. You don’t need to manage the S3 bucket directly.

    -   **Incremental backups**: Only **changes since the last snapshot** are saved — reducing storage cost.

    -   **Cross-region snapshot copy**: You can **copy snapshots to another AWS Region** for disaster recovery and business continuity.

    -   **Restore process**:

        -   Restoring a snapshot creates a **new Redshift cluster** with the data and configuration from that snapshot.
        -   Useful for rollback, migration, or testing.

    -   **Retention management**: Automated snapshots have a **retention period (1–35 days)**; manual snapshots persist until deleted.

    -   **Best practice**: Use **snapshot schedules** and **cross-region replication** for compliance and recovery.

-   **Subnet Group**: A **Redshift Subnet Group** defines which **subnets within a VPC** Redshift can launch cluster nodes into.

    -   **Collection of subnets**: A subnet group is a **logical grouping of subnets** (usually private subnets) within a VPC.

    -   **Availability Zones (AZs)**: You must include at least **two subnets in different AZs** for Redshift cluster high availability and maintenance operations.

    -   **Cluster placement**: When creating a Redshift cluster, AWS chooses a subnet from the defined subnet group to host the cluster’s nodes.

    -   **Private vs. Public**:

        -   Use **private subnets** (no direct internet access) for production workloads.
        -   Public subnets are only recommended for testing.

    -   **Networking dependency**: Ensures the Redshift cluster is launched **inside a specific VPC** with controlled IP range and routing.

    -   **Management**: Can be managed via Console, CLI (`aws redshift create-cluster-subnet-group`), or Terraform.

-   **Networking & Security**: It controls **how Redshift communicates** with other AWS resources and **who can access** it.

    -   **VPC Integration**: Redshift clusters run **inside a VPC** — using private IPs for isolation.

    -   **Security Groups**:

        -   Act as **virtual firewalls** controlling inbound/outbound traffic.
        -   Allow traffic only from trusted sources (e.g., application servers, BI tools, or bastion hosts).

    -   **Network Access Control Lists (NACLs)**: Provide **stateless layer of network control** at subnet level.

    -   **Enhanced VPC Routing**: Forces all COPY/UNLOAD traffic between Redshift and S3 (and other AWS services) to **flow through the VPC**, enabling **monitoring via VPC Flow Logs** and tighter control.

    -   **Public Accessibility**:

        -   `publicly_accessible = false` ensures private cluster.
        -   Set to `true` only when you need access via the public internet (rare for production).

    -   **IAM Integration**: Redshift uses **IAM roles** to securely access other AWS resources (e.g., S3, Glue, Spectrum).

    -   **Authentication**: Supports **IAM-based authentication**, **JDBC/ODBC username-password auth**, and **SSO (via Amazon Redshift integration with AWS IAM Identity Center or federated login)**.

-   **Encryption**: It protects data **at rest** and **in transit** to ensure security and compliance.

    -   **Data at Rest Encryption**:

        -   Uses **AWS Key Management Service (KMS)** or **hardware security module (HSM)** to manage encryption keys.
        -   Encrypts all data blocks, metadata, and backups (snapshots) stored in Redshift-managed S3.

    -   **KMS-managed keys (default)**: Simplifies encryption management — AWS handles key lifecycle automatically.

    -   **Customer-managed keys (CMKs)**: Allows you to create, rotate, and control keys in **AWS KMS** for stricter compliance.

    -   **HSM-based encryption**: Uses **external hardware security modules** for customers needing **FIPS 140-2 compliance** or stricter key control.

    -   **Data in transit encryption**: Redshift supports **SSL/TLS encryption** for client connections to the cluster.

    -   **Snapshot encryption**: Snapshots of encrypted clusters remain encrypted; unencrypted clusters’ snapshots can’t be restored into encrypted ones (and vice versa).

    -   **Best practice**: Always enable encryption (KMS-managed CMK) in production and restrict KMS key access via IAM policies.

-   **IAM role**: Show `aws_iam_role.redshift_role` and the policy allowing S3/Glue/KMS access. Demonstrate COPY/UNLOAD commands using that role.

-   **COPY / UNLOAD**: Upload CSV to S3 and run COPY into Redshift; then UNLOAD results back to S3.

-   **Redshift vs Traditional Databases**

    | Feature         | Redshift                     | Traditional RDBMS            |
    | --------------- | ---------------------------- | ---------------------------- |
    | **Storage**     | Columnar                     | Row-based                    |
    | **Workload**    | OLAP (Analytics)             | OLTP (Transactions)          |
    | **Scaling**     | Horizontal                   | Vertical                     |
    | **Compression** | High (10:1 ratio)            | Low                          |
    | **Joins**       | Optimized for large datasets | Optimized for small datasets |

---

## Data Types & Storage

#### **Supported Data Types**

```sql
-- Numeric Types
SMALLINT, INTEGER, BIGINT
DECIMAL(precision, scale), NUMERIC(precision, scale)
REAL, DOUBLE PRECISION

-- Character Types
CHAR(n), VARCHAR(n)
TEXT (VARCHAR(65535))

-- Date/Time Types
DATE, TIME, TIMETZ
TIMESTAMP, TIMESTAMPTZ

-- Boolean
BOOLEAN

-- Binary
VARBYTE(n)
```

#### **Distribution Styles**

```sql
-- AUTO Distribution (Recommended)
CREATE TABLE sales (
    sale_id INT,
    product_id INT,
    amount DECIMAL(10,2)
) DISTSTYLE AUTO;

-- KEY Distribution
CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(100)
) DISTSTYLE KEY DISTKEY(customer_id);

-- ALL Distribution
CREATE TABLE small_lookup (
    code CHAR(2),
    description VARCHAR(50)
) DISTSTYLE ALL;

-- EVEN Distribution
CREATE TABLE logs (
    log_id BIGINT,
    message TEXT
) DISTSTYLE EVEN;
```

#### **Sort Keys**

```sql
-- Compound Sort Key (Default)
CREATE TABLE events (
    event_date DATE,
    event_type VARCHAR(20),
    user_id INT
) SORTKEY(event_date, event_type);

-- Interleaved Sort Key
CREATE TABLE sales (
    sale_date DATE,
    region VARCHAR(20),
    product_id INT
) INTERLEAVED SORTKEY(sale_date, region, product_id);
```

#### **Compression Encodings**

```sql
-- Automatic Compression (Recommended)
CREATE TABLE products (
    product_id INT ENCODE AUTO,
    name VARCHAR(100) ENCODE AUTO,
    price DECIMAL(10,2) ENCODE AUTO
);

-- Manual Compression
CREATE TABLE manual_compression (
    id INT ENCODE DELTA,
    name VARCHAR(100) ENCODE LZO,
    category VARCHAR(50) ENCODE BYTEDICT,
    price DECIMAL(10,2) ENCODE DELTA32K
);
```

---

## Performance Optimization

#### **Query Performance Best Practices**

**1. Use Appropriate Distribution Keys**

```sql
-- Good: Distribute large tables on frequently joined columns
CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE
) DISTSTYLE KEY DISTKEY(customer_id);

CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(100)
) DISTSTYLE KEY DISTKEY(customer_id);

-- Join will be local (no data movement)
SELECT o.order_id, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
```

**2. Choose Effective Sort Keys**

```sql
-- Sort by most frequently filtered columns
CREATE TABLE sales (
    sale_date DATE,
    region VARCHAR(20),
    amount DECIMAL(10,2)
) SORTKEY(sale_date);  -- Frequently filtered by date

-- Query benefits from sort key
SELECT SUM(amount)
FROM sales
WHERE sale_date BETWEEN '2023-01-01' AND '2023-01-31';
```

**3. Use Column Compression**

```sql
-- Analyze compression recommendations
ANALYZE COMPRESSION table_name;

-- Apply recommended compression
ALTER TABLE table_name ALTER COLUMN column_name ENCODE compression_type;
```

#### **VACUUM and ANALYZE**

```sql
-- Reclaim space and sort data
VACUUM table_name;
VACUUM FULL table_name;  -- More thorough but slower

-- Update table statistics
ANALYZE table_name;
ANALYZE table_name(column1, column2);  -- Specific columns

-- Vacuum and analyze together
VACUUM ANALYZE table_name;
```

#### **Workload Management (WLM)**

```sql
-- Check current WLM configuration
SELECT * FROM stv_wlm_classification_config;

-- Monitor query queues
SELECT * FROM stv_wlm_query_state;

-- Query queue assignment
SET query_group TO 'reporting';
SELECT * FROM large_table;
RESET query_group;
```

---

## Security & Access Control

#### **User Management**

```sql
-- Create users
CREATE USER analyst PASSWORD 'SecurePass123!';
CREATE USER readonly_user PASSWORD 'ReadOnly456!';

-- Create groups
CREATE GROUP analysts;
CREATE GROUP readonly_group;

-- Add users to groups
ALTER GROUP analysts ADD USER analyst;
ALTER GROUP readonly_group ADD USER readonly_user;
```

#### **Database and Schema Permissions**

```sql
-- Grant database access
GRANT CONNECT ON DATABASE analytics TO GROUP analysts;

-- Create schema
CREATE SCHEMA sales_data;

-- Grant schema permissions
GRANT USAGE ON SCHEMA sales_data TO GROUP analysts;
GRANT CREATE ON SCHEMA sales_data TO GROUP analysts;
```

#### **Table Permissions**

```sql
-- Grant table permissions
GRANT SELECT ON TABLE sales_data.orders TO GROUP readonly_group;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE sales_data.orders TO GROUP analysts;

-- Grant permissions on all tables in schema
GRANT SELECT ON ALL TABLES IN SCHEMA sales_data TO GROUP readonly_group;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO GROUP dev_user1;

-- Grant future table permissions
ALTER DEFAULT PRIVILEGES IN SCHEMA sales_data
GRANT SELECT ON TABLES TO GROUP readonly_group;
```

#### **Row-Level Security (RLS)**

```sql
-- Enable RLS on table
ALTER TABLE sales_data.orders ENABLE ROW LEVEL SECURITY;

-- Create policy
CREATE POLICY region_policy ON sales_data.orders
FOR SELECT TO GROUP regional_analysts
USING (region = current_setting('app.current_region'));

-- Set session variable
SET app.current_region = 'US-WEST';
```

#### **Encryption**

```sql
-- Encryption at rest (cluster level)
-- Enabled during cluster creation

-- Encryption in transit
-- Use SSL connections
psql "host=cluster-name.region.redshift.amazonaws.com port=5439 dbname=dev user=username sslmode=require"
```

---

## Backup & Recovery

#### **Automated Snapshots**

```sql
-- Check snapshot settings
SELECT * FROM stv_snapshot_schedule;

-- Manual snapshot
-- Done through AWS Console or CLI
aws redshift create-cluster-snapshot \
    --cluster-identifier my-cluster \
    --snapshot-identifier manual-snapshot-2023-12-01
```

#### **Cross-Region Snapshots**

```sql
-- Configure cross-region snapshots (AWS CLI)
aws redshift modify-cluster \
    --cluster-identifier my-cluster \
    --automated-snapshot-retention-period 7 \
    --preferred-maintenance-window "sun:03:00-sun:04:00"
```

#### **Point-in-Time Recovery**

```sql
-- Restore from snapshot (AWS CLI)
aws redshift restore-from-cluster-snapshot \
    --cluster-identifier restored-cluster \
    --snapshot-identifier my-snapshot \
    --node-type ra3.xlplus \
    --number-of-nodes 2
```

---

## Monitoring & Troubleshooting

#### **System Tables for Monitoring**

```sql
-- Query performance
SELECT query, starttime, endtime, elapsed, rows
FROM stl_query_metrics
WHERE starttime >= DATEADD(hour, -1, GETDATE())
ORDER BY elapsed DESC;

-- Long running queries
SELECT query, pid, starttime, text
FROM stv_recents
WHERE status = 'Running'
AND starttime < DATEADD(minute, -30, GETDATE());

-- Disk usage
SELECT schema, "table", size, pct_used
FROM svv_table_info
ORDER BY size DESC;

-- Connection information
SELECT recordtime, username, dbname, remotehost
FROM stl_connection_log
WHERE recordtime >= DATEADD(hour, -1, GETDATE());
```

#### **Performance Monitoring Queries**

```sql
-- Top queries by execution time
SELECT query, elapsed, rows, text
FROM stl_query_metrics
WHERE starttime >= CURRENT_DATE
ORDER BY elapsed DESC
LIMIT 10;

-- Queries waiting in queue
SELECT query, service_class, slot_count, state
FROM stv_wlm_query_state
WHERE state = 'Queued';

-- Table scan information
SELECT schema, "table", sortkey1, max_varchar, unsorted
FROM svv_table_info
WHERE unsorted > 20;  -- Tables that need VACUUM

-- Distribution key effectiveness
SELECT schema, "table", diststyle, distkey
FROM svv_table_info
WHERE diststyle = 'KEY' AND skew_rows > 1.5;
```

#### **Common Performance Issues**

```sql
-- Identify tables needing VACUUM
SELECT schema, "table", unsorted
FROM svv_table_info
WHERE unsorted > 5
ORDER BY unsorted DESC;

-- Find queries with high disk usage
SELECT query, temp_blocks_to_disk
FROM stl_query_metrics
WHERE temp_blocks_to_disk > 0
ORDER BY temp_blocks_to_disk DESC;

-- Check for data skew
SELECT slice, COUNT(*)
FROM stv_blocklist
WHERE tbl = (SELECT oid FROM pg_class WHERE relname = 'your_table')
GROUP BY slice
ORDER BY COUNT(*) DESC;
```

---

## SQL Commands & Functions

#### **Redshift-Specific Functions**

```sql
-- Date/Time Functions
SELECT
    GETDATE(),                    -- Current timestamp
    DATEADD(day, 7, GETDATE()),  -- Add 7 days
    DATEDIFF(day, '2023-01-01', GETDATE()),  -- Difference in days
    DATE_TRUNC('month', GETDATE()),  -- Truncate to month
    EXTRACT(year FROM GETDATE());    -- Extract year

-- String Functions
SELECT
    LEN('Hello World'),           -- Length
    LEFT('Hello World', 5),       -- Left 5 characters
    RIGHT('Hello World', 5),      -- Right 5 characters
    SUBSTRING('Hello World', 7, 5),  -- Substring
    REPLACE('Hello World', 'World', 'Redshift');

-- Window Functions
SELECT
    customer_id,
    order_date,
    amount,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) as order_sequence,
    LAG(amount, 1) OVER (PARTITION BY customer_id ORDER BY order_date) as previous_amount,
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY order_date
                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as running_total
FROM orders;

-- Conditional Functions
SELECT
    CASE
        WHEN amount > 1000 THEN 'High'
        WHEN amount > 500 THEN 'Medium'
        ELSE 'Low'
    END as amount_category,
    COALESCE(discount, 0) as discount_value,
    NULLIF(status, '') as clean_status
FROM orders;
```

#### **Advanced SQL Patterns**

```sql
-- Pivot data
SELECT
    product_id,
    SUM(CASE WHEN quarter = 'Q1' THEN sales ELSE 0 END) as Q1_sales,
    SUM(CASE WHEN quarter = 'Q2' THEN sales ELSE 0 END) as Q2_sales,
    SUM(CASE WHEN quarter = 'Q3' THEN sales ELSE 0 END) as Q3_sales,
    SUM(CASE WHEN quarter = 'Q4' THEN sales ELSE 0 END) as Q4_sales
FROM quarterly_sales
GROUP BY product_id;

-- Unpivot data
SELECT product_id, 'Q1' as quarter, Q1_sales as sales FROM sales_pivot
UNION ALL
SELECT product_id, 'Q2' as quarter, Q2_sales as sales FROM sales_pivot
UNION ALL
SELECT product_id, 'Q3' as quarter, Q3_sales as sales FROM sales_pivot
UNION ALL
SELECT product_id, 'Q4' as quarter, Q4_sales as sales FROM sales_pivot;

-- Recursive CTE (Limited support)
WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id, manager_id, name, 1 as level
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.employee_id, e.manager_id, e.name, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
    WHERE eh.level < 10  -- Prevent infinite recursion
)
SELECT * FROM employee_hierarchy;
```

---

## ETL & Data Loading

#### **COPY Command (Primary Loading Method)**

```sql
-- Load from S3
COPY customers
FROM 's3://my-bucket/customers/'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
FORMAT AS CSV
DELIMITER ','
IGNOREHEADER 1
REGION 'us-east-1';

-- Load JSON data
COPY events
FROM 's3://my-bucket/events.json'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
FORMAT AS JSON 'auto'
TIMEFORMAT 'YYYY-MM-DD HH:MI:SS';

-- Load with manifest file
COPY sales
FROM 's3://my-bucket/manifest.json'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
MANIFEST
DELIMITER '|'
GZIP;

-- Load from DynamoDB
COPY products
FROM 'dynamodb://ProductCatalog'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
READRATIO 25;
```

#### **UNLOAD Command**

```sql
-- Unload to S3
UNLOAD ('SELECT * FROM customers WHERE region = ''US''')
TO 's3://my-bucket/customers-us/'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
DELIMITER ','
HEADER
GZIP;

-- Unload with partitioning
UNLOAD ('SELECT * FROM sales')
TO 's3://my-bucket/sales/'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
PARTITION BY (year, month)
INCLUDE HEADER
MAXFILESIZE 100 MB;
```

#### **Data Pipeline Patterns**

```sql
-- Staging table pattern
CREATE TABLE staging_orders (LIKE orders);

-- Load into staging
COPY staging_orders
FROM 's3://my-bucket/daily-orders/'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
FORMAT AS CSV;

-- Validate and transform
INSERT INTO orders
SELECT
    order_id,
    customer_id,
    CASE WHEN order_date IS NULL THEN CURRENT_DATE ELSE order_date END,
    amount
FROM staging_orders
WHERE amount > 0 AND customer_id IS NOT NULL;

-- Clean up staging
DROP TABLE staging_orders;
```

#### **UPSERT Pattern (MERGE)**

```sql
-- Create staging table
CREATE TEMP TABLE staging_customers (LIKE customers);

-- Load new data
COPY staging_customers FROM 's3://bucket/customers-update/'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
FORMAT AS CSV;

-- Begin transaction
BEGIN;

-- Delete existing records that will be updated
DELETE FROM customers
USING staging_customers
WHERE customers.customer_id = staging_customers.customer_id;

-- Insert all records from staging
INSERT INTO customers
SELECT * FROM staging_customers;

-- Commit transaction
COMMIT;
```

---

## Cost Optimization

#### **Cluster Sizing**

```sql
-- Monitor cluster utilization
SELECT
    DATE_TRUNC('hour', starttime) as hour,
    AVG(cpu_user + cpu_system) as avg_cpu,
    MAX(cpu_user + cpu_system) as max_cpu
FROM stl_query_metrics
WHERE starttime >= CURRENT_DATE - 7
GROUP BY DATE_TRUNC('hour', starttime)
ORDER BY hour;

-- Check storage usage
SELECT
    schema,
    SUM(size) as total_size_mb,
    SUM(size) / 1024.0 as total_size_gb
FROM svv_table_info
GROUP BY schema
ORDER BY total_size_mb DESC;
```

#### **Reserved Instances vs On-Demand**

```sql
-- Calculate potential savings
-- Reserved Instance: 1-year term = ~40% savings
-- Reserved Instance: 3-year term = ~60% savings

-- Monitor usage patterns
SELECT
    DATE_TRUNC('day', recordtime) as day,
    COUNT(DISTINCT session) as concurrent_sessions,
    SUM(CASE WHEN event = 'authenticated' THEN 1 ELSE 0 END) as logins
FROM stl_connection_log
WHERE recordtime >= CURRENT_DATE - 30
GROUP BY DATE_TRUNC('day', recordtime)
ORDER BY day;
```

#### **Pause/Resume Clusters**

```sql
-- Automated pause/resume using AWS Lambda
-- Pause cluster during off-hours
aws redshift pause-cluster --cluster-identifier my-cluster

-- Resume cluster
aws redshift resume-cluster --cluster-identifier my-cluster
```

#### **Data Lifecycle Management**

```sql
-- Archive old data
CREATE TABLE orders_archive (LIKE orders);

-- Move old data
INSERT INTO orders_archive
SELECT * FROM orders
WHERE order_date < CURRENT_DATE - INTERVAL '2 years';

-- Delete from main table
DELETE FROM orders
WHERE order_date < CURRENT_DATE - INTERVAL '2 years';

-- Unload to S3 for long-term storage
UNLOAD ('SELECT * FROM orders_archive')
TO 's3://my-bucket/archive/orders/'
IAM_ROLE 'arn:aws:iam::account:role/RedshiftRole'
GZIP;
```

---

## Common Interview Questions

#### **Architecture Questions**

**Q: Explain Redshift's architecture and how it differs from traditional databases.**
**A:** Redshift uses a massively parallel processing (MPP) architecture with:

-   **Leader Node**: Coordinates queries, manages metadata
-   **Compute Nodes**: Store data and execute queries in parallel
-   **Columnar Storage**: Data stored by columns for better compression and analytics
-   **Shared-Nothing Architecture**: Each node has its own CPU, memory, and storage

**Q: What are the different node types in Redshift?**
**A:**

-   **RA3 Nodes**: Managed storage, separate compute and storage scaling
-   **DC2 Nodes**: SSD storage, good for performance-intensive workloads
-   **DS2 Nodes**: HDD storage (legacy), cost-effective for large datasets

**Q: How does data distribution work in Redshift?**
**A:** Four distribution styles:

-   **AUTO**: Redshift chooses optimal distribution
-   **KEY**: Distributes based on values in specified column
-   **ALL**: Copies entire table to all nodes (small tables)
-   **EVEN**: Distributes rows evenly across nodes

#### **Performance Questions**

**Q: How would you optimize a slow-running query in Redshift?**
**A:**

1. **Check execution plan**: Use EXPLAIN to identify bottlenecks
2. **Analyze distribution**: Ensure proper distribution keys to minimize data movement
3. **Review sort keys**: Use appropriate sort keys for filtering
4. **Update statistics**: Run ANALYZE to update table statistics
5. **Check for data skew**: Ensure even data distribution
6. **VACUUM tables**: Reclaim space and re-sort data
7. **Use compression**: Apply appropriate column compression

**Q: What is the difference between VACUUM and ANALYZE?**
**A:**

-   **VACUUM**: Reclaims space from deleted rows and re-sorts data according to sort keys
-   **ANALYZE**: Updates table statistics used by the query planner for optimization
-   **Best Practice**: Run both regularly, especially after large data loads

**Q: Explain sort keys and when to use compound vs interleaved.**
**A:**

-   **Compound Sort Key**: Sorts data hierarchically (date, then region, then product)
    -   Use when queries filter on prefix of sort key columns
-   **Interleaved Sort Key**: Gives equal weight to all columns
    -   Use when queries filter on any combination of sort key columns

#### **Data Loading Questions**

**Q: What's the most efficient way to load data into Redshift?**
**A:** Use the COPY command:

-   **Parallel loading**: Split files for parallel processing
-   **Compression**: Use GZIP or LZO compression
-   **Manifest files**: For complex loading scenarios
-   **Staging tables**: For data validation and transformation
-   **Batch loading**: Load in batches rather than row-by-row

**Q: How do you handle data updates in Redshift?**
**A:** Redshift doesn't support efficient updates, so use:

-   **DELETE + INSERT**: For small updates
-   **CREATE new table + RENAME**: For large updates
-   **Staging table pattern**: Load to staging, then merge
-   **Time-based partitioning**: Keep only recent data in main table

#### **Security Questions**

**Q: How do you implement security in Redshift?**
**A:**

-   **Network Security**: VPC, security groups, subnet groups
-   **Encryption**: At-rest (AES-256) and in-transit (SSL)
-   **Access Control**: Users, groups, and role-based permissions
-   **Row-Level Security**: Control access to specific rows
-   **Audit Logging**: CloudTrail and database audit logs
-   **Column-Level Security**: Encrypt sensitive columns

**Q: Explain Redshift's user and permission model.**
**A:**

-   **Users**: Individual database users
-   **Groups**: Collections of users for easier permission management
-   **Database Permissions**: CONNECT, CREATE, TEMP
-   **Schema Permissions**: USAGE, CREATE
-   **Table Permissions**: SELECT, INSERT, UPDATE, DELETE, REFERENCES
-   **Default Privileges**: Automatically grant permissions on future objects

#### **Troubleshooting Questions**

**Q: How would you troubleshoot a Redshift cluster that's running slowly?**
**A:**

1. **Check system tables**: stl_query_metrics, stv_wlm_query_state
2. **Identify long-running queries**: Look for queries consuming resources
3. **Check WLM configuration**: Ensure proper queue setup
4. **Monitor disk usage**: Look for tables needing VACUUM
5. **Check for data skew**: Ensure even distribution
6. **Review recent changes**: New data loads, schema changes
7. **Check cluster metrics**: CPU, memory, disk I/O in CloudWatch

**Q: What are common causes of poor query performance?**
**A:**

-   **Poor distribution key choice**: Causing data skew or excessive data movement
-   **Missing or inappropriate sort keys**: Inefficient data scanning
-   **Outdated statistics**: Query planner making poor decisions
-   **Tables needing VACUUM**: Fragmented data and poor sort order
-   **Inefficient joins**: Large table joins without proper distribution
-   **WLM configuration**: Queries waiting in queues or insufficient memory

#### **Best Practices Questions**

**Q: What are the best practices for Redshift table design?**
**A:**

-   **Choose appropriate distribution keys**: Frequently joined columns
-   **Use sort keys effectively**: Most filtered columns first
-   **Apply compression**: Use ANALYZE COMPRESSION recommendations
-   **Avoid small frequent loads**: Batch data loading
-   **Use appropriate data types**: Smallest possible data types
-   **Regular maintenance**: VACUUM and ANALYZE regularly

**Q: How do you monitor and maintain a Redshift cluster?**
**A:**

-   **CloudWatch metrics**: Monitor CPU, disk, network usage
-   **System tables**: Query performance and resource usage
-   **Automated snapshots**: Regular backup schedule
-   **WLM monitoring**: Queue performance and query distribution
-   **Regular VACUUM/ANALYZE**: Maintain table performance
-   **Cost monitoring**: Track usage and optimize resources
-   **Security audits**: Review user access and permissions

---

## Quick Reference Commands

#### **Essential System Tables**

```sql
-- Query performance
SELECT * FROM stl_query_metrics WHERE starttime >= CURRENT_DATE;

-- Current running queries
SELECT * FROM stv_recents WHERE status = 'Running';

-- Table information
SELECT * FROM svv_table_info ORDER BY size DESC;

-- WLM queue state
SELECT * FROM stv_wlm_query_state;

-- Connection logs
SELECT * FROM stl_connection_log WHERE recordtime >= CURRENT_DATE;

-- Load errors
SELECT * FROM stl_load_errors WHERE starttime >= CURRENT_DATE;
```

#### **Maintenance Commands**

```sql
-- Vacuum and analyze
VACUUM FULL table_name;
ANALYZE table_name;

-- Check compression
ANALYZE COMPRESSION table_name;

-- Grant permissions
GRANT SELECT ON TABLE schema.table TO GROUP group_name;

-- Create user and group
CREATE USER username PASSWORD 'password';
CREATE GROUP groupname;
ALTER GROUP groupname ADD USER username;
```

This cheatsheet covers all major aspects of AWS Redshift that are commonly asked in interviews, from basic concepts to advanced optimization techniques.
