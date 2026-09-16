/* ============================================================
Below is a practical Aurora PostgreSQL database-object inventory script. 
Run it while connected to the target database; it uses PostgreSQL system 
catalogs and information_schema.
   ============================================================ */

/* ============================================================
   AWS Aurora PostgreSQL - Database Object Inventory
   Run this against the target database.
   ============================================================ */

WITH object_inventory AS (

    /* --------------------------------------------------------
       SCHEMAS
       -------------------------------------------------------- */
    SELECT
        'SCHEMA' AS object_type,
        n.nspname AS schema_name,
        n.nspname AS object_name,
        pg_get_userbyid(n.nspowner) AS owner,
        NULL::text AS parent_object,
        NULL::text AS details
    FROM pg_namespace n
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       TABLES
       -------------------------------------------------------- */
    SELECT
        CASE c.relkind
            WHEN 'r' THEN 'TABLE'
            WHEN 'p' THEN 'PARTITIONED TABLE'
            WHEN 'f' THEN 'FOREIGN TABLE'
        END AS object_type,
        n.nspname AS schema_name,
        c.relname AS object_name,
        pg_get_userbyid(c.relowner) AS owner,
        NULL::text AS parent_object,
        format(
            'rows_estimate=%s, persistence=%s',
            c.reltuples::bigint,
            CASE c.relpersistence
                WHEN 'p' THEN 'permanent'
                WHEN 'u' THEN 'unlogged'
                WHEN 't' THEN 'temporary'
            END
        ) AS details
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE c.relkind IN ('r', 'p', 'f')
      AND n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       TABLE PARTITIONS
       -------------------------------------------------------- */
    SELECT
        'TABLE PARTITION' AS object_type,
        child_ns.nspname AS schema_name,
        child.relname AS object_name,
        pg_get_userbyid(child.relowner) AS owner,
        parent_ns.nspname || '.' || parent.relname AS parent_object,
        pg_get_expr(child.relpartbound, child.oid) AS details
    FROM pg_inherits i
    JOIN pg_class child
        ON child.oid = i.inhrelid
    JOIN pg_namespace child_ns
        ON child_ns.oid = child.relnamespace
    JOIN pg_class parent
        ON parent.oid = i.inhparent
    JOIN pg_namespace parent_ns
        ON parent_ns.oid = parent.relnamespace
    WHERE child_ns.nspname NOT LIKE 'pg_%'
      AND child_ns.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       VIEWS
       -------------------------------------------------------- */
    SELECT
        CASE c.relkind
            WHEN 'v' THEN 'VIEW'
            WHEN 'm' THEN 'MATERIALIZED VIEW'
        END AS object_type,
        n.nspname AS schema_name,
        c.relname AS object_name,
        pg_get_userbyid(c.relowner) AS owner,
        NULL::text AS parent_object,
        NULL::text AS details
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE c.relkind IN ('v', 'm')
      AND n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       SEQUENCES
       -------------------------------------------------------- */
    SELECT
        'SEQUENCE' AS object_type,
        n.nspname AS schema_name,
        c.relname AS object_name,
        pg_get_userbyid(c.relowner) AS owner,
        NULL::text AS parent_object,
        NULL::text AS details
    FROM pg_class c
    JOIN pg_namespace n ON n.oid = c.relnamespace
    WHERE c.relkind = 'S'
      AND n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       INDEXES
       -------------------------------------------------------- */
    SELECT
        'INDEX' AS object_type,
        n.nspname AS schema_name,
        i.relname AS object_name,
        pg_get_userbyid(i.relowner) AS owner,
        t.relname AS parent_object,
        pg_get_indexdef(i.oid) AS details
    FROM pg_index x
    JOIN pg_class i ON i.oid = x.indexrelid
    JOIN pg_class t ON t.oid = x.indrelid
    JOIN pg_namespace n ON n.oid = i.relnamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       CONSTRAINTS
       -------------------------------------------------------- */
    SELECT
        CASE con.contype
            WHEN 'p' THEN 'PRIMARY KEY'
            WHEN 'f' THEN 'FOREIGN KEY'
            WHEN 'u' THEN 'UNIQUE CONSTRAINT'
            WHEN 'c' THEN 'CHECK CONSTRAINT'
            WHEN 'x' THEN 'EXCLUSION CONSTRAINT'
            WHEN 'n' THEN 'NOT NULL CONSTRAINT'
            WHEN 'd' THEN 'DOMAIN CONSTRAINT'
        END AS object_type,
        n.nspname AS schema_name,
        con.conname AS object_name,
        pg_get_userbyid(c.relowner) AS owner,
        c.relname AS parent_object,
        pg_get_constraintdef(con.oid) AS details
    FROM pg_constraint con
    JOIN pg_class c
        ON c.oid = con.conrelid
    JOIN pg_namespace n
        ON n.oid = c.relnamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       FUNCTIONS / PROCEDURES / AGGREGATES / WINDOW FUNCTIONS
       -------------------------------------------------------- */
    SELECT
        CASE p.prokind
            WHEN 'f' THEN 'FUNCTION'
            WHEN 'p' THEN 'PROCEDURE'
            WHEN 'a' THEN 'AGGREGATE'
            WHEN 'w' THEN 'WINDOW FUNCTION'
        END AS object_type,
        n.nspname AS schema_name,
        p.proname ||
            '(' ||
            pg_get_function_identity_arguments(p.oid) ||
            ')' AS object_name,
        pg_get_userbyid(p.proowner) AS owner,
        NULL::text AS parent_object,
        pg_get_functiondef(p.oid) AS details
    FROM pg_proc p
    JOIN pg_namespace n ON n.oid = p.pronamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       TRIGGERS
       -------------------------------------------------------- */
    SELECT
        'TRIGGER' AS object_type,
        n.nspname AS schema_name,
        t.tgname AS object_name,
        pg_get_userbyid(c.relowner) AS owner,
        c.relname AS parent_object,
        pg_get_triggerdef(t.oid) AS details
    FROM pg_trigger t
    JOIN pg_class c
        ON c.oid = t.tgrelid
    JOIN pg_namespace n
        ON n.oid = c.relnamespace
    WHERE NOT t.tgisinternal
      AND n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       RULES
       -------------------------------------------------------- */
    SELECT
        'RULE' AS object_type,
        n.nspname AS schema_name,
        r.rulename AS object_name,
        pg_get_userbyid(c.relowner) AS owner,
        c.relname AS parent_object,
        pg_get_ruledef(r.oid) AS details
    FROM pg_rewrite r
    JOIN pg_class c
        ON c.oid = r.ev_class
    JOIN pg_namespace n
        ON n.oid = c.relnamespace
    WHERE r.rulename <> '_RETURN'
      AND n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       TYPES
       -------------------------------------------------------- */
    SELECT
        CASE t.typtype
            WHEN 'd' THEN 'DOMAIN'
            WHEN 'e' THEN 'ENUM TYPE'
            WHEN 'c' THEN 'COMPOSITE TYPE'
            WHEN 'r' THEN 'RANGE TYPE'
            WHEN 'm' THEN 'MULTIRANGE TYPE'
            WHEN 'b' THEN 'BASE TYPE'
            ELSE 'TYPE'
        END AS object_type,
        n.nspname AS schema_name,
        t.typname AS object_name,
        pg_get_userbyid(t.typowner) AS owner,
        NULL::text AS parent_object,
        CASE
            WHEN t.typtype = 'd'
                THEN format(
                    'base_type=%s',
                    format_type(t.typbasetype, NULL)
                )
            WHEN t.typtype = 'e'
                THEN (
                    SELECT string_agg(e.enumlabel, ', ' ORDER BY e.enumsortorder)
                    FROM pg_enum e
                    WHERE e.enumtypid = t.oid
                )
            ELSE NULL
        END AS details
    FROM pg_type t
    JOIN pg_namespace n ON n.oid = t.typnamespace
    WHERE t.typtype IN ('d', 'e', 'c', 'r', 'm')
      AND n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       COLLATIONS
       -------------------------------------------------------- */
    SELECT
        'COLLATION' AS object_type,
        n.nspname AS schema_name,
        c.collname AS object_name,
        pg_get_userbyid(c.collowner) AS owner,
        NULL::text AS parent_object,
        format(
            'locale=%s',
            COALESCE(c.collcollate, '')
        ) AS details
    FROM pg_collation c
    JOIN pg_namespace n ON n.oid = c.collnamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       EXTENSIONS
       -------------------------------------------------------- */
    SELECT
        'EXTENSION' AS object_type,
        n.nspname AS schema_name,
        e.extname AS object_name,
        pg_get_userbyid(e.extowner) AS owner,
        NULL::text AS parent_object,
        e.extversion AS details
    FROM pg_extension e
    JOIN pg_namespace n ON n.oid = e.extnamespace

    UNION ALL

    /* --------------------------------------------------------
       TEXT SEARCH CONFIGURATIONS
       -------------------------------------------------------- */
    SELECT
        'TEXT SEARCH CONFIGURATION' AS object_type,
        n.nspname AS schema_name,
        c.cfgname AS object_name,
        pg_get_userbyid(c.cfgowner) AS owner,
        NULL::text AS parent_object,
        NULL::text AS details
    FROM pg_ts_config c
    JOIN pg_namespace n ON n.oid = c.cfgnamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       TEXT SEARCH DICTIONARIES
       -------------------------------------------------------- */
    SELECT
        'TEXT SEARCH DICTIONARY' AS object_type,
        n.nspname AS schema_name,
        d.dictname AS object_name,
        pg_get_userbyid(d.dictowner) AS owner,
        NULL::text AS parent_object,
        NULL::text AS details
    FROM pg_ts_dict d
    JOIN pg_namespace n ON n.oid = d.dictnamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       TEXT SEARCH PARSERS
       -------------------------------------------------------- */
    SELECT
        'TEXT SEARCH PARSER' AS object_type,
        n.nspname AS schema_name,
        p.prsname AS object_name,
        NULL::text AS owner,
        NULL::text AS parent_object,
        NULL::text AS details
    FROM pg_ts_parser p
    JOIN pg_namespace n ON n.oid = p.prsnamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       TEXT SEARCH TEMPLATES
       -------------------------------------------------------- */
    SELECT
        'TEXT SEARCH TEMPLATE' AS object_type,
        n.nspname AS schema_name,
        t.tmplname AS object_name,
        NULL::text AS owner,
        NULL::text AS parent_object,
        NULL::text AS details
    FROM pg_ts_template t
    JOIN pg_namespace n ON n.oid = t.tmplnamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

    UNION ALL

    /* --------------------------------------------------------
       FOREIGN DATA WRAPPERS
       -------------------------------------------------------- */
    SELECT
        'FOREIGN DATA WRAPPER' AS object_type,
        NULL::text AS schema_name,
        fdwname AS object_name,
        pg_get_userbyid(fdwowner) AS owner,
        NULL::text AS parent_object,
        fdwoptions::text AS details
    FROM pg_foreign_data_wrapper

    UNION ALL

    /* --------------------------------------------------------
       FOREIGN SERVERS
       -------------------------------------------------------- */
    SELECT
        'FOREIGN SERVER' AS object_type,
        NULL::text AS schema_name,
        srvname AS object_name,
        pg_get_userbyid(srvowner) AS owner,
        NULL::text AS parent_object,
        srvoptions::text AS details
    FROM pg_foreign_server

    UNION ALL

    /* --------------------------------------------------------
       PUBLICATIONS
       -------------------------------------------------------- */
    SELECT
        'PUBLICATION' AS object_type,
        NULL::text AS schema_name,
        pubname AS object_name,
        pg_get_userbyid(pubowner) AS owner,
        NULL::text AS parent_object,
        format(
            'insert=%s, update=%s, delete=%s, truncate=%s',
            pubinsert,
            pubupdate,
            pubdelete,
            pubtruncate
        ) AS details
    FROM pg_publication

    UNION ALL

    /* --------------------------------------------------------
       ROW LEVEL SECURITY POLICIES
       -------------------------------------------------------- */
    SELECT
        'RLS POLICY' AS object_type,
        n.nspname AS schema_name,
        pol.polname AS object_name,
        pg_get_userbyid(c.relowner) AS owner,
        c.relname AS parent_object,
        pg_get_expr(pol.polqual, pol.polrelid) AS details
    FROM pg_policy pol
    JOIN pg_class c
        ON c.oid = pol.polrelid
    JOIN pg_namespace n
        ON n.oid = c.relnamespace
    WHERE n.nspname NOT LIKE 'pg_%'
      AND n.nspname <> 'information_schema'

)

SELECT
    object_type,
    schema_name,
    object_name,
    owner,
    parent_object,
    details
FROM object_inventory
ORDER BY
    schema_name NULLS FIRST,
    object_type,
    object_name;

-------------------------------------------------------------------------------
--- For a simple object-count report
--- After running the above, this query gives you a quick inventory by type:
-------------------------------------------------------------------------------

SELECT
    object_type,
    COUNT(*) AS object_count
FROM (
    /* Put the inventory CTE from the previous query here */
) x
GROUP BY object_type
ORDER BY object_type;