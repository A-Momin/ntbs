-   <details><summary style="font-size:25px;color:Orange;text-align:left">Theory: RDBMS </summary>

    -   𝑳𝒊𝒔𝒕 𝒐𝒇 𝐔𝐬𝐞𝐟𝐮𝐥𝐥 𝑺𝒚𝒎𝒃𝒐𝒍𝒔: ⌘ ⌥ + ⌃ + ⤶ ⇧  ⤶ ⬋ ↩︎ ↲ ↵ ↫ ♥ ★ 🎾 &
    -   [Intermediate MySQL Tutorial Series](https://www.youtube.com/playlist?list=PLUaB-1hjhk8G5zci4HA8E21x2BJS3jzNm)
    -   [Advanced MySQL Tutorial Series](https://www.youtube.com/playlist?list=PLUaB-1hjhk8GjfgvWlreA6BvTvazz8RHG)
    -   [Learn Complete SQL (Beginner to Advance)](https://www.youtube.com/playlist?list=PLavw5C92dz9Ef4E-1Zi9KfCTXS_IN8gXZ)
    -   [Learn PostgreSQL Tutorial - Full Course for Beginners](https://www.youtube.com/watch?v=qw--VYLpxG4&t=1615s)
    -   [Full Database Course for Beginners](https://www.youtube.com/watch?v=HXV3zeQKqGY&t=4269s)

    -   🔥 MOS01:
        -   `ROOT` USER PASSWORD : `S...s.....`
        -   `Shah` USER PASSWORD : `s........9`
    -   🔥 MOS02:
        -   `ROOT` USER PASSWORD : `AMs#....`
    -   🔥 DOCUMENTATION OF MYSQL: https://dev.mysql.com/doc/refman/8.0/en/

    </details>

---

-   <details><summary style="font-size:20px;color:Red;text-align:left">MySQL </summary>

    -   `$ `

    -   How to start/stop mysql server from terminal

    ```bash
    alias startmysql="sudo /usr/local/mysql/support-files/mysql.server start"
    alias stopmysql="sudo /usr/local/mysql/support-files/mysql.server stop"
    alias statusmysql="sudo /usr/local/mysql/support-files/mysql.server status"
    alias logmysql="tail -f /usr/local/mysql/data/$(hostname).err"
    ```

    ##### LOGIN & LOGOUT

    -   `$ mysql -u root -p` -> to connect to mysql server as 'root' user using password.

    -   `$ mysql -u Farzana -p` -> login with username - 'Farzana'

    -   `$ mysql -h host -u user -p`

        -   If the server runs on a machine other than the one where you log in, you must also specify a host name along username

    -   `mysql> QUIT;` -> to quit mysql server

    -   `mysql> mysql.server start;` -> Turn the mysql server on

    -   `mysql> mysql.server stop;` -> Turn the mysql server off.

    -   `mysql> source file_name.sql;` -> to execute a sql file named file_name.sql

    ##### PRIMARYLY USEFULL MYSQL COMMAND

    -   `mysql> SHOW DATABASES;`

        -   Lists out the databases that are accessible by the MySQL DBMS.

    -   `mysql> USE Databasename;`

        -   This will be used to select a database in the MySQL workarea.

    -   `mysql> SHOW [FULL] TABLES;`

        -   Shows the tables in the database once a database has been selected with the use-command (`USE Databasename`).

    -   `mysql> DESCRIBE Employee;`

    -   `mysql> SHOW COLUMNS FROM tablename;`

        -   Shows the attributes, types of attributes, key information, whether NULL is permitted, defaults, and other information for a table.

    -   `mysql> SHOW INDEX FROM tablename;`

        -   Presents the details of all indexes on the table, including the PRIMARY KEY.

    -   `mysql> SHOW TABLE STATUS LIKE tablename\G;`

        -   Reports details of the MySQL DBMS performance and statistics.

    -   `DESCRIPBE TABLE;`

        -   Describe the given table.

    -   `EXPLAIN DATABASE.TABLE;`
        -   Describe the given table as `DESCRIBE TABLE` does

    ##### RUN A `script_name.sql` AGAINST A DATABASE

    1.  `$ mysql -u USER_NAME -p'password'`
        -   to connect to mysql server as 'root' user using password.
    2.  `mysql> source script_path/script_name.sql`

    ##### ADMINISTRATIVE OPERATIONS

    -   **Usefull Shell Commands**:

        -   `$ mysqldump -u shah -p shah711409 interview_questions Employee > path/backup_file.sql` -> Backup a table.
        -   `$ mysql -h localhost -P 3306 -u Shah -p'shah711409' IQ < /Users/am/mydocs/Software_Development/Databases/RDBMS/sql/schemas/students.sql`

    -   `mysql> CREATE user 'Shah'@'localhost' IDENTIFIED BY 'shah711409';`
    -   `mysql> GRANT ALL PRIVILEGES ON *.* TO 'Shah'@'localhost' WITH GRANT OPTION;`
    -   `mysql> FLUSH PRIVILEGES;`
    -   `mysql> CREATE user 'Farzana'@'localhost' IDENTIFIED BY 'FBs#7591';`

        -   Create a user by username 'Farzana' with password 'FBs#7591'

    -   `mysql> DROP USER 'Farzana'@'localhost';`

        -   Delete a user 'Farzana' from the database.

    -   `mysql> delete from mysql.user where user='Farzana' and host='localhost';`

        -   Delete a user named 'Farzana' from the user table

    -   `mysql> SELECT VERSION(), CURRENT_DATE;`

        -   to asks the server to tell you its version number and the current date

    -   `mysql> SELECT CURRENT_USER();`

        -   Returns the current MySQL username and hostname.

    -   `mysql> SELECT user FROM mysql.user;`

        -   Select user column from user table of mysql databases

    -   `mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('AMs#....');`

        -   Set password as 'AMs#....' for root user

    -   `mysql> UPDATE mysql.user SET Password=PASSWORD('ABs#1234') WHERE User='A.Momin';`

        -   Set password as 'AMs#....' for root user

    -   `mysql> GRANT ALL ON book_shop.* TO 'Farzana' IDENTIFIED BY 'FBs#7591';`

        -   Give a user, 'Farzana', all privileges of the database, book_shop

    -   `mysql> FLUSH PRIVILEGES;`

        -   Rereads the privileges from the grant tables in the mysql system schema

    -   `mysql> help ALTER`

        -   provide help about `ALTER`

    -   **ALTER**

        -   `mysql> help ALTER SERVER`

            -   Provide help of the command, 'ALTER' with item 'SERVER'.

        -   `mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'PASS#...’;`

            -   Change password of 'root' user from old password to new password, PASS#...

        -   `mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Shahs#1300';`

            -   Update password of root user

        -   `mysql> ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE;`

            -   To expire an account password manually

        -   `mysql> SELECT SIN(PI()/4), (4+1)*5;`
            -   Performs mathematical operations.

    -   **PRIVILEGES**

        -   `mysql> GRANT ALL ON interview_questions.* TO 'A.Momin'@'localhost';`

    ##### Role Based Access Control

    MySQL does not have built-in roles like some other database management systems, but you can simulate Role-Based Access Control (RBAC) using a combination of user accounts and privileges. Here's a demonstration of how you can implement RBAC-like access control in MySQL:

    -   **Step 1**: Create Users

        ```sql
        CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_password';
        CREATE USER 'editor'@'localhost' IDENTIFIED BY 'editor_password';
        CREATE USER 'viewer'@'localhost' IDENTIFIED BY 'viewer_password';
        ```

    -   **Step 2**: Create a Database and Grant different privileges to each user based on their role

        ```sql
        CREATE DATABASE mydatabase;

        -- Admin has all privileges on mydatabase
        GRANT ALL PRIVILEGES ON mydatabase.* TO 'admin'@'localhost';

        -- Editor can insert and update, but not delete
        GRANT INSERT, UPDATE ON mydatabase.* TO 'editor'@'localhost';

        -- Viewer has read-only access
        GRANT SELECT ON mydatabase.* TO 'viewer'@'localhost';
        ```

    -   **Step 3**: View User Privileges

        -   You can check the privileges assigned to each user:

        ```sql
        SHOW GRANTS FOR 'admin'@'localhost';
        SHOW GRANTS FOR 'editor'@'localhost';
        SHOW GRANTS FOR 'viewer'@'localhost';
        ```

    -   **Step 4**: Test the Setup

        -   Log in as each user and test their access:

        ```bash
        mysql -u admin -p
        mysql -u editor -p
        mysql -u viewer -p
        ```

    -   **Step 5**: Revoke Privileges if Needed

        -   If you need to change a user's privileges, you can use the REVOKE statement:

        ```sql
        REVOKE DELETE ON mydatabase.* FROM 'editor'@'localhost';
        ```

    -   **Step 6**: Remove Users

        ```sql
        DROP USER 'admin'@'localhost';
        DROP USER 'editor'@'localhost';
        DROP USER 'viewer'@'localhost';
        ```

    ##### UNINSTAL MYSQL

    -   Open a terminal window.
    -   Use mysqldump to backup your databases to text files!
    -   Stop the database server.
    -   sudo rm /usr/local/mysql.
    -   sudo rm -rf /usr/local/mysql\*
    -   sudo rm -rf /Library/StartupItems/MySQLCOM.

    </details>

---

-   <details><summary style="font-size:20px;color:Red;text-align:left">PostgreSQL </summary>

    -   `$ /usr/local/var/postgresql\@14/pg_hba.conf`
    -   `$ /usr/local/var/postgresql\@14/postgresql.conf`
    -   `$ createdb --help`

    -   createdb creates a PostgreSQL database.
    -   Usage:

        -   `$ createdb [OPTION]... [DBNAME] [DESCRIPTION]`

    -   PostgreSQL installed through `Homebrew`:

        -   `$ brew info postgresql` → Find information about 'postgresql' installed through 'brew'.
        -   `$ brew services run/start postgresql` → Run/Start the service formula without/with registering to launch at login (or boot) of your machine.
        -   `$ brew services stop/kill postgresql` → Stop the service formula immediately and unregister/keeping-registered it from launching at login of your machine.
        -   `$ brew services restart postgresql@14` → To restart postgresql@14 after an upgrade.

    -   Adds `PostgreSQL` to the `PATH` variable:
        -   `export PATH=${PATH}:/Applications/Postgres.app/Contents/Versions/13/bin`
    -   note: `sudo mkdir -p /etc/paths.d && echo /Applications/Postgres.app/Contents/Versions/latest/bin | sudo tee /etc/paths.d/postgresapp`
    -   MASTER PASSWORD: `AMs#....`

    ###### How to `search`/`install`/`run`/`start` and `stop` PostgreSQL through Homebrew.

    -   `$ brew search postgres`
    -   `$ brew install postgresql@14`
    -   `$ brew services run/start postgresql`
    -   `$ psql postgres` → Start using pre-defined 'postgres` database.
    -   `$ brew services stop/kill postgresql`
    -   `$ brew services list` → Check status

    ##### Connect/Login:

    -   `$ brew services run/start postgresql` → Run/Start the service formula without/with registering to launch at login (or boot) of your machine.
    -   `$ psql -l` → List out available PostgreSQl DB.
    -   `$ createdb am` → Create a DB using `createdb` utility included with PostgreSQl.
    -   `$ psql` → login to PostgreSQL using the default DB name ('am') as Super-user ('am')
    -   `$ psql db_name` → login to `db_name` DB as Super-user.

    -   `$ psql --help`
    -   `$ psql [OPTION]... [DBNAME [USERNAME]]`
    -   `$ psql -U am`
        -   If database name explicitly is not provided, pg tries to login the user into the db ('am') named by the username ('am').
    -   `$ psql -U am -d am`
    -   `$ psql -h localhost -p 5432 -U amomin amomin`
    -   `$ psql -h localhost -p 5432 -U airflow -d airflow_docker`
    -   `$ psql -h localhost -p 5432 -U interview_questions -d interview_questions`
    -   `$ psql -U interview_questions -d interview_questions`
    -   `$ psql -U airflow -d airflow_docker`
    -   `$ psql -h localhost -p 5432 -U am am`
    -   `DBName-# \c database_name` → Connect to the given database from the current database (DBName).

    -   Connection options:
        -   `-d, --dbname=DBNAME`
            -   database name to connect
        -   `-h, --host=HOSTNAME`
            -   database server host or socket directory (default: "local socket")
        -   `-p, --port=PORT`
            -   database server port (default: "5432")
        -   `-U, --username=USERNAME`
            -   database user name (default: "am")
        -   `-w, --no-password`
            -   never prompt for password
        -   `-W, --password`
            -   force password prompt (should happen automatically)

    ```yml
    -   User: am
        -   DBNAME: am
        -   Password: a.......4
    -   User: amomin
        -   DBNAME: amomin
        -   Password: s...s.....
    -   User: airflow
        -   DBNAME: airflow_docker
        -   Password: airflow
    -   User: interview_questions
        -   DBNAME: interview_questions
        -   Password: 1111
    ```

    ##### Usefull Commands:

    -   `DBName-# \?`
    -   `DBName-# \c` → opyright for distribution terms
    -   `DBName-# \h` → for help with SQL commands
    -   `DBName-# \?` → for help with psql commands
    -   `DBName-# \g` → or terminate with semicolon to execute query
    -   `DBName-# \q` → quit from the PostgreSQL.
    -   `a.momin-# \l` → list out all the databases.
    -   `a.momin-# \c postgres` → Conect to pre-defined `postgres` database from whatever database you'r are using.
    -   `DBName-# \dt` → list of all tables in the currently connected database, along with information such as their schema and owner.
    -   `DBName-# \du` → list all users and their attributes, including their username, whether they are a superuser or can create databases, and their role memberships.
    -   `DBName-# \du UserName` → To check the group(s) the user is associated with.
    -   `DBName-# \! clear` → To clear the psql CLI.

    -   `DBName-# CREATE USER a.momin WITH PASSWORD 's...s.....';`
    -   `DBName-# CREATE USER interview_questions WITH PASSWORD '1111';`
    -   `postgres=# CREATE DATABASE interview_questions WITH OWNER = interview_questions;`
    -   `postgres=# CREATE DATABASE your_database_name WITH OWNER = your_username;`
    -   `postgres=# ALTER USER am WITH PASSWORD 's...s.....';`
    -   `postgres=# SELECT * FROM pg_user WHERE usename = 'am';`
    -   `postgres=# SELECT * FROM pg_user;`
    -   `postgres=# SELECT usename FROM pg_user;`
    -   `postgres=# `
    -   `DBName=# \i my_script.sql`

    -   How to delete a user?
        -   `$ DROP ROLE username;`
    -   How to delete a database?
        -   `$ DROP DATABASE database_name;`

    ##### PGAdmin

    -   postgres
        -   Default username, a precreated database name
        -   Master password: AMs#1300
            -   Valid for all databases except for user created databases with different password

    </details>

---

-   <details><summary style="font-size:20px;color:Red;text-align:left">SQLite </summary>

    -   How to execute SQL script

        -   `$ sqlite3 your_database_name.db`
        -   `$ .read your_script_file.sql`
        -   `$ .exit`
        -   `$ `

    -   How to export data from 'sqlite' database

        1.  `$ sqlite3 db.sqlite`
        2.  `sqlite3> .mode csv`
        3.  `sqlite3> .output /path/to/output/file_name.csv`
        4.  `sqlite3> .output student_data.csv`
        5.  `sqlite3> SELECT * FROM table_name;`

        -   `sqlite3> SELECT * FROM student_student;`
        -   `sqlite3> sqlite3 employees.db ".mode csv" ".output employees.csv" "SELECT * FROM Employee;" ".quit"`

    -   How to import data from csv file to 'sqlite' database

        -   `$ sqlite3 db.sqlite`
        -   `sqlite3> .mode csv`
        -   `sqlite3> .import /path/to/csv/file_name.csv table_name`
            -   `sqlite3> .import ./data/students.csv student_student`
            -   `sqlite3> .import ./data/students.csv student_teacher`
        -   `sqlite3> select * from student;`

    -   All purpose sqlite queries

        -   `sqlite3> .databases`
        -   `sqlite3> .tables`

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">NoSQL </summary>

    -   [NoSQL Database Tutorial – Full Course for Beginners](https://www.youtube.com/watch?v=xh4gy1lbL2k&t=3220s)

    -   NoSQL (which stands for "not only SQL") is a broad term that refers to a class of databases that use a non-relational data model to store and retrieve data. While traditional relational databases use tables with fixed schemas and structured data, NoSQL databases allow for more flexible and dynamic data models, often using key-value pairs, document-based storage, or graph-based models.
    -   NoSQL (Not Only SQL) databases have gained popularity in recent years due to their ability to handle large amounts of unstructured and semi-structured data that traditional relational databases struggle with. It offers many advantages over traditional relational databases, especially for modern applications that require high scalability, flexibility, and performance.

    #### Here are some of the advantages of NoSQL databases:

    -   `Scalability`: NoSQL databases can easily scale horizontally by adding more nodes to the system, allowing them to handle massive amounts of data and high-traffic applications.
    -   `Flexibility`: NoSQL databases are designed to handle various types of data, including unstructured and semi-structured data, which makes them a better fit for modern applications.
    -   `Performance`: NoSQL databases can provide faster read and write speeds than traditional relational databases, especially when dealing with large amounts of data.
    -   `Cost-effective`: NoSQL databases are typically open source and free to use, which makes them a cost-effective solution for small and large businesses.
    -   `Availability`: NoSQL databases are designed to handle high availability and fault tolerance, ensuring that applications continue to function even if one or more nodes fail.
    -   `Easy to use`: NoSQL databases are typically easier to set up and use than traditional relational databases, which require extensive schema design and management.
    -   `Cloud-native`: NoSQL databases are a good fit for cloud environments, as they can easily scale up and down as needed and are designed to work in distributed environments.

    #### Key terms and concepts associated with NoSQL databases:

    -   `Document`: A NoSQL document is a data structure that can contain any number of fields, with each field having a name and a value. Documents are often used in document-based NoSQL databases such as **MongoDB** and **Couchbase**.
    -   `Key-value store`: A key-value store is a NoSQL database that stores data as a collection of key-value pairs, where each key is unique and the associated value can be any data type. Key-value stores are often used for caching, session management, and real-time data processing.
    -   `Column family`: A column family is a grouping of related data in a NoSQL database that is stored as columns rather than rows. Column families are often used in column-based NoSQL databases such as **Apache Cassandra**.
    -   `Graph database`: A graph database is a NoSQL database that stores data in nodes and edges, where nodes represent entities and edges represent relationships between those entities. Graph databases are often used for social networking, recommendation engines, and fraud detection.
    -   `Sharding`: Sharding is the process of splitting a large dataset across multiple servers, or shards, to improve performance and scalability in a distributed system.
    -   `MapReduce`: MapReduce is a programming model used for processing large datasets in a distributed system, often used in conjunction with NoSQL databases to perform analytics and data processing.

    #### CAP Therom

    The **CAP theorem** states that in a distributed system, it is impossible to simultaneously provide more than two out of three guarantees: consistency, availability, and partition tolerance. NoSQL databases often prioritize availability and partition tolerance over strong consistency.

    -   **Consistency (C)**:

        -   In a distributed database system, consistency implies that all nodes in the system will have the same data view at the same time. When a write operation is performed and acknowledged to the client, all subsequent read operations from any node will return the most recent write.
        -   In other words, consistency ensures that the data is always up-to-date and consistent across all nodes.

    -   **Availability (A)**:

        -   Availability means that every request (read or write) to the database receives a response, without guaranteeing that it is the most up-to-date data. An available system doesn't necessarily provide the latest data but ensures that there is no downtime or unavailability in the system.
        -   It's important to note that "availability" in the CAP theorem refers to the ability of the system to respond to client requests, even if the response is based on potentially outdated data.

    -   **Partition Tolerance (P)**:

        -   Partition tolerance means that the database can continue to function even in the presence of network partitions or communication failures between nodes in a distributed system. Network partitions can occur due to network failures or delays, but the system should still operate without complete failure.
        -   Partition tolerance is essential for distributed systems because network issues are a common occurrence in real-world scenarios.

    -   **CA**: If you prioritize Consistency and Availability (CA), your database will provide strong consistency guarantees, but it may become unavailable in the presence of network partitions. Traditional relational databases often fall into this category.

    -   **CP**: If you prioritize Consistency and Partition Tolerance (CP), your database will ensure data consistency even in the face of network partitions, but this may come at the cost of availability during partition scenarios. Some distributed databases, like **HBase**, lean towards CP.

    -   **AP**: If you prioritize Availability and Partition Tolerance (AP), your database will always be available to respond to requests, even in the presence of network partitions, but it may not guarantee strong data consistency. Many NoSQL databases, such as **Cassandra** and **Couchbase**, aim for AP characteristics.

    -   **Summary Table**

    | System Type          | Consistency   | Availability          | Partition Tolerance |
    | -------------------- | ------------- | --------------------- | ------------------- |
    | **DynamoDB (AP/CP)** | Configurable  | ✅                    | ✅                  |
    | **MongoDB (CP)**     | ✅            | ❌ (during partition) | ✅                  |
    | **Cassandra (AP)**   | ❌ (eventual) | ✅                    | ✅                  |
    | **HBase (CP)**       | ✅            | ❌ (during partition) | ✅                  |
    | **RDBMS (CA)**       | ✅            | ✅                    | ❌                  |

    It's important to understand that the CAP theorem is more of a guideline than a strict rule, and real-world distributed systems often make trade-offs based on specific use cases and requirements. The choice between consistency, availability, and partition tolerance depends on the application's needs and the desired trade-offs in a given distributed database system.

    #### Different Types of NoSQL Databases:

    NoSQL databases are a diverse group of database management systems that are designed to handle various types of data and use cases. Comparing different types of NoSQL databases can be challenging because each type is optimized for specific scenarios. Here, I'll provide an overview of the main types of NoSQL databases (document-oriented, key-value, column-family, and graph), highlighting their characteristics, strengths, and weaknesses:

    ##### Document-Oriented Databases:

    -   **Examples**: `MongoDB`, `CouchDB`, `RavenDB`
    -   **Data Model**: Store data in flexible, semi-structured documents (e.g., JSON, BSON, XML).
        -   `Documents`: Data is stored in documents, which encapsulate key-value pairs, arrays, nested documents, and more.
        -   **Collections**: Documents are grouped into collections, which can be thought of as analogous to tables in a relational database.
    -   **Flexible Schema**: Each document can have a different structure, allowing for schema evolution without requiring changes to the database schema.
    -   **Rich Query Capabilities**: Supports complex queries, indexing, and aggregation operations, making it suitable for a wide range of applications.
    -   **Hierarchical Data Storage**: Documents can store hierarchical data efficiently, making it easy to model real-world entities and relationships.
    -   **Strengths**:
        -   Schema flexibility allows for easy data evolution.
        -   Good for storing complex hierarchical data structures.
        -   Well-suited for content management systems, catalogs, and user profiles.
    -   **Weaknesses**:
        -   Less efficient for highly relational data.
        -   May require careful schema design for complex queries.
        -   Limited support for transactions and joins.

    ##### Key-Value Stores:

    A Key-Value Store is a type of NoSQL database that uses a simple key-value pair mechanism to store data. It is one of the most straightforward types of databases, where each unique key is associated with a value, which can be any type of data, from simple strings to complex objects like JSON, BLOBs, or serialized objects.

    -   **Examples**: `Amazon DynamoDB`, `Redis`, `Riak`
    -   **Data Model**: Simple key-value pairs; values can be binary blobs or strings.

        -   `Keys`: Unique identifiers used to access the associated values. Keys are usually simple strings.
        -   `Values`: The data associated with the keys, which can be any datatype.
        -   `Schema-less`: No fixed schema, allowing for flexible and dynamic data storage.

    -   **High Performance**: Optimized for fast read and write operations, often achieving low latency due to the simplicity of key-value access patterns.
    -   **Scalability**: Designed to scale horizontally, making it easy to distribute data across multiple servers.

    -   **Strengths**:

        -   Extremely fast and scalable for read and write operations.
        -   Ideal for caching, session management, and real-time analytics.
        -   Well-suited for high-throughput applications.

    -   **Weaknesses**:
        -   Limited query capabilities (no complex queries or joins).
        -   May not support data types beyond strings and binary.

    ##### Column-Oriented Database:

    A Column-Oriented Database, also known as a Column-Family Store, is a type of NoSQL database that organizes data into columns rather than the traditional row format used by relational databases. This model is highly efficient for read and write operations involving large volumes of data and is particularly well-suited for analytical queries.

    -   **Examples**: `Apache Cassandra`, `HBase`, `ScyllaDB`
    -   **Data Model**: Data is organized into column families, similar to tables with rows and columns.
        -   Data is stored in column families, which are groups of related data columns. Each column family can be thought of as a table in a relational database.
        -   Within each column family, data is stored in rows, but each row can have a different number of columns.
    -   **Strengths**:
        -   Highly scalable and designed for distributed environments.
        -   Excellent for write-intensive and time-series data.
        -   Provides tunable consistency levels.
    -   **Weaknesses**:
        -   Complex data modeling required for querying.
        -   May not support ACID transactions.
        -   Limited support for ad-hoc queries.

    ##### Graph Databases:

    -   **Examples**: `Neo4j`, `Amazon Neptune`, `ArangoDB`
    -   **Data Model**: Represent data as nodes, relationships, and properties, making it suitable for graph-based data structures.
    -   **Strengths**:
        -   Efficient for complex graph traversals and querying relationships.
        -   Ideal for recommendation engines, social networks, fraud detection, and knowledge graphs.
        -   Support for rich querying and pattern matching.
    -   **Weaknesses**:
        -   May not perform as well for non-graph use cases.
        -   Scaling can be challenging for large graphs.
        -   Limited support for tabular or document data.

    ##### Time-Series Databases:

    -   **Examples**: `InfluxDB`, `OpenTSDB`, `TimescaleDB`
    -   **Data Model**: Designed specifically for time-series data, such as sensor data, logs, and event data.
    -   **Strengths**:
        -   Optimized for high-volume data ingestion and time-based querying.
        -   Provides retention policies and downsampling capabilities.
        -   Ideal for monitoring, IoT, and analytics.
    -   **Weaknesses**:
        -   Less suitable for non-time-series data.
        -   May not support complex joins or transactions.
        -   Choosing the right NoSQL database depends on your specific requirements, including data structure, scalability needs, query complexity, and performance considerations. Many modern applications use a combination of different types of databases (polyglot persistence) to address various use cases within the same system.

    </details>

---

-   <details><summary style="font-size:20px;color:Red;text-align:left">Cassandra DB</summary>

    -   [Apache Cassandra Tutorial](https://www.youtube.com/playlist?list=PLalrWAGybpB-L1PGA-NfFu2uiWHEsdscD)
    -   [Learn Apache Cassandra In 1.5 Hours - Apache Cassandra Tutorial For Beginners](https://www.youtube.com/watch?v=_UGxEMdPYVI&t=127s)
    -   []()
    -   []()

    Cassandra is a distributed NoSQL database system designed for high availability, scalability, and fault tolerance. It was originally developed at Facebook and is now maintained by the Apache Software Foundation. To understand Cassandra in gory detail, let's delve into some of its key terms and concepts:

    -   `Distributed Database`: Cassandra is a distributed database system, which means it can span multiple nodes (machines) across different data centers. This distribution provides redundancy and high availability.
    -   `Node`: In Cassandra, a node is a single instance of the database running on a machine. Nodes collectively form a cluster.
        -   Node Ring:
            -   Nodes in a Cassandra cluster are organized in a ring structure.
            -   Each node is assigned a token, and the ring structure facilitates data distribution and retrieval.
    -   `Cluster`: A cluster in Cassandra is a group of nodes working together. Data is distributed across nodes in a cluster.
    -   `Keyspace`: A keyspace is a top-level namespace in Cassandra, similar to a database in a relational database system. It defines data replication settings and is used to group related tables.
        -   A keyspace is the outermost container for data in Cassandra.
        -   It is similar to a database in the relational database world.
        -   Keyspaces contain column families (tables).
    -   `Table`: Tables in Cassandra are similar to tables in a relational database but with a flexible schema. Each table consists of rows and columns, and each row is identified by a unique primary key.
        -   Tables in Cassandra are called column families.
    -   `Column Family`: In earlier versions of Cassandra, data was organized into column families, but this concept has evolved. In modern versions, tables serve the purpose of column families.
        -   Each column family consists of rows and columns.
        -   Columns do not need to be predefined; they can be added dynamically.
    -   `Column`: In Cassandra, a column is the basic unit of data storage. Columns are grouped into rows, and each column has a name, value, and a timestamp.
        -   Columns are basic units of data in Cassandra.
        -   Columns consist of a column name, a value, and a timestamp.
        -   Columns are grouped into rows.
    -   `Primary Key`: A primary key is used to uniquely identify rows within a table. In Cassandra, the primary key can consist of one or more columns.
        -   A primary key uniquely identifies a row in a table.
        -   In Cassandra, the primary key can be composite, consisting of multiple columns.
    -   `Partition Key`: The partition key is the first part of the primary key. It determines how data is distributed across nodes. All rows with the same partition key are stored together on the same node.
        -   The partition key is used to distribute data across nodes in the cluster.
        -   It is part of the primary key and determines the node responsible for storing a particular row.
    -   `Clustering Column`: Clustering columns are part of the primary key but are used to sort data within a partition. They determine the physical storage order of rows within a partition.
    -   `Replication Factor`: Cassandra replicates data across multiple nodes for fault tolerance. The replication factor defines how many copies of data are maintained. It's set at the keyspace level.
        -   Cassandra replicates data across multiple nodes for fault tolerance and high availability.
        -   The replication factor determines how many copies of each piece of data are stored.
    -   `Consistency Level`: Cassandra allows you to configure the consistency level for read and write operations. Consistency levels determine how many nodes must acknowledge the operation for it to be considered successful.
        -   The consistency level determines how many nodes must respond to a read or write operation for it to be considered successful.
        -   It is configurable based on the desired balance between consistency and availability.
    -   `CAP Theorem`: Cassandra adheres to the CAP theorem, which states that in a distributed system, you can have at most two of the following three properties: Consistency, Availability, and Partition Tolerance. Cassandra prioritizes Availability and Partition Tolerance over strict Consistency.
    -   `Data Modeling`: Cassandra's data model is designed for query-intensive workloads. It's essential to model your data to fit the query patterns you expect.
    -   `Tombstones`: Cassandra uses tombstones to mark data that has been deleted. These tombstones are eventually removed during compaction.
    -   `Compaction`: Compaction is the process of merging and compacting SSTables (Sorted String Tables) to reduce disk space usage and improve read performance.
    -   `CQL (Cassandra Query Language)`: CQL is a SQL-like query language used to interact with Cassandra databases. It provides commands for creating tables, inserting data, and querying data.
    -   `Gossip Protocol`: Cassandra uses a gossip protocol for node discovery and cluster management. Nodes communicate with each other to share information about their status and the cluster's topology.
    -   `Read Repair and Hinted Handoff`: Cassandra automatically handles read repair to ensure data consistency. Hinted handoff is a mechanism to temporarily store writes for unreachable nodes.
    -   `Snitch`: A snitch in Cassandra is responsible for determining the location of nodes in the cluster, which helps in data replication and routing.
    -   `Bloom Filters`: Bloom filters are used in Cassandra to quickly check if a particular row exists in a partition before performing a full read operation.
    -   `Write Path and Read Path`: Cassandra's architecture includes distinct paths for write operations (commit log and memtable) and read operations (SSTables and cache).

    Cassandra's architecture and concepts can be complex due to its distributed nature. It's crucial to carefully plan your data model and cluster configuration to meet your application's requirements for scalability and fault tolerance. Proper tuning and maintenance are also essential for optimal Cassandra performance.

    -   `$ `

    </details>

---

-   <details><summary style="font-size:20px;color:Red;text-align:left">MongoDB</summary>

    -   [neetcode: MongoDB Crash Course 2023](https://www.youtube.com/watch?v=QPFlGswpyJY&list=PLQpVsaqBj4RI5JlYgN5Pi9AfLhGJbkskW)
    -   [MongoDB with Python Crash Course - Tutorial for Beginners](https://www.youtube.com/watch?v=E-1xI85Zog8&t=11s)
    -   [Udacity Data Wrangling with MongoDB](https://learn.udacity.com/courses/ud032)
    -   [YT: Udacity Data Wrangling with MongoDB](https://www.youtube.com/playlist?list=PLAwxTw4SYaPnq2iMkfPxmXwBFjwc_AXK_)
    -   []()

    MongoDB is a popular NoSQL database system known for its flexibility and scalability. To understand MongoDB in detail, let's explore its key terms and concepts:

    -   `NoSQL Database`: MongoDB is a NoSQL database, which means it is not based on the traditional relational database model. Instead, it is designed to handle unstructured or semi-structured data and is known for its scalability and flexibility.
    -   `Document Database`: MongoDB is a document-oriented database. Instead of tables with rows and columns, MongoDB stores data in documents. Documents are JSON-like objects with key-value pairs.
    -   `Collection`: A collection in MongoDB is a group of related documents. Collections are similar to tables in a relational database but without a fixed schema. Documents within a collection can have different structures.
    -   `Document`: A document is a basic unit of data in MongoDB. Documents are represented in BSON (Binary JSON) format, which allows for complex data types and nested structures.
    -   `Field`: Fields are key-value pairs within a document. Each field has a name and a value, which can be of various data types, including strings, numbers, arrays, and subdocuments.
    -   `ObjectId`: MongoDB automatically generates a unique ObjectId for each document by default. This ObjectId serves as a primary key for the document.
    -   `Index`: MongoDB supports indexing for efficient querying. Indexes can be created on one or more fields to speed up searches.
    -   `Query`: Queries in MongoDB are used to retrieve documents from a collection. You can use a query to filter documents based on specified criteria.
    -   `CRUD Operations`: MongoDB supports the basic CRUD (Create, Read, Update, Delete) operations for data manipulation. These operations are performed on documents within collections.
    -   `Aggregation`: MongoDB provides a powerful aggregation framework that allows you to perform complex data transformations, filtering, grouping, and calculations on the data.
    -   `Replica Set`: A replica set is a group of MongoDB servers that maintain the same data. It provides redundancy and high availability. One server is the primary, and others are secondary servers that replicate data from the primary.
    -   `Sharding`: Sharding is a technique used to distribute data across multiple servers (shards) to achieve horizontal scalability. It allows MongoDB to handle large volumes of data and traffic.
    -   `Mongod`: mongod is the primary MongoDB daemon that runs the database server. It handles data storage, retrieval, and query processing.
    -   `Mongos`: mongos is a routing service used in sharded clusters to direct client requests to the appropriate shard servers.
    -   `Wire Protocol`: MongoDB uses a binary protocol for communication between clients and the database server. This protocol allows efficient data exchange.
    -   `Storage Engine`: MongoDB supports different storage engines, such as WiredTiger and MMAPv1, each with its own advantages and use cases. The storage engine is responsible for data storage and management.
    -   `Transactions`: MongoDB introduced multi-document transactions in recent versions, allowing you to perform multiple operations within a single transaction, ensuring data consistency.
    -   `Geospatial Indexing`: MongoDB supports geospatial queries, allowing you to store and query location-based data efficiently.
    -   `Change Streams`: Change streams in MongoDB enable real-time notifications of data changes in a collection. This is useful for building reactive applications.
    -   `Security`: MongoDB provides security features such as authentication, authorization, encryption, and auditing to protect your data and control access.
    -   `Drivers and APIs`: MongoDB offers official and community-supported drivers and APIs for various programming languages, making it easy to interact with the database from your application.
    -   `MQL (MongoDB Query Language)`: MongoDB has its query language, MQL, which is used to query and manipulate documents in the database.

    -   `$ `

    </details>

---

-   <details><summary style="font-size:25px;color:Orange;text-align:left">MISC</summary>

    Fault tolerance in the context of databases refers to the ability of a database system to continue operating reliably and provide uninterrupted service in the presence of hardware or software failures, errors, or unexpected events. The goal of achieving fault tolerance is to ensure that data remains accessible and consistent even when various types of failures occur. Here are some key aspects and strategies related to fault tolerance in databases:

    -   `Redundancy`: - Redundancy involves duplicating critical components of the database to eliminate single points of failure. This can include duplicating servers, storage devices, or network connections.
        Redundancy helps ensure that if one component fails, another can take over seamlessly, reducing the risk of downtime or data loss.

    -   `Data Replication`: - Data replication involves maintaining multiple copies of data on different servers or locations. These copies, or replicas, are kept synchronized to ensure data availability.
        Replication can be used to improve read performance, as clients can read from the nearest replica, and it provides fault tolerance by allowing failover to a replica if the primary server becomes unavailable.

    -   `High Availability (HA)`: - High availability refers to the ability of a system to remain operational and accessible with minimal downtime. In a database context, HA often involves redundant servers and automatic failover mechanisms.
        Cluster configurations, load balancers, and health monitoring are used to achieve high availability in databases.

    -   `Automatic Failover`: - Automatic failover mechanisms are used to detect when a primary database server becomes unresponsive or fails. In such cases, a standby server is automatically promoted to the primary role.
        This ensures that database operations can continue without manual intervention even in the event of a server failure.

    -   `Data Integrity`:

        -   Fault tolerance also includes mechanisms to maintain data integrity during failures. Techniques like write-ahead logging and transaction logs are used to ensure that changes to the database are recoverable in the event of a failure.

    -   `Backup and Recovery`: - Regular backups of the database are essential for fault tolerance. Backups allow you to restore the database to a previous state in case of data corruption, accidental deletions, or catastrophic failures.
        Database systems often provide tools and procedures for performing automated and manual backups.

    -   `Load Balancing`:

        -   Load balancing distributes incoming database queries and requests across multiple servers to ensure even utilization of resources. It can help prevent overloads and improve fault tolerance by redistributing workloads in case of server failures.

    -   `Isolation`:

        -   Isolation techniques ensure that a failure or error in one part of the database system does not impact other parts. For example, isolating transaction processing can prevent cascading failures.

    -   `Monitoring and Alerting`:

        -   Continuous monitoring of the database system for performance, health, and potential issues is crucial for fault tolerance. Alerts can notify administrators of abnormal conditions or failures.

    -   `Disaster Recovery`:

        -   Disaster recovery planning involves preparing for catastrophic events, such as natural disasters or data center outages. It includes offsite backups, data replication to geographically distant locations, and recovery procedures.

    -   `Consistency and Replication Models`:

        -   Databases may employ various replication models, such as synchronous or asynchronous replication, depending on the desired level of consistency and fault tolerance trade-offs.

    -   Overall, fault tolerance in databases is a critical aspect of ensuring data availability and reliability, especially in mission-critical applications. Database administrators and engineers need to carefully design, configure, and maintain database systems to withstand various failure scenarios and minimize downtime.

    -   Both SQL and NoSQL databases can be designed to be fault-tolerant, but they often use different approaches to achieve this. Here are examples of fault-tolerant databases in both categories:

    -   `SQL (Relational) Database Examples`:

        -   `Oracle Database`:

            -   Oracle Database is a popular enterprise-grade relational database management system (RDBMS) known for its robust fault-tolerance features.
            -   It offers features like Oracle Real Application Clusters (Oracle RAC) for high availability and automatic failover.

        -   `Microsoft SQL Server`:

            -   Microsoft SQL Server provides features like AlwaysOn Availability Groups and database mirroring to ensure high availability and data redundancy.
            -   It can be configured for automatic failover and data replication.

        -   `PostgreSQL`:
            -   PostgreSQL is an open-source RDBMS that offers streaming replication, logical replication, and failover mechanisms for fault tolerance.
            -   Extensions like pgpool-II can be used for load balancing and high availability.

    -   `NoSQL Database Examples`:

        -   `Cassandra`:

            -   Cassandra is a NoSQL database known for its fault tolerance and high availability.
            -   It uses data replication across multiple nodes in a cluster to ensure data availability even in the face of node failures.

        -   `MongoDB`:

            -   MongoDB offers features like replica sets, which provide data redundancy and automatic failover.
            -   It also has built-in data integrity mechanisms to prevent data loss during failures.

        -   `Amazon DynamoDB`:

            -   DynamoDB is a managed NoSQL database service provided by AWS.
            -   It offers built-in fault tolerance by replicating data across multiple Availability Zones (AZs) and handling automatic failover.

        -   `Couchbase`:

            -   Couchbase is a distributed NoSQL database that provides features like cross-datacenter replication (XDCR) for data redundancy and failover across multiple data centers.

        -   `Redis`:

            -   Redis is an in-memory NoSQL database. While it's not inherently distributed, it provides options for replication and high availability setups.
            -   Tools like Redis Sentinel can be used for monitoring and automatic failover.

        -   `HBase`:
            -   HBase is a NoSQL database designed for large-scale, fault-tolerant data storage.
            -   It uses Hadoop's HDFS for distributed storage and has features for data replication and high availability.

    It's important to note that both SQL and NoSQL databases can be made fault-tolerant through careful design, redundancy, replication, and the use of clustering and load balancing. The choice between SQL and NoSQL databases often depends on the specific requirements of your application and your desired trade-offs between consistency, availability, and partition tolerance, as discussed in the CAP theorem.

    </details>
