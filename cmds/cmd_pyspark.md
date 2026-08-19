-   <details><summary style="font-size:25px;color:Orange">Imports</summary>

    ```python
    import pyspark
    from pyspark import SparkContext, Broadcast, Accumulator
    from pyspark.context import SparkContext, SparkConf, Broadcast, Accumulator
    from pyspark.sql import SparkSession, DataFrame, Row
    import pyspark.sql.functions as F
    import pyspark.sql.types as T
    import pyspark.sql.window as W

    from pyspark.sql import SparkSession
    from pyspark.sql import functions as F
    from pyspark.sql.functions import (
        collect_list,
        udf, col, when, asc, desc, lit, coalesce,
        mean, sum, avg, rand, stddev,
        count, countDistinct,
        format_number, isnan,
        asc, desc, mean,
        rank, lag, lead,
        upper, concat, lower, substring
    )
    from pyspark.sql.types import (
        StructField, StructType, LongType, TimestampType,
        StringType, IntegerType,
        FloatType, BooleanType,
        DateType,
    )
    from pyspark.sql.window import Window

    import psycopg2
    import pandas as pd
    from sqlalchemy import create_engine
    import qgrid

    #appName = "PySpark PostgreSQL Example - via psycopg2"
    #master = "local"

    #spark = SparkSession.builder.master(master).appName(appName).getOrCreate()



    conf = pyspark.SparkConf().setAll([('spark.executor.id', 'driver'),
                                    ('spark.app.id', 'local-1631738601802'),
                                    ('spark.app.name', 'PySparkShell'),
                                    ('spark.driver.port', '32877'),
                                    ('spark.sql.warehouse.dir', 'file:/home/data_analysis_tool/spark-warehouse'),
                                    ('spark.driver.host', 'localhost'),
                                    ('spark.sql.catalogImplementation', 'hive'),
                                    ('spark.rdd.compress', 'True'),
                                    ('spark.driver.bindAddress', 'localhost'),
                                    ('spark.serializer.objectStreamReset', '100'),
                                    ('spark.master', 'local[*]'),
                                    ('spark.submit.pyFiles', ''),
                                    ('spark.app.startTime', '1631738600836'),
                                    ('spark.submit.deployMode', 'client'),
                                    ('spark.ui.showConsoleProgress', 'true'),
                                    ('spark.driver.extraClassPath','/tmp/postgresql-42.2.23.jar')])


    sc = pyspark.SparkContext(conf=conf)
    sc.getConf().getAll()

    sparkSession = SparkSession (sc)

    sparkDataFrame = sparkSession.read.format("jdbc") \
        .options(
        url="jdbc:postgresql://localhost:5432/Database",
        dbtable="test_features_3",
        user="database_user",
        password="Pa$$word").load()

    print (sparkDataFrame.count())
    sc.stop()

    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">I/O</summary>

    ```python
    ## Read CSV Files
    df = spark.read.csv("/Users/am/DATA/uspopulation.csv", header=True, inferSchema=True, sep="|")
    df = spark.read.option("header", True).option("inferSchema", True).option("sep", "|").csv("/Users/am/DATA/uspopulation.csv")
    df = spark.read.options(header=True, inferSchema=True,, sep="|").csv("/Users/am/DATA/uspopulation.csv")



    ## Read JSON Files
    df = spark.read.json("path/to/file.json")

    ## Read Parquet Files
    df = spark.read.parquet("path/to/file.parquet")

    ## Read ORC Files
    df = spark.read.orc("path/to/file.orc")

    ## Read Text Files
    df = spark.read.text("path/to/file.txt")

    JDBC_CONN_OPTIONS = {
        "user": os.environ["MYSQL_USERNAME"],
        "password": os.environ["MYSQL_PASSWORD"],
        "driver": "com.mysql.cj.jdbc.Driver",
    }
    FORMAT_OPTIONS = {
        **JDBC_CONN_OPTIONS,
        "url": "jdbc:mysql://localhost:3306/IQ",
        "dbtable": "Employee"
    }
    df = spark.read.jdbc(url="jdbc:mysql://localhost:3306/IQ", table="Employee", properties=JDBC_CONN_OPTIONS)
    df = spark.read.format("jdbc").options(**JDBC_CONN_OPTIONS).load()

    ## Read JDBC/ODBC
    df = spark.read.format("jdbc").option("url", jdbc_url+"/IQ").option("dbtable", "Employee").option("user", "Shah").option("password", "11112222").load()

    ## Read JDBC/ODBC
    df = spark.read.format("jdbc").options(**options).load()

    ## Read Avro Files
    df = spark.read.format("avro").load("path/to/file.avro")

    ## Read Delta Lake
    df = spark.read.format("delta").load("path/to/delta/table")

    ## Read Other Formats
    df = spark.read.format("custom_format").load("path/to/source")
    ```

    ```python
    df.write.save(out_path, format="csv", header=True)

    ## Write CSV Files
    df.write.csv("path/to/output.csv", header=True)

    ## Write JSON Files
    df.write.json("path/to/output.json")

    ## Write Parquet Files
    df.write.parquet("path/to/output.parquet")

    ## Write ORC Files
    df.write.orc("path/to/output.orc")

    ## Write Text Files
    df.write.text("path/to/output.txt")

    ## Write Avro Files
    df.write.format("avro").save("path/to/output.avro")

    ## Write Delta Lake
    df.write.format("delta").save("path/to/delta/output")

    ## Write JDBC/ODBC
    JDBC_CONN_OPTIONS["preaction"] = """CREATE TABLE BONUS (
        EMPLOYEE_REF_ID INT,
        BONUS_AMOUNT INT(10),
        BONUS_DATE TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (EMPLOYEE_REF_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID) ON DELETE CASCADE
    );
    """ # This will create the table if it doesn't exist with the primary key constraint

    df.write.jdbc(url="jdbc:mysql://localhost:3306/IQ", table="Bonus", mode="overwrite", properties=JDBC_CONN_OPTIONS)

    ## Write JDBC/ODBC
    emp_df.write.format("jdbc").options(**FORMAT_OPTIONS).mode("append").save()

    ## Write JDBC/ODBC
    df.write.format("jdbc").option("url", "jdbc:mysql://localhost:3306/db").option("dbtable", "table_name").option("user", "username").option("password", "password").save()

    ## Write Hive Tables
    df.write.saveAsTable("hive_table")

    df.write.format("parquet").saveAsTable("non_bucketed_table")

    ## Write Partitioned Data
    df.write.partitionBy("column").parquet("path/to/output")

    df_transactions.coalesce(1).write.mode('overwrite').option("header", "true").csv("TNX_test.csv")

    df_transactions.repartition(5).write.mode("overwrite").option("header", "true").csv("/TNX_test.csv")
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Basics</summary>

    ```python

    df.columns

    df.dtypes

    df.schema

    df.rdd

    df.na

    df.isStreaming

    df.stat


    # Show a preview
    df.show()

    # Show preview of first / last n rows
    df.head(5)
    df.tail(5)

    # Show preview as JSON (WARNING: in-memory)
    df = df.limit(10) # optional
    print(json.dumps([row.asDict(recursive=True) for row in df.collect()], indent=2))

    # Limit actual DataFrame to n rows (non-deterministic)
    df = df.limit(5)

    # Get row count
    df.count()

    # Get column count
    len(df.columns)

    # Get results (WARNING: in-memory) as list of PySpark Rows
    df = df.collect()

    # Get results (WARNING: in-memory) as list of Python dicts
    dicts = [row.asDict(recursive=True) for row in df.collect()]

    # Convert (WARNING: in-memory) to Pandas DataFrame
    df = df.toPandas()

    # Batch Rename/Clean Columns
    for col in df.columns:
        df = df.withColumnRenamed(col, col.lower().replace(' ', '_').replace('-', '_'))
    ```

    ```python
    Option 1:

    column_names = ["column1", "column2", "column3"]

    # Read the CSV file with header
    df = spark.read.csv("path/to/csvfile.csv", header=True, inferSchema=True).toDF(*new_column_names)

    Option 2:

    df = spark.read.csv("path/to/csvfile.csv", header=True, inferSchema=True).

    # Rename columns
    for idx, new_name in enumerate(new_column_names):
        df = df.withColumnRenamed(f"_c{idx}", new_name)

    Option 3:

    # Define the column names
    column_names = "column1,column2,column3"

    # Read the CSV file with specified column names
    df = spark.read.option("header", "false") \
        .option("inferSchema", "true") \
        .option("delimiter", ",") \
        .option("quote", "\"") \
        .option("escape", "\"") \
        .schema(column_names) \
        .csv("path/to/csvfile.csv")
    ```

    ```python
    columns = sqldf.columns
    for old_col, new_col in zip(columns, column_names):
        sqldf = sqldf.withColumnRenamed(old_col, new_col)
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Transformations & Actions</summary>

    #### Transformations

    -   **Selecting Columns**

    ```python
    df.select("column1", "column2")
    ```

    -   **Filtering Rows**

    ```python
    df.filter(df.column1 == "value")
    ```

    -   **Grouping and Aggretting**

    ```python
    df.groupBy("column1").agg({"column2": "sum"})
    ```

    -   **Joining**

    ```python
    joined_df = df1.join(df2, "common_column")
    ```

    -   **Ordering**

    ```python
    df.orderBy("column1")
    ```

    -   **Windowing**

    ```python
    from pyspark.sql.window import Window
    from pyspark.sql.functions import row_number

    window = Window.partitionBy("column1").orderBy("column2")
    df.withColumn("row_number", row_number().over(window))
    ```

    #### Actions

    -   **Counting Rows**

        ```python
        df.count()
        ```

    -   **Collecting Data**

        ```python
        df.collect()
        ```

    -   **Writting Data**

        ```python
        df.write.csv("path/to/output.csv", header=True)

        df.write.json("path/to/output.json")

        df.write.parquet("path/to/output.parquet")
        ```

    -   **Showing Data**

        ```python
        df.show()
        ```

    -   **Summarizing Data**

        ```python
        df.describe().show()
        ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Operations Triggering Shuffling</summary>

    Shuffling in PySpark refers to redistributing data across different nodes in a cluster, often required for certain operations like joins, groupings, and aggregations. Shuffling can be a costly operation as it involves moving data between nodes over the network, so it’s important to be aware of which operations trigger a shuffle.

    Here’s a list of the main operations in PySpark that involve shuffling, along with examples:

    1. **`repartition()`**: Redistributes the data into a specified number of partitions.

        - It involves a full shuffle of the data.

        ```python
        from pyspark.sql import SparkSession

        spark = SparkSession.builder.appName("ShuffleDemo").getOrCreate()

        data = [("Alice", 34), ("Bob", 45), ("Charlie", 23), ("David", 54)]
        df = spark.createDataFrame(data, ["Name", "Age"])

        # Repartition to 3 partitions (causes a shuffle)
        df_repartitioned = df.repartition(3)
        print(f"Number of partitions: {df_repartitioned.rdd.getNumPartitions()}")
        ```

    2. **`coalesce()`**: Reduces the number of partitions. It tries to avoid full shuffling by minimizing the movement of data.

        - Shuffling is not carried out unless increasing number of partitions.

        ```python
        # Coalesce to 2 partitions (no shuffle, unless you're increasing partitions)
        df_coalesced = df.repartition(4).coalesce(2)
        print(f"Number of partitions: {df_coalesced.rdd.getNumPartitions()}")
        ```

    3. **`partitionBy()`**:

        ```python
        df.write.partitionBy("column").parquet("path/to/output")
        ```

    4. **`distinct()`**: Returns distinct rows by removing duplicates.

        - It shuffles data to ensure unique rows across partitions.

        ```python
        # Distinct operation (causes shuffle)
        df_distinct = df.distinct()
        df_distinct.show()
        ```

    5. **`groupBy()`**: Groups the data based on column(s), followed by an aggregation.

        - Data with the same group key is sent to the same partition.

        ```python
        # Group by Age and count the occurrences (causes shuffle)
        df_grouped = df.groupBy("Age").count()
        df_grouped.show()
        ```

    6. **`reduceByKey()` (RDD API)**: Groups by key and reduces values for each key.

        - Similar to `groupByKey()`, but with an additional `reduce` step.

        ```python
        rdd = spark.sparkContext.parallelize([("a", 1), ("b", 1), ("a", 1)])
        # Reduces values by key (causes shuffle)
        rdd_reduce = rdd.reduceByKey(lambda x, y: x + y)
        rdd_reduce.collect()
        ```

    7. **`groupByKey()` (RDD API)**: Groups values by key.

        - All values for a key are sent to the same partition.

        ```python
        # Group by key (causes shuffle)
        rdd_group = rdd.groupByKey()
        rdd_group.collect()
        ```

    8. **`join()`**: Joins two DataFrames based on keys.

        - Data from both DataFrames is shuffled to align rows based on the join key.

        ```python
        data2 = [("Alice", "HR"), ("Bob", "IT"), ("Charlie", "Finance")]
        df2 = spark.createDataFrame(data2, ["Name", "Department"])

        # Inner join (causes shuffle)
        df_join = df.join(df2, on="Name", how="inner")
        df_join.show()
        ```

    9. **`cogroup()` (RDD API)**: Groups data from two RDDs based on a key.

        - Similar to a join operation.

        ```python
        rdd1 = spark.sparkContext.parallelize([("a", 1), ("b", 2)])
        rdd2 = spark.sparkContext.parallelize([("a", 3), ("b", 4)])

        # Cogroup operation (causes shuffle)
        rdd_cogroup = rdd1.cogroup(rdd2)
        rdd_cogroup.collect()
        ```

    10. **`union()`**: Combines the rows of two DataFrames.

        - Data is shuffled to combine the partitions.

        ```python
        # Union two DataFrames (causes shuffle)
        df_union = df.union(df2.selectExpr("Name", "Age as Age"))
        df_union.show()
        ```

    11. **`sort()` / `orderBy()`**: Sorts rows of the DataFrame by columns.

        - It shuffles the data across partitions to perform the global sort.

        ```python
        # Sort by Age (causes shuffle)
        df_sorted = df.orderBy("Age")
        df_sorted.show()
        ```

    12. **`cartesian()` (RDD API)**: Returns the Cartesian product of two RDDs.

        - This is an expensive operation as it creates `n * m` output elements, where `n` and `m` are the sizes of the two RDDs.

        ```python
        rdd1 = spark.sparkContext.parallelize([1, 2, 3])
        rdd2 = spark.sparkContext.parallelize([4, 5, 6])

        # Cartesian product (causes shuffle)
        rdd_cartesian = rdd1.cartesian(rdd2)
        rdd_cartesian.collect()
        ```

    13. **`aggregateByKey()` (RDD API)**: Aggregates values for each key, using different functions for merging within partitions and across partitions.

        - Data is shuffled to combine values across partitions.

        ```python
        rdd = spark.sparkContext.parallelize([("a", 1), ("b", 2), ("a", 2)])
        # Aggregate by key (causes shuffle)
        rdd_agg = rdd.aggregateByKey(
            (0, 0),
            lambda acc, value: (acc[0] + value, acc[1] + 1),
            lambda acc1, acc2: (acc1[0] + acc2[0], acc1[1] + acc2[1])
        )
        rdd_agg.collect()
        ```

    14. **`byKey()` Operations (groupByKey, reduceByKey, combineByKey, etc.)**: These operations group or reduce values based on a key.

        - as they require moving data across partitions.

    15. **Key Points to Remember**:

        - **Repartitioning**: `repartition()` triggers a shuffle to distribute data across partitions, while `coalesce()` does not unless you increase the number of partitions.
        - **Aggregation and Grouping**: Operations like `groupBy()`, `reduceByKey()`, and `groupByKey()` trigger shuffles because they require data to be redistributed so that all values with the same key are grouped together.
        - **Joins and Sorting**: `join()` and `orderBy()` cause a shuffle to align data across partitions.
        - **Avoiding Unnecessary Shuffles**: Shuffles are expensive. To avoid unnecessary shuffles, minimize the use of `groupByKey()` in favor of more efficient operations like `reduceByKey()` and carefully manage partitioning.

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Joins</summary>

    ```python

    # Inner Join
    inner_join_df = employees.join(departments, employees.DEPARTMENT_ID == departments.DEPARTMENT_ID, "inner")
    inner_join_df.show()

    # Left Outer Join
    left_join_df = employees.join(departments, employees.DEPARTMENT_ID == departments.DEPARTMENT_ID, "left")
    left_join_df.show()

    # Right Outer Join
    right_join_df = employees.join(departments, employees.DEPARTMENT_ID == departments.DEPARTMENT_ID, "right")
    right_join_df.show()

    # Full Outer Join
    full_join_df = employees.join(departments, employees.DEPARTMENT_ID == departments.DEPARTMENT_ID, "outer")
    full_join_df.show()

    # Left Semi Join
    left_semi_join_df = employees.join(departments, employees.DEPARTMENT_ID == departments.DEPARTMENT_ID, "leftsemi")
    left_semi_join_df.show()

    # Left Anti Join
    left_anti_join_df = employees.join(departments, employees.DEPARTMENT_ID == departments.DEPARTMENT_ID, "leftanti")
    left_anti_join_df.show()

    # Cross Join
    cross_join_df = employees.crossJoin(departments)
    cross_join_df.show()

    # ---------------------------

    # Left join in another dataset
    df = df.join(person_lookup_table, 'person_id', 'left')

    # Match on different columns in left & right datasets
    df = df.join(other_table, df.id == other_table.person_id, 'left')

    # Match on multiple columns
    df = df.join(other_table, ['first_name', 'last_name'], 'left')
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">UDF</summary>

    In Apache PySpark, you can define and register User-Defined functions (UDFs) to perform custom operations on DataFrame columns. There are several ways to define and register UDFs in PySpark.

    A UDF is a custom function that can be applied to Spark DataFrame columns, especially when built-in functions are insufficient. Think of UDFs as a way to bring your own Python logic into Spark transformations.

    #### Using udf from `pyspark.sql.functions`

    -   **Example 1**: Simple Scalar UDF

        ```python
        from pyspark.sql import SparkSession
        from pyspark.sql.functions import udf
        from pyspark.sql.types import StringType

        # Initialize Spark Session
        spark = SparkSession.builder \
            .appName("UDF Example") \
            .getOrCreate()

        # Sample data
        data = [(1, "Alice"), (2, "Bob")]
        df = spark.createDataFrame(data, ["id", "name"])

        # Define a Python function
        def upper_case(name):
            return name.upper()

        # Register the UDF
        upper_case_udf = udf(upper_case, StringType())

        # Use the UDF
        df.withColumn("name_upper", upper_case_udf(df["name"])).show()

        # Stop Spark Session
        spark.stop()
        ```

    -   **Example 2**: UDF with Type Hints

        ```python
        from pyspark.sql.types import IntegerType

        # Define a Python function with type hints
        def add_one(x: int) -> int:
            return x + 1

        # Register the UDF
        add_one_udf = udf(add_one, IntegerType())

        # Use the UDF
        df.withColumn("id_plus_one", add_one_udf(df["id"])).show()
        ```

    #### Using `pandas_udf` for Vectorized UDFs

    Vectorized UDFs are faster than standard UDFs because they utilize Apache Arrow to batch process data.

    ```python
    from pyspark.sql.functions import pandas_udf
    from pyspark.sql.types import StringType
    import pandas as pd

    # Define a vectorized UDF
    @pandas_udf(StringType())
    def upper_case_vec(names: pd.Series) -> pd.Series:
        return names.str.upper()

    # Use the vectorized UDF
    df.withColumn("name_upper", upper_case_vec(df["name"])).show()
    ```

    #### Register and Use UDF in SQL

    You can register UDFs as SQL functions and use them in SQL queries.

    ```python
    # Register the UDF
    spark.udf.register("upper_case_sql", upper_case, StringType())

    # Create a temporary view
    df.createOrReplaceTempView("people")

    # Use the UDF in a SQL query
    spark.sql("SELECT id, name, upper_case_sql(name) as name_upper FROM people").show()
    ```

    #### Using `pandas_udf` for Grouped Map Operations

    Grouped map operations allow you to apply a UDF to each group of data, which is useful for complex transformations.

    ```python
    from pyspark.sql.functions import pandas_udf, PandasUDFType
    from pyspark.sql.types import StructType, StructField, IntegerType, StringType

    # Sample data with a group column
    data = [(1, "Alice", "A"), (2, "Bob", "B"), (3, "Charlie", "A"), (4, "David", "B")]
    df = spark.createDataFrame(data, ["id", "name", "group"])

    # Define a grouped map UDF
    @pandas_udf(
        StructType([
            StructField("id", IntegerType()),
            StructField("name", StringType()),
            StructField("group", StringType()),
            StructField("name_upper", StringType())
        ]),
        PandasUDFType.GROUPED_MAP
    )
    def upper_case_grouped(df: pd.DataFrame) -> pd.DataFrame:
        df["name_upper"] = df["name"].str.upper()
        return df

    # Use the grouped map UDF
    df.groupby("group").apply(upper_case_grouped).show()
    ```

    #### Notes

    -   **Standard UDFs (udf)**: Suitable for scalar operations and simple transformations. Defined using `pyspark.sql.functions.udf`.
    -   **Vectorized UDFs (pandas_udf)**: Utilize Apache Arrow for performance optimization, suitable for batch operations. Defined using `pyspark.sql.functions.pandas_udf`.
    -   **SQL UDFs**: Register UDFs as SQL functions using `spark.udf.register` and use them in SQL queries.
    -   **Grouped Map UDFs (pandas_udf with PandasUDFType.GROUPED_MAP)**: Apply UDFs to each group of data, useful for complex group-based transformations.

    -   **Performance Note**:

        -   UDFs are less efficient than native Spark functions because:
            -   They break Spark's Catalyst optimizer
            -   Run outside JVM, adding serialization cost
            -   Lose benefits like predicate pushdown, vectorization

    -   **When to Use UDFs in PySpark**:
        -   Built-in Spark SQL functions can’t handle your use case
        -   You need complex, domain-specific logic
        -   Performance is not a bottleneck

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Handling Missing Values</summary>

    #### Filtering

    ```python
    # Filter on equals condition
    df = df.filter(df.is_adult == 'Y')

    # Filter on >, <, >=, <= condition
    df = df.filter(df.age > 25)

    # Multiple conditions require parentheses around each condition
    df = df.filter((df.age > 25) & (df.is_adult == 'Y'))

    # Compare against a list of allowed values
    df = df.filter(col('first_name').isin([3, 4, 7]))

    # Sort results
    df = df.orderBy(df.age.asc()))
    df = df.orderBy(df.age.desc()))
    ```

    #### Column Operations

    ```python
    # Add a new static column
    df = df.withColumn('status', F.lit('PASS'))

    # Construct a new dynamic column
    df = df.withColumn('full_name', F.when(
        (df.fname.isNotNull() & df.lname.isNotNull()), F.concat(df.fname, df.lname)
    ).otherwise(F.lit('N/A'))

    # Pick which columns to keep, optionally rename some
    df = df.select(
        'name',
        'age',
        F.col('dob').alias('date_of_birth'),
    )

    # Remove columns
    df = df.drop('mod_dt', 'mod_username')

    # Rename a column
    df = df.withColumnRenamed('dob', 'date_of_birth')

    # Keep all the columns which also occur in another dataset
    df = df.select(*(F.col(c) for c in df2.columns))

    # Batch Rename/Clean Columns
    for col in df.columns:
        df = df.withColumnRenamed(col, col.lower().replace(' ', '_').replace('-', '_'))
    ```

    #### Casting & Coalescing Null Values & Duplicates

    ```python
    # Cast a column to a different type
    df = df.withColumn('price', df.price.cast(T.DoubleType()))

    # Replace all nulls with a specific value
    df = df.fillna({
        'first_name': 'Tom',
        'age': 0,
    })

    # Take the first value that is not null
    df = df.withColumn('last_name', F.coalesce(df.last_name, df.surname, F.lit('N/A')))

    # Drop duplicate rows in a dataset (distinct)
    df = df.dropDuplicates() # or
    df = df.distinct()

    # Drop duplicate rows, but consider only specific columns
    df = df.dropDuplicates(['name', 'height'])

    # Replace empty strings with null (leave out subset keyword arg to replace in all columns)
    df = df.replace({"": None}, subset=["name"])

    # Convert Python/PySpark/NumPy NaN operator to null
    df = df.replace(float("nan"), None)
    ```

    ##### Example

    ```python
    # Initialize SparkSession
    spark = SparkSession.builder.appName("HandleMissingData").getOrCreate()

    # Sample data with missing values
    data = [
        (1, "John", None),
        (2, None, 5000),
        (3, "Sara", 4500),
        (None, "David", None),
        (5, "Mike", 5500)
    ]

    # Define schema
    schema = ["id", "name", "salary"]

    # Create DataFrame
    df = spark.createDataFrame(data, schema)

    # Show the DataFrame
    df.show()

    # Drop rows with any null values
    df_dropped_any = df.na.drop()
    df_dropped_any.show()

    # Drop rows with all null values
    df_dropped_all = df.na.drop(how='all')
    df_dropped_all.show()

    # Drop rows with null values in specific columns
    df_dropped_subset = df.na.drop(subset=['name', 'salary'])
    df_dropped_subset.show()

    # Fill all null values with a specified value
    df_filled_all = df.na.fill("Unknown")
    df_filled_all.show()

    # Fill null values in specific columns
    df_filled_subset = df.na.fill({"name": "Unknown", "salary": 0})
    df_filled_subset.show()

    # Replace specific values
    # df_replaced = df.na.replace({None: "Unknown"})
    # df_replaced.show()

    # Using SQL to handle missing data
    df.createOrReplaceTempView("people")
    filled_df_sql = spark.sql("""
    SELECT id,
        COALESCE(name, 'Unknown') as name,
        COALESCE(salary, 0) as salary
    FROM people
    """)
    filled_df_sql.show()

    # Stop the SparkSession
    spark.stop()
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Useful Builtin Functions</summary>

    -   [Functions](https://spark.apache.org/docs/latest/api/python/reference/pyspark.sql/functions.html)

    ## String Operations

    #### String Filters

    ```python
    # Contains - col.contains(string)
    df = df.filter(df.name.contains('o'))

    # Starts With - col.startswith(string)
    df = df.filter(df.name.startswith('Al'))

    # Ends With - col.endswith(string)
    df = df.filter(df.name.endswith('ice'))

    # Is Null - col.isNull()
    df = df.filter(df.is_adult.isNull())

    # Is Not Null - col.isNotNull()
    df = df.filter(df.first_name.isNotNull())

    # Like - col.like(string_with_sql_wildcards)
    df = df.filter(df.name.like('Al%'))

    # Regex Like - col.rlike(regex)
    df = df.filter(df.name.rlike('[A-Z]*ice$'))

    # Is In List - col.isin(*cols)
    df = df.filter(df.name.isin('Bob', 'Mike'))
    ```

    #### String Functions

    ```python
    # Substring - col.substr(startPos, length)
    df = df.withColumn('short_id', df.id.substr(0, 10))

    # Trim - F.trim(col)
    df = df.withColumn('name', F.trim(df.name))

    # Left Pad - F.lpad(col, len, pad)
    # Right Pad - F.rpad(col, len, pad)
    df = df.withColumn('id', F.lpad('id', 4, '0'))

    # Left Trim - F.ltrim(col)
    # Right Trim - F.rtrim(col)
    df = df.withColumn('id', F.ltrim('id'))

    # Concatenate - F.concat(*cols)
    df = df.withColumn('full_name', F.concat('fname', F.lit(' '), 'lname'))

    # Concatenate with Separator/Delimiter - F.concat_ws(delimiter, *cols)
    df = df.withColumn('full_name', F.concat_ws('-', 'fname', 'lname'))

    # Regex Replace - F.regexp_replace(str, pattern, replacement)[source]
    df = df.withColumn('id', F.regexp_replace(id, '0F1(.*)', '1F1-$1'))

    # Regex Extract - F.regexp_extract(str, pattern, idx)
    df = df.withColumn('id', F.regexp_extract(id, '[0-9]*', 0))
    ```

    #### Number Operations

    ```python
    # Round - F.round(col, scale=0)
    df = df.withColumn('price', F.round('price', 0))

    # Floor - F.floor(col)
    df = df.withColumn('price', F.floor('price'))

    # Ceiling - F.ceil(col)
    df = df.withColumn('price', F.ceil('price'))

    # Absolute Value - F.abs(col)
    df = df.withColumn('price', F.abs('price'))

    # X raised to power Y – F.pow(x, y)
    df = df.withColumn('exponential_growth', F.pow('x', 'y'))

    # Select smallest value out of multiple columns – F.least(*cols)
    df = df.withColumn('least', F.least('subtotal', 'total'))

    # Select largest value out of multiple columns – F.greatest(*cols)
    df = df.withColumn('greatest', F.greatest('subtotal', 'total'))
    ```

    #### Date & Timestamp Operations

    ```python
    # Add a column with the current date
    df = df.withColumn('current_date', F.current_date())

    # Convert a string of known format to a date (excludes time information)
    df = df.withColumn('date_of_birth', F.to_date('date_of_birth', 'yyyy-MM-dd'))

    # Convert a string of known format to a timestamp (includes time information)
    df = df.withColumn('time_of_birth', F.to_timestamp('time_of_birth', 'yyyy-MM-dd HH:mm:ss'))

    # Get year from date:       F.year(col)
    # Get month from date:      F.month(col)
    # Get day from date:        F.dayofmonth(col)
    # Get hour from date:       F.hour(col)
    # Get minute from date:     F.minute(col)
    # Get second from date:     F.second(col)
    df = df.filter(F.year('date_of_birth') == F.lit('2017'))

    # Add & subtract days
    df = df.withColumn('three_days_after', F.date_add('date_of_birth', 3))
    df = df.withColumn('three_days_before', F.date_sub('date_of_birth', 3))

    # Add & Subtract months
    df = df.withColumn('next_month', F.add_month('date_of_birth', 1))

    # Get number of days between two dates
    df = df.withColumn('days_between', F.datediff('start', 'end'))

    # Get number of months between two dates
    df = df.withColumn('months_between', F.months_between('start', 'end'))

    # Keep only rows where date_of_birth is between 2017-05-10 and 2018-07-21
    df = df.filter(
        (F.col('date_of_birth') >= F.lit('2017-05-10')) &
        (F.col('date_of_birth') <= F.lit('2018-07-21'))
    )
    ```

    #### Array Operations

    ```python
    # Column Array - F.array(*cols)
    df = df.withColumn('full_name', F.array('fname', 'lname'))

    # Empty Array - F.array(*cols)
    df = df.withColumn('empty_array_column', F.array([]))

    # Get element at index – col.getItem(n)
    df = df.withColumn('first_element', F.col("my_array").getItem(0))

    # Array Size/Length – F.size(col)
    df = df.withColumn('array_length', F.size('my_array'))

    # Flatten Array – F.flatten(col)
    df = df.withColumn('flattened', F.flatten('my_array'))

    # Unique/Distinct Elements – F.array_distinct(col)
    df = df.withColumn('unique_elements', F.array_distinct('my_array'))

    # Map over & transform array elements – F.transform(col, func: col -> col)
    df = df.withColumn('elem_ids', F.transform(F.col('my_array'), lambda x: x.getField('id')))

    # Return a row per array element – F.explode(col)
    df = df.select(F.explode('my_array'))
    ```

    #### Struct Operations

    ```python
    # Make a new Struct column (similar to Python's `dict()`) – F.struct(*cols)
    df = df.withColumn('my_struct', F.struct(F.col('col_a'), F.col('col_b')))

    # Get item from struct by key – col.getField(str)
    df = df.withColumn('col_a', F.col('my_struct').getField('col_a'))
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Window Functions</summary>

    Window functions in Apache PySpark are incredibly useful for performing operations across partitions of your data without reshuffling or recomputing the entire dataset. These functions allow you to calculate cumulative sums, rankings, averages, etc., over a specified window or "frame" of rows.

    Here’s a list of some key window functions, along with brief demos:

    1. **`rank()`** and **`dense_rank()`**: Both of these functions assign ranks to rows in a partition. The difference is that `dense_rank()` doesn’t skip ranks when there are ties, while `rank()` does.

    ```python
    from pyspark.sql import SparkSession, Window
    from pyspark.sql.functions import rank, dense_rank

    spark = SparkSession.builder.master("local").appName("WindowFunctionsDemo").getOrCreate()

    data = [("A", 1000), ("B", 900), ("C", 900), ("D", 800)]
    df = spark.createDataFrame(data, ["Employee", "Salary"])

    ## Define a window specification (partition by nothing and order by Salary)
    # window_spec = Window.orderBy(df['Salary'].desc())

    window_spec = Window.partitionBy("department").orderBy(col("salary").desc())

    # Apply rank and dense_rank functions
    df.withColumn("rank", rank().over(window_spec)) \
    .withColumn("dense_rank", dense_rank().over(window_spec)) \
    .show()
    ```

    **Output:**

    ```
    +--------+------+----+----------+
    |Employee|Salary|rank|dense_rank|
    +--------+------+----+----------+
    |       A|  1000|   1|         1|
    |       B|   900|   2|         2|
    |       C|   900|   2|         2|
    |       D|   800|   4|         3|
    +--------+------+----+----------+
    ```

    2. **`row_number()`**: This function assigns a unique sequential number to rows within a partition.

    ```python
    from pyspark.sql.functions import row_number

    df.withColumn("row_number", row_number().over(window_spec)).show()
    ```

    **Output:**

    ```
    +--------+------+----------+
    |Employee|Salary|row_number|
    +--------+------+----------+
    |       A|  1000|         1|
    |       B|   900|         2|
    |       C|   900|         3|
    |       D|   800|         4|
    +--------+------+----------+
    ```

    3. **`lag()`** and **`lead()`**: These functions are used to access previous (`lag()`) or next (`lead()`) rows within the partition.

    ```python
    from pyspark.sql.functions import lag, lead

    df.withColumn("lag", lag("Salary", 1).over(window_spec)) \
    .withColumn("lead", lead("Salary", 1).over(window_spec)) \
    .show()
    ```

    **Output:**

    ```
    +--------+------+----+----+
    |Employee|Salary| lag|lead|
    +--------+------+----+----+
    |       A|  1000|null| 900|
    |       B|   900|1000| 900|
    |       C|   900| 900| 800|
    |       D|   800| 900|null|
    +--------+------+----+----+
    ```

    4. **`cume_dist()`** (Cumulative Distribution): This calculates the cumulative distribution of a value within a partition.

    ```python
    from pyspark.sql.functions import cume_dist

    df.withColumn("cume_dist", cume_dist().over(window_spec)).show()
    ```

    **Output:**

    ```
    +--------+------+------------------+
    |Employee|Salary|         cume_dist|
    +--------+------+------------------+
    |       A|  1000|               0.25|
    |       B|   900|               0.75|
    |       C|   900|               0.75|
    |       D|   800|               1.0|
    +--------+------+------------------+
    ```

    5. **`percent_rank()`**: This calculates the percentile rank of rows within a partition.

    ```python
    from pyspark.sql.functions import percent_rank

    df.withColumn("percent_rank", percent_rank().over(window_spec)).show()
    ```

    **Output:**

    ```
    +--------+------+------------+
    |Employee|Salary|percent_rank|
    +--------+------+------------+
    |       A|  1000|         0.0|
    |       B|   900|         0.5|
    |       C|   900|         0.5|
    |       D|   800|         1.0|
    +--------+------+------------+
    ```

    6. **`ntile()`**: This function divides rows within a partition into a specified number of buckets and assigns a bucket number to each row.

    ```python
    from pyspark.sql.functions import ntile

    df.withColumn("ntile", ntile(3).over(window_spec)).show()
    ```

    **Output:**

    ```
    +--------+------+-----+
    |Employee|Salary|ntile|
    +--------+------+-----+
    |       A|  1000|    1|
    |       B|   900|    2|
    |       C|   900|    2|
    |       D|   800|    3|
    +--------+------+-----+
    ```

    7. **`sum()` and **`avg()`\*\* (Aggregates over a window): You can calculate aggregates like `sum()`, `avg()`, `min()`, and `max()` over a window of rows.

    ```python
    from pyspark.sql.functions import sum, avg

    df.withColumn("sum_salary", sum("Salary").over(window_spec)) \
    .withColumn("avg_salary", avg("Salary").over(window_spec)) \
    .show()
    ```

    **Output:**

    ```
    +--------+------+----------+----------+
    |Employee|Salary|sum_salary|avg_salary|
    +--------+------+----------+----------+
    |       A|  1000|      3700|      925.0|
    |       B|   900|      2700|      900.0|
    |       C|   900|      1800|      900.0|
    |       D|   800|       800|      800.0|
    +--------+------+----------+----------+
    ```

    8. **`first()` and `last()`**: These functions return the first or last value within a window frame.

    ```python
    from pyspark.sql.functions import first, last

    df.withColumn("first_salary", first("Salary").over(window_spec)) \
    .withColumn("last_salary", last("Salary").over(window_spec)) \
    .show()
    ```

    **Output:**

    ```
    +--------+------+------------+-----------+
    |Employee|Salary|first_salary|last_salary|
    +--------+------+------------+-----------+
    |       A|  1000|        1000|        800|
    |       B|   900|        1000|        800|
    |       C|   900|        1000|        800|
    |       D|   800|        1000|        800|
    +--------+------+------------+-----------+
    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">MISC</summary>

    #### Aggregation Operations

    ```python
    # Row Count:                F.count()
    # Sum of Rows in Group:     F.sum(*cols)
    # Mean of Rows in Group:    F.mean(*cols)
    # Max of Rows in Group:     F.max(*cols)
    # Min of Rows in Group:     F.min(*cols)
    # First Row in Group:       F.alias(*cols)
    df = df.groupBy('gender').agg(F.max('age').alias('max_age_by_gender'))

    # Collect a Set of all Rows in Group:       F.collect_set(col)
    # Collect a List of all Rows in Group:      F.collect_list(col)
    df = df.groupBy('age').agg(F.collect_set('name').alias('person_names'))

    # Just take the lastest row for each combination (Window Functions)
    from pyspark.sql import Window as W

    window = W.partitionBy("first_name", "last_name").orderBy(F.desc("date"))
    df = df.withColumn("row_number", F.row_number().over(window))
    df = df.filter(F.col("row_number") == 1)
    df = df.drop("row_number")
    ```

    #### Repartitioning

    ```python
    # Repartition – df.repartition(num_output_partitions)
    df = df.repartition(1)
    ```

    #### Useful Functions / Transformations

    ```python
    def flatten(df: DataFrame, delimiter="_") -> DataFrame:
        '''
        Flatten nested struct columns in `df` by one level separated by `delimiter`, i.e.:

        df = [ {'a': {'b': 1, 'c': 2} } ]
        df = flatten(df, '_')
        -> [ {'a_b': 1, 'a_c': 2} ]
        '''
        flat_cols = [name for name, type in df.dtypes if not type.startswith("struct")]
        nested_cols = [name for name, type in df.dtypes if type.startswith("struct")]

        flat_df = df.select(
            flat_cols
            + [F.col(nc + "." + c).alias(nc + delimiter + c) for nc in nested_cols for c in df.select(nc + ".*").columns]
        )
        return flat_df


    def lookup_and_replace(df1, df2, df1_key, df2_key, df2_value):
        '''
        Replace every value in `df1`'s `df1_key` column with the corresponding value
        `df2_value` from `df2` where `df1_key` matches `df2_key`

        df = lookup_and_replace(people, pay_codes, id, pay_code_id, pay_code_desc)
        '''
        return (
            df1
            .join(df2[[df2_key, df2_value]], df1[df1_key] == df2[df2_key], 'left')
            .withColumn(df1_key, F.coalesce(F.col(df2_value), F.col(df1_key)))
            .drop(df2_key)
            .drop(df2_value)
        )

    ```

    </details>

---

-   <details><summary style="font-size:25px;color:Orange">Job Submits</summary>

    -   `$ spark-submit --driver-class-path=path/to/postgresql-connector-java-someversion-bin.jar file_to_run.py`

    </details>
