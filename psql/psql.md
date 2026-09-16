| Category                           | Database objects                                                                                                                                       |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Databases & schemas**            | Database, Schema                                                                                                                                       |
| **Tables**                         | Table, Partitioned Table, Foreign Table                                                                                                                |
| **Columns & constraints**          | Column, Primary Key, Foreign Key, Unique Constraint, Check Constraint, Exclusion Constraint, NOT NULL                                                  |
| **Indexes**                        | B-tree, Hash, GiST, SP-GiST, GIN, BRIN indexes; expression indexes; partial indexes                                                                    |
| **Views**                          | View, Materialized View                                                                                                                                |
| **Sequences**                      | Sequence                                                                                                                                               |
| **Routines**                       | Function, Procedure                                                                                                                                    |
| **Triggers**                       | Trigger                                                                                                                                                |
| **Types**                          | Enum Type, Composite Type, Domain, Range Type, Multirange Type                                                                                         |
| **Aliases / procedural objects**   | Synonym-like patterns via views/functions; PostgreSQL does not have Oracle-style SYNONYM objects                                                       |
| **Security**                       | Role, User, Group Role, Row-Level Security Policy, Default Privilege                                                                                   |
| **Extensions**                     | Extension                                                                                                                                              |
| **Full-text search**               | Text Search Configuration, Text Search Dictionary, Text Search Template, Text Search Parser                                                            |
| **Special objects**                | Collation, Conversion, Foreign Data Wrapper, Foreign Server, User Mapping                                                                              |
| **Replication / logical decoding** | Publication, Subscription, Replication Slot                                                                                                            |
| **Statistics / performance**       | Extended Statistics                                                                                                                                    |
| **Access control**                 | Grant, Privilege, ACL                                                                                                                                  |
| **Event-driven objects**           | Event Trigger                                                                                                                                          |
| **Partitioning**                   | Partitioned Table, Table Partition                                                                                                                     |
| **Large objects**                  | Large Object                                                                                                                                           |
| **XML / JSON-related**             | These are primarily data types/features rather than standalone database objects                                                                        |
| **AWS/Aurora-specific**            | Aurora PostgreSQL parameter groups, cluster/instance configuration, endpoints, extensions/features exposed by Aurora—not ordinary SQL database objects |


-   <details><summary style="font-size:25px;color:#C71585">Function vs Procedure</summary>

    In **AWS Aurora PostgreSQL**, the distinction between a **Function** and a **Procedure** is the same core distinction as in PostgreSQL.

    | Feature                    | Function                                            | Procedure                                                    |
    | -------------------------- | --------------------------------------------------- | ------------------------------------------------------------ |
    | Created with               | `CREATE FUNCTION`                                   | `CREATE PROCEDURE`                                           |
    | Executed with              | `SELECT` / SQL expression                           | `CALL`                                                       |
    | Returns a value            | Yes, or can return a set/table                      | No direct return value                                       |
    | Can use `RETURN`           | Yes                                                 | Not to return a function result                              |
    | Can be used inside a query | Yes                                                 | No                                                           |
    | Transaction control        | Generally cannot independently `COMMIT`/`ROLLBACK`  | Can use transaction control in supported invocation contexts |
    | Available since            | PostgreSQL has long supported functions             | Procedures introduced in PostgreSQL 11                       |
    | Typical use                | Calculations, transformations, reusable query logic | Multi-step business/administrative workflows                 |

    ## 1. Function

    A function is designed to **compute something and return a result**.

    ```sql
    CREATE OR REPLACE FUNCTION calculate_tax(
        amount NUMERIC
    )
    RETURNS NUMERIC
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN amount * 0.0825;
    END;
    $$;
    ```

    Call it using `SELECT`:

    ```sql
    SELECT calculate_tax(100);
    ```

    Result:

    ```text
    8.25
    ```

    A major advantage is that a function can participate directly in SQL:

    ```sql
    SELECT
        order_id,
        calculate_tax(order_amount) AS tax
    FROM orders;
    ```

    You can also return multiple rows:

    ```sql
    CREATE OR REPLACE FUNCTION get_customer_orders(
        p_customer_id BIGINT
    )
    RETURNS TABLE (
        order_id BIGINT,
        order_amount NUMERIC
    )
    LANGUAGE plpgsql
    AS $$
    BEGIN
        RETURN QUERY
        SELECT
            o.order_id,
            o.order_amount
        FROM orders o
        WHERE o.customer_id = p_customer_id;
    END;
    $$;
    ```

    Usage:

    ```sql
    SELECT *
    FROM get_customer_orders(101);
    ```

    ### Common Aurora PostgreSQL function use cases

    * Data calculations
    * Data transformation
    * Validation logic
    * Returning query results
    * Custom expressions
    * Reusable SQL logic
    * Trigger functions

    For example, triggers in PostgreSQL execute a **function**, not a procedure:

    ```sql
    CREATE FUNCTION audit_order_changes()
    RETURNS TRIGGER
    LANGUAGE plpgsql
    AS $$
    BEGIN
        INSERT INTO order_audit (...);
        RETURN NEW;
    END;
    $$;
    ```

    ---

    # 2. Procedure

    A procedure is designed more for **performing an action or workflow**.

    ```sql
    CREATE OR REPLACE PROCEDURE process_month_end()
    LANGUAGE plpgsql
    AS $$
    BEGIN

        UPDATE accounts
        SET status = 'CLOSED'
        WHERE month_end = CURRENT_DATE;

        INSERT INTO processing_log (
            process_name,
            processed_at
        )
        VALUES (
            'MONTH_END',
            CURRENT_TIMESTAMP
        );

    END;
    $$;
    ```

    You execute it with `CALL`:

    ```sql
    CALL process_month_end();
    ```

    Unlike a function, you cannot do this:

    ```sql
    SELECT process_month_end();
    ```

    Nor can you normally embed a procedure in a query:

    ```sql
    -- Not valid
    SELECT *
    FROM orders
    WHERE process_month_end();
    ```

    ---

    # 3. Transaction control: the biggest practical difference

    One important distinction is that procedures can support **transaction control**, whereas functions cannot independently commit or roll back transactions.

    Conceptually:

    ```sql
    CREATE PROCEDURE load_daily_data()
    LANGUAGE plpgsql
    AS $$
    BEGIN

        INSERT INTO staging_table
        SELECT *
        FROM source_table;

        COMMIT;

        INSERT INTO audit_log(message)
        VALUES ('Load completed');

    END;
    $$;
    ```

    However, there is an important PostgreSQL/Aurora consideration:

    > Whether `COMMIT` or `ROLLBACK` is permitted depends on how the procedure is invoked and the surrounding transaction context.

    For example, transaction control inside a procedure is not simply available in every context where you can issue `CALL`. Your application or client may already have started an explicit transaction.

    This is especially important when calling procedures through:

    * JDBC
    * Python/psycopg
    * Java frameworks
    * ORMs
    * AWS Lambda
    * Amazon RDS Data API, where applicable
    * Migration/deployment tools

    So, if transaction management is a requirement, test the exact Aurora PostgreSQL version and client transaction behavior you're using.

    ---

    # 4. Functions can have OUT parameters

    Functions can return values through `OUT` parameters.

    ```sql
    CREATE FUNCTION get_order_summary(
        p_order_id BIGINT,
        OUT order_total NUMERIC,
        OUT item_count INTEGER
    )
    LANGUAGE plpgsql
    AS $$
    BEGIN

        SELECT
            SUM(amount),
            COUNT(*)
        INTO
            order_total,
            item_count
        FROM order_items
        WHERE order_id = p_order_id;

    END;
    $$;
    ```

    Call:

    ```sql
    SELECT *
    FROM get_order_summary(1001);
    ```

    ---

    # 5. Procedures can also use INOUT/OUT-style parameters

    Procedures don't return a value the same way a function does, but they can use output parameters.

    Example:

    ```sql
    CREATE OR REPLACE PROCEDURE get_order_count(
        IN p_customer_id BIGINT,
        INOUT p_order_count INTEGER
    )
    LANGUAGE plpgsql
    AS $$
    BEGIN

        SELECT COUNT(*)
        INTO p_order_count
        FROM orders
        WHERE customer_id = p_customer_id;
    END;
    $$;
    ```

    Call:

    ```sql
    CALL get_order_count(
        101,
        0
    );
    ```

    The result is returned as an output parameter/result row, depending on the client.

    ---

    # 6. Side-by-side example

    Suppose you have an order system.

    ### Function: calculate a value

    ```sql
    CREATE FUNCTION calculate_discount(
        p_amount NUMERIC
    )
    RETURNS NUMERIC
    LANGUAGE plpgsql
    AS $$
    BEGIN

        IF p_amount >= 1000 THEN
            RETURN p_amount * 0.10;
        ELSE
            RETURN 0;
        END IF;

    END;
    $$;
    ```

    Use it in SQL:

    ```sql
    SELECT
        order_id,
        order_amount,
        calculate_discount(order_amount) AS discount
    FROM orders;
    ```

    ### Procedure: perform a workflow

    ```sql
    CREATE PROCEDURE close_order(
        p_order_id BIGINT
    )
    LANGUAGE plpgsql
    AS $$
    BEGIN

        UPDATE orders
        SET status = 'CLOSED',
            closed_at = CURRENT_TIMESTAMP
        WHERE order_id = p_order_id;

        INSERT INTO order_audit (
            order_id,
            action,
            created_at
        )
        VALUES (
            p_order_id,
            'ORDER CLOSED',
            CURRENT_TIMESTAMP
        );

    END;
    $$;
    ```

    Execute:

    ```sql
    CALL close_order(1001);
    ```

    ---

    ## When to use which?

    ### Use a **Function** when:

    * You need to return a scalar value.
    * You need to return rows or a table.
    * You want to use the logic inside `SELECT`.
    * You need reusable calculation logic.
    * You need a trigger handler.
    * You want to use the result in `WHERE`, `JOIN`, `ORDER BY`, etc.

    Example:

    ```sql
    SELECT *
    FROM orders
    WHERE calculate_discount(order_amount) > 50;
    ```

    ### Use a **Procedure** when:

    * You are executing a multi-step operation.
    * The primary purpose is to perform actions rather than calculate a query result.
    * You have ETL or batch-processing logic.
    * You need a database-side administrative/business workflow.
    * Transaction boundaries need to be part of the procedure design, subject to PostgreSQL's invocation rules.

    Examples:

    ```sql
    CALL nightly_etl_process();

    CALL close_financial_period();

    CALL archive_old_orders();

    CALL rebuild_reporting_data();
    ```

    ## A simple rule of thumb

    ```text
    Need to ask the database for a result?
            ↓
        FUNCTION


    Need to tell the database to perform a process?
            ↓
        PROCEDURE
    ```

    ### One Aurora PostgreSQL-specific note

    Aurora PostgreSQL is PostgreSQL-compatible, so you should generally design functions and procedures according to the **PostgreSQL major version supported by your Aurora cluster**, rather than expecting a separate Aurora-specific programming model. The exact capabilities can vary with the PostgreSQL-compatible version.

    If you're inventorying an existing Aurora PostgreSQL database, I can next provide a query that shows **all functions and procedures separately**, including **schema, arguments, return type, language, owner, source definition, volatility, security mode, and dependencies**.


    </details>

---

-   <details><summary style="font-size:25px;color:#C71585">Sequences and Types/domains/enums</summary>

    Below is a detailed explanation specifically for **Amazon Aurora PostgreSQL**, including how these objects work, when to use them, how they relate to tables, and what to watch for during migrations.

    ---

    # 1. Sequences in Aurora PostgreSQL

    A **sequence** is a PostgreSQL database object that generates a series of numeric values, typically used for generating unique IDs.

    Think of it as a **database-managed number generator**.

    For example:

    ```text
    1001
    1002
    1003
    1004
    1005
    ...
    ```

    Aurora PostgreSQL uses the standard PostgreSQL sequence implementation.

    ---

    ## 1.1 Creating a sequence

    ```sql
    CREATE SEQUENCE order_id_seq
        START WITH 1
        INCREMENT BY 1;
    ```

    You can retrieve the next value with:

    ```sql
    SELECT nextval('order_id_seq');
    ```

    Example result:

    ```text
    1
    ```

    Another call:

    ```sql
    SELECT nextval('order_id_seq');
    ```

    returns:

    ```text
    2
    ```

    The important point is that the sequence maintains its own state independently of the table.

    ---

    # 1.2 Using a sequence with a table

    Suppose you have:

    ```sql
    CREATE TABLE orders (
        order_id BIGINT PRIMARY KEY,
        order_date DATE,
        amount NUMERIC(12,2)
    );
    ```

    You can associate a sequence with `order_id`:

    ```sql
    CREATE SEQUENCE order_id_seq
        START WITH 1
        INCREMENT BY 1;
    ```

    Then:

    ```sql
    ALTER TABLE orders
    ALTER COLUMN order_id
    SET DEFAULT nextval('order_id_seq');
    ```

    Now:

    ```sql
    INSERT INTO orders (
        order_date,
        amount
    )
    VALUES (
        CURRENT_DATE,
        250.00
    );
    ```

    The database automatically obtains the next sequence value.

    For example:

    ```text
    order_id | order_date  | amount
    ---------+-------------+--------
    1        | 2026-09-15  | 250.00
    ```

    ---

    # 1.3 Sequence ownership

    A sequence can be associated with a particular table column.

    ```sql
    ALTER SEQUENCE order_id_seq
    OWNED BY orders.order_id;
    ```

    This relationship is important.

    It tells PostgreSQL that:

    > `order_id_seq` exists primarily to support `orders.order_id`.

    When the associated column/table is dropped under appropriate dependency semantics, PostgreSQL can automatically handle the owned sequence.

    You can inspect the relationship with:

    ```sql
    SELECT
        n.nspname AS schema_name,
        s.relname AS sequence_name,
        pg_get_userbyid(s.relowner) AS owner,
        a.attname AS owned_by_column
    FROM pg_class s
    JOIN pg_namespace n
        ON n.oid = s.relnamespace
    LEFT JOIN pg_depend d
        ON d.objid = s.oid
    AND d.deptype = 'a'
    LEFT JOIN pg_class t
        ON t.oid = d.refobjid
    LEFT JOIN pg_attribute a
        ON a.attrelid = t.oid
    AND a.attnum = d.refobjsubid
    WHERE s.relkind = 'S'
    ORDER BY
        n.nspname,
        s.relname;
    ```

    ---

    # 1.4 `SERIAL` and sequences

    You will frequently encounter this in existing PostgreSQL/Aurora databases:

    ```sql
    CREATE TABLE customers (
        customer_id SERIAL PRIMARY KEY,
        customer_name TEXT
    );
    ```

    `SERIAL` is not actually a data type.

    It is shorthand that causes PostgreSQL to create:

    1. An integer column
    2. A sequence
    3. A default using `nextval()`
    4. An ownership dependency between the sequence and column

    Conceptually:

    ```text
    customers.customer_id
            |
            v
    nextval('customers_customer_id_seq')
            |
            v
    customers_customer_id_seq
    ```

    For `BIGSERIAL`:

    ```sql
    customer_id BIGSERIAL
    ```

    the underlying column is `BIGINT`.

    ---

    # 1.5 Identity columns

    Modern PostgreSQL applications often use **identity columns** instead of `SERIAL`.

    Example:

    ```sql
    CREATE TABLE customers (
        customer_id BIGINT GENERATED ALWAYS AS IDENTITY,
        customer_name TEXT
    );
    ```

    Or:

    ```sql
    CREATE TABLE customers (
        customer_id BIGINT GENERATED BY DEFAULT AS IDENTITY,
        customer_name TEXT
    );
    ```

    Identity columns still use sequence-backed mechanisms internally, but the relationship is managed as part of the column definition.

    ### `SERIAL` vs `IDENTITY`

    | Feature                          | `SERIAL`                            | `IDENTITY`               |
    | -------------------------------- | ----------------------------------- | ------------------------ |
    | Actual data type                 | Integer/Bigint/etc.                 | Integer/Bigint/etc.      |
    | Creates sequence                 | Yes                                 | Yes, internally          |
    | Standard SQL                     | No                                  | Yes                      |
    | Column-level identity definition | No                                  | Yes                      |
    | Explicit value behavior          | Controlled through sequence/default | `ALWAYS` or `BY DEFAULT` |
    | Recommended for new designs      | Usually no                          | Generally preferred      |

    For new Aurora PostgreSQL designs, **identity columns are usually preferable** unless you have a reason to explicitly manage sequences.

    ---

    # 1.6 `GENERATED ALWAYS` vs `BY DEFAULT`

    This is important.

    ### `GENERATED ALWAYS`

    ```sql
    CREATE TABLE orders (
        order_id BIGINT GENERATED ALWAYS AS IDENTITY,
        amount NUMERIC(12,2)
    );
    ```

    Normally:

    ```sql
    INSERT INTO orders(amount)
    VALUES (100);
    ```

    PostgreSQL generates `order_id`.

    Trying to provide your own ID normally produces an error.

    If you really need to override it, PostgreSQL provides:

    ```sql
    INSERT INTO orders(order_id, amount)
    OVERRIDING SYSTEM VALUE
    VALUES (5000, 100);
    ```

    ### `GENERATED BY DEFAULT`

    ```sql
    CREATE TABLE orders (
        order_id BIGINT GENERATED BY DEFAULT AS IDENTITY,
        amount NUMERIC(12,2)
    );
    ```

    PostgreSQL generates an ID when you don't provide one, but you can explicitly provide a value.

    This can be useful during:

    * Data migration
    * Data loading
    * ETL
    * Replication
    * Restoring data

    ---

    # 1.7 Important sequence behavior

    Sequences are **not gapless counters**.

    Suppose:

    ```sql
    SELECT nextval('order_id_seq');
    ```

    returns:

    ```text
    101
    ```

    Then your transaction fails:

    ```sql
    INSERT INTO orders (...);
    -- transaction fails
    ROLLBACK;
    ```

    The sequence value `101` is generally **not rolled back**.

    The next call can return:

    ```text
    102
    ```

    Therefore:

    ```text
    100
    101  <-- failed transaction
    102
    103
    ```

    You can have gaps.

    ### Don't use sequences for:

    > "Every number must be consecutive."

    Use them for:

    > "I need efficiently generated unique numeric identifiers."

    This distinction matters significantly in financial, invoice, legal-document, and regulatory systems.

    ---

    # 1.8 Sequence caching

    Sequences can cache values:

    ```sql
    CREATE SEQUENCE order_id_seq
    CACHE 100;
    ```

    This improves performance because PostgreSQL doesn't have to persist sequence state for every individual request.

    However, cached sequence values can contribute to larger gaps if the database/server process terminates unexpectedly.

    Therefore, sequence numbers should generally be treated as **unique identifiers**, not as a guaranteed contiguous business numbering system.

    ---

    # 1.9 Aurora considerations

    Aurora PostgreSQL is distributed storage underneath, but PostgreSQL sequences retain PostgreSQL's normal semantics.

    You should not assume:

    ```text
    sequence value = transaction commit order
    ```

    or:

    ```text
    sequence value = timestamp order
    ```

    or:

    ```text
    sequence values will never have gaps
    ```

    Sequences are designed primarily for **efficient uniqueness**, not ordering guarantees.

    ---

    # 1.10 Sequence inventory query

    To inventory sequences in Aurora:

    ```sql
    SELECT
        n.nspname AS schema_name,
        c.relname AS sequence_name,
        pg_get_userbyid(c.relowner) AS owner
    FROM pg_class c
    JOIN pg_namespace n
        ON n.oid = c.relnamespace
    WHERE c.relkind = 'S'
    AND n.nspname NOT LIKE 'pg_%'
    AND n.nspname <> 'information_schema'
    ORDER BY
        n.nspname,
        c.relname;
    ```

    You can also inspect sequence properties:

    ```sql
    SELECT
        schemaname,
        sequencename,
        data_type,
        start_value,
        min_value,
        max_value,
        increment_by,
        cycle,
        cache_size,
        last_value
    FROM pg_sequences
    WHERE schemaname NOT LIKE 'pg_%'
    ORDER BY
        schemaname,
        sequencename;
    ```

    ---

    # 2. Types in Aurora PostgreSQL

    PostgreSQL has a much richer type system than many relational databases.

    Besides standard types such as:

    ```text
    INTEGER
    BIGINT
    NUMERIC
    VARCHAR
    DATE
    TIMESTAMP
    BOOLEAN
    ```

    PostgreSQL allows you to create your own types.

    These are called **user-defined types**.

    The most important categories for Aurora PostgreSQL are:

    1. **Enum types**
    2. **Domain types**
    3. **Composite types**
    4. **Range types**
    5. **Multirange types**
    6. Custom/base types
    7. Types supplied by extensions

    For application/database migration work, **ENUM, DOMAIN, and COMPOSITE types** are particularly important.

    ---

    # 3. ENUM types

    An **ENUM** defines a fixed set of allowed values.

    For example:

    ```sql
    CREATE TYPE order_status AS ENUM (
        'PENDING',
        'PROCESSING',
        'SHIPPED',
        'DELIVERED',
        'CANCELLED'
    );
    ```

    Then:

    ```sql
    CREATE TABLE orders (
        order_id BIGINT GENERATED ALWAYS AS IDENTITY,
        status order_status
    );
    ```

    Now:

    ```sql
    INSERT INTO orders(status)
    VALUES ('PENDING');
    ```

    works.

    But:

    ```sql
    INSERT INTO orders(status)
    VALUES ('INVALID');
    ```

    fails because `INVALID` isn't a member of the enum.

    ---

    # 3.1 Why use ENUM?

    An enum is useful when the valid values are:

    * Small
    * Well-defined
    * Relatively stable
    * Part of the data model itself

    For example:

    ```text
    order_status
    -------------
    PENDING
    PROCESSING
    SHIPPED
    DELIVERED
    CANCELLED
    ```

    It provides database-level enforcement.

    ---

    # 3.2 ENUM ordering

    One interesting PostgreSQL characteristic is that enum values have an ordering based on their definition order.

    For:

    ```sql
    CREATE TYPE priority AS ENUM (
        'LOW',
        'MEDIUM',
        'HIGH',
        'CRITICAL'
    );
    ```

    PostgreSQL knows:

    ```text
    LOW < MEDIUM < HIGH < CRITICAL
    ```

    So:

    ```sql
    SELECT *
    FROM tickets
    WHERE priority > 'MEDIUM';
    ```

    can use enum ordering semantics.

    ---

    # 3.3 Adding ENUM values

    You can add values:

    ```sql
    ALTER TYPE order_status
    ADD VALUE 'RETURNED';
    ```

    You can also position a new value relative to existing values using PostgreSQL's supported syntax, for example:

    ```sql
    ALTER TYPE order_status
    ADD VALUE 'PACKED' AFTER 'PROCESSING';
    ```

    However, enum modifications should be treated carefully in production deployments because schema changes to enum types can affect application compatibility and deployment sequencing.

    ---

    # 3.4 ENUM limitations

    ENUMs are excellent for stable categories, but they can become inconvenient when values change frequently.

    Suppose a business team frequently adds:

    ```text
    PENDING
    PENDING_REVIEW
    PENDING_APPROVAL
    PENDING_FINANCE_REVIEW
    PENDING_MANAGER_REVIEW
    ...
    ```

    A lookup/reference table may be easier to manage.

    Instead:

    ```sql
    CREATE TABLE order_status (
        status_code VARCHAR(30) PRIMARY KEY,
        description TEXT,
        active BOOLEAN
    );
    ```

    Then:

    ```sql
    CREATE TABLE orders (
        order_id BIGINT,
        status_code VARCHAR(30)
            REFERENCES order_status(status_code)
    );
    ```

    This gives you more flexibility.

    ---

    # 3.5 ENUM vs lookup table

    | Requirement                |                     ENUM |  Lookup table |
    | -------------------------- | -----------------------: | ------------: |
    | Fixed small set            |                Excellent |          Good |
    | Frequently changing values |          Less convenient |     Excellent |
    | Metadata per value         |                  Limited |     Excellent |
    | Foreign-key relationships  | No traditional FK needed |     Excellent |
    | Application readability    |                Excellent |          Good |
    | Database enforcement       |                Excellent |     Excellent |
    | Runtime administration     |            Less flexible | More flexible |

    For example, use ENUM for something like:

    ```text
    gender? 
    ```

    Actually, even this can be business-dependent and often deserves a more flexible model.

    Better examples are technical states such as:

    ```text
    PENDING
    ACTIVE
    DISABLED
    ```

    when those values are genuinely stable.

    ---

    # 4. DOMAIN types

    A **domain** is a custom type based on an existing PostgreSQL type, with optional constraints.

    Think of it as:

    > "This is still a VARCHAR/INTEGER/etc., but it has additional business rules."

    For example:

    ```sql
    CREATE DOMAIN email_address AS TEXT
    CHECK (
        VALUE ~* '^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$'
    );
    ```

    Now:

    ```sql
    CREATE TABLE customers (
        customer_id BIGINT,
        email email_address
    );
    ```

    The `email` column is still fundamentally text-based, but it has domain validation.

    ---

    # 4.1 Another domain example

    Suppose every percentage in your database must be between 0 and 100:

    ```sql
    CREATE DOMAIN percentage AS NUMERIC(5,2)
    CHECK (
        VALUE >= 0
        AND VALUE <= 100
    );
    ```

    Then:

    ```sql
    CREATE TABLE products (
        product_id BIGINT,
        discount_percentage percentage
    );
    ```

    This is rejected:

    ```sql
    INSERT INTO products(
        product_id,
        discount_percentage
    )
    VALUES (
        1,
        150
    );
    ```

    because:

    ```text
    150 > 100
    ```

    ---

    # 4.2 Why domains are useful

    Suppose your database contains 50 tables with email addresses.

    Without a domain:

    ```sql
    customer.email TEXT
    employee.email TEXT
    vendor.email TEXT
    contact.email TEXT
    ```

    You may have validation rules scattered across applications.

    With a domain:

    ```sql
    CREATE DOMAIN email_address AS TEXT
    CHECK (...);
    ```

    you can use:

    ```sql
    customer.email email_address
    employee.email email_address
    vendor.email email_address
    contact.email email_address
    ```

    Now the common constraint is centralized.

    ---

    # 4.3 Domain vs ENUM

    They solve different problems.

    ### ENUM

    Answers:

    > "What values are allowed?"

    Example:

    ```text
    PENDING
    ACTIVE
    CLOSED
    ```

    ### DOMAIN

    Answers:

    > "What underlying data type and constraints should this value have?"

    Example:

    ```text
    NUMERIC between 0 and 100
    ```

    Conceptually:

    ```text
    ENUM
    ↓
    Fixed set of values


    DOMAIN
    ↓
    Existing type
    +
    Validation rules
    ```

    ---

    # 4.4 Domain example with NOT NULL

    You can define constraints on domains.

    For example:

    ```sql
    CREATE DOMAIN positive_amount AS NUMERIC(18,2)
    CHECK (VALUE > 0);
    ```

    Then:

    ```sql
    CREATE TABLE payments (
        payment_id BIGINT,
        amount positive_amount
    );
    ```

    This rejects:

    ```sql
    INSERT INTO payments(amount)
    VALUES (-100);
    ```

    But remember that **domain constraints and column-level constraints are separate concepts**.

    You can still define:

    ```sql
    amount positive_amount NOT NULL
    ```

    if the column itself must not be null.

    ---

    # 4.5 Domain inventory

    To find domains:

    ```sql
    SELECT
        n.nspname AS schema_name,
        t.typname AS domain_name,
        format_type(t.typbasetype, t.typtypmod) AS base_type,
        pg_get_userbyid(t.typowner) AS owner
    FROM pg_type t
    JOIN pg_namespace n
        ON n.oid = t.typnamespace
    WHERE t.typtype = 'd'
    AND n.nspname NOT LIKE 'pg_%'
    AND n.nspname <> 'information_schema'
    ORDER BY
        n.nspname,
        t.typname;
    ```

    To see domain constraints:

    ```sql
    SELECT
        n.nspname AS schema_name,
        t.typname AS domain_name,
        c.conname AS constraint_name,
        pg_get_constraintdef(c.oid) AS constraint_definition
    FROM pg_type t
    JOIN pg_namespace n
        ON n.oid = t.typnamespace
    JOIN pg_constraint c
        ON c.contypid = t.oid
    WHERE t.typtype = 'd'
    ORDER BY
        n.nspname,
        t.typname,
        c.conname;
    ```

    ---

    # 5. Composite types

    PostgreSQL can also define a type consisting of multiple fields.

    Example:

    ```sql
    CREATE TYPE address AS (
        street      TEXT,
        city        TEXT,
        state       TEXT,
        postal_code TEXT
    );
    ```

    Now:

    ```sql
    CREATE TABLE customers (
        customer_id BIGINT,
        name TEXT,
        address address
    );
    ```

    The `address` column contains a structured value:

    ```text
    street
    city
    state
    postal_code
    ```

    This is similar conceptually to a small object/record structure.

    ---

    # 5.1 Using a composite type

    You can insert a composite value:

    ```sql
    INSERT INTO customers (
        name,
        address
    )
    VALUES (
        'John Smith',
        ROW(
            '123 Main Street',
            'Frisco',
            'TX',
            '75034'
        )
    );
    ```

    You can access individual fields:

    ```sql
    SELECT
        (address).city,
        (address).state
    FROM customers;
    ```

    ---

    # 5.2 Composite types and tables

    An interesting PostgreSQL feature is that a table automatically has a corresponding composite row type.

    For:

    ```sql
    CREATE TABLE customers (
        customer_id BIGINT,
        name TEXT
    );
    ```

    PostgreSQL internally has a row type representing the table's structure.

    This is one reason PostgreSQL's type system is tightly integrated with its relational model.

    ---

    # 6. Range types

    PostgreSQL also supports **range types**.

    A range represents an interval.

    For example:

    ```text
    [2026-01-01, 2026-02-01)
    ```

    means:

    ```text
    January 1 through January 31
    ```

    PostgreSQL provides built-in range types such as:

    ```text
    int4range
    int8range
    numrange
    tsrange
    tstzrange
    daterange
    ```

    Example:

    ```sql
    CREATE TABLE room_bookings (
        room_id BIGINT,
        booking_period DATERANGE
    );
    ```

    Insert:

    ```sql
    INSERT INTO room_bookings (
        room_id,
        booking_period
    )
    VALUES (
        101,
        '[2026-09-15,2026-09-20)'
    );
    ```

    This is particularly useful for:

    * Reservations
    * Effective dates
    * Employment periods
    * Pricing periods
    * Contract validity
    * Scheduling

    ---

    # 6.1 Range operators

    PostgreSQL provides specialized operators.

    For example, overlap:

    ```sql
    SELECT *
    FROM room_bookings
    WHERE booking_period &&
        '[2026-09-18,2026-09-22)'::daterange;
    ```

    `&&` means the ranges overlap.

    This can be extremely useful for scheduling applications.

    ---

    # 7. Multirange types

    Newer PostgreSQL versions also support **multiranges**.

    A multirange represents multiple non-overlapping ranges.

    For example:

    ```text
    [2026-01-01, 2026-01-10)
    [2026-02-01, 2026-02-15)
    [2026-03-01, 2026-03-05)
    ```

    Conceptually:

    ```text
    Range:
        [A, B)

    Multirange:
        [A, B)
        [C, D)
        [E, F)
    ```

    These can be useful for:

    * Availability calendars
    * Working hours
    * Multiple contract periods
    * Complex scheduling
    * Intermittent service periods

    ---

    # 8. Types, Domains and ENUMs — relationship

    It's useful to visualize the hierarchy like this:

    ```text
                        PostgreSQL Type System
                                |
            +-----------------+------------------+
            |                 |                  |
        Built-in         User-defined       Extension
            types              types              types
            |                 |
        INTEGER            +---+---------+
        BIGINT             |             |
        TEXT             ENUM          DOMAIN
        DATE               |             |
        JSONB              |          Existing type
        UUID               |             +
                        Fixed set     Constraints
                        of values
    ```

    And there are additional user-defined structures:

    ```text
    User-defined types
            |
            +-- ENUM
            |
            +-- DOMAIN
            |
            +-- COMPOSITE
            |
            +-- RANGE
            |
            +-- MULTIRANGE
    ```

    ---

    # 9. Example: Putting them together

    Imagine an Aurora PostgreSQL order-management system.

    ## Status ENUM

    ```sql
    CREATE TYPE order_status AS ENUM (
        'PENDING',
        'PROCESSING',
        'SHIPPED',
        'DELIVERED',
        'CANCELLED'
    );
    ```

    ## Percentage DOMAIN

    ```sql
    CREATE DOMAIN percentage AS NUMERIC(5,2)
    CHECK (
        VALUE >= 0
        AND VALUE <= 100
    );
    ```

    ## Money DOMAIN

    ```sql
    CREATE DOMAIN positive_money AS NUMERIC(18,2)
    CHECK (
        VALUE >= 0
    );
    ```

    ## Sequence / identity

    ```sql
    CREATE TABLE orders (
        order_id BIGINT GENERATED ALWAYS AS IDENTITY,
        status order_status NOT NULL DEFAULT 'PENDING',
        discount percentage,
        total_amount positive_money NOT NULL,
        PRIMARY KEY (order_id)
    );
    ```

    Now the database itself enforces several rules:

    ```text
    order_id
    ↓
    Automatically generated

    status
    ↓
    Must be one of the defined ENUM values

    discount
    ↓
    Must be between 0 and 100

    total_amount
    ↓
    Must be >= 0
    ```

    This is a good example of PostgreSQL's philosophy:

    > Put appropriate data integrity rules close to the data.

    ---

    # 10. Aurora PostgreSQL migration considerations

    These objects become especially important when migrating from another database platform to Aurora PostgreSQL.

    For example:

    | Source concept               | Aurora PostgreSQL consideration                     |
    | ---------------------------- | --------------------------------------------------- |
    | Oracle `SEQUENCE`            | PostgreSQL sequence                                 |
    | Oracle identity column       | PostgreSQL identity                                 |
    | Oracle `VARCHAR2`            | `VARCHAR`/`TEXT`                                    |
    | Oracle user-defined type     | May require composite/domain/custom type            |
    | Oracle `OBJECT TYPE`         | Often composite type or redesigned relational model |
    | Oracle `SUBTYPE`             | Often domain or another PostgreSQL type strategy    |
    | Oracle enum-like lookup      | PostgreSQL ENUM or lookup table                     |
    | SQL Server `IDENTITY`        | PostgreSQL identity                                 |
    | SQL Server `SEQUENCE`        | PostgreSQL sequence                                 |
    | MySQL `AUTO_INCREMENT`       | PostgreSQL identity/sequence                        |
    | Application status constants | PostgreSQL ENUM or lookup table                     |

    Migration tooling may not automatically produce the exact desired PostgreSQL design, so these objects should be explicitly inventoried.

    ---

    # 11. Important Aurora PostgreSQL checklist

    When assessing an existing Aurora PostgreSQL database, I would inventory at least the following:

    ### Sequences

    ```text
    Schema
    Sequence name
    Owner
    Start value
    Increment
    Min value
    Max value
    Cache
    Cycle
    Current/last value
    Owned table
    Owned column
    ```

    ### ENUMs

    ```text
    Schema
    Type name
    Owner
    Enum values
    Enum ordering
    Dependent tables/columns
    ```

    ### Domains

    ```text
    Schema
    Domain name
    Owner
    Base type
    Default
    NOT NULL property
    Constraints
    Constraint definitions
    Dependent columns
    ```

    ### Other custom types

    ```text
    Composite types
    Range types
    Multirange types
    Extension-provided types
    ```

    ---

    # 12. Useful inventory queries

    ## ENUMs

    ```sql
    SELECT
        n.nspname AS schema_name,
        t.typname AS enum_name,
        pg_get_userbyid(t.typowner) AS owner,
        e.enumlabel AS enum_value,
        e.enumsortorder AS sort_order
    FROM pg_type t
    JOIN pg_namespace n
        ON n.oid = t.typnamespace
    JOIN pg_enum e
        ON e.enumtypid = t.oid
    WHERE t.typtype = 'e'
    AND n.nspname NOT LIKE 'pg_%'
    AND n.nspname <> 'information_schema'
    ORDER BY
        n.nspname,
        t.typname,
        e.enumsortorder;
    ```

    ## Domains

    ```sql
    SELECT
        n.nspname AS schema_name,
        t.typname AS domain_name,
        pg_get_userbyid(t.typowner) AS owner,
        format_type(t.typbasetype, t.typtypmod) AS base_type,
        t.typnotnull AS not_null,
        pg_get_expr(t.typdefaultbin, 0) AS default_value
    FROM pg_type t
    JOIN pg_namespace n
        ON n.oid = t.typnamespace
    WHERE t.typtype = 'd'
    AND n.nspname NOT LIKE 'pg_%'
    AND n.nspname <> 'information_schema'
    ORDER BY
        n.nspname,
        t.typname;
    ```

    ## All user-defined types

    ```sql
    SELECT
        n.nspname AS schema_name,
        t.typname AS type_name,
        CASE t.typtype
            WHEN 'd' THEN 'DOMAIN'
            WHEN 'e' THEN 'ENUM'
            WHEN 'c' THEN 'COMPOSITE'
            WHEN 'r' THEN 'RANGE'
            WHEN 'm' THEN 'MULTIRANGE'
            ELSE t.typtype::text
        END AS type_category,
        pg_get_userbyid(t.typowner) AS owner
    FROM pg_type t
    JOIN pg_namespace n
        ON n.oid = t.typnamespace
    WHERE t.typtype IN ('d', 'e', 'c', 'r', 'm')
    AND n.nspname NOT LIKE 'pg_%'
    AND n.nspname <> 'information_schema'
    ORDER BY
        n.nspname,
        type_category,
        t.typname;
    ```

    ---

    # Summary

    The three concepts can be remembered this way:

    ```text
    SEQUENCE
        ↓
    Generates numbers
        ↓
    Typically used for IDs


    ENUM
        ↓
    Defines a fixed set of values
        ↓
    Example: PENDING / ACTIVE / CLOSED


    DOMAIN
        ↓
    Creates a constrained version of an existing type
        ↓
    Example: NUMERIC between 0 and 100
    ```

    For Aurora PostgreSQL specifically:

    ```text
    Sequence
    └── ID generation

    Identity
    └── Modern column-level ID generation backed by sequence mechanics

    ENUM
    └── Stable finite set of values

    DOMAIN
    └── Reusable type + validation rules

    COMPOSITE
    └── Structured record/object-like type

    RANGE
    └── Represents an interval

    MULTIRANGE
    └── Represents multiple intervals
    ```

    **For a new Aurora PostgreSQL application**, a common approach is to use **identity columns for generated IDs**, **ENUMs for genuinely stable finite states**, **domains for reusable validation rules**, and **lookup/reference tables when values or their metadata need to change frequently**.
    """
    path = "/mnt/data/Aurora_PostgreSQL_Sequences_Types_Domains_Enums.md"
    with open(path, "w", encoding="utf-8") as f:
    f.write(md)
    print(path)
    print(len(md.splitlines()), "lines")
    print("Created markdown file.")
    print("Download: [Aurora PostgreSQL — Sequences, Types, Domains & Enums](sandbox:/mnt/data/Aurora_PostgreSQL_Sequences_Types_Domains_Enums.md)")
    " .strip()
    return
    }

    ```
    But the output is weird because code contains invalid syntax. Need fix. Let's call again properly. 
    ```


    </details>

---

