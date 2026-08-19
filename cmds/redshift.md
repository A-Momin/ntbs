Amazon Redshift has several **Redshift-specific SQL commands** that are optimized for its architecture, particularly for performance tuning, data ingestion, and cluster management. Below are the most useful **Redshift-specific SQL commands**:

### 1. **Performance and Query Optimization**

-   **`VACUUM`**: Reclaims storage and sorts data to optimize query performance by reorganizing data on disk.

    ```sql
    VACUUM [ FULL | SORT ONLY | DELETE ONLY ] [ table_name ]
    ```

-   **`ANALYZE`**: Updates table statistics to help the query optimizer create better execution plans.

    ```sql
    ANALYZE [ table_name | ALL ]
    ```

-   **`EXPLAIN`**: Shows the execution plan for a query, useful for debugging and performance tuning.

    ```sql
    EXPLAIN SELECT * FROM table_name;
    ```

-   **`DISTKEY`** / **`SORTKEY`**: Specify how data should be distributed across nodes and sorted to improve performance.

    ```sql
    CREATE TABLE table_name (
      column1 INT,
      column2 VARCHAR(255)
    )
    DISTKEY(column1)
    SORTKEY(column2);
    ```

-   **`WLM` (Workload Management)**: Commands related to managing queues and workloads to allocate resources efficiently.
    ```sql
    ALTER SYSTEM SET work_mem TO '64MB';
    ```

### 2. **Data Loading and Unloading**

-   **`COPY`**: Bulk loads data from files in S3, DynamoDB, or other sources into Redshift tables.

    ```sql
    COPY table_name FROM 's3://bucket/file.csv'
    CREDENTIALS 'aws_access_key_id=ACCESS_KEY;aws_secret_access_key=SECRET_KEY'
    DELIMITER ','
    IGNOREHEADER 1;
    ```

-   **`UNLOAD`**: Exports data from Redshift tables to files in S3.
    ```sql
    UNLOAD ('SELECT * FROM table_name')
    TO 's3://bucket/output_file_prefix'
    CREDENTIALS 'aws_access_key_id=ACCESS_KEY;aws_secret_access_key=SECRET_KEY';
    ```

### 3. **Data Distribution and Sorting**

-   **`DISTSTYLE`**: Specifies the distribution style for a table, which affects how data is distributed across nodes.

    -   `DISTSTYLE EVEN`: Distributes rows evenly across all slices.
    -   `DISTSTYLE KEY`: Distributes rows based on the values in the DISTKEY.

    ```sql
    CREATE TABLE table_name (
      column1 INT,
      column2 VARCHAR(255)
    )
    DISTSTYLE KEY;
    ```

-   **`SORTKEY`**: Specifies how the data should be sorted, improving the efficiency of range queries.
    ```sql
    CREATE TABLE table_name (
      column1 INT,
      column2 VARCHAR(255)
    )
    SORTKEY (column1);
    ```

### 4. **Cluster and Session Management**

-   **`CANCEL`**: Cancels a running query.

    ```sql
    CANCEL pid;
    ```

-   **`SET`**: Sets parameters for the current session, such as time zone or query group.

    ```sql
    SET query_group TO 'group_name';
    ```

-   **`SHOW`**: Displays the current settings or values for various parameters.

    ```sql
    SHOW search_path;
    ```

-   **`LOCK`**: Acquires a lock on a table to prevent other operations from conflicting.
    ```sql
    LOCK table_name;
    ```

### 5. **System and Diagnostic Queries**

-   **`STL` and `SVL Tables`**: Redshift provides system tables like `STL_` (system logs) and `SVL_` (system views) for diagnosing performance issues and monitoring the cluster.

    -   **STL_QUERY**: Logs all SQL queries executed on the cluster.
    -   **SVV_TABLE_INFO**: Provides metadata about the tables, including size and distribution.

    ```sql
    SELECT * FROM stl_query WHERE user_id = 100;
    SELECT * FROM svv_table_info WHERE schema = 'public';
    ```

-   **`PG_TABLE_DEF`**: Shows the schema details for a table, including column names, data types, and distribution.
    ```sql
    SELECT * FROM pg_table_def WHERE tablename = 'table_name';
    ```

### 6. **Concurrency Scaling and Workload Management**

-   **`ALTER SYSTEM`**: Manages system-wide settings, such as enabling concurrency scaling.

    ```sql
    ALTER SYSTEM SET enable_concurrency_scaling = 1;
    ```

-   **`CREATE WLM QUERY MONITORING RULE`**: Allows you to define query monitoring rules to manage workloads based on duration, memory usage, etc.
    ```sql
    CREATE WLM QUERY MONITORING RULE long_running_queries
    FOR user_group user_group_name
    WLM_CLASSIFICATION 'user_class'
    ACTION log, abort;
    ```

### 7. **Backup and Restore**

-   **`BACKUP`**: Takes a snapshot of the Redshift cluster, either manual or automated.

    ```sql
    CREATE SNAPSHOT snapshot_name;
    ```

-   **`RESTORE`**: Restores data from a backup.
    ```sql
    RESTORE TABLE table_name FROM SNAPSHOT snapshot_name;
    ```

### 8. **Concurrency Scaling and Spectrum**

-   **`SPECTRUM`**: Allows querying data in S3 without loading it into Redshift.
    ```sql
    CREATE EXTERNAL SCHEMA spectrum_schema
    FROM DATA CATALOG
    DATABASE 'external_db'
    IAM_ROLE 'arn:aws:iam::account-id:role/MySpectrumRole';
    ```

### 9. **Materialized Views**

-   **`CREATE MATERIALIZED VIEW`**: Creates a materialized view that stores the result of a query physically, enabling faster access.

    ```sql
    CREATE MATERIALIZED VIEW view_name AS
    SELECT column1, column2 FROM table_name;
    ```

-   **`REFRESH MATERIALIZED VIEW`**: Refreshes the materialized view to ensure it contains the latest data.
    ```sql
    REFRESH MATERIALIZED VIEW view_name;
    ```

These Redshift-specific commands are essential for managing and optimizing Redshift clusters, improving query performance, handling data ingestion, and managing workloads effectively.
