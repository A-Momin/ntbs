<details><summary style="font-size:18px;color:Orange;text-align:left">SQL, DBMS and RDBMS?</summary>

DBMSs are software applications that help you build and maintain databases. RDBMS is a subset of DBMS, and it is a database management system based on the relational model of the DBMS.

A Relational Database Management System (RDBMS) is a software system that manages and organizes data in a structured manner using the principles of the relational model. It's designed to store, retrieve, and manage large amounts of data while ensuring data integrity, consistency, and security. Here's an in-depth explanation of the terms and concepts associated with RDBMS:

-   `Database`: A collection of related data organized in tables, schemas, and other structures for efficient storage and retrieval.

-   `Table`: A fundamental structure in an RDBMS that represents a collection of related data. It consists of rows (records) and columns (fields).

-   `Row (Record)`: A single data entry within a table, representing a specific entity or instance. Each column stores a specific attribute of the entity.

-   `Column (Field)`: A single data element within a table that represents an attribute of the entity. Columns have a specified data type and store values.

-   `Schema`: A logical container that holds tables, views, indexes, and other database objects. It defines the structure, relationships, and constraints of the database.

-   `Primary Key`: A column or set of columns that uniquely identifies each row in a table. It enforces entity integrity and ensures data uniqueness.

-   `Foreign Key`: A column that establishes a link between two tables by referencing the primary key of another table. It enforces referential integrity, maintaining data consistency.

-   `Index`: A data structure that enhances data retrieval speed by creating a sorted reference to the table's data. It speeds up queries but may slightly slow down updates.

-   `Normalization`: A process to organize data in a way that minimizes data redundancy, reduces anomalies, and ensures data integrity. It involves decomposing tables into smaller, related tables.

-   `Denormalization`: The opposite of normalization, where redundant data is intentionally introduced to improve read performance at the expense of some update performance.

-   `ACID Properties`: A set of properties that guarantee reliable transaction processing: Atomicity (transactions are all or nothing), Consistency (maintaining data integrity), Isolation (transactions don't interfere), Durability (changes survive system failures).

-   `Transaction`: A sequence of one or more SQL statements executed as a single unit of work. It's used to maintain data integrity during database updates.

-   `Query Language (SQL)`: Structured Query Language is a standardized language used to interact with RDBMS. It includes commands like SELECT, INSERT, UPDATE, and DELETE for data manipulation.

-   `View`: A virtual table created by a query, displaying selected data from one or more tables. It simplifies data access and can enforce data security.

-   `Trigger`: A stored procedure that is automatically executed when a specific event (e.g., insert, update, delete) occurs in the database.

-   `Stored Procedure`: A precompiled set of SQL statements that can be executed as a single unit. They enhance security, reusability, and maintainability.

-   `Data Types`: Specific formats for representing data, such as integers, strings, dates, and more. They define the kind of data that can be stored in a column.

-   `Concurrency Control`: Techniques used to manage simultaneous access to the database by multiple users or processes. It ensures data consistency and prevents conflicts.

-   `Backup and Recovery`: Processes and strategies to create copies of the database and restore it in case of data loss, corruption, or system failures.

-   `Normalization Forms`: A set of rules that guide the process of database normalization. Examples include First Normal Form (1NF), Second Normal Form (2NF), and Third Normal Form (3NF).

-   `Joins`: Combining data from two or more tables based on a related column to retrieve meaningful information.

RDBMS systems like MySQL, PostgreSQL, Oracle Database, Microsoft SQL Server, and SQLite are widely used for various applications, ranging from small-scale web applications to large-scale enterprise systems. They provide a structured and efficient way to store, manage, and retrieve data while ensuring data integrity and security.

#### What are the subsets of SQL?

**DDL(Data Definition Language)**: Includes SQL commands like `CREATE`, `ALTER`, and `DELETE`.

In the context of SQL, data definition or data description language (DDL) is a syntax for creating and modifying database objects such as tables, indices, and users. DDL statements are similar to a computer programming language for defining data structures, especially database schemas. Common examples of DDL statements include `CREATE`, `ALTER`, and `DROP`.

**DML(Data Manipulation Language)**: Accesses and manipulates data Uses `INSERT`, `UPDATE` commands

DML includes the most common SQL statements to store, modify, delete, and retrieve data. They are SELECT, UPDATE, INSERT, and DELETE.

```sql
INSERT INTO table_name /*    Insert is a DML  statement */
VALUES (value, value, value  …)
INSERT INTO customers /*   data being inserted in the table customers    */
VALUES (‘George’ , 'Washington' , 'Connecticut')
```

3. **DCL(Data Control Language)**: Controls access to the database. Uses commands like `GRANT` and `REVOKE`.

</details>

---

<details><summary style="font-size:18px;color:Orange;text-align:left">JOIN in SQL</summary>

A join is used to query data from multiple tables based on the relationship between the fields.

There are four types of joins:

-   Inner Join
    Rows are returned when there is at least one match of rows between the tables.

```sql
select first_name, last_name, order_date, order_amount
from customers c
inner join orders o
on c.customer_id = o.customer_id
/*   customers and orders are two tables. Data will be displayed from the two tables where the customer_id from customer table matches
The customer_id from the orders table.   */
```

-   `Right Join` : Right join returns all rows from the right table and those which are shared between the tables. If there are no matching rows in the left table, it will still return all the rows from the right table.

    ```sql
    select first_name, last_name, order_date, order_amount
    from customers c
    left join orders o
    on c.customer_id = o.customer_id
    /*   customers and orders are two tables.   All rows from the Orders table is returned with matching rows from the Customers table if any  */
    ```

-   `Left Join`: Left join returns all rows from the Left table and those which are shared between the tables. If there are no matching rows in the right table, it will still return all the rows from the left table.

    ```sql
    select first_name, last_name, order_date, order_amount
    from customers c
    left join orders o
    on c.customer_id = o.customer_id
    /*   customers and orders are two tables.   All rows from the customers table is returned with matching rows from the orders table if any  */
    ```

-   `Full Join`: Full join return rows when there are matching rows in any one of the tables. This means it returns all the rows from the left-hand side table and all the rows from the right-hand side table.

    ```sql
    select first_name, last_name, order_date, order_amount
    from customers c
    full join orders o
    on c.customer_id = o.customer_id
    /*   customers and orders are two tables.   All rows from the Orders table and customer table are returned  */
    ```

#### What is the MERGE statement?

The statement enables conditional updates or inserts into the table. It updates the row if it exists or inserts the row if it does not exist.

#### What is a UNION operator?

The UNION operator combines the results of two or more Select statements by removing duplicate rows. The columns and the data types must be the same in the SELECT statements.

```sql
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;
```

</details>

---

<details><summary style="font-size:18px;color:Orange;text-align:left">SQL Constraints</summary>

Constraints are used to specify the rules of data type in a table.
They can be specified while creating and altering the table.
The following are the constraints in SQL:

-   `NOT NULL`: Restricts NULL value from being inserted into a column.
-   `CHECK`: Verifies that all values in a field satisfy a condition.
-   `DEFAULT`: Automatically assigns a default value if no value has been specified for the field.
-   `UNIQUE`: Ensures unique values to be inserted into the field.
-   `INDEX`: Indexes a field providing faster retrieval of records.
-   `PRIMARY KEY`: Uniquely identifies each record in a table.
-   `FOREIGN KEY`: Ensures referential integrity for a record in another table.

```sql
-- Create Employees table with constraints
-- Create Employees table with an INDEX constraint
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Age INT,
    DepartmentID INT,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10, 2) DEFAULT 50000.00,
    CONSTRAINT fk_department FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    INDEX idx_department (DepartmentID) -- Creating INDEX constraint
);

```

#### What is a primary key, a foreign key, unique, and composite key?

Answer:

-   The PRIMARY KEY is a field in the table which uniquely identifies a row. It cannot be NULL.
-   A FOREIGN KEY is a field in one table, which is a PRIMARY KEY in another table. A relationship is created between the two tables by referencing the FOREIGN KEY of one table with the PRIMARY KEY of another table. In the example below, the employee_id_ref in the salary table is the FOREIGN KEY.
-   Unique Key uniquely identifies a record in a table. There can be many unique key constraints defined on a table.
    EMP_ID
    EMP_NAME
    Government_ID
    222
    Harry
    111-203-987
    333
    Stephan
    789-456-123
    444
    Lan
    745-562-321
    #BBD0E0 »
    In the table above Emp_id is the PRIMARY KEY however Government_id is the unique key. You may want the Government_id to be unique for every employee. Since the data belongs to the government, you may not want it to be the PRIMARY KEY.

In a relational database management system (RDBMS), a composite key, also known as a composite primary key, is a key that consists of two or more columns (attributes) in a table. These columns, taken together, uniquely identify a record (row) within the table. A composite key is used to enforce uniqueness and to establish relationships between tables in a database.

Here's a more detailed explanation of a composite key:

-   `Uniqueness`: Each combination of values in the composite key must be unique across the table. This means no two rows can have the same set of values for the columns that make up the composite key.

-   `Primary Key`: In most cases, a composite key is used as a primary key for a table. This means it serves as a unique identifier for each record in the table.

-   `Relationships`: Composite keys are often used to establish relationships between tables. The columns that make up the composite key in one table can also be foreign keys in another table, creating a link between the tables.

-   `Order Matters`: The order of the columns in a composite key is important. Swapping the order of columns results in a different composite key value.

```sql
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    -- other columns
    PRIMARY KEY (OrderID, CustomerID) -- Composite primary key
);
```

#### What is a composite key?

When more than one column is used to define the primary key, it is called a composite key.
Here is a SQL syntax to create a composite key in MySQL

```sql
CREATE TABLE SAMPLE_TABLE
(COL1 integer,
COL2 varchar(30),
COL3 varchar(50),
PRIMARY KEY (COL1, COL2));
```

</details>

---

<details><summary style="font-size:18px;color:Orange;text-align:left">Normalization</summary>

Normalization is a process in database design to minimize data redundancy and dependency. The database is divided into two or more tables, and relationships are defined between them.

-   First Normal Form: Every record is unique in a table and is identified by a primary or a composite key

| StudiD | Name  | Phonenum              |
| ------ | ----- | --------------------- |
| 1      | John  | 9176612345,9176645698 |
| 2      | Susie | 9176645789            |
| 3      | Jim   | 9176696325            |

-   In the above table the field ‘phonenum’ is a multi-valued attribute, so it is not in 1NF.
-   Below Table is in 1NF as there is no multi-valued attribute

| StudiD | Name  | Phonenum   |
| ------ | ----- | ---------- |
| 1      | John  | 9176612345 |
| 1      | John  | 9176645698 |
| 2      | Susie | 9176645789 |
| 3      | Jim   | 9176696325 |

-   Second Normal Form: The table must be in First Normal Form, and it should have a single column as its primary key.
    2NF tries to reduce the redundant data getting stored in memory. To bring the above table in 2NF we split the table into two tables

| StudiD | Name   |
| ------ | ------ |
| 1      | . John |
| 2      | Susie  |
| 2      | . Jim  |

| StudiD | Phonenum   |
| ------ | ---------- |
| 1      | 9176612345 |
| 1      | 9176645698 |
| 2      | 9176645789 |
| 3      | 9176696325 |

-   Third Normal Form: The table must be in Second Normal Form and must have no transitive functional dependencies. I.e., a non-key column must not be dependent on another non-key column within the same table.'
    Consider the `EMPLOYEE_DETAIL` table: This table is not in the third normal form because the fields `emp_state` and `emp_city` depend on `emp_zip` and not on the primary key `emp_id`.

| EMP_ID | EMP_NAME | EMP_ZIP | EMP_STATE | EMP_CITY |
| ------ | -------- | ------- | --------- | -------- |
| 222    | Harry    | 201010  | CT        | Monroe   |
| 333    | Stephan  | 02228   | TX        | Dallas   |
| 444    | Lan      | 060007  | IL        | Chicago  |

The above table is split into 2 tables and now the tables are in the third normal form.

EMPLOYEE table:

| EMP_ID | EMP_NAME | EMP_ZIP |
| ------ | -------- | ------- |
| 222    | Harry    | 201010  |
| 333    | Stephan  | 02228   |
| 444    | Lan      | 060007  |

EMPLOYEE_ZIP table:

| EMP_ZIP | EMP_STATE | EMP_CITY |
| ------- | --------- | -------- |
| 201010  | CT        | Monroe   |
| 02228   | TX        | Dallas   |
| 060007  | IL        | Chicago  |

#### What is de-normalization, and when do you go for it?

De-normalization is a technique sometimes used to improve performance so the table design allows redundant data to avoid complex joins. If the application involves heavy read operations, then de-normalization is used at the expense of the write operations performance.

</details>

---

<details><summary style="font-size:18px;color:Orange;text-align:left">Important Concepts</summary>

#### What is a schema?

A schema is a collection of database objects in a database for a particular user/owner. Objects can be tables, views, indices and so on.

The database schema is its structure described in a formal language supported by the database management system (DBMS). The term "schema" refers to the organization of data as a blueprint of how the database is constructed (divided into database tables in the case of relational databases)

#### Can we use TRUNCATE with a WHERE clause?

No, we cannot use TRUNCATE with the WHERE clause.

#### Distinguish between BETWEEN and IN conditional operators.

BETWEEN- Displays the rows based on range of values
IN- Checks for values contained in a specific set of values.
Example:

```sql
SELECT * FROM Students where ROLL_NO BETWEEN 10 AND 50;
SELECT * FROM students where ROLL_NO IN (8,15,25);
```

#### Define COMMIT

When a COMMIT is used in a transaction all changes made in the transaction are written into the database permanently.

```sql
BEGIN TRANSACTION;
DELETE FROM HumanResources.JobCandidate
   WHERE JobCandidateID = 13;
COMMIT TRANSACTION;
```

The above example deletes a job candidate in a SQL server.

</details>

---

<details><summary style="font-size:18px;color:Orange;text-align:left">Definitions</summary>

#### What is a trigger?

Triggers are stored programs that get automatically executed when an event such as INSERT, DELETE, UPDATE(DML) statement occurs. Triggers can also be evoked in response to Data definition statements(DDL) and database operations, for example, SERVER ERROR, LOGON.

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

#### What is SAVEPOINT in transaction control?

A SAVEPOINT is a point in a transaction when you can roll the transaction back to a certain point without rolling back the entire transaction.

```sql
SQL> SAVEPOINT A
SQL> INSERT INTO TEST VALUES (1,'Savepoint A');
1 row inserted.
SQL> SAVEPOINT B
SQL> INSERT INTO TEST VALUES (2,'Savepoint B');
1 row inserted.
SQL> ROLLBACK TO B;
Rollback complete.
SQL> SELECT \* FROM TEST;
ID MSG

---

1 Savepoint A
```

#### What is a cursor, and when do you use it?

A cursor is a database object which is used to manipulate data by traversing row by row in a result set. A cursor is used when you need to retrieve data, one row at a time from a result set and when you need to update records one row at a time.

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
     SELECT CustomerId, Name, Country
      FROM Customers
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

---

#### What is the difference between CHAR and VARCHAR2 datatype in SQL?

CHAR is used to store fixed-length character strings, and VARCHAR2 is used to store variable-length character strings.
For example, suppose you store the string ‘Database’ in a CHAR(20) field and a VARCHAR2(20) field.
The CHAR field will use 22 bytes (2 bytes for leading length).
The VARCHAR2 field will use 10 bytes only (8 for the string, 2 bytes for leading length).

#### What are the scalar functions in SQL? Give an example?

Scalar Functions are used to return a single value based on the input values. Scalar Functions are as follows:

-   `UCASE()`: Converts the specified field in upper case

```sql
SELECT UCASE("SQL Tutorial is FUN!") AS UppercaseText;
```

UppercaseText
SQL TUTORIAL IS FUN!

-   `LCASE()`: Converts the specified field in lower case

#### What is the difference between SQL and MySQL?

SQL is a structured query language used to access the DBMS whereas MYSQL is an Open Source Relational DBMS.

#### How can you create an empty table from an existing table?

Answer:

```sql
CREATE TABLE NEW_TABLE_NAME AS SELECT [column1, column2 ……column]
FROM EXISTING_TABLE_NAME [WHERE ]
```

#### What are views, and why are they used?

SQL views are virtual tables created from one or more tables. Views are a subset of data; hence, it can limit the degree of exposure of data from the tables.
The following SQL creates a view that shows all customers from Brazil:

```sql
CREATE VIEW Brazil_Customers_view AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = "Brazil";
```

You can query the view above as follows:

```sql
SELECT * FROM Brazil_Customers_view;
```

#### What are the different operators in SQL?

Answer:

1.  Arithmetic
2.  Comparison
3.  Logical

#### What are GROUP functions? Why do we need them?

Group functions work on a set of rows and return a single result per group. The popularly used group functions are AVG, MAX, MIN, SUM, VARIANCE, COUNT
``

#### Distinguish between a table and a field in SQL.

The collection of data organized in the form of columns and rows refers to the table. The number of columns in a table refers to the field.
Table: Employee_Details
Fields: Emp_id, Emp_name, Emp_dept, Emp_salary

#### What is data integrity?

Data integrity defines the accuracy, consistency, and reliability of data that is stored in the database.
There are four kinds of data integrity:

1.  Row integrity
2.  Column integrity
3.  Referential integrity
4.  User-defined integrity

#### What are entities and relationship

Answer:

-   Entity: A person, place, or any real-world thing that can be represented as a table is called an entity.
    Example: Employee table represents the details of an employee in an organization.
-   Relationship: Relationship defines the dependency that entities share amongst each other.
    Example: Employee name, id, salary might belong to the same or different tables.

#### Write the SQL query to get the current date.

Answer:

```sql
SELECT CURDATE();
```

#### What are the different character manipulation functions?

Answer:

1.  CONCAT: joins two or more string values.
2.  SUBSTR: extracts string of a specific length.
3.  LENGTH: returns the length of the string
4.  INSTR: returns the position of the specific character.
5.  LPAD: padding of the left-side character value for right-justified value.
6.  RPAD: padding of right-side character value for left-justified value.
7.  TRIM: removes the defined character from beginning and end or both.
8.  REPLACE: replaces a specific sequence of characters with another sequence of characters.

#### Can a View be active if the Base table is dropped?

No, the view cannot be active in the parent table is dropped.

#### What is a One-Many Relationship in SQL?

In a One-Many relationship, a record in One Table can be associated or related to Many records in another table.

#### What are ACID properties in a transaction

In order to maintain consistency in a database ‘before and after’ transactions, certain properties are followed. They are

-   Atomicity: This means the transaction must happen fully and cannot be left midway.
-   Consistency: To maintain integrity constraints hence valid data enters the database
-   Isolation: Controls Concurrency
-   Durability: Once a transaction is committed it remains committed

#### What is Dateadd SQL?

Dateadd is a function that is used to add a number to specified part of the date and returns the modified date. Syntax- `DATEADD (date_part, value, input_date);` Date part can be as below-

-   date_part
-   abbreviations
-   Year
-   yy, yyyy
-   Quarter
-   qq, q
-   Month
-   mm, m
-   dayofyear
-   dy, y
-   Day
-   dd, d
-   Week
-   wk, ww
-   Hour
-   hh
-   Minute
-   mi, n
-   Second
-   ss, s
-   millisecond
-   ms
-   microsecond
-   mcs
-   nanosecond
-   ns

#### What is a set-based solution?

Cursors operate on individual rows, and in the case of a set, it works on a resultant set of data, which could be a table/view or a join of both. The resultant set is an output of a SQL query.

#### What is a forward cursor?

Forward cursors support fetching of rows from start to end from a result set. You cannot go to the previous row in the result set.

#### State one situation where the set-based solution is advantageous over the cursor-based solution

Set-based solutions provide better performance as they work on a result set and not on one row at a time. They are concise and more readable.

#### What are clustered indexes and non-clustered indexes?

A table can have only one clustered index. In this type of index, it reorders the table based on the key values and physically stores them in that order.
The non-clustered index does not have the physical ordering of the data in the table it has a logical order.

```sql
CREATE CLUSTERED INDEX IX_tblStudent_Gender_Score
ON student(gender ASC, total_score DESC)
```

The above script creates a clustered index named “IX_tblStudent_Gender_Score” on the student table. This index is created on the “gender” and “total_score” columns. An index that is created on more than one column is called the “composite index”.
A non-clustered index doesn’t sort the physical data inside the table. A non-clustered index is stored in one place, and table data is stored in another place. This allows for more than one non-clustered index per table.

```sql
CREATE NONCLUSTERED INDEX IX_tblStudent_Name
ON student(name ASC)
```

The above script creates a non-clustered index on the “name” column of the student table — the index sorts by name in ascending order. The table data and index will be stored in different places.

#### What is T-SQL?

It is an extension of SQL(Structured Query Language) developed by Sybase and used by Microsoft.

#### What are system functions and give one example

System functions are operations performed on the database server, and values are returned accordingly.
Example: @@ERROR - Returns 0 if the previous Transact-SQL statement encountered no errors. Otherwise returns an error number.

#### What is a transaction log?

A log is an audit trail file where the history of actions executed by the DBMS is stored.

#### How do you maintain database integrity where deletions from one table will automatically cause deletions in another table?

`ON DELETE CASCADE` is a command that is used when deletions happen in the parent table, and all child records are automatically deleted, and the child table is referenced by the foreign key in the parent table.

```sql
CREATE TABLE products
( product_id INT PRIMARY KEY,
 product_name VARCHAR(50) NOT NULL,
 category VARCHAR(25)
);
```

```sql
CREATE TABLE inventory
( inventory_id INT PRIMARY KEY,
 product_id INT NOT NULL,
 quantity INT,
 min_level INT,
 max_level INT,
 CONSTRAINT fk_inv_product_id
   FOREIGN KEY (product_id)
   REFERENCES products (product_id)
   ON DELETE CASCADE
);
```

The Products table is the parent table and the inventory table is the child table. If a productid is deleted from the parent table all the inventory records for that productid will be deleted from the child table

#### How do you sort records in a table?

The ORDER BY Clause is used to sort records in a table.

```sql
SELECT * FROM Emp ORDER BY salary;
```

By default, the records are returned in ascending order.

#### What is a shared lock?

When two transactions are granted read access to the same data, they are given a shared lock. This enables reading the same data, and data is not updated until the shared lock is released.

#### What is a deadlock?

It is an unwanted situation where two or more transactions are waiting indefinitely for one another to release the locks.
Below is an example of a deadlock situation

#### What is lock escalation?

Lock escalation is a process of converting row or page locks into table locks. It is an optimization technique used by RDBMS like SQL Server dynamically.

#### What is SQL injection?

SQL injection is a code injection technique used to hack data-driven applications.

#### How do we avoid getting duplicate entries in a query?

The Select `DISTINCT` is used to get distinct data from tables using a query
The following SQL statement selects only the `DISTINCT` values from the "Country" column in the "Customers" table:
`SELECT DISTINCT Country FROM Customers;`

#### Give an example of a comparison operator in SQL

EQUAL TO written as = is used to compare data values

#### What is a Subquery?

A subQuery is a SQL query nested into a larger Query.

```sql
SELECT
   employee_id, first_name, last_name
FROM
   employees
WHERE
   department_id IN (SELECT
           department_id
       FROM
           departments
       WHERE
           location_id = 1700)
ORDER BY first_name , last_name;
```

The query placed within the parentheses is called a subquery. It is also known as an inner query or inner select. The query that contains the subquery is called an outer query or an outer select.

#### What is a Non-correlated subquery?

A Non-Correlated subquery is an independent query, and the output of subquery is substituted in the main query.
Advance Interview Questions

```sql

```

#### Can we embed Pl/SQL in SQL? Justify your answers

PL/SQL is a procedural language, and it has one or more SQL statements in it. So SQL can be embedded in a PL/SQL block; however, PL/SQL cannot be embedded in SQL as SQL executes a single query at a time.

```sql
DECLARE                            /* this is a PL/SQL block */
  qty_on_hand  NUMBER(5);
BEGIN
  SELECT quantity INTO qty_on_hand FROM inventory     /* this is the SQL statement embedded in the PL/SQL block   */
    WHERE product = 'TENNIS RACKET';
 END;
```

#### What is a SYSTEM Privilege?

Rights are given to a user, usually by the DBA, to perform a particular action on the database schema objects like creating tablespaces.
The following are examples of system privileges that can be granted to users:

-   `CREATE TABLE` allows a grantee to create tables in the grantee's schema.
-   `CREATE USER` allows a grantee to create users in the database.
-   `CREATE SESSION` allows a grantee to connect to an Oracle database to create a user session.

#### What are Object Privileges?

An object-level privilege is a permission granted to a database user account or role to perform some action on a database object. These object privileges include SELECT, INSERT, UPDATE, DELETE, ALTER, INDEX on tables, and so on.
The following examples are object privileges that can be granted to users:

-   `SELECT ON hr.employees TO myuser`
-   `INSERT ON hr.employees TO myuser`

#### What does the BCP command do?

The BCP (Bulk Copy) is a utility or a tool that exports/imports data from a table into a file and vice versa

#### What does the VARIANCE function do?

This function returns the VARIANCE of a set of numbers:

```sql
CREATE TABLE EMP (EMPNO NUMBER(4) NOT NULL,
                 ENAME VARCHAR2(10),
                 JOB VARCHAR2(9),
                 SAL NUMBER(7, 2),
                 DEPTNO NUMBER(2));
INSERT INTO EMP VALUES (1, 'SMITH', 'CLERK',     800, 20);
INSERT INTO EMP VALUES (2, 'ALLEN', 'SALESMAN', 1600,    30);
INSERT INTO EMP VALUES (3, 'WARD',  'SALESMAN', 1250, 30);
INSERT INTO EMP VALUES (4, 'JONES', 'MANAGER',  2975, 20);
INSERT INTO EMP VALUES (5, 'MARTIN','SALESMAN', 1250,    30);
INSERT INTO EMP VALUES (6, 'BLAKE', 'MANAGER',  2850, 30);
INSERT INTO EMP VALUES (7, 'CLARK', 'MANAGER',  2850, 10);
INSERT INTO EMP VALUES (8, 'SCOTT', 'ANALYST',  3000, 20);
INSERT INTO EMP VALUES (9, 'KING',  'PRESIDENT',3000, 10);
INSERT INTO EMP VALUES (10,'TURNER','SALESMAN', 1500,    30);
INSERT INTO EMP VALUES (11,'ADAMS', 'CLERK',    1500, 20);
```

```sql
SQL> SELECT VARIANCE(sal)
 2  FROM emp;
VARIANCE(SAL)
-------------
   759056.818
```

#### What is the role of GRANT and REVOKE commands?

The GRANT command enables privileges on the database objects and the REVOKE command removes them. They are DCL commands

```sql
GRANT CREATE ANY TABLE TO username
GRANT sysdba TO username
GRANT DROP ANY TABLE TO username
REVOKE CREATE TABLE FROM username
```

#### Where are stored procedures stored in the database?

Stored Procedures are stored in the Data Dictionary of the Database.

#### Can we call Stored Procedure inside Stored Procedure?

Yes, we can call a stored procedure from another stored procedure. For example, Procedure2 is the procedure which is called Procedure1. Both Procedure1 and Procedure2 can have business logic implemented in it.

```sql
Create PROCEDURE Procedure1
AS BEGIN
Exec Procedure2
END
```

#### Does the data stored in the stored procedure increase access time or execution time? Explain

Data stored in stored procedures can be retrieved much faster than the data stored in the SQL database. Data can be precompiled and stored in stored procedures. This reduces the time gap between query and compiling as the data has been pre-compiled and stored in the procedure.

#### Can a Stored Procedure contain a return value?

Procedures may or may not return values.

#### What is the difference between null, zero and blank space?

NULL refers to a value that is unknown, not available, unapplicable or unassigned. While zero is a number and blank space is treated as a character.

#### Which function is used to return the remainder in a division operator in SQL?

The MOD function returns the remainder in the division operation.

#### What are case manipulation functions?

Case manipulation functions converts the existing data in the table to lower, upper or mixed case characters.

#### What are the different case manipulation functions in SQL?

Answer:

1.  LOWER: converts all the characters to lowercase.
2.  UPPER: converts all the characters to uppercase.
3.  INITCAP: converts initial character of each word to uppercase

#### What are the character manipulation functions?

Character manipulation functions alter, extract and change the character string.

#### Define inconsistent dependency.

The difficulty of accessing data as the path may be broken or missing defines inconsistent dependency. Inconsistent dependency enables users to search for data in the wrong different table which afterward results in an error as an output.

#### Explain recursive stored procedure.

Stored procedure calling itself until it reaches some boundary condition is a recursive stored procedure. It enables the programmers to use a set of code n number of times.

#### How can dynamic SQL be executed?

It can be executed by the following ways:

-   By executing the query with parameters.
-   By using EXEC
-   By using sp_executesql

#### Define Cursor

Cursor is a control that allows traversal over the rows and records of the table. It acts as a pointer to a row in a set of rows. It is used for traversing like retrieval, addition, and removal of database records.

#### What is the stored procedure?

It is a function consisting of many SQL statements to access the database system. Several SQL statements are consolidated into a stored procedure and are executed wherever and whenever required.

#### What do you understand by Auto Increment?

This keyword allows a new unique number to be generated whenever a new record is inserted into the table. It can be used where we need the PRIMARY KEY.

#### What is a Data warehouse?

Data from multiple sources of information is stored in a central repository called Data warehouse. Data warehouses have subsets of data called data marts. The data stored is transformed and used for online mining and processing.

#### What are user-defined functions?

Functions written to use the specific logic whenever required are user-defined functions. It avoids redundancy by avoiding writing the same logic again.

#### Mention the types user-defined functions?

There are three types of user-defined functions:

-   Scalar functions
-   Inline Table-valued functions
-   Multi statement valued functions

#### What is ALIAS command?

This command provides another name to a table or a column. It can be used in WHERE clause of a SQL query using the as keyword.
Example:

```sql
SELECT S.StudentID, E.Result from student S, Exam as E where S.StudentID = E.StudentID
```

S and E are alias names for student table and exam table respectively.

#### What is Collation?

Collation is defined as the set of rules that determines how to store and compare data.

#### Mention the different types of collation sensitivity.

The following are the types of collation sensitivity:

1.  Case
2.  Kana
3.  Width
4.  Accent

#### What are STUFF and REPLACE functions?

Answer:
STUFF: overwriteS existing character or inserts a string into another string.
Syntax:

```sql
STUFF(string_expression,start, length, replacement_characters)
REPLACE: replaces the existing characters of all the occurrences.
```

Syntax:

```sql
REPLACE (string_expression, search_string, replacement_string)
```

### Second set of Questions

#### 13. What is the difference between clustered and non-clustered index in SQL?

The differences between the clustered and non clustered index in SQL are : 1. Clustered index is used for easy retrieval of data from the database and its faster whereas reading from non clustered index is relatively slower. 2. Clustered index alters the way records are stored in a database as it sorts out rows by the column which is set to be clustered index whereas in a non clustered index, it does not alter the way it was stored but it creates a separate object within a table which points back to the original table rows after searching. 3. One table can only have one clustered index whereas it can have many non clustered index.

#### 14. Write a SQL query to display the current date?

In SQL, there is a built-in function called GetDate() which helps to return the current timestamp/date.

#### 15.What do you understand by query optimization?

The phase that identifies a plan for evaluation query which has the least estimated cost is known as query optimization.
The advantages of query optimization are as follows:

-   The output is provided faster
-   A larger number of queries can be executed in less time \* Reduces time and space complexity

#### 17. What are Entities and Relationships?

Entities: A person, place, or thing in the real world about which data can be stored in a database. Tables store data that represents one type of entity. For example – A bank database has a customer table to store customer information. The customer table stores this information as a set of attributes (columns within the table) for each customer.
Relationships: Relation or links between entities that have something to do with each other. For example – The customer name is related to the customer account number and contact information, which might be in the same table. There can also be relationships between separate tables (for example, customer to accounts).

#### 18. What is an Index?

An index refers to a performance tuning method of allowing faster retrieval of records from the table. An index creates an entry for each value and hence it will be faster to retrieve data.

#### 19. Explain different types of index in SQL.

There are three types of index in SQL namely:
Unique Index:
This index does not allow the field to have duplicate values if the column is unique indexed. If a primary key is defined, a unique index can be applied automatically.
Clustered Index:
This index reorders the physical order of the table and searches based on the basis of key values. Each table can only have one clustered index.
Non-Clustered Index:
Non-Clustered Index does not alter the physical order of the table and maintains a logical order of the data. Each table can have many nonclustered indexes.

#### 23. What is the ACID property in a database?

ACID stands for Atomicity, Consistency, Isolation, Durability. It is used to ensure that the data transactions are processed reliably in a database system.

-   Atomicity: Atomicity refers to the transactions that are completely done or failed where transaction refers to a single logical operation of a data. It means if one part of any transaction fails, the entire transaction fails and the database state is left unchanged.
-   Consistency: Consistency ensures that the data must meet all the validation rules. In simple words, you can say that your transaction never leaves the database without completing its state.
-   Isolation: The main goal of isolation is concurrency control.
-   Durability: Durability means that if a transaction has been committed, it will occur whatever may come in between such as power loss, crash or any sort of error.

#### 24. What do you mean by “Trigger” in SQL?

Trigger in SQL is are a special type of stored procedures that are defined to execute automatically in place or after data modifications. It allows you to execute a batch of code when an insert, update or any other query is executed against a specific table.

#### 26. Are NULL values same as that of zero or a blank space?

A NULL value is not at all same as that of zero or a blank space. NULL value represents a value which is unavailable, unknown, assigned or not applicable whereas a zero is a number and blank space is a character.

#### 29. What are the different types of a subquery?

There are two types of subquery namely, Correlated and Non-Correlated.
Correlated subquery: These are queries which select the data from a table referenced in the outer query. It is not considered as an independent query as it refers to another table and refers the column in a table.
Non-Correlated subquery: This query is an independent query where the output of subquery is substituted in the main query.
SQL Interview Questions

#### 32. Write a SQL query to get the third-highest salary of an employee from employee_table?

```sql
SELECT TOP 1 salary
FROM(
SELECT TOP 3 salary
FROM employee_table
ORDER BY salary DESC) AS emp
ORDER BY salary ASC;
```

#### 33. What is the need for group functions in SQL?

Group functions work on the set of rows and return one result per group. Some of the commonly used group functions are: AVG, COUNT, MAX, MIN, SUM, VARIANCE.

#### 34 . What is a Relationship and what are they?

Relation or links are between entities that have something to do with each other. Relationships are defined as the connection between the tables in a database. There are various relationships, namely:

-   One to One Relationship.
-   One to Many Relationship.
-   Many to One Relationship.
-   Self-Referencing Relationship.

#### 35. How can you insert NULL values in a column while inserting the data?

NULL values in SQL can be inserted in the following ways:

-   Implicitly by omitting column from column list.
-   Explicitly by specifying NULL keyword in the VALUES clause

#### 39. What do you mean by recursive stored procedure?

Recursive stored procedure refers to a stored procedure which calls by itself until it reaches some boundary condition. This recursive function or procedure helps the programmers to use the same set of code n number of times.

#### 40. What is CLAUSE in SQL?

SQL clause helps to limit the result set by providing a condition to the query. A clause helps to filter the rows from the entire set of records.
For example – WHERE, HAVING clause.

#### 41. What is the difference between ‘HAVING’ CLAUSE and a ‘WHERE’ CLAUSE?

HAVING clause can be used only with SELECT statement. It is usually used in a GROUP BY clause and whenever GROUP BY is not used, HAVING behaves like a WHERE clause.
Having Clause is only used with the GROUP BY function in a query whereas WHERE Clause is applied to each row before they are a part of the GROUP BY function in a query.

#### 50. Name the operator which is used in the query for pattern matching?

LIKE operator is used for pattern matching, and it can be used as -. 1. % – It matches zero or more characters.
For example- select _ from students where studentname like ‘a%’
\_ (Underscore) – it matches exactly one character.
For example- select _ from student where studentname like ‘abc\_’

#### 51. How can you select unique records from a table?

You can select unique records from a table by using the DISTINCT keyword.
Select DISTINCT studentID from Student
Using this command, it will print unique student id from the table Student.

#### 52. How can you fetch first 5 characters of the string?

There are a lot of ways to fetch characters from a string. For example:

```sql
Select SUBSTRING(StudentName,1,5) as studentname from student
```

#### 58. List all the types of user-defined functions?

There are three types of user-defined functions, namely:

-   Scalar Functions
-   Inline Table-valued functions \* Multi-statement valued functions
    Scalar returns the unit, variant defined the return clause. Other two types of defined functions return table.

#### 59. What do you mean by Collation?

Collation is defined as a set of rules that determine how data can be sorted as well as compared. Character data is sorted using the rules that define the correct character sequence along with options for specifying case-sensitivity, character width etc.

#### 60. What are the different types of Collation Sensitivity?

Following are the different types of collation sensitivity:

-   Case Sensitivity: A and a and B and b.
-   Kana Sensitivity: Japanese Kana characters.
-   Width Sensitivity: Single byte character and double-byte character.
-   Accent Sensitivity.

#### 61. What are Local and Global variables?

**Local variables:**
These variables can be used or exist only inside the function. These variables are not used or referred by any other function.
**Global variables:**
These variables are the variables which can be accessed throughout the program. Global variables cannot be created whenever that function is called.

#### 63. What is a Datawarehouse?

Datawarehouse refers to a central repository of data where the data is assembled from multiple sources of information. Those data are consolidated, transformed and made available for the mining as well as online processing. Warehouse data also have a subset of data called Data Marts.

#### 64. What are the different authentication modes in SQL Server? How can it be changed?

Windows mode and Mixed Mode – SQL and Windows. You can go to the below steps to change authentication mode in SQL Server:

-   Click Start> Programs> Microsoft SQL Server and click SQL Enterprise Manager to run SQL Enterprise Manager from the Microsoft SQL Server program group.
-   Then select the server from the Tools menu. \* Select SQL Server Configuration Properties, and choose the Security page.

#### 65. What are STUFF and REPLACE function?

STUFF Function: This function is used to overwrite existing character or inserts a string into another string. Syntax:
`STUFF(string_expression,start, length, replacement_characters)`
where,

-   string_expression: it is the string that will have characters substituted
-   start: This refers to the starting position
-   length: It refers to the number of characters in the string which are substituted.
-   replacement_string: They are the new characters which are injected in the string.

REPLACE function: This function is used to replace the existing characters of all the occurrences. Syntax:
`REPLACE (string_expression, search_string, replacement_string)`
Here every search_string in the string_expression will be replaced with the replacement_string.
