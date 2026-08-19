-   [Top 5 SQL Interview Questions for Data Engineers](https://bittersweet-mall-f00.notion.site/Top-5-SQL-Interview-Questions-for-Data-Engineers-10a1d38a67c44775878e2ee4c8ec5d45)

<details><summary style="font-size:18px;color:#C71585">Some Complex query examples on Employee Table</summary>

```sql
SELECT department, COUNT(*) AS num_employees, AVG(salary) AS avg_salary
FROM Employee
WHERE hire_date BETWEEN '2023-01-01' AND '2023-12-31'
AND department IN ('Sales', 'Marketing', 'Finance')
GROUP BY department
HAVING AVG(salary) > 60000
ORDER BY avg_salary DESC
LIMIT 5;
```

```sql
SELECT department, AVG(salary) AS avg_salary
FROM Employee
WHERE department IN ('Sales', 'Marketing', 'Finance')
GROUP BY department
HAVING AVG(salary) > 60000
ORDER BY avg_salary DESC
LIMIT 5;
```

```sql
SELECT department, COUNT(*) AS num_employees
FROM Employee
WHERE salary > 50000
GROUP BY department
HAVING COUNT(*) > 5
ORDER BY num_employees DESC
LIMIT 10;
```

</details>

<details><summary style="font-size:18px;color:#C71585">What is a Common Table Expression (CTE) in MySQL?</summary>

A Common Table Expression (CTE) in MySQL is a named temporary result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement. CTEs make complex queries easier to write and understand by breaking them down into simpler, more manageable parts. They are defined using the WITH keyword.

CTEs were introduced in MySQL 8.0 and are particularly useful for recursive queries or when you need to reuse the result set multiple times within a single query.

**Syntax**: Here's the basic syntax for a CTE:

```sql
WITH cte_name (column1, column2, ...)
AS (
    -- CTE query definition
    SELECT ...
)
-- Use the CTE in the main query
SELECT column1, column2, ...
FROM cte_name;
```

**Example**: Let's say you have a table employees with columns id, name, manager_id, and you want to create a CTE to find all employees under a specific manager.

```sql
WITH RecursiveEmployeeHierarchy AS (
    SELECT id, name, manager_id
    FROM employees
    WHERE manager_id IS NULL -- Assuming NULL is for top-level manager

    UNION ALL

    SELECT e.id, e.name, e.manager_id
    FROM employees e
    INNER JOIN RecursiveEmployeeHierarchy reh
    ON e.manager_id = reh.id
)
SELECT * FROM RecursiveEmployeeHierarchy;
```

**Types of CTEs**

-   `Non-recursive CTEs`: These CTEs do not reference themselves and are simpler to use. They are typically used for simplifying complex subqueries or breaking down large queries into more manageable parts.

```sql
WITH SalesData AS (
    SELECT product_id, SUM(sales) AS total_sales
    FROM sales
    GROUP BY product_id
)
SELECT product_id, total_sales
FROM SalesData
WHERE total_sales > 1000;
```

-   `Recursive CTEs`: These CTEs reference themselves and are used for hierarchical data, like organizational charts or tree structures. Recursive CTEs consist of an anchor member and a recursive member.

```sql
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT id, name, manager_id
    FROM employees
    WHERE manager_id IS NULL

    UNION ALL

    SELECT e.id, e.name, e.manager_id
    FROM employees e
    INNER JOIN EmployeeHierarchy eh
    ON e.manager_id = eh.id
)
SELECT * FROM EmployeeHierarchy;
```

**Benefits of Using CTEs**

-   `Improved readability`: CTEs allow you to break down complex queries into simpler, more understandable parts.
-   `Reusability`: You can define a CTE once and use it multiple times within the same query.
-   `Recursion`: Recursive CTEs are especially powerful for querying hierarchical data.

**Limitations**

-   `Performance`: While CTEs can improve readability and maintainability, they might not always offer performance benefits. In some cases, using CTEs can lead to suboptimal execution plans.
-   `MySQL Version`: CTEs are available in MySQL 8.0 and later. If you're using an earlier version, you won't have access to this feature.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between <b>CTEs</b> and <b>Views</b> in context of SQL?</summary>

In relational databases, **Common Table Expressions (CTEs)** and **Views** both allow you to structure and organize complex queries, but they serve different purposes and have distinct characteristics:

1. **Definition and Purpose**

    - **CTE (Common Table Expression)**: A CTE is a temporary, named result set defined within a single SQL statement, usually for readability and reusability within a complex query. It's created with a `WITH` clause at the beginning of the query and is only available for that specific execution.
    - **View**: A view is a stored query that behaves like a virtual table. It’s a saved SQL query within the database, which can be queried like a regular table. Views are often used to simplify access to complex data structures, enforce security, and maintain query consistency.

2. **Lifetime and Scope**

    - **CTE**: Exists only during the execution of the query. It’s temporary and only accessible within the query where it’s defined.
    - **View**: Persistent in the database until explicitly dropped. Once created, it can be used by any user with the appropriate permissions in multiple queries over time.

3. **Use Cases**

    - **CTE**: Best used for breaking down complex queries, recursive queries, or when temporary results are needed within a single query.
    - **View**: Useful for creating simplified representations of complex data that can be reused across multiple queries and users. It can encapsulate business logic or complex joins and can serve as an abstraction layer over the underlying tables.

4. **Performance Considerations**

    - **CTE**: Evaluated each time the query runs. CTEs are generally optimized as part of the query execution plan, but they may be slower for repeated use cases within different queries since they are not stored persistently.
    - **View**: Non-materialized views (default in most databases) are recalculated each time they’re accessed, which could impact performance for complex queries. Materialized views (if supported) store the results, offering faster access at the cost of needing periodic refreshes to reflect updated data.

5. **Recursive Operations**

    - **CTE**: Supports recursive operations in many RDBMSs, making it useful for querying hierarchical or tree-like data structures.
    - **View**: Does not inherently support recursion. To achieve recursion with views, a CTE or other recursive query would be required within the view definition, if allowed.

6. **Example**:

    ```sql
    -- CTE Example:
    WITH SalesCTE AS (
        SELECT customer_id, SUM(amount) AS total_sales
        FROM sales
        GROUP BY customer_id
    )
    SELECT *
    FROM SalesCTE
    WHERE total_sales > 1000;
    ```

    ```sql
    -- View Example:
    CREATE VIEW HighValueCustomers AS
    SELECT customer_id, SUM(amount) AS total_sales
    FROM sales
    GROUP BY customer_id
    HAVING total_sales > 1000;

    -- Later, you can query the view:
    SELECT * FROM HighValueCustomers;
    ```

7. **Summary Table**:

    | Feature         | CTE                      | View                                 |
    | --------------- | ------------------------ | ------------------------------------ |
    | **Lifetime**    | Temporary                | Persistent                           |
    | **Scope**       | Single query             | Database-wide                        |
    | **Usage**       | Complex query breakdown  | Data abstraction                     |
    | **Recursion**   | Supported in some RDBMSs | Not directly supported               |
    | **Performance** | Recomputed every query   | May use caching (materialized views) |

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between <b>WHERE</b> and <b>HAVING</b> in context of SQL?</summary>

In MySQL, both the `WHERE` and `HAVING` clauses are used to filter rows returned by a query, but they operate at different stages of query execution and have different purposes:

-   **WHERE Clause**:

    -   The WHERE clause is used to filter rows before any aggregation is performed.
    -   It is applied to individual rows in the table(s) being queried.
    -   Conditions specified in the WHERE clause are applied to the rows in the result set.
    -   It filters rows based on column values, typically using comparison operators (e.g., `=`, `>`, `<`, `LIKE`) to match specific criteria.
    -   Example:

        ```sql
        SELECT * FROM students WHERE age > 18;
        ```

-   **HAVING Clause**:

    -   The HAVING clause is used to filter rows after the aggregation has been performed, typically with aggregate functions such as SUM, COUNT, AVG, etc.
    -   It is applied to the result of aggregation, usually on groups defined by a GROUP BY clause.
    -   Conditions specified in the HAVING clause are applied to the groups generated by the GROUP BY clause.
    -   It filters groups based on aggregated values, such as the result of a SUM or COUNT operation.
    -   Example:

        ```sql
        SELECT department, AVG(salary) AS avg_salary
        FROM employees
        GROUP BY department
        HAVING AVG(salary) > 50000;
        ```

In summary, the main difference between WHERE and HAVING clauses in MySQL is that WHERE is used to filter individual rows based on column values before any aggregation, while HAVING is used to filter groups based on aggregated values after aggregation has been performed, typically with the GROUP BY clause.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between <b>TRUNCATE</b> and <b>DELETE</b> in context of SQL?</summary>

The `TRUNCATE` statement in MySQL is used to quickly delete all rows from a table without logging individual row deletions. Unlike the `DELETE` statement, which deletes rows one at a time and generates a log entry for each deleted row, `TRUNCATE` simply removes all rows from the table, resulting in faster performance, especially for large tables. Here's how to use it:

It's important to note that `TRUNCATE` is a DDL (Data Definition Language) statement, not a DML (Data Manipulation Language) statement like `DELETE`. Therefore, it cannot be rolled back using the ROLLBACK statement, and it resets any AUTO_INCREMENT columns to their starting values.

Also, keep in mind that `TRUNCATE` does not fire any triggers that might be associated with the table. If you need to execute triggers when deleting rows, you should use the `DELETE` statement instead.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between <b>JOIN</b> and <b>UNION</b> Operations?</summary>

The JOIN and UNION operations in SQL serve different purposes and have distinct functionalities:

-   **JOIN Operation**:

    -   The JOIN operation is used to combine rows from two or more tables based on a related column between them.
    -   It allows you to retrieve data from multiple tables by specifying the relationship between them using join conditions (e.g., ON clause).
    -   Joins can be categorized into different types such as INNER JOIN, LEFT JOIN, RIGHT JOIN, FULL JOIN, CROSS JOIN, etc., each serving a specific purpose in retrieving data.
    -   Joins combine columns from different tables into a single result set, but the rows remain distinct based on the join condition.

-   **UNION Operation**:

    -   The `UNION` operation is used to combine the result sets of two or more SELECT statements into a single result set.
    -   It is primarily used to combine rows from different SELECT statements or tables that have the same column structure.
    -   `UNION` removes duplicate rows from the combined result set by default. However, `UNION ALL` retains all rows, including duplicates.
    -   Unlike joins, `UNION` operates on rows, not columns, and requires that the SELECT statements involved have the same number of columns with compatible data types.
    -   `UNION` allows you to stack rows vertically, whereas JOIN allows you to combine columns horizontally.

-   **Main Differences**:

    -   JOIN combines columns from different tables based on related columns, while `UNION` combines rows from different SELECT statements or tables.
    -   JOIN requires specifying join conditions to determine how rows are combined, while `UNION` does not require any join conditions.
    -   JOIN operates horizontally, combining columns, while `UNION` operates vertically, stacking rows.

In summary, JOIN is used to horizontally combine columns from different tables based on related data, while `UNION` is used to vertically combine rows from different SELECT statements or tables with similar structures.

</details>

<details><summary style="font-size:18px;color:#C71585"> Distinguish between <b>BETWEEN</b> and <b>IN</b> conditional operators.</summary>

-   BETWEEN- Displays the rows based on range of values

    -   IN- Checks for values contained in a specific set of values.
    -   Example:

        ```sql
        SELECT * FROM Students where ROLL_NO BETWEEN 10 AND 50;
        SELECT * FROM students where ROLL_NO IN (8,15,25);
        ```

</details>

<details><summary style="font-size:18px;color:#C71585">How to delete duplicate records in MySQL?</summary>

Sure, there are several methods to delete duplicate records in MySQL. Here are a few commonly used approaches:

1.  Using `GROUP BY` and `HAVING`: You can use the `GROUP BY` and `HAVING` clauses to identify duplicate records based on specific columns and delete them.

    ```sql
    DELETE FROM your_table
    WHERE id NOT IN (
        SELECT MIN(id)
        FROM your_table
        GROUP BY col1, col2, col3
    );
    ```

    **In this query**:

    -   col1, col2, and col3 are the columns based on which you want to identify duplicates.
    -   id is assumed as the primary key or a unique identifier column.
    -   The inner subquery selects the minimum id for each set of duplicate records.
    -   The outer query deletes all records except those with the minimum id within each duplicate set.

2.  Using **ROW_NUMBER()** Window Function (MySQL 8.0+): If you're using MySQL 8.0 or later, you can leverage the `ROW_NUMBER()` window function to assign a row number to each record within duplicate sets.

    ```sql
    DELETE FROM your_table
    WHERE (col1, col2, col3) IN (
        SELECT col1, col2, col3
        FROM (
            SELECT col1, col2, col3, ROW_NUMBER() OVER (PARTITION BY col1, col2, col3 ORDER BY id) AS row_num
            FROM your_table
        ) AS t
        WHERE row_num > 1
    );
    ```

    **This query**:

    -   Assigns a row number to each record within duplicate sets using the ROW_NUMBER() function.
    -   Deletes all records except those with a row number of 1 within each duplicate set.

3.  Using Temporary Table: You can copy distinct records into a temporary table and then truncate the original table before re-inserting the unique records back into it.

    ```sql
    CREATE TABLE temp_table AS
    SELECT DISTINCT *
    FROM your_table;

    TRUNCATE TABLE your_table;

    INSERT INTO your_table
    SELECT * FROM temp_table;

    DROP TABLE temp_table;
    ```

    **This method**:

    -   Creates a temporary table temp_table containing only distinct records.
    -   Truncates the original table your_table.
    -   Inserts the unique records from temp_table back into your_table.
    -   Drops the temporary table.

</details>

<details><summary style="font-size:18px;color:#C71585">How creating an index of a table in RDBMS provide faster retrieval? What kind of algorithm it uses to perform indexed based operations?</summary>

Creating an index on a table in a Relational Database Management System (RDBMS) significantly improves data retrieval performance by allowing the database to quickly locate and access the desired rows without scanning the entire table. This is especially useful for large tables where full table scans would be time-consuming and inefficient.

##### How Indexes Provide Faster Retrieval

Reduced Search Space:

An index is a data structure that stores a sorted version of the column(s) it is created on. When a query is executed, the database can use the index to narrow down the search space, quickly locating the rows that match the query criteria.
Efficient Lookups:

With an index, the database can perform lookups more efficiently. Instead of scanning every row in the table, it can traverse the index structure to find the matching rows, which is much faster.
Quick Access Paths:

Indexes provide a direct access path to the data. For example, if an index is created on a column that is frequently used in WHERE clauses, the database can use the index to quickly find and retrieve the rows that meet the condition.

##### Types of Indexes and Algorithms

The most commonly used indexing algorithms in RDBMSs are B-trees (and variations like B+ trees) and Hash indexes. Each has its own characteristics and use cases.

-   **B-tree Index**:

    -   A B-tree index is a balanced tree data structure that maintains sorted data and allows searches, sequential access, insertions, and deletions in logarithmic time.
    -   In a B-tree, each node can have multiple children, and the tree remains balanced by splitting nodes that exceed the maximum number of children and merging nodes that fall below the minimum.

-   **B+ tree Index**:

    -   A B+ tree is a variation of the B-tree where all values are stored in the leaf nodes, and internal nodes only store keys that guide the search.
    -   B+ trees are particularly efficient for range queries because leaf nodes are linked, allowing in-order traversal.
    -   Algorithm for B-tree/B+ tree Operations:

        -   `Search`: Starting from the root, compare the search key with the keys in the node. Traverse to the appropriate child node based on the comparison until the leaf node is reached.
        -   `Insertion`: Insert the key in the appropriate leaf node. If the node overflows (exceeds the maximum number of keys), split the node and propagate the split upwards.
        -   `Deletion`: Remove the key from the appropriate leaf node. If the node underflows (falls below the minimum number of keys), merge or redistribute keys with sibling nodes and adjust the tree.

-   **Hash Index**:

    -   A hash index uses a hash function to map keys to a specific location in a hash table.
    -   Hash indexes are excellent for equality searches (e.g., finding a row where a column equals a specific value) because they provide constant-time complexity for lookups.
    -   Algorithm for Hash Index Operations:

        -   `Search`: Apply the hash function to the search key to compute the hash value, which directly points to the location in the hash table where the corresponding row is stored.
        -   `Insertion`: Compute the hash value for the key and store the key-value pair in the corresponding location in the hash table. Handle collisions using techniques like chaining or open addressing.
        -   `Deletion`: Compute the hash value for the key and remove the key-value pair from the corresponding location in the hash table.

#####

</details>

---

---

<details><summary style="font-size:25px;color:Orange">SQL Interview Questions</summary>

<details><summary style="font-size:18px;color:#C71585"> How do you maintain database integrity where deletions from one table will automatically cause deletions in another table?</summary>

-   `ON DELETE CASCADE` is a command that is used when deletions happen in the parent table, and all child records are automatically deleted, and the child table is referenced by the foreign key in the parent table.

    ```sql
    CREATE TABLE products(
        product_id INT PRIMARY KEY,
        product_name VARCHAR(50) NOT NULL,
        category VARCHAR(25)
    );
    ```

    ```sql
    CREATE TABLE inventory(
        inventory_id INT PRIMARY KEY,
        product_id INT NOT NULL,
        quantity INT,
        min_level INT,
        max_level INT,
        CONSTRAINT fk_inv_product_id FOREIGN KEY (product_id)
            REFERENCES products (product_id) ON DELETE CASCADE
    );
    ```

    -   The Products table is the parent table and the inventory table is the child table. If a productid is deleted from the parent table all the inventory records for that productid will be deleted from the child table

</details>

<details><summary style="font-size:18px;color:#C71585"> What is the MERGE statement?</summary>

-   The statement enables conditional updates or inserts into the table. It updates the row if it exists or inserts the row if it does not exist.

</details>

<details><summary style="font-size:18px;color:#C71585">How does an index improve query performance? </summary>

In a relational database management system (RDBMS), an index is a data structure that improves the speed of data retrieval operations on a table. It works by providing a quick lookup mechanism for locating rows based on the values of one or more columns. Here's how an index improves query performance:

-   `Faster Data Retrieval`: When a query specifies conditions in the WHERE clause that match the indexed columns, the database engine can use the index to quickly locate the relevant rows without scanning the entire table. This leads to faster data retrieval, especially for tables with a large number of rows.
-   `Reduced Disk I/O`: Without an index, the database may need to perform a full table scan to find matching rows, which requires reading every row from disk. With an index, the database can perform an index seek or scan, which involves reading only the index pages containing the relevant data. This reduces disk I/O operations and improves overall query performance.
-   `Optimized Sorting and Join Operations`: Indexes can also benefit sorting and join operations. For example, if a query involves an ORDER BY clause on an indexed column, the database can use the index to retrieve rows in the desired order without the need for additional sorting. Similarly, indexes can facilitate efficient join operations by providing quick access to related rows in joined tables.
-   `Covering Indexes`: In some cases, an index may cover all the columns required by a query, eliminating the need to access the actual table data. This is known as a covering index and can further improve query performance by reducing the amount of data that needs to be read from disk.
-   `Query Plan Optimization`: The presence of indexes allows the database optimizer to consider different query execution plans and choose the most efficient one based on factors such as index selectivity, cardinality, and cost estimates. This can lead to better query performance by selecting optimal access paths.
-   `Concurrency Control`: In addition to improving read operations, indexes can also enhance the performance of certain types of write operations, such as updates and deletes. By allowing the database to quickly locate rows to modify, indexes can reduce contention and improve concurrency control.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the concept of database sharding.</summary>

-   Database sharding is the practice of breaking up a large database into smaller, more manageable parts called shards, each of which is hosted on a separate database server.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the concept of data integrity in a database.</summary>

-   Data integrity ensures the accuracy, consistency, and reliability of data in a database. It is maintained through constraints, relationships, and rules.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the ACID properties of a transaction.</summary>

-   ACID stands for Atomicity, Consistency, Isolation, and Durability. These properties ensure the reliability of database transactions.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the concept of database normalization and its types.</summary>

-   Database normalization is the process of organizing data to reduce redundancy and dependency. Types include 1NF (First Normal Form), 2NF, 3NF, and BCNF (Boyce-Codd Normal Form).

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the term 'Normalization' in the context of databases.</summary>

-   Normalization is the process of organizing data in a database to reduce redundancy and improve data integrity. It involves dividing large tables into smaller, related tables.

</details>

<details><summary style="font-size:18px;color:#C71585"> Can we use TRUNCATE with a WHERE clause?</summary>

-   No, we cannot use TRUNCATE with the WHERE clause.

</details>

<details><summary style="font-size:18px;color:#C71585"> What is a UNION operator?</summary>

-   The UNION operator combines the results of two or more Select statements by removing duplicate rows. The columns and the data types must be the same in the SELECT statements.

        ```sql
        SELECT City FROM Customers
        UNION
        SELECT City FROM Suppliers
        ORDER BY City;
        ```

</details>

<details><summary style="font-size:18px;color:#C71585"> Explain the difference between a view and a table. </summary>

In the context of a relational database management system (RDBMS), a view and a table are both database objects that store and present data, but they have significant differences in terms of their structure, purpose, and usage:

-   **Structure**:

    -   `Table`: A table is a fundamental database object that stores data in rows and columns. It consists of a schema that defines the structure of the table, including the names and data types of its columns.
    -   `View`: A view is a virtual table that does not store data itself but rather presents data derived from one or more tables or other views. It is defined by a SQL query, known as the view's definition, which specifies how the data should be selected and presented.

-   **Data Storage**:

    -   `Table`: Tables physically store data on disk or in memory. When rows are inserted, updated, or deleted in a table, the changes are directly applied to the underlying data.
    -   `View`: Views do not store data independently. Instead, they provide a logical representation of data retrieved dynamically from one or more tables. When data is queried from a view, the underlying tables are accessed to retrieve the requested data in real-time.

-   **Purpose**:

    -   `Table`: Tables serve as the primary means of storing and managing structured data in a database. They represent the actual entities and relationships within the domain being modeled.
    -   `View`: Views are used for various purposes, including simplifying complex queries, providing customized data presentations, enforcing security policies, and abstracting underlying data structures. They offer a convenient way to encapsulate and reuse common query logic.

-   **Mutability**:

    -   `Table`: Tables are mutable, meaning that data can be inserted, updated, or deleted directly within the table.
    -   `View`: Views are generally read-only by default, although some views can be updatable if certain conditions are met (e.g., simple views with a single underlying table and no complex expressions).

-   **Storage Overhead**:

    -   `Table`: Tables consume storage space to store the actual data, indexes, and other metadata associated with the table.
    -   `View`: Views do not consume storage space directly because they do not store data. However, the underlying tables and indexes referenced by the view consume storage space.

-   **Schema Definition**:

    -   `Table`: Tables have a fixed schema defined by the table's structure, including column names, data types, constraints, and indexes.
    -   `View`: Views do not have their own schema but instead inherit the schema of the underlying tables or expressions specified in the view's definition.

</details>

<details><summary style="font-size:18px;color:#C71585"> Explain the use of the CASE statement in SQL</summary>

</details>

<details><summary style="font-size:18px;color:#C71585"> How do you remove duplicate rows from a table? </summary>

To remove duplicate rows from a table in a relational database management system (RDBMS) such as MySQL, you can use various methods depending on your specific requirements and the features supported by your database. Here are some common approaches:

-   **Using DISTINCT**: If you want to retrieve distinct rows from a table (i.e., remove duplicates when selecting data), you can use the DISTINCT keyword in a SELECT query.

    -   `Example`:

        ```sql
        SELECT DISTINCT column1, column2, ...
        FROM table_name;
        ```

-   **Using GROUP BY**: You can use the GROUP BY clause to group rows by certain columns and then select only one row from each group, effectively removing duplicates.

    -   `Example`:

        ```sql
        SELECT column1, column2, ...
        FROM table_name
        GROUP BY column1, column2, ...;
        ```

-   **Using a Temporary Table**: Another approach involves creating a temporary table with distinct rows and then replacing the original table with the temporary one.

    -   `Example (MySQL)`:

        ```sql
        CREATE TABLE temp_table AS
        SELECT DISTINCT *
        FROM original_table;

        -- Optionally, drop the original table
        DROP TABLE original_table;

        -- Rename the temporary table to the original table name
        RENAME TABLE temp_table TO original_table;
        ```

-   **Using ROW_NUMBER() Window Function**: You can use the `ROW_NUMBER()` window function to assign a unique row number to each row and then filter out rows with row numbers greater than 1.

    -   `Example (for removing duplicates based on a single column named column1)`:

        ```sql
        DELETE FROM table_name
        WHERE (column1) IN (
            SELECT column1
            FROM (
                SELECT column1, ROW_NUMBER() OVER (PARTITION BY column1 ORDER BY column1) AS row_num
                FROM table_name
            ) AS t
            WHERE t.row_num > 1
        );
        Using DELETE with EXISTS Subquery:
        ```

-   **Using DELETE with EXISTS Subquery**: You can use a subquery with the EXISTS keyword to identify duplicate rows and delete them from the table.

    -   `Example`:

        ```sql
        DELETE FROM table_name
        WHERE EXISTS (
            SELECT 1
            FROM table_name t2
            WHERE table_name.column1 = t2.column1
            AND table_name.primary_key_column > t2.primary_key_column
        );
        ```

Before performing any deletion operation, make sure to take appropriate backups and consider the impact on your data integrity and application behavior. Additionally, always test the queries in a non-production environment to ensure they behave as expected.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between `UNION` and `UNION ALL`? </summary>

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the concept of a stored procedure.</summary>

-   A stored procedure is a set of SQL statements that can be stored in the database and executed by calling the procedure rather than sending the SQL statements from the application.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the purpose of the ROLLBACK statement.</summary>

-   The ROLLBACK statement is used to undo changes made during a transaction that has not been committed. It rolls back the database to its previous state.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the purpose of the COMMIT statement in SQL?</summary>

-   The COMMIT statement is used to save the changes made during a transaction, making the changes permanent.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the concept of a subquery.</summary>

-   A subquery is a query nested within another query. It can be used to retrieve data that will be used by the main query as a condition.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the concept of a trigger in a database.</summary>

-   A trigger is a set of instructions that are automatically executed ("triggered") in response to certain events, such as an INSERT, UPDATE, or DELETE operation.

</details>

<details><summary style="font-size:18px;color:#C71585">What is a view in a database?</summary>

-   A view is a virtual table based on the result of a SELECT query. It does not store the data itself but provides a way to represent the data from one or more tables.

---

</details>

<details><summary style="font-size:18px;color:#C71585">What is an RDBMS?</summary>

-   RDBMS stands for Relational Database Management System. It is a type of database management system that stores data in the form of tables with relationships between the tables.

</details>

<details><summary style="font-size:18px;color:#C71585">What is a table in a database?</summary>

-   A table is a collection of data organized in rows and columns. Each row represents a record, and each column represents an attribute.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the difference between INNER JOIN and OUTER JOIN.</summary>

-   INNER JOIN returns only the rows where there is a match in both tables, while OUTER JOIN returns all rows from one table and the matched rows from the other.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between DELETE and TRUNCATE in SQL?</summary>

-   DELETE is used to remove rows from a table based on a condition, while TRUNCATE removes all rows from a table.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the purpose of the GROUP BY clause in SQL?</summary>

-   The GROUP BY clause is used to group rows that have the same values in specified columns into summary rows.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the purpose of the INDEX in a database?</summary>

-   An INDEX is used to speed up the retrieval of rows from a table by creating a data structure that allows for faster data access.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the difference between a candidate key and a composite key.</summary>

-   A candidate key is a column or set of columns that can uniquely identify a record, while a composite key is a combination of two or more columns that together uniquely identify a record.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between a clustered and non-clustered index?</summary>

-   In a clustered index, the order of the rows in the table is the same as the order in the index, while in a non-clustered index, the order of the rows in the table is not affected by the order of the index.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between UNION and UNION ALL in SQL?</summary>

-   UNION combines the results of two or more SELECT statements and removes duplicates, while UNION ALL includes all rows, including duplicates.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the purpose of the HAVING clause in SQL?</summary>

-   The HAVING clause is used in conjunction with the GROUP BY clause and is used to filter the results of a GROUP BY based on a specified condition.

</details>

<details><summary style="font-size:18px;color:#C71585">Explain the concept of database denormalization.</summary>

-   Database denormalization is the process of introducing redundancy into a table structure to improve query performance.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the purpose of the CHECK constraint in SQL?</summary>

-   The CHECK constraint is used to limit the range of values that can be placed in a column.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the purpose of the CASCADE constraint?</summary>

-   The CASCADE constraint is used to specify that when a referenced table is modified, the changes are automatically reflected in the referencing table.

</details>

<details><summary style="font-size:18px;color:#C71585">What is the difference between a database and a DBMS?</summary>

-   A database is a collection of data, while a DBMS (Database Management System) is software that provides an interface to interact with the database, managing storage, retrieval, and manipulation of data.

</details>

</details>

---

---

<details><summary style="font-size:18px;color:#C71585">What is a primary key?</summary>

-   A primary key is a unique identifier for each record in a table. It ensures that each record can be uniquely identified and helps establish relationships between tables.

</details>

<details><summary style="font-size:18px;color:#C71585"> What is a composite key?</summary>

A composite key, also known as a composite primary key, is a type of key in a relational database that consists of two or more columns used together to uniquely identify a row in a table. The combination of these columns must be unique across the table, ensuring that no two rows have the same set of values for these columns.

Defining a composite key is necessary in several scenarios where a single column cannot uniquely identify a row.

In an order details table, OrderID and ProductID together can uniquely identify each order line item, but individually, they cannot.

```sql
CREATE TABLE SAMPLE_TABLE
(COL1 integer,
COL2 varchar(30),
COL3 varchar(50),
PRIMARY KEY (COL1, COL2));
```

</details>

<details><summary style="font-size:18px;color:#C71585">What is a foreign key?</summary>

-   A foreign key is a column in a table that refers to the primary key in another table. It establishes a link between the two tables.

</details>

<details><summary style="font-size:18px;color:#C71585"> What is a cursor, and when do you use it?</summary>

-   A cursor is a database object which is used to manipulate data by traversing row by row in a result set. A cursor is used when you need to retrieve data, one row at a time from a result set and when you need to update records one row at a time.

    ```sql
        DECLARE @CustomerId INT
                    ,@Name VARCHAR(100)
                    ,@Country VARCHAR(100)
        --DECLARE AND SET COUNTER.
        DECLARE @Counter INT
        SET @Counter = 1
        --DECLARE THE CURSOR FOR A QUERY.
        DECLARE PrintCustomers CURSOR READ_ONLY
        FOR
        SELECT CustomerId, Name, Country FROM Customers
        --OPEN CURSOR.
        OPEN PrintCustomers
        --FETCH THE RECORD INTO THE VARIABLES.
        FETCH NEXT FROM PrintCustomers INTO
        @CustomerId, @Name, @Country
        --LOOP UNTIL RECORDS ARE AVAILABLE.
        WHILE @@FETCH_STATUS = 0
        BEGIN
                    IF @Counter = 1
                    BEGIN
                        PRINT 'CustomerID' + CHAR(9) + 'Name' + CHAR(9) + CHAR(9) + CHAR(9) + 'Country'
                        PRINT '------------------------------------'
                    END
                    --PRINT CURRENT RECORD.                 PRINT CAST(@CustomerId AS VARCHAR(10)) + CHAR(9) + CHAR(9) + CHAR(9) + @Name + CHAR(9) + @Country
                    --INCREMENT COUNTER.
                    SET @Counter = @Counter + 1
                    --FETCH THE NEXT RECORD INTO THE VARIABLES.
                    FETCH NEXT FROM PrintCustomers INTO
                    @CustomerId, @Name, @Country
        END
        --CLOSE THE CURSOR.
        CLOSE PrintCustomers
        DEALLOCATE PrintCustomers
    ```

</details>

<details><summary style="font-size:18px;color:#C71585"> What is a trigger?</summary>

-   Triggers are stored programs that get automatically executed when an event such as INSERT, DELETE, UPDATE(DML) statement occurs. Triggers can also be evoked in response to Data definition statements(DDL) and database operations, for example, SERVER ERROR, LOGON.

    ```sql
    create trigger dbtrigger
    on database
    for
    create_table,alter_table,drop_table
    as
    print'you can not create ,drop and alter table in this database'
    rollback;
    ```

    ```sql
    create trigger emptrigger
    on emp
    for
    insert,update,delete
    as
    print'you can not insert,update and delete this table i'
    rollback;
    ```

</details>

<details><summary style="font-size:18px;color:#C71585">What is SAVEPOINT in transaction control?</summary>

-   A SAVEPOINT is a point in a transaction when you can roll the transaction back to a certain point without rolling back the entire transaction.

    ```sql
    SQL> SAVEPOINT A
    SQL> INSERT INTO TEST VALUES (1,'Savepoint A');
        1 row inserted.
    SQL> SAVEPOINT B
    SQL> INSERT INTO TEST VALUES (2,'Savepoint B');
        1 row inserted.
    SQL> ROLLBACK TO B;
        Rollback complete.
    SQL> SELECT * FROM TEST;
        ID MSG

    ---

    1 Savepoint A
    ```

</details>
