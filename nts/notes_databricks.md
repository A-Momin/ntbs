-   <details><summary style="font-size:25px;color:#C71585">Delta Lake</summary>

    **Delta Lake** is an open-source storage layer that brings ACID transactions, schema enforcement, and time travel to big data workloads on data lakes like Amazon S3, Azure Data Lake, or HDFS.
    **Delta Lake** is an **open-source storage layer** that brings **ACID transactions**, **schema enforcement**, and **time travel** to big data lakes, especially on top of **Apache Spark** and **Databricks**.
    It’s built on **Apache Parquet** but adds reliability and data management features like a database.

    -   **Core Features of Delta Lake**

        | Feature                | Description                                                              |
        | ---------------------- | ------------------------------------------------------------------------ |
        | **ACID Transactions**  | Ensures reliable reads/writes using a transaction log.                   |
        | **Schema Enforcement** | Prevents bad or unexpected data from being written.                      |
        | **Time Travel**        | Allows access to previous versions of the data using versioning.         |
        | **Scalable Metadata**  | Stores metadata in logs rather than memory (unlike Hive).                |
        | **Data Lineage**       | Tracks changes to your data for auditing and debugging.                  |
        | **Upserts (MERGE)**    | Supports `MERGE INTO`, `UPDATE`, `DELETE`, and `INSERT` like SQL tables. |
        | **Streaming + Batch**  | Supports concurrent batch and streaming reads/writes.                    |

    -   **Architecture Overview**:

        ```
        Client (Spark, Databricks, etc.)
        |
        V
        Delta Lake API (Spark Connector)
        |
        V
        Delta Transaction Log (_delta_log/)
        |
        V
        Parquet Files (data)
        |
        V
        Cloud Storage (S3, ADLS, HDFS)
        ```

    -   **When to Use Delta Lake?**

        -   You need ACID on your data lake
        -   You're managing streaming + batch pipelines
        -   You want versioning & rollback
        -   You want reliable CDC or upserts
        -   You're using Spark, Databricks, or cloud-based lakes

    #### 🧱 Key Components of Delta Lake

    1.  -   **Delta Table**: A **Delta Table** is a **transactional table** stored in cloud storage (like S3 or ADLS) using **Apache Parquet** format with **ACID guarantees**.

        -   Think of it like a **traditional RDBMS table**, but stored in **data lake** (e.g., S3).
        -   Supports **reads**, **writes**, **updates**, **merges**, and **deletes** reliably.
        -   Used in Databricks, Spark, and other Delta Lake-compatible engines.

        ```sql
        CREATE TABLE sales USING DELTA LOCATION '/mnt/data/sales';
        ```

    2.  **`_delta_log` (Transaction Log)**:

        -   A hidden folder that tracks **every operation** (like insert, update, delete) on the Delta table.
        -   Stored at the **root of the Delta table directory**.
        -   Contains:

            -   **JSON files** for each commit (operation metadata)
            -   **Checkpoint Parquet files** to speed up reads

        -   It’s like a **version control system** (e.g., Git) for your data.

        -   Example directory structure:

            ```
            /mnt/data/sales/
            ├── part-00001.snappy.parquet
            ├── part-00002.snappy.parquet
            └── _delta_log/
                    ├── 00000000000000000000.json
                    ├── 00000000000000000001.json
                    └── 00000000000000000010.checkpoint.parquet
            ```

    3.  **Time Travel**: **Time Travel** lets you **query or restore** data **as it existed at a previous point in time** (by version number or timestamp).

        -   Built on top of the `_delta_log` history
        -   Useful for:

            -   Debugging data issues
            -   Auditing changes
            -   Rolling back mistakes

        ```sql
        -- Query a previous version of the table
        SELECT * FROM sales VERSION AS OF 5;

        -- Query by timestamp
        SELECT * FROM sales TIMESTAMP AS OF '2024-07-01T00:00:00.000Z';
        ```

    4.  **Parquet Files**: Actual data files. Delta Lake uses Apache Parquet for storage.

        -   Delta tracks which Parquet files are active via the log.
        -   When data is updated/deleted, new Parquet files are written and old ones are logically removed (not physically deleted immediately).

    5.  **Schema Enforcement & Evolution**: Delta validates the schema during write operations. You can optionally allow **schema evolution** if the structure changes.

        -   **Schema Enforcement (a.k.a. Schema Validation)**

            -   Prevents **bad or incompatible data** from being written into a Delta table.
            -   It **checks column names and data types** during write operations.
            -   If the incoming data doesn't match the table schema, the write will **fail**.
            -   📌 Think of it as a **data firewall** — only valid data is allowed in.

        -   **Schema Evolution**

            -   Allows the **table schema to automatically adapt** to new columns or types when data is written.
            -   Useful in **append** operations or when ingesting data with evolving schemas.
            -   📌 Think of it as **schema auto-update** — Delta updates the table structure when needed (if allowed).
            -   Must be enabled explicitly:
                ```python
                df.write.option("mergeSchema", "true").format("delta").mode("append").save("/delta/events")
                ```

    6.  **Upserts / Merge**: Delta supports SQL-style merge:

            ```sql
            MERGE INTO target
            USING source
            ON target.id = source.id
            WHEN MATCHED THEN UPDATE ...
            WHEN NOT MATCHED THEN INSERT ...
            ```

        -   Efficient for CDC (change data capture), de-duplication, etc.

    7.  **Concurrency Control**: Delta supports concurrent streaming and batch jobs using a combination of:

        -   **Optimistic concurrency control**
        -   **Transaction logs** for consistent views
        -   **Automatic conflict detection**

    </details>

---

-   <details><summary style="font-size:25px;color:#C71585">Unity Catalog</summary>

    -   [Unity Catalog](https://docs.databricks.com/aws/en/data-governance/unity-catalog/)
    -   [Data governance with Databricks](https://docs.databricks.com/aws/en/data-governance/)

    **Unity Catalog** is Databricks' unified governance layer that helps you manage data access, auditing, lineage, and cataloging across all your workspaces — for tables, files, machine learning models, notebooks, and more — in one place.

    **Unity Catalog** = Centralized, secure, searchable data catalog + access control system for everything in Databricks.

    It provides a **centralized, fine-grained, and secure data catalog** across **Workspaces**, **Cloud storage**, **Data lakes (like Delta Lake, Parquet)**, **Tables, views, ML models, notebooks**. Think of it as an **enterprise data catalog + permission system** across all Databricks assets.

    -   **Hierarchical Structure**

        ```
        Metastore (per cloud account)
        └── Catalog (e.g., analytics_catalog)
                └── Schema (e.g., marketing)
                    └── Table/View (e.g., ad_clicks, campaign_stats)
        ```

    -   **Example Use Cases**:

        1. Centralized governance across workspaces
        2. Fine-grained access control on data assets
        3. Automated audit + lineage tracking
        4. Secure external data access (S3/ADLS)
        5. Data sharing without data duplication

    -   **Example SQL Flow**:

        ```sql
        -- Switch to catalog & schema
        USE CATALOG analytics_catalog;
        USE SCHEMA marketing;

        -- Create a managed Delta table
        CREATE TABLE campaign_stats (
        id INT,
        clicks INT,
        impressions INT
        );

        -- Grant read-only access
        GRANT SELECT ON TABLE campaign_stats TO `marketing_analyst`;

        -- View lineage in UI automatically
        ```

    #### Core Components of Unity Catalog

    1. **Metastore**:

        - The **top-level container**.
        - One Unity Catalog metastore per region per cloud account.
        - It maps users/groups to data and tracks metadata.
        - Backed by an S3 bucket (AWS), ADLS (Azure), or GCS (GCP).

    2. **Catalog**:

        - Logical grouping of schemas/databases.
        - Example: `finance_catalog`, `marketing_catalog`.

        ```sql
        SELECT * FROM finance_catalog.sales_schema.transactions;
        ```

        > You can apply permissions at the catalog level.

    3. **Schema (Database)**:

        - Group of related tables and views.
        - Equivalent to a **database** in other systems.
        - Nested inside a Catalog.

        ```sql
        USE CATALOG finance_catalog;
        USE SCHEMA sales_schema;
        ```

    4. **Table / View**:

        - The actual **data object** (Delta table, Parquet, view, etc.)
        - Unity Catalog supports:

            - **Managed tables**
            - **External tables**
            - **Views** (temp and permanent)

    5. **User & Group Permissions**:

        - Uses **Identity Federation** (via SCIM or workspace identities).
        - Permissions controlled via **GRANT/REVOKE** on Catalogs, Schemas, Tables, Views

        - Example:

            ```sql
            GRANT SELECT ON TABLE sales TO `data_analyst`;
            ```

    6. **Data Lineage (Automatic)**:

        - Unity Catalog automatically captures **data lineage**:

            - What data was read?
            - What was written?
            - Which notebooks or jobs triggered it?

        Lineage is **visible in Databricks UI** per table or column.

    7. **Audit Logging**:

        - Built-in **audit logs** track:

            - Who accessed what data
            - What operation they performed
            - From which workspace or job

        - Useful for compliance and security.

    8. **External Locations & Storage Credentials**:

        - Controls **secure access to cloud storage** (e.g., S3/ADLS).
        - You define:

            - `storage_credential` (IAM role or SAS token)
            - `external_location` (actual S3/ADLS URI)

        - Example:

            ```sql
            CREATE EXTERNAL LOCATION ext_location
            URL 's3://my-bucket/data'
            WITH (STORAGE CREDENTIAL my_iam_role);
            ```

    9. **Managed vs. External Tables**:

        | Type           | Storage Location               | Managed by UC? | Deletion behavior         |
        | -------------- | ------------------------------ | -------------- | ------------------------- |
        | Managed Table  | Unity Catalog-managed location | Yes            | Deletes data and metadata |
        | External Table | Your custom S3/ADLS location   | No             | Only deletes metadata     |

    10. **Data Sharing (Delta Sharing)**:

        - Unity Catalog integrates with **Delta Sharing**.
        - You can **share data** securely across regions or even external partners **without copying data**.

    #### Summary

    | Feature            | Purpose                                      |
    | ------------------ | -------------------------------------------- |
    | Metastore          | Central control plane for data assets        |
    | Catalogs & Schemas | Logical grouping and access control          |
    | Tables/Views       | Actual structured data assets                |
    | Lineage & Auditing | Visibility into how and by whom data is used |
    | External Locations | Secure data lake access via credentials      |
    | Delta Sharing      | Share data externally without moving it      |

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Databricks Overview</summary>

    -   **Databricks** is a **unified analytics platform** built on **Apache Spark**, offering an interactive workspace for data engineering, machine learning, and data analytics.
    -   It is cloud-based and integrates with AWS, Azure, and GCP.

    #### Core Architecture Concepts

    -   **Apache Spark**

        -   Distributed data processing engine.
        -   Databricks is built on Spark but enhances it with managed infrastructure and collaborative features.

    -   **Delta Lake**

        -   An open-source storage layer that brings **ACID transactions** to data lakes.
        -   Supports **schema enforcement**, **time travel**, and **unified batch + streaming**.

    -   **Lakehouse Architecture**

        -   Combines the reliability of data warehouses with the scalability of data lakes.
        -   Uses Delta Lake as the foundational layer.

    #### Workspace Components

    -   **Workspace**

        -   The main UI environment where users manage notebooks, clusters, jobs, libraries, and data.

    -   **Notebooks**

        -   Interactive web-based editor supporting **multiple languages** (Python, SQL, Scala, R).
        -   Provides real-time collaboration like Google Docs.

    -   **Repos**

        -   Git integration within Databricks.
        -   Enables version control and CI/CD workflows via GitHub, GitLab, or Azure Repos.

    -   **Dashboards**

        -   Visualization panels built from notebook outputs.
        -   Used to present insights to non-technical stakeholders.

    #### Compute & Execution

    -   **Clusters**

        -   Scalable compute engines managed by Databricks.
        -   Types:

            -   **Interactive Clusters**: Used for development and exploration.
            -   **Job Clusters**: Auto-terminated, used for scheduled jobs.

    -   **Jobs**

        -   Scheduled workflows for running notebooks, JARs, Python scripts, or Spark submit tasks.
        -   Supports **triggers**, **retry policies**, and **multi-task jobs** (DAG-based).

    -   **DBUtils**

        -   Utility library to interact with the system.
        -   Functions for filesystem (`dbutils.fs`), secrets (`dbutils.secrets`), widgets, etc.

    #### Data & Storage Concepts

    -   **Databricks File System (DBFS)**

        -   Abstraction over cloud object storage (e.g., S3, ADLS).
        -   Appears as a distributed file system under `/dbfs`.

    -   **Tables**

        -   Structured data stored in **Delta**, **Parquet**, or other formats.
        -   Managed or external tables are supported.

    -   **Catalogs, Schemas, Tables**

        -   **Catalog** > **Schema** > **Table** hierarchy is used in Unity Catalog.
        -   Enables data governance and multi-tenant access control.

    -   **Mount Points**

        -   Link external storage locations (e.g., S3 buckets) to DBFS paths using `dbutils.fs.mount`.

    #### Security & Governance

    -   **Access Control Lists (ACLs)**

        -   Control permissions at the **workspace**, **cluster**, **table**, or **notebook** level.

    -   **Unity Catalog**

        -   Centralized governance layer to manage data access, discovery, and lineage across all workspaces.
        -   Supports fine-grained access policies and auditing.

    -   **Secrets**

        -   Store credentials securely using `dbutils.secrets`.
        -   Integrated with cloud secret managers like AWS Secrets Manager.

    #### Development Concepts

    -   **Languages Supported**

        -   **PySpark**: Python API for Spark.
        -   **Scala/Java**: Native Spark APIs.
        -   **SQL**: For querying structured data.
        -   **R**: Statistical computing.

    -   **Libraries**

        -   Custom or third-party packages that can be installed via PyPI, Maven, or CRAN.
        -   Can be attached to clusters manually or through init scripts.

    -   **Widgets**

        -   UI inputs added to notebooks using `dbutils.widgets` for parameterization and interactivity.

    #### Machine Learning & AI

    -   **MLflow**

        -   Open-source platform for managing ML lifecycle.
        -   Components:

            -   **Tracking**: Log experiments and metrics.
            -   **Projects**: Package ML code.
            -   **Models**: Version and store models.
            -   **Registry**: Manage model lifecycle.

    -   **Feature Store**

        -   Centralized repository to create, manage, and reuse features for ML models.

    -   **AutoML**

        -   Automatically trains and tunes models with minimal input.
        -   Provides notebooks with code for transparency.

    #### Streaming and Real-Time Data

    -   **Structured Streaming**

        -   Built on Spark, processes data incrementally and continuously.
        -   Supports **Delta Live Tables**, **Kafka**, and other sources.

    -   **Delta Live Tables (DLT)**

        -   Managed ETL framework for building reliable data pipelines.
        -   Supports declarative syntax and automatic error handling.

    #### Collaboration & Productivity

    -   **Co-Authoring**

        -   Multiple users can edit notebooks simultaneously.

    -   **Commenting**

        -   Inline comments for collaboration and documentation.

    -   **Version Control**

        -   Notebooks and repos can be versioned and rolled back.

    #### Integration & Extensibility

    -   **Partner Integrations**

        -   Native connectors to **Power BI**, **Tableau**, **Airflow**, **Snowflake**, etc.

    -   **REST API / CLI / SDKs**

        -   Automate tasks and integrate with external tools using:

            -   **Databricks REST API**
            -   **Databricks CLI**
            -   **Databricks Terraform Provider**
            -   **Databricks SDKs (Python, Go)**

    -   **Init Scripts**

        -   Custom shell scripts executed during cluster start-up for configuring environment.

    #### Monitoring & Logging

    -   **Cluster Event Logs**

        -   Track start/stop events, errors, and resource usage.

    -   **Ganglia / Spark UI**

        -   Visual interfaces to monitor metrics like memory usage, executor logs, DAG execution.

    -   **Audit Logs**

        -   Available in enterprise versions, used for compliance and security audits.

    #### Pricing & Editions

    -   **Pricing Models**

        -   Pay-per-use based on **Databricks Units (DBUs)**.
        -   Separate compute and storage costs.

    -   **Tiers**

        -   **Community Edition**: Free for basic use.
        -   **Standard**, **Premium**, and **Enterprise** tiers available with increasing features.

    Let me know if you want a visual version, mind map, or flashcards for any of these topics!

    </details>

-   <details><summary style="font-size:25px;color:Orange">Comprehensive Databricks Components and Concepts Guide</summary>

    ## Table of Contents

    1. [Databricks Platform Overview](#databricks-platform-overview)
    2. [Core Architecture Components](#core-architecture-components)
    3. [Compute Components](#compute-components)
    4. [Storage and Data Management](#storage-and-data-management)
    5. [Development and Collaboration](#development-and-collaboration)
    6. [Analytics and Business Intelligence](#analytics-and-business-intelligence)
    7. [Machine Learning and AI](#machine-learning-and-ai)
    8. [Security and Governance](#security-and-governance)
    9. [Integration and Connectivity](#integration-and-connectivity)
    10. [Advanced Features and Optimization](#advanced-features-and-optimization)

    ## Databricks Platform Overview

    #### **What is Databricks?**

    Databricks is a **unified analytics platform** that combines the power of Apache Spark with a collaborative, cloud-native environment designed for data engineering, data science, and machine learning workloads. It's built on the concept of the **Lakehouse architecture**, which merges the flexibility of data lakes with the performance and reliability of data warehouses.

    **Think of Databricks as:**

    -   A **digital laboratory** where data scientists, engineers, and analysts collaborate
    -   A **high-performance computing cluster** that scales automatically
    -   A **unified workspace** that eliminates data silos
    -   A **production-ready platform** for enterprise data workloads

    #### **Core Philosophy: The Lakehouse**

    The Lakehouse architecture represents a paradigm shift in data management:

    ```
    Traditional Architecture:
    Data Lake (Raw Data) → ETL → Data Warehouse (Structured Data) → BI Tools

    Lakehouse Architecture:
    Unified Storage Layer with ACID Transactions + Schema Enforcement + Performance Optimization
    ```

    **Benefits of Lakehouse:**

    -   **Single Source of Truth**: All data in one place
    -   **Cost Efficiency**: Store data in open formats (Parquet, Delta)
    -   **Performance**: Query performance comparable to data warehouses
    -   **Flexibility**: Handle structured, semi-structured, and unstructured data
    -   **Real-time Processing**: Unified batch and streaming analytics

    ## Core Architecture Components

    #### **Apache Spark Foundation**

    Databricks is built on **Apache Spark**, a distributed computing framework designed for big data processing.

    **Spark Core Components:**

    1. **Driver Program**: The main program that coordinates the Spark application
    2. **Cluster Manager**: Manages resources across the cluster
    3. **Executors**: Worker nodes that execute tasks
    4. **Tasks**: Individual units of work sent to executors

    ```python
    # Spark Context - The entry point to Spark functionality
    from pyspark.sql import SparkSession

    spark = SparkSession.builder \
        .appName("MyDataApplication") \
        .config("spark.sql.adaptive.enabled", "true") \
        .getOrCreate()

    # Spark automatically handles:
    # - Data partitioning across nodes
    # - Task scheduling and execution
    # - Fault tolerance and recovery
    # - Memory management
    ```

    **Spark's Distributed Computing Model:**

    ```
    Driver Node
    ├── Creates SparkContext
    ├── Defines transformations and actions
    ├── Schedules tasks across cluster
    └── Collects results

    Worker Nodes (Executors)
    ├── Execute tasks in parallel
    ├── Store data in memory/disk
    ├── Report status back to driver
    └── Handle data locality optimization
    ```

    #### **Databricks Runtime**

    The **Databricks Runtime** is an optimized version of Apache Spark that includes:

    **Performance Optimizations:**

    -   **Photon Engine**: Vectorized query engine for SQL workloads
    -   **Auto Optimization**: Automatic file compaction and indexing
    -   **Adaptive Query Execution**: Dynamic optimization during query execution
    -   **Delta Engine**: Optimized processing for Delta Lake tables

    **Additional Libraries:**

    -   Pre-installed ML libraries (scikit-learn, TensorFlow, PyTorch)
    -   Visualization libraries (matplotlib, seaborn, plotly)
    -   Connectivity drivers (JDBC, ODBC)
    -   Custom Databricks utilities

    ```python
    # Example of Databricks-specific optimizations
    # Automatic file compaction
    spark.sql("OPTIMIZE my_table")

    # Z-ordering for better query performance
    spark.sql("OPTIMIZE my_table ZORDER BY (customer_id, date)")

    # Automatic statistics collection
    spark.sql("ANALYZE TABLE my_table COMPUTE STATISTICS")
    ```

    ## Compute Components

    ### Clusters - The Computing Engine

    **What are Clusters?**
    Clusters are groups of virtual machines that provide the computational power for your data processing tasks. Think of a cluster as a **team of specialized workers** where each worker (node) has specific roles and capabilities.

    #### **Cluster Types**

    ##### **1. All-Purpose Clusters**

    **Purpose**: Interactive development, exploration, and ad-hoc analysis
    **Analogy**: Like a **research laboratory** that stays open for ongoing experiments

    **Characteristics:**

    -   Persistent and shareable across users
    -   Support multiple languages (Python, Scala, SQL, R)
    -   Interactive notebook execution
    -   Manual start/stop control
    -   Ideal for development and exploration

    **Configuration Example:**

    ```json
    {
        "cluster_name": "analytics-cluster",
        "spark_version": "11.3.x-scala2.12",
        "node_type_id": "i3.xlarge",
        "driver_node_type_id": "i3.xlarge",
        "num_workers": 3,
        "autoscale": {
            "min_workers": 1,
            "max_workers": 8
        },
        "auto_termination_minutes": 120,
        "spark_conf": {
            "spark.sql.adaptive.enabled": "true",
            "spark.sql.adaptive.coalescePartitions.enabled": "true"
        }
    }
    ```

    ##### **2. Job Clusters**

    **Purpose**: Automated workloads and production jobs
    **Analogy**: Like a **specialized construction crew** hired for a specific project

    **Characteristics:**

    -   Created for specific job execution
    -   Automatically terminated after job completion
    -   Cost-effective for production workloads
    -   Optimized for specific job requirements
    -   No interactive access

    **Use Cases:**

    -   ETL pipelines
    -   Scheduled reports
    -   Model training jobs
    -   Data validation processes

    ##### **3. SQL Warehouses (Compute Clusters)**

    **Purpose**: SQL analytics and BI workloads
    **Analogy**: Like a **dedicated query processing center**

    **Characteristics:**

    -   Optimized for SQL queries
    -   Photon engine acceleration
    -   Automatic scaling based on query load
    -   Serverless option available
    -   BI tool integration

    #### **Cluster Architecture Deep Dive**

    ```
    Cluster Architecture:
    ┌─────────────────────────────────────────────────────────────┐
    │                    Driver Node                              │
    │  ┌─────────────────┐  ┌─────────────────┐                  │
    │  │   Spark Driver  │  │  Databricks     │                  │
    │  │   - SparkContext│  │  Agent          │                  │
    │  │   - DAG Scheduler│  │  - Monitoring   │                  │
    │  │   - Task Scheduler│ │  - Logging      │                  │
    │  └─────────────────┘  └─────────────────┘                  │
    └─────────────────────────────────────────────────────────────┘
                                │
                                │ (Cluster Communication)
                                │
    ┌─────────────────────────────────────────────────────────────┐
    │                    Worker Nodes                            │
    │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
    │  │  Executor 1 │  │  Executor 2 │  │  Executor N │        │
    │  │  - Tasks    │  │  - Tasks    │  │  - Tasks    │        │
    │  │  - Cache    │  │  - Cache    │  │  - Cache    │        │
    │  │  - Storage  │  │  - Storage  │  │  - Storage  │        │
    │  └─────────────┘  └─────────────┘  └─────────────┘        │
    └─────────────────────────────────────────────────────────────┘
    ```

    #### **Auto-scaling and Resource Management**

    **Auto-scaling Behavior:**

    ```python
    # Auto-scaling configuration
    autoscale_config = {
        "min_workers": 2,      # Minimum nodes to keep running
        "max_workers": 20,     # Maximum nodes during peak load
        "target_workers": 5    # Preferred number of workers
    }

    # Scaling triggers:
    # - Scale UP when: CPU > 80% for 2+ minutes
    # - Scale DOWN when: CPU < 30% for 10+ minutes
    # - Consider pending tasks and queue length
    # - Respect min/max boundaries
    ```

    **Resource Allocation:**

    -   **Driver Node**: Coordinates tasks, stores small results, runs application logic
    -   **Worker Nodes**: Execute tasks, store cached data, perform computations
    -   **Memory Management**: Automatic allocation between execution and storage
    -   **CPU Utilization**: Dynamic task scheduling across available cores

    #### **Cluster Policies and Governance**

    **Cluster Policies** allow administrators to control cluster configurations:

    ```json
    {
        "policy_name": "standard-analytics-policy",
        "definition": {
            "node_type_id": {
                "type": "allowlist",
                "values": ["i3.large", "i3.xlarge", "i3.2xlarge"]
            },
            "max_workers": {
                "type": "range",
                "maxValue": 10
            },
            "auto_termination_minutes": {
                "type": "fixed",
                "value": 60
            },
            "spark_conf": {
                "spark.sql.adaptive.enabled": {
                    "type": "fixed",
                    "value": "true"
                }
            }
        }
    }
    ```

    ### Serverless Compute

    **What is Serverless Compute?**
    Serverless compute eliminates the need to manage clusters by providing **on-demand, auto-scaling compute resources**.

    **Benefits:**

    -   **Instant Start**: No cluster startup time
    -   **Automatic Scaling**: Scales to zero when not in use
    -   **Cost Optimization**: Pay only for actual compute time
    -   **Simplified Management**: No cluster configuration needed

    **Use Cases:**

    -   Ad-hoc SQL queries
    -   Lightweight data exploration
    -   Development and testing
    -   Intermittent workloads

    ## Storage and Data Management

    ### DBFS (Databricks File System)

    **What is DBFS?**
    DBFS is a **distributed file system** that provides a unified interface to various cloud storage systems. Think of it as a **universal translator** that lets you access any storage system using the same commands.

    #### **DBFS Architecture**

    ```
    DBFS Layer (Abstraction)
    ├── /databricks-datasets/     (Sample datasets)
    ├── /databricks-results/      (Query results)
    ├── /FileStore/              (Uploaded files)
    ├── /mnt/                    (Mounted storage)
    │   ├── /mnt/s3-bucket/      (AWS S3)
    │   ├── /mnt/adls-container/ (Azure Data Lake)
    │   └── /mnt/gcs-bucket/     (Google Cloud Storage)
    └── /tmp/                    (Temporary files)
    ```

    #### **DBFS Operations**

    ```python
    # File system operations using dbutils
    dbutils.fs.ls("/databricks-datasets/")

    # Copy files
    dbutils.fs.cp("/source/path", "/destination/path", recurse=True)

    # Remove files
    dbutils.fs.rm("/path/to/file", recurse=True)

    # Create directories
    dbutils.fs.mkdirs("/new/directory/path")

    # Mount external storage
    dbutils.fs.mount(
        source="s3a://my-bucket/data/",
        mount_point="/mnt/my-data",
        extra_configs={
            "fs.s3a.access.key": "ACCESS_KEY",
            "fs.s3a.secret.key": "SECRET_KEY"
        }
    )

    # Access mounted data
    df = spark.read.parquet("/mnt/my-data/sales/")
    ```

    #### **Storage Integration Patterns**

    **1. Direct Access Pattern:**

    ```python
    # Direct S3 access
    df = spark.read.format("delta") \
        .option("path", "s3://bucket/path/to/delta-table") \
        .load()
    ```

    **2. Mount Pattern:**

    ```python
    # Mount once, use everywhere
    dbutils.fs.mount(source="s3a://bucket/", mount_point="/mnt/data")
    df = spark.read.format("delta").load("/mnt/data/delta-table")
    ```

    **3. Unity Catalog Pattern:**

    ```sql
    -- Managed through Unity Catalog
    CREATE TABLE catalog.schema.table_name
    USING DELTA
    LOCATION 's3://bucket/path/to/table'
    ```

    ### Delta Lake - The Storage Revolution

    **What is Delta Lake?**
    Delta Lake is an **open-source storage layer** that brings **ACID transactions**, **scalable metadata handling**, and **time travel** capabilities to data lakes. Think of it as **Git for data** - it provides versioning, branching, and reliable data management.

    #### **Core Delta Lake Features**

    ##### **1. ACID Transactions**

    **Problem Solved**: Data corruption during concurrent writes
    **Solution**: Atomic, Consistent, Isolated, Durable operations

    ```python
    # Multiple writers can safely write to the same table
    # Writer 1
    df1.write.format("delta").mode("append").save("/path/to/table")

    # Writer 2 (concurrent)
    df2.write.format("delta").mode("append").save("/path/to/table")

    # Delta Lake ensures:
    # - No partial writes
    # - No data corruption
    # - Consistent reads during writes
    ```

    ##### **2. Time Travel (Data Versioning)**

    **Capability**: Access historical versions of your data

    ```python
    # Read current version
    current_df = spark.read.format("delta").load("/path/to/table")

    # Read data as of specific timestamp
    historical_df = spark.read.format("delta") \
        .option("timestampAsOf", "2023-01-01 00:00:00") \
        .load("/path/to/table")

    # Read data as of specific version
    version_df = spark.read.format("delta") \
        .option("versionAsOf", 5) \
        .load("/path/to/table")

    # View table history
    spark.sql("DESCRIBE HISTORY delta.`/path/to/table`").show()
    ```

    ##### **3. Schema Evolution**

    **Capability**: Safely evolve table schemas over time

    ```python
    # Original schema: id, name, age
    original_df = spark.createDataFrame([
        (1, "John", 25),
        (2, "Jane", 30)
    ], ["id", "name", "age"])

    original_df.write.format("delta").save("/path/to/table")

    # New schema: id, name, age, city (added column)
    new_df = spark.createDataFrame([
        (3, "Bob", 35, "NYC"),
        (4, "Alice", 28, "LA")
    ], ["id", "name", "age", "city"])

    # Schema evolution with mergeSchema option
    new_df.write.format("delta") \
        .mode("append") \
        .option("mergeSchema", "true") \
        .save("/path/to/table")
    ```

    ##### **4. Data Quality and Constraints**

    **Capability**: Enforce data quality rules at the storage layer

    ```sql
    -- Add constraints to ensure data quality
    ALTER TABLE my_table ADD CONSTRAINT age_positive CHECK (age > 0);
    ALTER TABLE my_table ADD CONSTRAINT email_format CHECK (email LIKE '%@%.%');

    -- Constraints are enforced on all writes
    INSERT INTO my_table VALUES (1, 'John', -5, 'invalid-email'); -- This will fail
    ```

    #### **Delta Lake Operations**

    ##### **MERGE (Upsert) Operations**

    ```python
    # Complex upsert logic
    from delta.tables import DeltaTable

    # Load existing Delta table
    delta_table = DeltaTable.forPath(spark, "/path/to/table")

    # Perform merge operation
    delta_table.alias("target").merge(
        new_data.alias("source"),
        "target.id = source.id"
    ).whenMatchedUpdate(set={
        "name": "source.name",
        "age": "source.age",
        "updated_at": "current_timestamp()"
    }).whenNotMatchedInsert(values={
        "id": "source.id",
        "name": "source.name",
        "age": "source.age",
        "created_at": "current_timestamp()",
        "updated_at": "current_timestamp()"
    }).execute()
    ```

    ##### **Optimization Operations**

    ```python
    # Optimize file sizes (compact small files)
    spark.sql("OPTIMIZE my_table")

    # Z-order optimization for better query performance
    spark.sql("OPTIMIZE my_table ZORDER BY (customer_id, date)")

    # Vacuum old files (clean up old versions)
    spark.sql("VACUUM my_table RETAIN 168 HOURS") # Keep 7 days of history
    ```

    #### **Delta Lake Architecture**

    ```
    Delta Lake Architecture:
    ┌─────────────────────────────────────────────────────────────┐
    │                    Delta Table                              │
    │  ┌─────────────────┐  ┌─────────────────┐                  │
    │  │   Transaction   │  │    Data Files   │                  │
    │  │      Log        │  │    (Parquet)    │                  │
    │  │  ┌───────────┐  │  │  ┌───────────┐  │                  │
    │  │  │ Version 0 │  │  │  │  Part 1   │  │                  │
    │  │  │ Version 1 │  │  │  │  Part 2   │  │                  │
    │  │  │ Version 2 │  │  │  │  Part N   │  │                  │
    │  │  │    ...    │  │  │  └───────────┘  │                  │
    │  │  └───────────┘  │  └─────────────────┘                  │
    │  └─────────────────┘                                       │
    └─────────────────────────────────────────────────────────────┘
    ```

    **Transaction Log Details:**

    -   **JSON files** that record every change to the table
    -   **Atomic operations** ensure consistency
    -   **Metadata** includes schema, partitioning, statistics
    -   **Checkpoint files** for efficient metadata reads

    ### Structured Streaming with Delta Lake

    **Real-time Data Processing:**

    ```python
    # Read streaming data
    streaming_df = spark.readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", "localhost:9092") \
        .option("subscribe", "events") \
        .load()

    # Process streaming data
    processed_df = streaming_df.select(
        from_json(col("value").cast("string"), schema).alias("data")
    ).select("data.*") \
    .withWatermark("timestamp", "10 minutes") \
    .groupBy(window(col("timestamp"), "5 minutes"), col("event_type")) \
    .count()

    # Write to Delta Lake (exactly-once semantics)
    query = processed_df.writeStream \
        .format("delta") \
        .outputMode("append") \
        .option("checkpointLocation", "/path/to/checkpoint") \
        .start("/path/to/delta-table")
    ```

    ## Development and Collaboration

    ### Workspaces - The Collaborative Environment

    **What are Workspaces?**
    A Workspace is your **collaborative digital environment** where teams organize, develop, and share data projects. Think of it as a **corporate office building** where different departments have their own floors, but everyone can access shared resources.

    #### **Workspace Organization**

    ```
    Workspace Hierarchy:
    ├── Users/                          (Personal folders)
    │   ├── john.doe@company.com/
    │   │   ├── Personal Projects/
    │   │   ├── Experiments/
    │   │   └── Drafts/
    │   └── jane.smith@company.com/
    ├── Shared/                         (Team collaboration)
    │   ├── Data Engineering/
    │   │   ├── ETL Pipelines/
    │   │   ├── Data Quality/
    │   │   └── Monitoring/
    │   ├── Data Science/
    │   │   ├── ML Models/
    │   │   ├── Feature Engineering/
    │   │   └── Experiments/
    │   └── Analytics/
    │       ├── Dashboards/
    │       ├── Reports/
    │       └── Ad-hoc Analysis/
    └── Repos/                          (Git integration)
        ├── data-platform-repo/
        ├── ml-models-repo/
        └── analytics-repo/
    ```

    #### **Workspace Features**

    ##### **1. Access Control and Permissions**

    ```python
    # Workspace-level permissions
    permissions = {
        "CAN_MANAGE": ["admin@company.com"],
        "CAN_EDIT": ["data-team@company.com"],
        "CAN_READ": ["analysts@company.com"],
        "CAN_RUN": ["business-users@company.com"]
    }

    # Object-level permissions (notebooks, folders)
    # - Owner: Full control
    # - Can Manage: Edit permissions and content
    # - Can Edit: Modify content
    # - Can Read: View content
    # - Can Run: Execute notebooks
    ```

    ##### **2. Resource Sharing**

    -   **Libraries**: Shared Python/Scala packages
    -   **Clusters**: Shared compute resources
    -   **Data Sources**: Common database connections
    -   **Secrets**: Secure credential management

    ##### **3. Workspace Administration**

    ```python
    # Workspace settings
    workspace_config = {
        "enable_notebook_table_clipboard": True,
        "enable_web_terminal": True,
        "enable_dbfs_file_browser": True,
        "max_notebook_size_mb": 10,
        "enable_experimental_features": False
    }
    ```

    ### Notebooks - Interactive Development Environment

    **What are Notebooks?**
    Notebooks are **interactive documents** that combine executable code, rich text, equations, and visualizations. Think of them as **digital lab notebooks** where you can document your thought process alongside executable experiments.

    #### **Notebook Architecture**

    ```
    Notebook Structure:
    ┌─────────────────────────────────────────────────────────────┐
    │                    Notebook Header                          │
    │  Title: Customer Analysis                                   │
    │  Language: Python  │  Cluster: analytics-cluster          │
    └─────────────────────────────────────────────────────────────┘
    ┌─────────────────────────────────────────────────────────────┐
    │                    Cell 1 (Markdown)                       │
    │  # Customer Segmentation Analysis                          │
    │  This notebook analyzes customer behavior patterns...      │
    └─────────────────────────────────────────────────────────────┘
    ┌─────────────────────────────────────────────────────────────┐
    │                    Cell 2 (Python)                         │
    │  import pandas as pd                                        │
    │  import matplotlib.pyplot as plt                           │
    │  df = spark.read.table("customers")                        │
    │  [Output: DataFrame preview]                               │
    └─────────────────────────────────────────────────────────────┘
    ┌─────────────────────────────────────────────────────────────┐
    │                    Cell 3 (SQL)                            │
    │  %sql                                                       │
    │  SELECT segment, COUNT(*) as customers                     │
    │  FROM customers GROUP BY segment                           │
    │  [Output: Query results + visualization]                   │
    └─────────────────────────────────────────────────────────────┘
    ```

    #### **Multi-Language Support**

    **Language Magic Commands:**

    ```python
    # Python (default)
    df = spark.read.table("sales")
    df.show()

    # SQL
    %sql
    SELECT * FROM sales WHERE amount > 1000

    # Scala
    %scala
    val df = spark.read.table("sales")
    df.show()

    # R
    %r
    library(SparkR)
    df <- sql("SELECT * FROM sales")
    head(df)

    # Shell commands
    %sh
    ls -la /dbfs/mnt/data/
    ```

    #### **Advanced Notebook Features**

    ##### **1. Widgets (Parameters)**

    ```python
    # Create input widgets for parameterization
    dbutils.widgets.text("start_date", "2023-01-01", "Start Date")
    dbutils.widgets.dropdown("region", "US", ["US", "EU", "APAC"], "Region")
    dbutils.widgets.multiselect("categories", "Electronics",
                            ["Electronics", "Clothing", "Books"], "Categories")

    # Use widget values
    start_date = dbutils.widgets.get("start_date")
    region = dbutils.widgets.get("region")
    categories = dbutils.widgets.get("categories").split(",")

    # Filter data based on parameters
    filtered_df = df.filter(
        (col("date") >= start_date) &
        (col("region") == region) &
        (col("category").isin(categories))
    )
    ```

    ##### **2. Notebook Workflows**

    ```python
    # Run another notebook and pass parameters
    result = dbutils.notebook.run(
        "/Shared/ETL/data_preprocessing",
        timeout_seconds=3600,
        arguments={"date": "2023-01-01", "region": "US"}
    )

    # Exit notebook with return value
    dbutils.notebook.exit({"status": "success", "records_processed": 10000})
    ```

    ##### **3. Visualization Integration**

    ```python
    # Built-in display() function
    display(df)  # Automatic table rendering with sorting/filtering

    # Matplotlib integration
    import matplotlib.pyplot as plt
    plt.figure(figsize=(10, 6))
    plt.plot(dates, values)
    plt.title("Sales Trend")
    displayHTML(plt.show())  # Render in notebook

    # Plotly integration
    import plotly.express as px
    fig = px.scatter(df.toPandas(), x="age", y="income", color="segment")
    fig.show()

    # Built-in chart creation
    display(df.groupBy("category").sum("amount"))  # Auto-generates charts
    ```

    #### **Collaborative Features**

    ##### **1. Real-time Collaboration**

    -   **Live editing**: Multiple users can edit simultaneously
    -   **Comments**: Add comments to cells for discussion
    -   **Revision history**: Track changes over time
    -   **Presence indicators**: See who's currently viewing/editing

    ##### **2. Notebook Sharing**

    ```python
    # Share notebook with specific permissions
    sharing_config = {
        "users": [
            {"email": "analyst@company.com", "permission": "CAN_EDIT"},
            {"email": "manager@company.com", "permission": "CAN_READ"}
        ],
        "groups": [
            {"name": "data-team", "permission": "CAN_EDIT"}
        ]
    }
    ```

    ### Jobs - Automation and Orchestration

    **What are Jobs?**
    Jobs are **automated workflows** that execute notebooks, JAR files, or Python scripts on a schedule or trigger. Think of them as **robotic assistants** that perform repetitive tasks without human intervention.

    #### **Job Types and Patterns**

    ##### **1. Single-Task Jobs**

    ```json
    {
        "name": "Daily Sales Report",
        "notebook_task": {
            "notebook_path": "/Shared/Reports/daily_sales",
            "base_parameters": {
                "date": "{{ds}}",
                "region": "US"
            }
        },
        "new_cluster": {
            "spark_version": "11.3.x-scala2.12",
            "node_type_id": "i3.large",
            "num_workers": 2
        },
        "schedule": {
            "quartz_cron_expression": "0 0 8 * * ?",
            "timezone_id": "America/New_York"
        }
    }
    ```

    ##### **2. Multi-Task Workflows**

    ```json
    {
        "name": "ETL Pipeline",
        "tasks": [
            {
                "task_key": "extract_data",
                "notebook_task": {
                    "notebook_path": "/ETL/extract"
                }
            },
            {
                "task_key": "transform_data",
                "notebook_task": {
                    "notebook_path": "/ETL/transform"
                },
                "depends_on": [{ "task_key": "extract_data" }]
            },
            {
                "task_key": "load_data",
                "notebook_task": {
                    "notebook_path": "/ETL/load"
                },
                "depends_on": [{ "task_key": "transform_data" }]
            },
            {
                "task_key": "data_quality_check",
                "notebook_task": {
                    "notebook_path": "/ETL/quality_check"
                },
                "depends_on": [{ "task_key": "load_data" }]
            }
        ]
    }
    ```

    ##### **3. Conditional Workflows**

    ```json
    {
        "name": "Conditional Processing",
        "tasks": [
            {
                "task_key": "check_data_availability",
                "notebook_task": {
                    "notebook_path": "/Checks/data_availability"
                }
            },
            {
                "task_key": "process_full_dataset",
                "notebook_task": {
                    "notebook_path": "/Processing/full_process"
                },
                "depends_on": [{ "task_key": "check_data_availability" }],
                "condition_task": {
                    "op": "EQUAL_TO",
                    "left": "{{tasks.check_data_availability.values.data_available}}",
                    "right": "true"
                }
            },
            {
                "task_key": "process_partial_dataset",
                "notebook_task": {
                    "notebook_path": "/Processing/partial_process"
                },
                "depends_on": [{ "task_key": "check_data_availability" }],
                "condition_task": {
                    "op": "EQUAL_TO",
                    "left": "{{tasks.check_data_availability.values.data_available}}",
                    "right": "false"
                }
            }
        ]
    }
    ```

    #### **Job Monitoring and Alerting**

    ##### **1. Job Monitoring**

    ```python
    # Job run monitoring
    job_run_info = {
        "run_id": 12345,
        "status": "RUNNING",
        "start_time": "2023-01-01T08:00:00Z",
        "tasks": [
            {
                "task_key": "extract_data",
                "status": "SUCCESS",
                "duration": 300
            },
            {
                "task_key": "transform_data",
                "status": "RUNNING",
                "start_time": "2023-01-01T08:05:00Z"
            }
        ]
    }
    ```

    ##### **2. Alerting Configuration**

    ```json
    {
        "email_notifications": {
            "on_start": ["team@company.com"],
            "on_success": ["manager@company.com"],
            "on_failure": ["oncall@company.com", "team@company.com"],
            "no_alert_for_skipped_runs": false
        },
        "webhook_notifications": {
            "on_failure": [
                {
                    "id": "slack-webhook",
                    "url": "https://hooks.slack.com/services/..."
                }
            ]
        }
    }
    ```

    ### Repos and Version Control

    **What are Repos?**
    Repos provide **Git integration** for Databricks, allowing you to sync notebooks and code with version control systems. Think of it as **connecting your digital lab notebook to a library's cataloging system**.

    #### **Git Integration Workflow**

    ```
    Git Workflow in Databricks:
    ┌─────────────────────────────────────────────────────────────┐
    │                    Remote Git Repository                    │
    │  ┌─────────────────┐  ┌─────────────────┐                  │
    │  │      main       │  │   feature/xyz   │                  │
    │  │    branch       │  │     branch      │                  │
    │  └─────────────────┘  └─────────────────┘                  │
    └─────────────────────────────────────────────────────────────┘
                                │
                                │ (Git Sync)
                                │
    ┌─────────────────────────────────────────────────────────────┐
    │                    Databricks Repos                        │
    │  ┌─────────────────┐  ┌─────────────────┐                  │
    │  │   main repo     │  │  feature repo   │                  │
    │  │   (read-only)   │  │   (editable)    │                  │
    │  └─────────────────┘  └─────────────────┘                  │
    └─────────────────────────────────────────────────────────────┘
    ```

    #### **Repository Operations**

    ##### **1. Repository Setup**

    ```python
    # Clone repository to Databricks
    repo_config = {
        "url": "https://github.com/company/data-platform.git",
        "provider": "github",
        "path": "/Repos/team/data-platform"
    }

    # Branch management
    branch_operations = {
        "create_branch": "feature/new-pipeline",
        "switch_branch": "develop",
        "merge_branch": "feature/completed-feature"
    }
    ```

    ##### **2. Development Workflow**

    ```python
    # 1. Create feature branch
    # UI: Repos -> Create Branch -> "feature/customer-segmentation"

    # 2. Develop in notebooks
    # Edit notebooks in /Repos/team/data-platform/notebooks/

    # 3. Commit changes
    commit_info = {
        "message": "Add customer segmentation analysis",
        "files": [
            "notebooks/customer_analysis.py",
            "config/segmentation_config.json"
        ]
    }

    # 4. Create pull request (external to Databricks)
    # 5. Merge to main branch
    # 6. Sync main branch in Databricks
    ```

    ##### **3. CI/CD Integration**

    ```yaml
    # GitHub Actions workflow
    name: Databricks CI/CD
    on:
        push:
            branches: [main]
        pull_request:
            branches: [main]

    jobs:
        test:
            runs-on: ubuntu-latest
            steps:
                - uses: actions/checkout@v2
                - name: Setup Python
                uses: actions/setup-python@v2
                with:
                    python-version: 3.8
                - name: Install dependencies
                run: pip install databricks-cli pytest
                - name: Run tests
                run: pytest tests/
                - name: Deploy to Databricks
                run: |
                    databricks workspace import-dir \
                        --language PYTHON \
                        --exclude-hidden-files \
                        ./notebooks /Repos/production/data-platform
    ```

    ## Analytics and Business Intelligence

    ### Databricks SQL - Analytics Powerhouse

    **What is Databricks SQL?**
    Databricks SQL is a **SQL-native analytics interface** that provides business intelligence capabilities on the lakehouse. Think of it as **Tableau or Power BI built directly into your data platform**.

    #### **SQL Warehouses (Compute for Analytics)**

    **Warehouse Types:**

    1. **Serverless**: Instant startup, automatic scaling
    2. **Pro**: Enhanced performance and security features
    3. **Classic**: Standard SQL compute

    ```sql
    -- Warehouse configuration
    CREATE WAREHOUSE analytics_warehouse
    WITH (
        WAREHOUSE_SIZE = 'MEDIUM',
        AUTO_SUSPEND = 10,  -- minutes
        AUTO_RESUME = TRUE,
        MIN_CLUSTER_COUNT = 1,
        MAX_CLUSTER_COUNT = 4,
        ENABLE_PHOTON = TRUE
    );
    ```

    #### **Advanced SQL Features**

    ##### **1. Complex Analytics Queries**

    ```sql
    -- Window functions for advanced analytics
    WITH customer_metrics AS (
    SELECT
        customer_id,
        order_date,
        amount,
        -- Running total
        SUM(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
        ) as running_total,
        -- Moving average
        AVG(amount) OVER (
        PARTITION BY customer_id
        ORDER BY order_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) as moving_avg_3,
        -- Rank customers by spending
        DENSE_RANK() OVER (
        ORDER BY SUM(amount) DESC
        ) as spending_rank
    FROM orders
    ),
    customer_segments AS (
    SELECT
        customer_id,
        CASE
        WHEN spending_rank <= 100 THEN 'VIP'
        WHEN spending_rank <= 1000 THEN 'Premium'
        ELSE 'Standard'
        END as segment
    FROM customer_metrics
    )
    SELECT
    segment,
    COUNT(*) as customer_count,
    AVG(running_total) as avg_lifetime_value
    FROM customer_segments
    GROUP BY segment;
    ```

    ##### **2. Time Series Analysis**

    ```sql
    -- Time series analysis with date functions
    SELECT
    DATE_TRUNC('month', order_date) as month,
    product_category,
    SUM(amount) as monthly_revenue,
    -- Year-over-year comparison
    LAG(SUM(amount), 12) OVER (
        PARTITION BY product_category
        ORDER BY DATE_TRUNC('month', order_date)
    ) as same_month_last_year,
    -- Growth rate calculation
    ROUND(
        (SUM(amount) - LAG(SUM(amount), 12) OVER (
        PARTITION BY product_category
        ORDER BY DATE_TRUNC('month', order_date)
        )) / LAG(SUM(amount), 12) OVER (
        PARTITION BY product_category
        ORDER BY DATE_TRUNC('month', order_date)
        ) * 100, 2
    ) as yoy_growth_rate
    FROM orders
    WHERE order_date >= '2022-01-01'
    GROUP BY DATE_TRUNC('month', order_date), product_category
    ORDER BY month, product_category;
    ```

    #### **Dashboard Creation**

    ##### **1. Interactive Dashboards**

    ```sql
    -- Dashboard query with parameters
    SELECT
    region,
    product_category,
    COUNT(*) as order_count,
    SUM(amount) as total_revenue,
    AVG(amount) as avg_order_value
    FROM orders
    WHERE
    order_date BETWEEN '{{start_date}}' AND '{{end_date}}'
    AND region IN ({{selected_regions}})
    GROUP BY region, product_category
    ORDER BY total_revenue DESC;
    ```

    ##### **2. Alert Configuration**

    ```sql
    -- Alert query for anomaly detection
    WITH daily_sales AS (
    SELECT
        DATE(order_date) as date,
        SUM(amount) as daily_revenue
    FROM orders
    WHERE order_date >= CURRENT_DATE - INTERVAL 30 DAYS
    GROUP BY DATE(order_date)
    ),
    sales_stats AS (
    SELECT
        AVG(daily_revenue) as avg_revenue,
        STDDEV(daily_revenue) as stddev_revenue
    FROM daily_sales
    )
    SELECT
    ds.date,
    ds.daily_revenue,
    ss.avg_revenue,
    -- Alert if revenue is 2 standard deviations below average
    CASE
        WHEN ds.daily_revenue < (ss.avg_revenue - 2 * ss.stddev_revenue)
        THEN 'ALERT: Low Revenue'
        ELSE 'Normal'
    END as status
    FROM daily_sales ds
    CROSS JOIN sales_stats ss
    WHERE ds.date = CURRENT_DATE - INTERVAL 1 DAY;
    ```

    #### **Performance Optimization**

    ##### **1. Query Optimization**

    ```sql
    -- Optimized query patterns
    -- Use partition pruning
    SELECT * FROM sales
    WHERE year = 2023 AND month = 12;  -- Efficient if partitioned by year, month

    -- Use column pruning
    SELECT customer_id, amount FROM sales;  -- Only read needed columns

    -- Use predicate pushdown
    SELECT * FROM sales
    WHERE amount > 1000;  -- Filter pushed to storage layer

    -- Use broadcast joins for small tables
    SELECT /*+ BROADCAST(dim_products) */
    s.*, p.product_name
    FROM sales s
    JOIN dim_products p ON s.product_id = p.product_id;
    ```

    ##### **2. Caching Strategies**

    ```sql
    -- Cache frequently accessed tables
    CACHE TABLE customer_summary AS
    SELECT
    customer_id,
    SUM(amount) as total_spent,
    COUNT(*) as order_count,
    MAX(order_date) as last_order_date
    FROM orders
    GROUP BY customer_id;

    -- Use materialized views for complex aggregations
    CREATE MATERIALIZED VIEW monthly_sales_summary AS
    SELECT
    DATE_TRUNC('month', order_date) as month,
    region,
    product_category,
    SUM(amount) as revenue,
    COUNT(*) as order_count
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date), region, product_category;
    ```

    ## Machine Learning and AI

    ### MLflow - ML Lifecycle Management

    **What is MLflow?**
    MLflow is an **open-source platform** for managing the complete machine learning lifecycle. Think of it as a **laboratory information management system (LIMS)** for data science - it tracks experiments, manages models, and facilitates deployment.

    #### **MLflow Components**

    ##### **1. MLflow Tracking**

    **Purpose**: Log and query experiments

    ```python
    import mlflow
    import mlflow.sklearn
    from sklearn.ensemble import RandomForestClassifier
    from sklearn.model_selection import train_test_split
    from sklearn.metrics import accuracy_score, precision_score, recall_score

    # Set experiment
    mlflow.set_experiment("/Shared/customer-churn-prediction")

    # Start experiment run
    with mlflow.start_run(run_name="rf_baseline") as run:
        # Log parameters
        n_estimators = 100
        max_depth = 10
        mlflow.log_param("n_estimators", n_estimators)
        mlflow.log_param("max_depth", max_depth)
        mlflow.log_param("algorithm", "RandomForest")

        # Train model
        model = RandomForestClassifier(
            n_estimators=n_estimators,
            max_depth=max_depth,
            random_state=42
        )
        model.fit(X_train, y_train)

        # Make predictions
        y_pred = model.predict(X_test)

        # Log metrics
        accuracy = accuracy_score(y_test, y_pred)
        precision = precision_score(y_test, y_pred)
        recall = recall_score(y_test, y_pred)

        mlflow.log_metric("accuracy", accuracy)
        mlflow.log_metric("precision", precision)
        mlflow.log_metric("recall", recall)

        # Log artifacts
        feature_importance = pd.DataFrame({
            'feature': X_train.columns,
            'importance': model.feature_importances_
        }).sort_values('importance', ascending=False)

        feature_importance.to_csv("feature_importance.csv", index=False)
        mlflow.log_artifact("feature_importance.csv")

        # Log model
        mlflow.sklearn.log_model(
            model,
            "model",
            registered_model_name="customer_churn_predictor"
        )

        # Log additional metadata
        mlflow.set_tag("model_type", "classification")
        mlflow.set_tag("data_version", "v1.2")
        mlflow.set_tag("author", "data-science-team")
    ```

    ##### **2. MLflow Models**

    **Purpose**: Package and deploy models

    ```python
    # Model signature for input/output schema
    from mlflow.models.signature import infer_signature

    signature = infer_signature(X_train, y_pred)

    # Log model with signature
    mlflow.sklearn.log_model(
        model,
        "model",
        signature=signature,
        input_example=X_train.iloc[:5],
        registered_model_name="customer_churn_predictor"
    )

    # Load model for inference
    model_uri = f"models:/customer_churn_predictor/1"
    loaded_model = mlflow.sklearn.load_model(model_uri)

    # Batch inference
    predictions = loaded_model.predict(new_data)
    ```

    ##### **3. MLflow Model Registry**

    **Purpose**: Centralized model store with versioning

    ```python
    from mlflow.tracking import MlflowClient

    client = MlflowClient()

    # Register model
    model_name = "customer_churn_predictor"
    model_uri = f"runs:/{run.info.run_id}/model"

    model_version = client.create_model_version(
        name=model_name,
        source=model_uri,
        description="Random Forest model for customer churn prediction"
    )

    # Transition model to staging
    client.transition_model_version_stage(
        name=model_name,
        version=model_version.version,
        stage="Staging"
    )

    # Add model description and tags
    client.update_model_version(
        name=model_name,
        version=model_version.version,
        description="Improved model with feature engineering v2"
    )

    client.set_model_version_tag(
        name=model_name,
        version=model_version.version,
        key="validation_status",
        value="passed"
    )

    # Promote to production after validation
    client.transition_model_version_stage(
        name=model_name,
        version=model_version.version,
        stage="Production"
    )
    ```

    #### **Advanced MLflow Features**

    ##### **1. Hyperparameter Tuning with MLflow**

    ```python
    from hyperopt import fmin, tpe, hp, Trials, STATUS_OK
    import mlflow.xgboost

    def objective(params):
        with mlflow.start_run(nested=True):
            # Log hyperparameters
            mlflow.log_params(params)

            # Train model
            model = xgb.XGBClassifier(**params)
            model.fit(X_train, y_train)

            # Evaluate
            y_pred = model.predict(X_test)
            accuracy = accuracy_score(y_test, y_pred)

            # Log metrics
            mlflow.log_metric("accuracy", accuracy)
            mlflow.xgboost.log_model(model, "model")

            # Return negative accuracy for minimization
            return {'loss': -accuracy, 'status': STATUS_OK}

    # Define search space
    search_space = {
        'n_estimators': hp.choice('n_estimators', [50, 100, 200]),
        'max_depth': hp.choice('max_depth', [3, 5, 7, 9]),
        'learning_rate': hp.uniform('learning_rate', 0.01, 0.3),
        'subsample': hp.uniform('subsample', 0.6, 1.0)
    }

    # Run hyperparameter optimization
    with mlflow.start_run(run_name="hyperparameter_tuning"):
        trials = Trials()
        best = fmin(
            fn=objective,
            space=search_space,
            algo=tpe.suggest,
            max_evals=50,
            trials=trials
        )

        mlflow.log_params(best)
    ```

    ##### **2. Model Comparison and Selection**

    ```python
    # Compare multiple models
    models_to_compare = [
        ("RandomForest", RandomForestClassifier()),
        ("XGBoost", xgb.XGBClassifier()),
        ("LogisticRegression", LogisticRegression())
    ]

    experiment_id = mlflow.create_experiment("model_comparison")

    for model_name, model in models_to_compare:
        with mlflow.start_run(experiment_id=experiment_id, run_name=model_name):
            # Train and evaluate model
            model.fit(X_train, y_train)
            y_pred = model.predict(X_test)

            # Log metrics
            metrics = {
                "accuracy": accuracy_score(y_test, y_pred),
                "precision": precision_score(y_test, y_pred),
                "recall": recall_score(y_test, y_pred),
                "f1": f1_score(y_test, y_pred)
            }

            mlflow.log_metrics(metrics)
            mlflow.sklearn.log_model(model, "model")

    # Query and compare results
    experiment = mlflow.get_experiment_by_name("model_comparison")
    runs = mlflow.search_runs(experiment_ids=[experiment.experiment_id])
    best_run = runs.loc[runs['metrics.accuracy'].idxmax()]
    ```

    ### Databricks AutoML

    **What is AutoML?**
    AutoML automatically builds machine learning models with minimal code. Think of it as an **expert data scientist assistant** that handles feature engineering, model selection, and hyperparameter tuning.

    #### **AutoML Workflow**

    ```python
    from databricks import automl

    # Prepare data
    df = spark.read.table("customer_features")

    # Run AutoML for classification
    summary = automl.classify(
        dataset=df,
        target_col="churn",
        primary_metric="f1",
        timeout_minutes=60,
        max_trials=20
    )

    # Access results
    print(f"Best trial F1 score: {summary.best_trial.metrics['f1_score']}")
    print(f"Best model URI: {summary.best_trial.model_path}")

    # Load best model
    best_model = summary.best_trial.load_model()

    # Make predictions
    predictions = best_model.predict(test_data)
    ```

    #### **AutoML Configuration Options**

    ```python
    # Advanced AutoML configuration
    summary = automl.classify(
        dataset=df,
        target_col="churn",
        primary_metric="f1",

        # Data configuration
        exclude_cols=["customer_id", "signup_date"],
        pos_label="Yes",  # For binary classification

        # Experiment configuration
        timeout_minutes=120,
        max_trials=50,

        # Feature engineering
        feature_store_lookups=[
            {
                "table_name": "feature_store.customer_features",
                "lookup_key": "customer_id"
            }
        ],

        # Model selection
        exclude_frameworks=["sklearn"],  # Exclude specific frameworks

        # Evaluation
        split_col="split",  # Custom train/validation split

        # Output
        experiment_name="/Shared/automl_churn_prediction",
        experiment_dir="/Shared/automl_experiments/"
    )
    ```

    ### Feature Store

    **What is Feature Store?**
    Feature Store is a **centralized repository** for machine learning features. Think of it as a **data mart specifically designed for ML features** with versioning, lineage, and serving capabilities.

    #### **Feature Store Operations**

    ##### **1. Feature Table Creation**

    ```python
    from databricks.feature_store import FeatureStoreClient

    fs = FeatureStoreClient()

    # Create feature table
    customer_features_df = spark.sql("""
    SELECT
        customer_id,
        age,
        income,
        days_since_last_purchase,
        total_purchases_last_30d,
        avg_purchase_amount,
        preferred_category,
        current_timestamp() as update_timestamp
    FROM customer_raw_data
    """)

    # Create feature table
    fs.create_table(
        name="feature_store.customer_features",
        primary_keys=["customer_id"],
        df=customer_features_df,
        description="Customer demographic and behavioral features"
    )
    ```

    ##### **2. Feature Engineering Pipeline**

    ```python
    # Feature engineering function
    def compute_customer_features(df):
        from pyspark.sql.functions import col, datediff, current_date, avg, sum, count

        features = df.groupBy("customer_id").agg(
            # Recency features
            datediff(current_date(), max("last_purchase_date")).alias("days_since_last_purchase"),

            # Frequency features
            count("order_id").alias("total_orders"),
            countDistinct("product_category").alias("category_diversity"),

            # Monetary features
            sum("order_amount").alias("total_spent"),
            avg("order_amount").alias("avg_order_value"),

            # Behavioral features
            (sum(when(col("discount_used") > 0, 1).otherwise(0)) / count("*")).alias("discount_usage_rate")
        )

        return features

    # Compute and write features
    new_features = compute_customer_features(raw_data)

    fs.write_table(
        name="feature_store.customer_features",
        df=new_features,
        mode="merge"
    )
    ```

    ##### **3. Feature Serving**

    ```python
    # Training time - create training dataset
    from databricks.feature_store import feature_table

    # Define feature lookups
    feature_lookups = [
        feature_table.FeatureLookup(
            table_name="feature_store.customer_features",
            lookup_key="customer_id"
        ),
        feature_table.FeatureLookup(
            table_name="feature_store.product_features",
            lookup_key="product_id"
        )
    ]

    # Create training set
    training_set = fs.create_training_set(
        df=labels_df,  # DataFrame with labels and keys
        feature_lookups=feature_lookups,
        label="churn",
        exclude_columns=["customer_id"]
    )

    # Load training data
    training_df = training_set.load_df()

    # Inference time - batch scoring
    batch_input = spark.table("customers_to_score")

    predictions = fs.score_batch(
        model_uri="models:/customer_churn_model/Production",
        df=batch_input
    )
    ```

    ### Model Deployment and Serving

    #### **Real-time Model Serving**

    ```python
    # Deploy model to real-time endpoint
    from databricks.model_serving import ModelServingClient

    serving_client = ModelServingClient()

    # Create serving endpoint
    endpoint_config = {
        "name": "customer-churn-endpoint",
        "config": {
            "served_models": [
                {
                    "name": "customer_churn_model",
                    "model_name": "customer_churn_predictor",
                    "model_version": "1",
                    "workload_size": "Small",
                    "scale_to_zero_enabled": True
                }
            ]
        }
    }

    serving_client.create_endpoint(endpoint_config)

    # Query endpoint
    import requests
    import json

    endpoint_url = "https://databricks-instance/serving-endpoints/customer-churn-endpoint/invocations"
    headers = {"Authorization": f"Bearer {token}"}

    data = {
        "inputs": [
            {
                "customer_id": "12345",
                "age": 35,
                "income": 75000,
                "days_since_last_purchase": 30
            }
        ]
    }

    response = requests.post(endpoint_url, headers=headers, json=data)
    prediction = response.json()
    ```

    #### **Batch Inference Pipeline**

    ```python
    # Scheduled batch inference job
    def batch_inference_pipeline():
        # Load model
        model = mlflow.sklearn.load_model("models:/customer_churn_predictor/Production")

        # Load new data
        new_customers = spark.read.table("new_customers")

        # Feature engineering
        features = compute_customer_features(new_customers)

        # Make predictions
        predictions_df = model.predict(features.toPandas())

        # Save results
        results = features.withColumn("churn_probability", predictions_df)
        results.write.mode("overwrite").table("churn_predictions")

        # Send alerts for high-risk customers
        high_risk = results.filter(col("churn_probability") > 0.8)
        if high_risk.count() > 0:
            send_alert(f"Found {high_risk.count()} high-risk customers")

    # Schedule as Databricks job
    dbutils.notebook.run("/Shared/ML/batch_inference", timeout_seconds=3600)
    ```

    ## Security and Governance

    ### Unity Catalog - Unified Governance

    **What is Unity Catalog?**
    Unity Catalog is a **unified governance solution** for data and AI assets across clouds and platforms. Think of it as a **comprehensive library system** that not only catalogs all your data but also controls who can access what, tracks how data is used, and maintains detailed lineage.

    #### **Unity Catalog Architecture**

    ```
    Unity Catalog Hierarchy:
    ┌─────────────────────────────────────────────────────────────┐
    │                    Metastore                                │
    │  ┌─────────────────────────────────────────────────────────┐│
    │  │                   Catalog                               ││
    │  │  ┌─────────────────────────────────────────────────────┐││
    │  │  │                  Schema                             │││
    │  │  │  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐ │││
    │  │  │  │    Table    │  │    View     │  │  Function   │ │││
    │  │  │  └─────────────┘  └─────────────┘  └─────────────┘ │││
    │  │  └─────────────────────────────────────────────────────┘││
    │  └─────────────────────────────────────────────────────────┘│
    └─────────────────────────────────────────────────────────────┘
    ```

    #### **Catalog Management**

    ##### **1. Creating Catalogs and Schemas**

    ```sql
    -- Create catalog for production data
    CREATE CATALOG IF NOT EXISTS production
    COMMENT 'Production data catalog';

    -- Create schemas within catalog
    CREATE SCHEMA IF NOT EXISTS production.sales
    COMMENT 'Sales transaction data';

    CREATE SCHEMA IF NOT EXISTS production.customers
    COMMENT 'Customer master data';

    CREATE SCHEMA IF NOT EXISTS production.products
    COMMENT 'Product catalog data';

    -- Create development catalog
    CREATE CATALOG IF NOT EXISTS development
    COMMENT 'Development and testing data';
    ```

    ##### **2. Table Registration and Management**

    ```sql
    -- Create managed table (Unity Catalog manages storage)
    CREATE TABLE production.sales.transactions (
        transaction_id BIGINT,
        customer_id BIGINT,
        product_id BIGINT,
        transaction_date TIMESTAMP,
        amount DECIMAL(10,2),
        payment_method STRING,
        created_at TIMESTAMP DEFAULT current_timestamp()
    ) USING DELTA
    PARTITIONED BY (DATE(transaction_date))
    COMMENT 'Daily sales transactions';

    -- Create external table (you manage storage)
    CREATE TABLE production.sales.historical_data (
        year INT,
        month INT,
        revenue DECIMAL(15,2),
        order_count BIGINT
    ) USING DELTA
    LOCATION 's3://data-lake/historical/sales/'
    COMMENT 'Historical sales summary data';

    -- Create view with business logic
    CREATE VIEW production.sales.monthly_summary AS
    SELECT
        DATE_TRUNC('month', transaction_date) as month,
        COUNT(*) as transaction_count,
        SUM(amount) as total_revenue,
        AVG(amount) as avg_transaction_value
    FROM production.sales.transactions
    GROUP BY DATE_TRUNC('month', transaction_date);
    ```

    #### **Access Control and Permissions**

    ##### **1. Grant-Based Access Control**

    ```sql
    -- Grant catalog-level permissions
    GRANT USE CATALOG ON CATALOG production TO `data-analysts`;
    GRANT CREATE SCHEMA ON CATALOG production TO `data-engineers`;

    -- Grant schema-level permissions
    GRANT USE SCHEMA ON SCHEMA production.sales TO `sales-team`;
    GRANT CREATE TABLE ON SCHEMA production.sales TO `data-engineers`;

    -- Grant table-level permissions
    GRANT SELECT ON TABLE production.sales.transactions TO `business-analysts`;
    GRANT SELECT, INSERT ON TABLE production.sales.transactions TO `etl-service`;

    -- Grant column-level permissions (fine-grained access)
    GRANT SELECT (customer_id, transaction_date, amount)
    ON TABLE production.sales.transactions TO `junior-analysts`;

    -- Row-level security with dynamic views
    CREATE VIEW production.sales.regional_transactions AS
    SELECT * FROM production.sales.transactions
    WHERE region = current_user_region();

    GRANT SELECT ON VIEW production.sales.regional_transactions TO `regional-managers`;
    ```

    ##### **2. Dynamic Access Control**

    ```sql
    -- Create function for dynamic filtering
    CREATE FUNCTION current_user_department()
    RETURNS STRING
    LANGUAGE SQL
    DETERMINISTIC
    RETURN (
    SELECT department
    FROM system.access.users
    WHERE email = current_user()
    );

    -- Create view with dynamic filtering
    CREATE VIEW production.hr.employee_data_filtered AS
    SELECT
    employee_id,
    name,
    CASE
        WHEN current_user_department() = 'HR' THEN salary
        ELSE NULL
    END as salary,
    department,
    hire_date
    FROM production.hr.employees;
    ```

    #### **Data Lineage and Discovery**

    ##### **1. Automatic Lineage Tracking**

    ```python
    # Unity Catalog automatically tracks lineage for:
    # - Table-to-table dependencies
    # - Column-level lineage
    # - Notebook and job dependencies
    # - ML model feature dependencies

    # Query lineage information
    lineage_info = spark.sql("""
    SELECT
        source_table,
        target_table,
        column_mapping,
        transformation_type,
        created_by,
        created_at
    FROM system.access.table_lineage
    WHERE target_table = 'production.sales.customer_summary'
    """)
    ```

    ##### **2. Data Discovery**

    ```sql
    -- Search for tables containing customer data
    SELECT
    catalog_name,
    schema_name,
    table_name,
    table_type,
    comment
    FROM system.information_schema.tables
    WHERE
    table_name LIKE '%customer%'
    OR comment LIKE '%customer%';

    -- Find columns with PII data
    SELECT
    table_catalog,
    table_schema,
    table_name,
    column_name,
    data_type,
    comment
    FROM system.information_schema.columns
    WHERE
    column_name IN ('email', 'phone', 'ssn', 'credit_card')
    OR comment LIKE '%PII%';
    ```

    #### **Data Quality and Monitoring**

    ##### **1. Data Quality Constraints**

    ```sql
    -- Add table constraints
    ALTER TABLE production.sales.transactions
    ADD CONSTRAINT positive_amount CHECK (amount > 0);

    ALTER TABLE production.sales.transactions
    ADD CONSTRAINT valid_payment_method
    CHECK (payment_method IN ('credit_card', 'debit_card', 'cash', 'digital_wallet'));

    -- Add column constraints
    ALTER TABLE production.customers.profiles
    ADD CONSTRAINT valid_email CHECK (email LIKE '%@%.%');

    ALTER TABLE production.customers.profiles
    ADD CONSTRAINT adult_age CHECK (age >= 18);
    ```

    ##### **2. Data Monitoring**

    ```python
    # Monitor data quality metrics
    def monitor_data_quality():
        quality_checks = spark.sql("""
        SELECT
            'production.sales.transactions' as table_name,
            COUNT(*) as total_rows,
            COUNT(CASE WHEN amount IS NULL THEN 1 END) as null_amounts,
            COUNT(CASE WHEN amount <= 0 THEN 1 END) as invalid_amounts,
            MIN(transaction_date) as earliest_date,
            MAX(transaction_date) as latest_date,
            current_timestamp() as check_timestamp
        FROM production.sales.transactions
        WHERE DATE(transaction_date) = current_date()
        """)

        # Log quality metrics
        quality_checks.write.mode("append").table("monitoring.data_quality_checks")

        # Alert on quality issues
        issues = quality_checks.filter(
            (col("null_amounts") > 0) | (col("invalid_amounts") > 0)
        )

        if issues.count() > 0:
            send_alert("Data quality issues detected in transactions table")

    # Schedule quality monitoring
    dbutils.jobs.create({
        "name": "Data Quality Monitor",
        "notebook_task": {"notebook_path": "/Monitoring/data_quality"},
        "schedule": {"cron_expression": "0 */6 * * *"}  # Every 6 hours
    })
    ```

    ### Advanced Security Features

    #### **1. Encryption and Key Management**

    ```python
    # Encryption at rest (automatic with Unity Catalog)
    encryption_config = {
        "storage_encryption": "AES-256",
        "key_management": "customer_managed_keys",
        "key_rotation": "automatic_90_days"
    }

    # Encryption in transit (automatic)
    transit_encryption = {
        "client_to_databricks": "TLS 1.2+",
        "inter_node_communication": "TLS 1.2+",
        "storage_communication": "TLS 1.2+"
    }
    ```

    #### **2. Audit Logging**

    ```sql
    -- Query audit logs
    SELECT
    event_time,
    user_identity,
    service_name,
    action_name,
    request_params,
    response,
    source_ip_address
    FROM system.access.audit
    WHERE
    event_time >= current_timestamp() - INTERVAL 24 HOURS
    AND action_name IN ('SELECT', 'INSERT', 'UPDATE', 'DELETE')
    AND request_params LIKE '%production.sales%'
    ORDER BY event_time DESC;
    ```

    #### **3. Network Security**

    ```python
    # VPC configuration for network isolation
    vpc_config = {
        "enable_private_link": True,
        "vpc_endpoints": [
            "databricks-workspace",
            "databricks-backend-rest-api",
            "databricks-log-delivery"
        ],
        "security_groups": {
            "workspace_sg": {
                "inbound_rules": [
                    {"port": 443, "source": "corporate_network_cidr"},
                    {"port": 22, "source": "admin_cidr"}
                ]
            }
        }
    }
    ```

    ## Integration and Connectivity

    ### Data Sources and Connectors

    **Databricks provides extensive connectivity** to various data sources and systems. Think of it as a **universal data hub** that can connect to virtually any data system.

    #### **Database Connectors**

    ##### **1. JDBC/ODBC Connections**

    ```python
    # Connect to SQL Server
    sql_server_df = spark.read.format("jdbc") \
        .option("url", "jdbc:sqlserver://server:1433;databaseName=mydb") \
        .option("dbtable", "sales_data") \
        .option("user", "username") \
        .option("password", "password") \
        .option("driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver") \
        .load()

    # Connect to PostgreSQL with connection pooling
    postgres_df = spark.read.format("jdbc") \
        .option("url", "jdbc:postgresql://host:5432/database") \
        .option("dbtable", "customer_data") \
        .option("user", "username") \
        .option("password", "password") \
        .option("numPartitions", "4") \
        .option("partitionColumn", "id") \
        .option("lowerBound", "1") \
        .option("upperBound", "1000000") \
        .load()

    # Connect to Oracle with custom query
    oracle_df = spark.read.format("jdbc") \
        .option("url", "jdbc:oracle:thin:@host:1521:xe") \
        .option("dbtable", "(SELECT * FROM orders WHERE order_date >= '2023-01-01') as recent_orders") \
        .option("user", "username") \
        .option("password", "password") \
        .load()
    ```

    ##### **2. NoSQL Database Connections**

    ```python
    # MongoDB connection
    mongo_df = spark.read.format("mongo") \
        .option("uri", "mongodb://username:password@host:27017/database.collection") \
        .option("pipeline", '[{"$match": {"status": "active"}}]') \
        .load()

    # Cassandra connection
    cassandra_df = spark.read.format("org.apache.spark.sql.cassandra") \
        .option("keyspace", "analytics") \
        .option("table", "user_events") \
        .option("spark.cassandra.connection.host", "cassandra-host") \
        .load()

    # Redis connection (for caching and real-time data)
    redis_df = spark.read.format("org.apache.spark.sql.redis") \
        .option("host", "redis-host") \
        .option("port", "6379") \
        .option("keys.pattern", "user:*") \
        .load()
    ```

    #### **Cloud Storage Integration**

    ##### **1. AWS S3 Integration**

    ```python
    # Direct S3 access
    s3_df = spark.read.format("parquet") \
        .option("path", "s3a://my-bucket/data/year=2023/month=12/") \
        .load()

    # S3 with server-side encryption
    encrypted_s3_df = spark.read.format("delta") \
        .option("path", "s3a://encrypted-bucket/delta-table/") \
        .option("fs.s3a.server-side-encryption-algorithm", "AES256") \
        .load()

    # S3 with cross-account access
    cross_account_df = spark.read.format("json") \
        .option("path", "s3a://external-bucket/shared-data/") \
        .option("fs.s3a.aws.credentials.provider",
                "org.apache.hadoop.fs.s3a.auth.AssumedRoleCredentialProvider") \
        .option("fs.s3a.assumed.role.arn", "arn:aws:iam::account:role/CrossAccountRole") \
        .load()
    ```

    ##### **2. Azure Data Lake Integration**

    ```python
    # Azure Data Lake Storage Gen2
    adls_df = spark.read.format("delta") \
        .option("path", "abfss://container@account.dfs.core.windows.net/path/to/data") \
        .load()

    # Azure Blob Storage
    blob_df = spark.read.format("csv") \
        .option("header", "true") \
        .option("path", "wasbs://container@account.blob.core.windows.net/data.csv") \
        .load()
    ```

    ##### **3. Google Cloud Storage Integration**

    ```python
    # Google Cloud Storage
    gcs_df = spark.read.format("parquet") \
        .option("path", "gs://my-bucket/data/") \
        .load()

    # BigQuery integration
    bigquery_df = spark.read.format("bigquery") \
        .option("table", "project.dataset.table") \
        .option("parentProject", "billing-project") \
        .load()
    ```

    #### **Streaming Data Integration**

    ##### **1. Apache Kafka Integration**

    ```python
    # Read from Kafka
    kafka_stream = spark.readStream \
        .format("kafka") \
        .option("kafka.bootstrap.servers", "broker1:9092,broker2:9092") \
        .option("subscribe", "topic1,topic2") \
        .option("startingOffsets", "latest") \
        .option("kafka.security.protocol", "SASL_SSL") \
        .option("kafka.sasl.mechanism", "PLAIN") \
        .option("kafka.sasl.jaas.config",
                'org.apache.kafka.common.security.plain.PlainLoginModule required username="user" password="pass";') \
        .load()

    # Process Kafka messages
    processed_stream = kafka_stream.select(
        col("key").cast("string"),
        from_json(col("value").cast("string"), message_schema).alias("data"),
        col("timestamp"),
        col("partition"),
        col("offset")
    ).select("key", "data.*", "timestamp", "partition", "offset")

    # Write processed data to Delta Lake
    query = processed_stream.writeStream \
        .format("delta") \
        .outputMode("append") \
        .option("checkpointLocation", "/mnt/checkpoints/kafka-to-delta") \
        .trigger(processingTime="30 seconds") \
        .start("/mnt/delta/kafka-data")
    ```

    ##### **2. Event Hubs Integration (Azure)**

    ```python
    # Azure Event Hubs
    eventhubs_stream = spark.readStream \
        .format("eventhubs") \
        .option("eventhubs.connectionString", connection_string) \
        .option("eventhubs.consumerGroup", "databricks-consumer") \
        .option("eventhubs.startingPosition", '{"offset": "-1", "seqNo": -1, "enqueuedTime": null, "isInclusive": true}') \
        .load()
    ```

    ##### **3. Kinesis Integration (AWS)**

    ```python
    # Amazon Kinesis
    kinesis_stream = spark.readStream \
        .format("kinesis") \
        .option("streamName", "my-kinesis-stream") \
        .option("region", "us-east-1") \
        .option("initialPosition", "TRIM_HORIZON") \
        .option("awsAccessKey", access_key) \
        .option("awsSecretKey", secret_key) \
        .load()
    ```

    #### **API and Web Service Integration**

    ##### **1. REST API Integration**

    ```python
    import requests
    import json
    from pyspark.sql.types import StructType, StructField, StringType, IntegerType

    def fetch_api_data(api_url, headers):
        """Fetch data from REST API"""
        response = requests.get(api_url, headers=headers)
        return response.json()

    # Create UDF for API calls
    from pyspark.sql.functions import udf

    @udf(returnType=StringType())
    def enrich_with_api(customer_id):
        api_url = f"https://api.example.com/customers/{customer_id}"
        headers = {"Authorization": "Bearer token"}
        try:
            data = fetch_api_data(api_url, headers)
            return json.dumps(data)
        except:
            return None

    # Apply API enrichment
    enriched_df = customer_df.withColumn(
        "api_data",
        enrich_with_api(col("customer_id"))
    )
    ```

    ##### **2. GraphQL Integration**

    ```python
    from gql import gql, Client
    from gql.transport.requests import RequestsHTTPTransport

    def query_graphql(query_string, variables=None):
        """Execute GraphQL query"""
        transport = RequestsHTTPTransport(
            url="https://api.example.com/graphql",
            headers={"Authorization": "Bearer token"}
        )
        client = Client(transport=transport)
        query = gql(query_string)
        return client.execute(query, variable_values=variables)

    # GraphQL query for customer data
    customer_query = """
    query GetCustomer($customerId: ID!) {
    customer(id: $customerId) {
        id
        name
        email
        orders {
        id
        total
        date
        }
    }
    }
    """

    # Broadcast GraphQL function for use in Spark
    broadcast_graphql = spark.sparkContext.broadcast(query_graphql)
    ```

    ### External System Integration

    #### **1. Data Warehouse Integration**

    ```python
    # Snowflake integration
    snowflake_df = spark.read.format("snowflake") \
        .option("sfUrl", "account.snowflakecomputing.com") \
        .option("sfUser", "username") \
        .option("sfPassword", "password") \
        .option("sfDatabase", "database") \
        .option("sfSchema", "schema") \
        .option("sfWarehouse", "warehouse") \
        .option("dbtable", "customer_data") \
        .load()

    # Redshift integration
    redshift_df = spark.read.format("jdbc") \
        .option("url", "jdbc:redshift://cluster.region.redshift.amazonaws.com:5439/database") \
        .option("dbtable", "sales_summary") \
        .option("user", "username") \
        .option("password", "password") \
        .option("driver", "com.amazon.redshift.jdbc42.Driver") \
        .option("tempdir", "s3a://temp-bucket/redshift-temp/") \
        .load()
    ```

    #### **2. BI Tool Integration**

    ```python
    # Tableau integration via JDBC
    tableau_connection = {
        "server": "databricks-instance.cloud.databricks.com",
        "http_path": "/sql/1.0/warehouses/warehouse-id",
        "catalog": "production",
        "schema": "analytics"
    }

    # Power BI integration
    powerbi_connection = {
        "server": "databricks-instance.cloud.databricks.com",
        "http_path": "/sql/1.0/warehouses/warehouse-id",
        "authentication": "Azure Active Directory"
    }

    # Looker integration
    looker_connection = {
        "connection_name": "databricks_prod",
        "database": "production",
        "host": "databricks-instance.cloud.databricks.com",
        "port": "443",
        "username": "service_account",
        "password": "token"
    }
    ```

    #### **3. ETL Tool Integration**

    ```python
    # Apache Airflow integration
    from airflow.providers.databricks.operators.databricks import DatabricksSubmitRunOperator

    databricks_task = DatabricksSubmitRunOperator(
        task_id='run_databricks_notebook',
        databricks_conn_id='databricks_default',
        notebook_task={
            'notebook_path': '/Shared/ETL/daily_pipeline',
            'base_parameters': {
                'date': '{{ ds }}',
                'environment': 'production'
            }
        },
        new_cluster={
            'spark_version': '11.3.x-scala2.12',
            'node_type_id': 'i3.xlarge',
            'num_workers': 2
        }
    )

    # dbt integration
    dbt_project_config = {
        "profile": "databricks",
        "target": "prod",
        "outputs": {
            "prod": {
                "type": "databricks",
                "catalog": "production",
                "schema": "analytics",
                "host": "databricks-instance.cloud.databricks.com",
                "http_path": "/sql/1.0/warehouses/warehouse-id",
                "token": "{{ env_var('DATABRICKS_TOKEN') }}"
            }
        }
    }
    ```

    ## Advanced Features and Optimization

    ### Performance Optimization

    #### **1. Photon Engine**

    **What is Photon?**
    Photon is a **vectorized query engine** that accelerates SQL workloads. Think of it as a **high-performance race car engine** compared to a standard engine - it processes data much faster using advanced optimization techniques.

    ```python
    # Enable Photon on cluster
    cluster_config = {
        "runtime_engine": "PHOTON",
        "spark_conf": {
            "spark.databricks.photon.enabled": "true",
            "spark.databricks.photon.parquetWriter.enabled": "true"
        }
    }

    # Photon automatically optimizes:
    # - Columnar processing
    # - Vectorized operations
    # - Advanced code generation
    # - Memory management
    ```

    #### **2. Adaptive Query Execution (AQE)**

    ```python
    # AQE configuration
    spark.conf.set("spark.sql.adaptive.enabled", "true")
    spark.conf.set("spark.sql.adaptive.coalescePartitions.enabled", "true")
    spark.conf.set("spark.sql.adaptive.skewJoin.enabled", "true")
    spark.conf.set("spark.sql.adaptive.localShuffleReader.enabled", "true")

    # AQE automatically:
    # - Coalesces small partitions
    # - Handles data skew in joins
    # - Optimizes shuffle operations
    # - Switches join strategies dynamically
    ```

    #### **3. Delta Engine Optimizations**

    ```sql
    -- Optimize table layout
    OPTIMIZE sales_data;

    -- Z-order for better query performance
    OPTIMIZE sales_data ZORDER BY (customer_id, product_category, date);

    -- Auto-optimize for continuous optimization
    ALTER TABLE sales_data SET TBLPROPERTIES (
        'delta.autoOptimize.optimizeWrite' = 'true',
        'delta.autoOptimize.autoCompact' = 'true'
    );

    -- Bloom filters for faster lookups
    CREATE BLOOMFILTER INDEX ON sales_data FOR COLUMNS (customer_id);
    ```

    #### **4. Caching Strategies**

    ```python
    # Cache frequently accessed DataFrames
    customer_df.cache()
    customer_df.count()  # Trigger caching

    # Persist with specific storage level
    from pyspark import StorageLevel
    large_df.persist(StorageLevel.MEMORY_AND_DISK_SER)

    # Delta caching (automatic)
    spark.conf.set("spark.databricks.io.cache.enabled", "true")
    spark.conf.set("spark.databricks.io.cache.maxDiskUsage", "50g")

    # SQL caching
    spark.sql("CACHE TABLE customer_summary")
    ```

    ### Advanced Data Processing Patterns

    #### **1. Change Data Capture (CDC)**

    ```python
    # CDC with Delta Lake
    from delta.tables import DeltaTable

    def process_cdc_data(source_df, target_table_path):
        # Load existing Delta table
        target_table = DeltaTable.forPath(spark, target_table_path)

        # Merge CDC data
        target_table.alias("target").merge(
            source_df.alias("source"),
            "target.id = source.id"
        ).whenMatchedUpdate(
            condition="source.operation = 'UPDATE'",
            set={
                "name": "source.name",
                "email": "source.email",
                "updated_at": "source.timestamp"
            }
        ).whenMatchedDelete(
            condition="source.operation = 'DELETE'"
        ).whenNotMatchedInsert(
            condition="source.operation = 'INSERT'",
            values={
                "id": "source.id",
                "name": "source.name",
                "email": "source.email",
                "created_at": "source.timestamp",
                "updated_at": "source.timestamp"
            }
        ).execute()

    # Process CDC stream
    cdc_stream = spark.readStream \
        .format("delta") \
        .option("readChangeFeed", "true") \
        .option("startingVersion", "0") \
        .table("source_table")

    # Apply CDC transformations
    processed_cdc = cdc_stream.select(
        col("id"),
        col("name"),
        col("email"),
        col("_change_type").alias("operation"),
        col("_commit_timestamp").alias("timestamp")
    )

    # Write to target with CDC processing
    cdc_query = processed_cdc.writeStream \
        .foreachBatch(lambda df, epoch: process_cdc_data(df, "/mnt/target/table")) \
        .option("checkpointLocation", "/mnt/checkpoints/cdc") \
        .start()
    ```

    #### **2. Slowly Changing Dimensions (SCD)**

    ```python
    def handle_scd_type2(new_data_df, target_table_path):
        """Handle SCD Type 2 with Delta Lake"""
        from delta.tables import DeltaTable
        from pyspark.sql.functions import current_timestamp, lit

        # Load existing dimension table
        dim_table = DeltaTable.forPath(spark, target_table_path)

        # Prepare new data with SCD columns
        new_data_with_scd = new_data_df.withColumn("effective_date", current_timestamp()) \
                                    .withColumn("end_date", lit(None).cast("timestamp")) \
                                    .withColumn("is_current", lit(True))

        # Close existing records
        dim_table.alias("target").merge(
            new_data_with_scd.alias("source"),
            "target.business_key = source.business_key AND target.is_current = true"
        ).whenMatchedUpdate(
            condition="target.name != source.name OR target.email != source.email",
            set={
                "end_date": "source.effective_date",
                "is_current": "false"
            }
        ).execute()

        # Insert new records
        new_records = new_data_with_scd.join(
            dim_table.toDF().filter(col("is_current") == True),
            ["business_key"],
            "left_anti"
        )

        new_records.write.format("delta").mode("append").save(target_table_path)

    # Example usage
    customer_updates = spark.read.table("staging.customer_updates")
    handle_scd_type2(customer_updates, "/mnt/dimensions/customers")
    ```

    #### **3. Data Lakehouse Medallion Architecture**

    ```python
    # Bronze Layer - Raw data ingestion
    def bronze_layer_processing():
        """Ingest raw data with minimal transformation"""
        raw_data = spark.readStream \
            .format("cloudFiles") \
            .option("cloudFiles.format", "json") \
            .option("cloudFiles.schemaLocation", "/mnt/schemas/bronze") \
            .load("/mnt/raw-data/")

        # Add metadata columns
        bronze_data = raw_data.withColumn("ingestion_timestamp", current_timestamp()) \
                            .withColumn("source_file", input_file_name())

        # Write to bronze Delta table
        bronze_query = bronze_data.writeStream \
            .format("delta") \
            .option("checkpointLocation", "/mnt/checkpoints/bronze") \
            .trigger(availableNow=True) \
            .start("/mnt/bronze/raw_events")

        return bronze_query

    # Silver Layer - Cleaned and validated data
    def silver_layer_processing():
        """Clean and validate bronze data"""
        bronze_data = spark.readStream \
            .format("delta") \
            .table("bronze.raw_events")

        # Data quality rules
        silver_data = bronze_data.filter(
            col("event_type").isNotNull() &
            col("timestamp").isNotNull() &
            (col("user_id") != "")
        ).withColumn("processed_timestamp", current_timestamp()) \
        .dropDuplicates(["event_id"])

        # Write to silver Delta table
        silver_query = silver_data.writeStream \
            .format("delta") \
            .option("checkpointLocation", "/mnt/checkpoints/silver") \
            .trigger(processingTime="5 minutes") \
            .start("/mnt/silver/clean_events")

        return silver_query

    # Gold Layer - Business-ready aggregated data
    def gold_layer_processing():
        """Create business-ready aggregated data"""
        silver_data = spark.readStream \
            .format("delta") \
            .table("silver.clean_events")

        # Business aggregations
        gold_data = silver_data.withWatermark("timestamp", "10 minutes") \
            .groupBy(
                window(col("timestamp"), "1 hour"),
                col("event_type"),
                col("user_segment")
            ).agg(
                count("*").alias("event_count"),
                countDistinct("user_id").alias("unique_users"),
                avg("session_duration").alias("avg_session_duration")
            )

        # Write to gold Delta table
        gold_query = gold_data.writeStream \
            .format("delta") \
            .option("checkpointLocation", "/mnt/checkpoints/gold") \
            .outputMode("append") \
            .trigger(processingTime="10 minutes") \
            .start("/mnt/gold/hourly_metrics")

        return gold_query
    ```

    ### Monitoring and Observability

    #### **1. Cluster Monitoring**

    ```python
    # Custom cluster metrics collection
    def collect_cluster_metrics():
        """Collect custom cluster performance metrics"""
        metrics = spark.sql("""
            SELECT
                current_timestamp() as timestamp,
                '{}' as cluster_id,
                count(*) as active_executors,
                sum(maxMemory) as total_memory,
                sum(memoryUsed) as used_memory,
                sum(maxOnHeapMemory) as max_heap_memory,
                sum(onHeapMemoryUsed) as used_heap_memory
            FROM (
                SELECT
                    executorId,
                    maxMemory,
                    memoryUsed,
                    maxOnHeapMemory,
                    onHeapMemoryUsed
                FROM system.compute.executor_memory_status
            )
        """.format(spark.conf.get("spark.databricks.clusterUsageTags.clusterId")))

        # Write metrics to monitoring table
        metrics.write.mode("append").table("monitoring.cluster_metrics")

    # Schedule metrics collection
    dbutils.jobs.create({
        "name": "Cluster Metrics Collection",
        "notebook_task": {"notebook_path": "/Monitoring/cluster_metrics"},
        "schedule": {"cron_expression": "*/5 * * * *"}  # Every 5 minutes
    })
    ```

    #### **2. Data Quality Monitoring**

    ```python
    def monitor_data_quality(table_name, quality_rules):
        """Monitor data quality with custom rules"""
        df = spark.table(table_name)

        quality_results = []

        for rule_name, rule_condition in quality_rules.items():
            # Count violations
            violations = df.filter(~expr(rule_condition)).count()
            total_records = df.count()

            quality_result = {
                "table_name": table_name,
                "rule_name": rule_name,
                "rule_condition": rule_condition,
                "total_records": total_records,
                "violations": violations,
                "pass_rate": (total_records - violations) / total_records if total_records > 0 else 0,
                "check_timestamp": datetime.now()
            }

            quality_results.append(quality_result)

        # Save quality results
        quality_df = spark.createDataFrame(quality_results)
        quality_df.write.mode("append").table("monitoring.data_quality_results")

        # Alert on quality issues
        failed_rules = [r for r in quality_results if r["pass_rate"] < 0.95]
        if failed_rules:
            send_alert(f"Data quality issues in {table_name}: {len(failed_rules)} rules failed")

    # Define quality rules
    customer_quality_rules = {
        "email_format": "email RLIKE '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'",
        "age_range": "age BETWEEN 18 AND 120",
        "phone_format": "phone RLIKE '^\\+?[1-9]\\d{1,14}$'",
        "no_null_ids": "customer_id IS NOT NULL"
    }

    # Monitor customer data quality
    monitor_data_quality("production.customers", customer_quality_rules)
    ```

    #### **3. Cost Monitoring and Optimization**

    ```python
    def analyze_cluster_costs():
        """Analyze cluster usage and costs"""
        usage_data = spark.sql("""
            SELECT
                cluster_id,
                cluster_name,
                DATE(start_time) as usage_date,
                SUM(DATEDIFF(MINUTE, start_time, end_time)) as total_minutes,
                AVG(num_workers) as avg_workers,
                node_type,
                COUNT(DISTINCT user_name) as unique_users,
                COUNT(*) as total_sessions
            FROM system.compute.cluster_usage
            WHERE start_time >= current_date() - INTERVAL 30 DAYS
            GROUP BY cluster_id, cluster_name, DATE(start_time), node_type
        """)

        # Calculate estimated costs (example pricing)
        cost_analysis = usage_data.withColumn(
            "estimated_cost_usd",
            col("total_minutes") * col("avg_workers") * 0.05 / 60  # $0.05 per worker-hour
        )

        # Identify optimization opportunities
        optimization_opportunities = cost_analysis.filter(
            (col("unique_users") == 1) & (col("total_minutes") > 480)  # Single user, >8 hours
        ).select(
            "cluster_name",
            "usage_date",
            "total_minutes",
            "estimated_cost_usd",
            lit("Consider using job clusters for single-user workloads").alias("recommendation")
        )

        return cost_analysis, optimization_opportunities

    # Generate cost reports
    cost_data, optimizations = analyze_cluster_costs()
    cost_data.write.mode("overwrite").table("monitoring.cluster_costs")
    optimizations.write.mode("overwrite").table("monitoring.cost_optimizations")
    ```

    </details>
