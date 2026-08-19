```sql
SHOW VARIABLES LIKE '%%secure_file_priv%%';
DESCRIBE EMPLOYEE;

CREATE INDEX idx_department ON Employee(department);
SHOW INDEX FROM Employee;
DROP INDEX DEPARTMENT_ID ON Employee;

```

---

```sql
CREATE TEMPORARY TABLE IF NOT EXISTS EMP LIKE EMPLOYEE;
```

```sql
CREATE TEMPORARY TABLE tmp AS
WITH dating AS (
    SELECT STR_TO_DATE('2023-01-01', '%Y-%m-%d') AS STRING_TO_DATE,
           DATE_FORMAT(NOW(), '%Y-%m-%d') AS DATE_TO_STRING
)
SELECT * FROM dating;

DESCRIBE tmp;
```

---

```sql
CREATE OR REPLACE VIEW dating_view AS
WITH dating AS (
    SELECT STR_TO_DATE('2023-01-01', '%Y-%m-%d') AS STRING_TO_DATE,
           DATE_FORMAT(NOW(), '%Y-%m-%d') AS DATE_TO_STRING
)
SELECT * FROM dating;

DESCRIBE dating_view;
```
