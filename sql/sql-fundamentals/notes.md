# Course Notes: SQL Fundamentals

**Course:** Complete SQL Course 2025 [Beginners] + Challenges + Lots of Practice

This document contains all theoretical notes, definitions, and syntax covered throughout the course.

---

## LESSON 0 - INSTALLATIONS

### Installation Links (0 - 4 min)
- **SQL Server:** Download version 2019 (Express) from the official Microsoft website.
    - *Note:* I used the 2025 version.
- **SSMS (SQL Server Management Studio):** Download version 19.
    - *Note:* I used the 2022 version.

---

## LESSON 1 - RESTORING A DATABASE

### Restoring a Database
1.  **Backup:** Download the `.bak` file of the AdventureWorks2017 database.
2.  **Location:** Move the `.bak` file to a folder, for example, `C:\SQLBackups\`.
3.  **Restoration in SSMS:**
    - Right-click on **Databases** > **Restore Database...**.
    - Under **Source**, select **Device** and click the three dots (`...`).
    - In the **Select backup devices** window, click **Add**.
    - In the **Backup File location** field, type the folder path (e.g., `C:\SQLBackups\`) and press Enter.
    - Select the `.bak` file and click **Ok**.
4.  **Finalization:** The database will be available. Refresh and navigate through its tables.
    - *Tip:* Right-clicking a table and selecting **Select Top 1000 Rows** automatically generates the query and its results.

---

## LESSON 2 - SELECT + CHALLENGES

### Selecting Tabular Data
- To create a new query, right-click on the database and select **New Query**.

**Basic Syntax:**
**All columns:**
```sql
SELECT *
FROM table_name;
```

**Specific columns:**
```sql
SELECT column1, column2
FROM table_name;
```

---

## LESSON 3 - DISTINCT + CHALLENGES

### Selecting Unique Data
- The `DISTINCT` command is used to omit duplicate data, returning only unique values.

**Syntax:**
```sql
SELECT DISTINCT column
FROM table_name;
```

---

## LESSON 4 - WHERE + CHALLENGES

### Filtering Data with Conditions
- The `WHERE` clause is used to filter query results based on specific conditions.

**Syntax:**
```sql
SELECT column1, column2
FROM table_name
WHERE condition;
```

**Comparison and Logical Operators:**

- `=`   : Equal
- `>`   : Greater than
- `<`   : Less than
- `>=`  : Greater than or equal to
- `<=`  : Less than or equal to
- `<>`  : Not equal to
- `AND` : Logical "AND" operator
- `OR`  : Logical "OR" operator

**Example with multiple conditions:**
```sql
SELECT *
FROM Table.Name
WHERE column1 = 'info1' AND column2 = 'info2';
```

---

## LESSON 5 - COUNT + CHALLENGES

### Counting Rows
- The `COUNT` function returns the number of rows that match a criteria.

**Syntax:**

**Count all rows in the table:**
```sql
SELECT COUNT(*)
FROM table_name;
```

**Count non-null values in a column:**
```sql
SELECT COUNT(column)
FROM table_name;
```

**Count unique and non-null values:**
```sql
SELECT COUNT(DISTINCT column)
FROM table_name;
```

---

## LESSON 6 - TOP + CHALLENGES

### Limiting Results
- The `TOP` command limits the number of rows returned in a query.

**Syntax (to return the first 10 rows):**
```sql
SELECT TOP 10 *
FROM table_name;
```

---

## LESSON 7 - ORDER BY + CHALLENGES

### Sorting Results
- `ORDER BY` allows you to sort query results in ascending (`ASC`) or descending (`DESC`) order.

**Syntax:**
```sql
SELECT column1, column2
FROM table_name
ORDER BY column1 ASC/DESC;
```

---

## LESSON 8 - BETWEEN

### Filtering by Range
- The `BETWEEN` operator is used to find values within a range (minimum and maximum).
- Works like: `value >= minimum AND value <= maximum`.

**Syntax:**
```sql
SELECT column
FROM table_name
WHERE column BETWEEN min_value AND max_value;
```

---

## LESSON 9 - IN

### Filtering by a List of Values
- The `IN` operator is used with `WHERE` to check if a value matches any value in a list.

**Syntax:**
```sql
SELECT column
FROM table_name
WHERE column IN ('value1', 'value2', 'value3');
```

---

## LESSON 10 - LIKE

### Searching for Text Patterns
- The `LIKE` operator is used to search for specific patterns in text columns.
- `%` : Represents zero, one, or multiple characters.
- `_` : Represents a single character.

**Examples:**

**Starts with "ovi":**
```sql
WHERE column LIKE 'ovi%'
```

**Ends with "ro" and has one more letter:**
```sql
WHERE column LIKE '%ro_'
```

**Contains "essa" anywhere:**
```sql
WHERE column LIKE '%essa%'
```

---

## LESSON 11 - SQL FUNDAMENTALS CHALLENGES
*(Challenges solved in the SQL script)*

---

## LESSON 12 - MIN, MAX, SUM, AVG

### Aggregate Functions
- Aggregate or combine data from a table into a single result.

**Syntax:**
```sql
SELECT SUM(column) AS 'Sum' FROM table;
SELECT MIN(column) AS 'Minimum' FROM table;
SELECT MAX(column) AS 'Maximum' FROM table;
SELECT AVG(column) AS 'Average' FROM table;
```

---

## LESSON 13 - GROUP BY + CHALLENGES

### Grouping Data
- `GROUP BY` divides the query result into groups.
- Typically used with aggregate functions (like `COUNT`, `SUM`, `AVG`) to calculate metrics per group.

**Syntax:**
```sql
SELECT column_to_group_by, aggregate_function(column_to_calculate)
FROM table_name
GROUP BY column_to_group_by;
```

---

## LESSON 14 - HAVING + CHALLENGES

### Filtering Groups
- `HAVING` is used in conjunction with `GROUP BY` to filter the results of a grouping. It works like a `WHERE` for grouped data.
- The key difference is that `WHERE` filters rows before grouping, while `HAVING` filters groups after.

**Syntax:**
```sql
SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1
HAVING group_filter_condition;
```

**Example:**
```sql
SELECT FirstName, COUNT(FirstName) as 'Count'
FROM Person.Person
GROUP BY FirstName
HAVING COUNT(FirstName) > 10;
```

---

## LESSON 15 - AS + CHALLENGES

### Renaming Columns
- The `AS` keyword is used to temporarily rename a column or table in the query result (creating an alias).

**Syntax:**
```sql
SELECT column AS 'NewName'
FROM table;
```

---

## LESSON 16 - INNER JOIN + CHALLENGES

### Joining Tables (Part 1)
- **`INNER JOIN`** : Returns only the records that have matching values in *both* tables involved in the join.
- **Primary Key (PK)** : Uniquely identifies each row in its table.
- **Foreign Key (FK)** : A reference to the primary key of another table.

**Syntax:**
```sql
SELECT A.ColumnA, A.ColumnX, B.ColumnY
FROM TableA A
INNER JOIN TableB B ON B.ForeignKey = A.PrimaryKey;
```
*(In this example, `A` and `B` are table aliases)*

---

## LESSON 17 & 18 - JOIN TYPES & OUTER JOIN

### Joining Tables (Part 2)

- **`INNER JOIN`** : Returns only matching records from both tables.
- **`FULL OUTER JOIN`** : Returns all records from both tables. Fills with `NULL` where there is no match.
- **`LEFT OUTER JOIN`** (or `LEFT JOIN`) : Returns *all* records from the left table (`FROM`) and the matching ones from the right table. Fills with `NULL` when there is no match.
- **`RIGHT OUTER JOIN`** (or `RIGHT JOIN`) : The opposite of `LEFT JOIN`. Returns all records from the right table.

---

## LESSON 19 - UNION + CHALLENGES

### Combining Query Results
- The `UNION` operator combines the results of two or more `SELECT` queries into a single result set.

**Rules:**
- The selected columns must have the *same number* and *compatible data types*.
- `UNION` automatically removes duplicate rows. To keep duplicates, use `UNION ALL`.

**Syntax:**
```sql
SELECT column1, column2 FROM table1
UNION
SELECT column1, column2 FROM table2;
```

---

## LESSON 20 - SELF JOIN + CHALLENGES

### Joining a Table with Itself
- `SELF JOIN` is used to compare records within the *same* table. It works like a Cartesian product of the table with itself and is created by using different aliases for the same table.

**General Syntax:**
```sql
SELECT A.column, B.column
FROM table_name A, table_name B
WHERE join_condition;
```

---

## LESSON 21 - SUBQUERIES (SUBSELECT) + CHALLENGES

### Nested Queries
- A **Subquery** (or Subselect) is a `SELECT` query inside another SQL query. It's used to create more dynamic and complex queries.

**Example:**
```sql
SELECT *
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);
```

---

## LESSON 22 - DATEPART + CHALLENGES (ADVANCED)

### Working with Dates
- The `DATEPART` function is used to extract specific parts from a date (year, month, day, etc.).

**Syntax:**
```sql
DATEPART(part, date)
```
*(Examples of `part`: `year`, `month`, `day`)*

**Example:**
```sql
SELECT SalesOrderID, DATEPART(month, OrderDate) as Month
FROM Sales.SalesOrderHeader;
```

---

## LESSON 23 - STRING MANIPULATION (ADVANCED)

### Text Functions

- **`CONCAT`** : Joins two or more strings.
- **`UPPER` / `LOWER`** : Converts the string to uppercase/lowercase.
- **`LEN`** : Returns the number of characters in a string.
- **`SUBSTRING`** : Extracts a portion of a string.
- **`REPLACE`** : Replaces all occurrences of a substring with another.

---

## LESSON 24 - MATHEMATICAL OPERATIONS (ADVANCED)

### Mathematical Functions

- **Operators:** `+`, `-`, `*`, `/`.
- **`ROUND`** : Rounds a number to a specific number of decimal places.
- **`SQRT`** : Returns the square root of a number.

---

## LESSON 25 - DATA TYPES (ADVANCED)

### Main Categories in SQL Server

**Boolean:**
- **`BIT`** : Can be 0, 1, or NULL.

**Character:**
- **`CHAR(n)`** : Fixed length. Always occupies the reserved space (`n`).
- **`VARCHAR(n)` / `NVARCHAR(n)`** : Variable length. Only uses the space that is filled. `NVARCHAR` supports Unicode characters.

**Numeric:**

*Exact:*
- `TINYINT`, `SMALLINT`, `INT`, `BIGINT` : Integers.
- `NUMERIC`/`DECIMAL(p,s)` : Allows fractional part, with precision `p` and scale `s`.

*Approximate:*
- `REAL`, `FLOAT` : Floating-point numbers with approximate precision.

**Temporal:**
- **`DATE`** : Date (year/month/day).
- **`DATETIME`** : Date and time.
- **`DATETIME2`** : Date and time with more precision.
- **`SMALLDATETIME`** : Date and time with a smaller range (`1900-01-01` to `2079-06-06`).
- **`TIME`** : Time only.
- **`DATETIMEOFFSET`** : Date, time, and timezone offset.

---

## LESSON 26 - PRIMARY AND FOREIGN KEYS (ADVANCED)

### Referential Integrity

- **`PRIMARY KEY`** : A column (or set of columns) that uniquely identifies each row in a table. It's a combination of `NOT NULL` and `UNIQUE`. Creates a unique index.

- **`FOREIGN KEY`** : A column (or set of columns) that uniquely identifies a row in *another* table. It's a reference to the primary key of another table (the parent table). Maintains referential integrity between tables.

---

## LESSON 27 - CREATE TABLE

### Creating New Tables
**Syntax:**
```sql
CREATE TABLE table_name (
    column1 data_type constraint,
    column2 data_type constraint,
    ...
);
```

**Main Constraints:**

- **`NOT NULL`** : Ensures the column does not have null values.
- **`UNIQUE`** : Ensures all values in the column are different from each other.
- **`PRIMARY KEY`** : Combination of `NOT NULL` and `UNIQUE`. Uniquely identifies the row.
- **`FOREIGN KEY`** : Uniquely identifies a row in another table. Maintains referential integrity.
- **`CHECK`** : Ensures the values in a column satisfy a specific condition.
- **`DEFAULT`** : Provides a default value for the column when no value is specified during insertion.

---

## LESSON 28 - INSERT INTO

### Inserting Data

**Syntax for inserting specific data:**
```sql
INSERT INTO table_name (column1, column2, ...)
VALUES
    (value1, value2, ...),
    (value1, value2, ...);
```

**Syntax for inserting data from another table:**
```sql
INSERT INTO destination_table (column1)
SELECT column2
FROM source_table;
```

---

## LESSON 29 - UPDATE

### Updating Data
**Syntax:**
```sql
UPDATE table_name
SET column1 = value1,
    column2 = value2
WHERE condition;
```
*Important: Without `WHERE`, all records in the table will be updated!*

---

## LESSON 30 - DELETE

### Deleting Data
**Syntax:**
```sql
DELETE FROM table_name
WHERE condition;
```
*Important: Without `WHERE`, all records in the table will be deleted!*

---

## LESSON 31 - ALTER TABLE

### Modifying Table Structure
The `ALTER TABLE` command is used to modify the structure of an existing table.

**Common Actions:**

**Add a column:**
```sql
ALTER TABLE table_name
ADD column_name data_type;
```

**Change a column's data type:**
```sql
ALTER TABLE table_name
ALTER COLUMN column_name new_data_type;
```

**Rename a column (using `sp_rename`):**
```sql
EXEC sp_RENAME 'table_name.current_column_name', 'new_column_name', 'COLUMN';
```

**Rename a table (using `sp_rename`):**
```sql
EXEC sp_rename 'current_name', 'new_name';
```

---

## LESSON 32 - DROP TABLE

### Deleting Tables

- **`DROP TABLE table_name;`** : Deletes the table and its structure from the database. You cannot drop a table that is referenced by a foreign key from another table.

- **`TRUNCATE TABLE table_name;`** : Removes all data from the table but keeps its structure (columns, constraints, etc.).

---

## LESSON 33 - CHECK CONSTRAINT

### Ensuring Valid Values
- The `CHECK` constraint is used to limit the range of values that can be placed in a column.

**Example:**
```sql
CREATE TABLE DriverLicense (
    Id INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Age INT CHECK (Age >= 18)
);
```

---

## LESSON 34 - NOT NULL CONSTRAINT

### Preventing Null Values
- The `NOT NULL` constraint forces the column to always have a value, preventing the insertion of records with empty fields.

**Example:**
```sql
CREATE TABLE DriverLicense (
    Id INT NOT NULL,
    Name VARCHAR(255) NOT NULL
);
```

---

## LESSON 35 - UNIQUE CONSTRAINT

### Ensuring Unique Values
- The `UNIQUE` constraint ensures that all values in a column are different. Unlike `PRIMARY KEY`, there can be multiple columns with the `UNIQUE` constraint.

**Example:**
```sql
CREATE TABLE DriverLicense (
    Id INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    LicenseCode INT NOT NULL UNIQUE
);
```

---

## LESSON 36 - VIEWS

### Creating Virtual Tables
- A `VIEW` is a virtual table created from the result of a SQL query. It's very useful for simplifying complex queries or for creating a security layer by exposing only specific data.

**Syntax:**
```sql
CREATE VIEW [ViewName] AS
SELECT column1, column2
FROM base_table
WHERE condition;
```

**Example:**
```sql
CREATE VIEW [Simplified People] AS
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE Title = 'Ms.';
```

---

## FINAL REMARKS
*(End of course notes)*