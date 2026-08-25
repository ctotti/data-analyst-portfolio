-- =============================================
-- Author: Camila Totti
-- Date: 2026-06-13
-- Description: Practical SQL scripts for the SQL Fundamentals course.
-- Database: AdventureWorks2017
-- Environment: SQL Server 2022 + SSMS
-- =============================================

-- =============================================
-- LESSON 02 - SELECT
-- =============================================

-- Selecting all columns from a table
SELECT *
FROM person.Person;

-- Selecting a specific column from a table
SELECT Title
FROM person.Person;

-- Activity: Extract the first name and last name of customers
SELECT FirstName, LastName
FROM Person.Person;


-- =============================================
-- LESSON 03 - DISTINCT
-- =============================================

-- Selecting unique values from a column
SELECT DISTINCT FirstName
FROM Person.Person;

-- Activity: Check how many unique last names exist in the Person.Person table
SELECT DISTINCT LastName
FROM Person.Person;


-- =============================================
-- LESSON 04 - WHERE
-- =============================================

/*
Comparison and Logical Operators:
=  : Equal
>  : Greater than
<  : Less than
>= : Greater than or equal to
<= : Less than or equal to
<> : Not equal to
AND : Logical AND
OR  : Logical OR
*/

-- Selecting information with AND operator
SELECT *
FROM Person.Person
WHERE LastName = 'Miller' AND FirstName = 'Anna';

-- Selecting information with OR operator
SELECT *
FROM Production.Product
WHERE Color = 'blue' OR Color = 'black';

-- Selecting information with > operator
SELECT *
FROM Production.Product
WHERE ListPrice > 1500;

-- Selecting information with > and < operators
SELECT *
FROM Production.Product
WHERE ListPrice > 1500 AND ListPrice < 5000;

-- Selecting information with <> operator (NOT EQUAL TO)
SELECT *
FROM Production.Product
WHERE Color <> 'red';

/*
ACTIVITIES

Activity 1: The production team needs the name of all parts 
that weigh more than 500kg but less than 700kg for inspection.

Activity 2: Marketing requested a list of all employees 
who are married and salaried.

Activity 3: A user named Peter Krebs owes a payment, 
get his email so we can send a collection notice.
*/

-- Activity 1
SELECT *
FROM Production.Product
WHERE Weight > 500 AND Weight < 700;

-- Activity 2
SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus = 'M' AND SalariedFlag = 1;

-- Activity 3
SELECT *
FROM Person.Person
WHERE FirstName = 'Peter' AND LastName = 'Krebs';

SELECT *
FROM Person.EmailAddress
WHERE BusinessEntityID = 26;


-- =============================================
-- LESSON 05 - COUNT
-- =============================================

-- Counting all rows in a table
SELECT COUNT(*)
FROM Person.Person;

-- Counting all rows in a column of a table
SELECT COUNT(Title)
FROM Person.Person;

-- Counting unique information in a table column
SELECT COUNT(DISTINCT Title)
FROM Person.Person;

/*
ACTIVITIES

Activity 1: How many products do we have registered in our products table?

Activity 2: How many product sizes do we have registered in our table?
*/

-- Activity 1
SELECT COUNT(*)
FROM Production.Product;

-- Activity 2
SELECT COUNT(Size)
FROM Production.Product;


-- =============================================
-- LESSON 06 - TOP
-- =============================================

-- Limiting the first 10 rows returned from a table
SELECT TOP 10 *
FROM Production.Product;


-- =============================================
-- LESSON 07 - ORDER BY
-- =============================================

-- Selecting names in ascending order
SELECT *
FROM Person.Person
ORDER BY FirstName ASC;

-- Selecting names in descending order
SELECT *
FROM Person.Person
ORDER BY FirstName DESC;

-- Selecting names in ascending order and last names in descending order
SELECT *
FROM Person.Person
ORDER BY FirstName ASC, LastName DESC;

-- It's possible to order by columns not selected in the view
-- Although not recommended by best practices
SELECT FirstName, LastName
FROM Person.Person
ORDER BY MiddleName ASC;

/*
ACTIVITIES

Activity 1: Get the ProductId of the 10 most expensive products in the system,
listing from most expensive to cheapest

Activity 2: Get the name and number of products with ProductID between 1 and 4
*/

-- Activity 1
SELECT TOP 10 ProductID, ListPrice
FROM Production.Product
ORDER BY ListPrice DESC;

-- Activity 2 (my solution)
SELECT ProductID, Name, ProductNumber
FROM Production.Product
WHERE ProductID >= 1 AND ProductID <= 4;

-- Activity 2 (instructor's solution)
SELECT TOP 4 ProductId, Name, ProductNumber
FROM Production.Product
ORDER BY ProductID ASC;


-- =============================================
-- LESSON 08 - BETWEEN
-- =============================================

-- Selecting values between 1000 and 1500
SELECT *
FROM Production.Product
WHERE ListPrice BETWEEN 1000 AND 1500;

-- Selecting values not between 1000 and 1500
SELECT *
FROM Production.Product
WHERE ListPrice NOT BETWEEN 1000 AND 1500;

-- Selecting dates between 01/01/2009 and 01/01/2010
SELECT *
FROM HumanResources.Employee
WHERE HireDate BETWEEN '2009/01/01' AND '2010/01/01'
ORDER BY HireDate;


-- =============================================
-- LESSON 09 - IN
-- =============================================

-- Selecting rows with specific values within a given column
SELECT *
FROM Person.Person
WHERE BusinessEntityID IN (2, 7, 13);

-- Selecting rows that DO NOT contain specific values within a given column
SELECT *
FROM Person.Person
WHERE BusinessEntityID NOT IN (2, 7, 13);


-- =============================================
-- LESSON 10 - LIKE
-- =============================================

/*
Pattern Matching Operators:
% : Represents zero, one, or multiple characters
_ : Represents a single character
*/

-- Selecting rows from a column that start with 'ovi' in the string
SELECT *
FROM Person.Person
WHERE FirstName LIKE 'ovi%';

-- Selecting rows from a column that end with 'to' in the string
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%to';

-- Selecting rows from a column that have 'essa' in the middle of the string
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%essa%';

-- Selecting rows from a column that end with 'ro' and one more letter
SELECT *
FROM Person.Person
WHERE FirstName LIKE '%ro_';


-- =============================================
-- LESSON 11 - SQL FUNDAMENTALS CHALLENGES
-- =============================================

/*
ACTIVITIES

Activity 1: How many products do we have in the system that cost more than 1500 dollars?

Activity 2: How many people have a last name that starts with the letter P?

Activity 3: In how many unique cities are our customers registered?

Activity 4: What are the unique cities registered in our system?

Activity 5: How many red products have a price between 500 and 1000 dollars?

Activity 6: How many products have the word 'road' in their name?
*/

-- Activity 1 (my solution)
SELECT COUNT(*)
FROM Production.Product
WHERE ListPrice >= 1500;

-- Activity 1 (instructor's solution)
SELECT COUNT(ListPrice)
FROM Production.Product
WHERE ListPrice >= 1500;

-- Activity 2 (my solution)
SELECT COUNT(*)
FROM Person.Person
WHERE LastName LIKE 'P%';

-- Activity 2 (instructor's solution)
SELECT COUNT(LastName)
FROM Person.Person
WHERE LastName LIKE 'P%';

-- Activity 3
SELECT COUNT(DISTINCT City)
FROM Person.Address;

-- Activity 4
SELECT DISTINCT City
FROM Person.Address;

-- Activity 5
SELECT COUNT(*)
FROM Production.Product
WHERE ListPrice BETWEEN 500 AND 1000
AND Color = 'Red';

-- Activity 6
SELECT COUNT(*)
FROM Production.Product
WHERE Name LIKE '%road%';


-- =============================================
-- LESSON 12 - MIN, MAX, SUM, AVG
-- =============================================

-- Aggregate functions
-- Note: The 'TOP 10' is irrelevant in this context, as aggregate functions
-- calculate the result over all rows from the FROM clause

-- Sums all values from the LineTotal column as 'Sum'
SELECT TOP 10 SUM(LineTotal) AS 'Sum'
FROM Sales.SalesOrderDetail;

-- Lowest value from the LineTotal column
SELECT TOP 10 MIN(LineTotal) AS 'Minimum'
FROM Sales.SalesOrderDetail;

-- Highest value from the LineTotal column
SELECT TOP 10 MAX(LineTotal) AS 'Maximum'
FROM Sales.SalesOrderDetail;

-- Average value from the LineTotal column
SELECT TOP 10 AVG(LineTotal) AS 'Average'
FROM Sales.SalesOrderDetail;


-- =============================================
-- LESSON 13 - GROUP BY
-- =============================================

-- Grouping all Offer ID values and summing the unit prices based on the Offer ID groups
SELECT SpecialOfferID, SUM(UnitPrice) AS "SUM"
FROM Sales.SalesOrderDetail
GROUP BY SpecialOfferID;

-- Viewing all offer IDs with value 9 and the unit prices of those offer 9
SELECT SpecialOfferID, UnitPrice
FROM Sales.SalesOrderDetail
WHERE SpecialOfferID = 9;

-- Checking how much of each product has been sold so far
SELECT ProductId, COUNT(ProductId) AS 'COUNT'
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

-- Checking how many of each first name we have registered in the database
SELECT FirstName, COUNT(FirstName) AS 'COUNT'
FROM Person.Person
GROUP BY FirstName;

-- Checking the average price of silver products in the production.product table
SELECT Color, AVG(ListPrice) "PRICE"
FROM Production.Product
WHERE Color = 'Silver'
GROUP BY Color;

/*
ACTIVITIES

Activity 1: How many people have the same MiddleName, grouped by MiddleName

Activity 2: On average, what is the quantity in which each product is sold in the store?

Activity 3: What were the 10 sales that had the highest total sales values (line total) per product, from highest to lowest?

Activity 4: How many products and what is the average quantity of products registered in the work orders, grouped by productId?
*/

-- Activity 1
SELECT MiddleName, COUNT(MiddleName) 'COUNT'
FROM Person.Person
GROUP BY MiddleName;

-- Activity 2
SELECT ProductID, AVG(OrderQty) 'Average'
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

-- Activity 3
SELECT TOP 10 ProductID, SUM(LineTotal) 'SUM' 
FROM Sales.SalesOrderDetail
GROUP BY ProductID 
ORDER BY SUM(LineTotal) DESC;

-- Activity 4
-- number of products | average quantity registered | grouped by productId
SELECT 
    ProductID, 
    COUNT(ProductID) 'COUNT', 
    AVG(OrderQty) 'AVERAGE'
FROM Production.WorkOrder
GROUP BY ProductID;


-- =============================================
-- LESSON 14 - HAVING
-- =============================================

-- Which names in the system have more than 10 occurrences
SELECT FirstName, COUNT(FirstName) as 'Count'
FROM Person.Person
GROUP BY FirstName
HAVING COUNT(FirstName) > 10;

-- Which products have total sales between 162k and 500k?
SELECT ProductID, SUM(LineTotal) as 'TOTAL'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) BETWEEN 162000 AND 500000;

-- Where to use WHERE and where to use HAVING
-- Which names in the system have more than 10 occurrences, but only where the title is 'Mr.'
SELECT FirstName, COUNT(FirstName) as 'Count'
FROM Person.Person
WHERE Title = 'Mr.'  -- WHERE comes before GROUP BY
GROUP BY FirstName
HAVING COUNT(FirstName) > 10;

/*
ACTIVITIES

Activity 1: We want to identify the provinces (stateProvinceId) with the highest number of registrations in our system. To do this, we need to find which provinces (stateProvinceId) are registered in the database more than 1000 times.

Activity 2: Since this is a multinational, managers want to know which products (productId) are not bringing in an average of at least 1 million in total sales (lineTotal).
*/

-- Activity 1
SELECT StateProvinceID, COUNT(StateProvinceID) as 'CountSPID'
FROM Person.Address
GROUP BY StateProvinceID
HAVING COUNT(StateProvinceID) > 1000
ORDER BY COUNT(StateProvinceID) DESC;

-- Activity 2
-- productId not bringing in an average of at least 1 million in total sales lineTotal
SELECT ProductID, AVG(LineTotal) AS 'AVERAGE'
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING AVG(LineTotal) < 1000000
ORDER BY AVG(LineTotal) ASC;


-- =============================================
-- LESSON 15 - AS
-- =============================================

-- Used to rename columns
SELECT TOP 10 AVG(ListPrice) AS 'Average Price'
FROM Production.Product;


-- =============================================
-- LESSON 16 - INNER JOIN
-- =============================================

-- Getting BusinessEntityId, FirstName, LastName, EmailAddress
-- The first 3 columns come from the Person.Person table and the last column
-- comes from the Person.EmailAddress table
SELECT P.BusinessEntityID, P.FirstName, P.LastName, PE.EmailAddress
FROM Person.Person AS P
INNER JOIN Person.EmailAddress PE ON P.BusinessEntityID = PE.BusinessEntityID;

-- Getting product names and their subcategory information
-- ListPrice, Product Name, Subcategory Name
SELECT Pr.ListPrice, Pr.Name, PC.Name
FROM Production.Product Pr
INNER JOIN Production.ProductSubcategory PC 
    ON PC.ProductSubcategoryID = Pr.ProductSubcategoryID;

-- Joining all information from two tables
-- Just do a join without defining specific columns
SELECT TOP 10 *
FROM Person.BusinessEntityAddress BA
INNER JOIN Person.Address PA ON PA.AddressID = BA.AddressID;

/*
ACTIVITIES

Activity 1: Get a table with columns BusinessEntityId, Name, PhoneNumberTypeId, PhoneNumber from the Person.PhoneNumberType and Person.PersonNumber tables

Activity 2: Get a table with columns AddressId, City, StateProvinceId, State Name from the Person.StateProvince and Person.Address tables
*/

-- Activity 1
SELECT PP.BusinessEntityID, PN.Name, PN.PhoneNumberTypeID, PP.PhoneNumber
FROM Person.PersonPhone PP
INNER JOIN Person.PhoneNumberType PN ON
    PP.PhoneNumberTypeID = PN.PhoneNumberTypeID;

-- Activity 2
SELECT PA.AddressID, PA.City, PA.StateProvinceID, PSP.Name
FROM Person.Address PA
INNER JOIN Person.StateProvince PSP ON
    PA.StateProvinceID = PSP.StateProvinceID;


-- =============================================
-- LESSON 17 & 18 - JOIN TYPES & OUTER JOIN
-- =============================================

-- LEFT OUTER JOIN (or simply LEFT JOIN)
-- Find out which people have a registered credit card
SELECT *
FROM Person.Person PP
LEFT JOIN Sales.PersonCreditCard PC ON
    PP.BusinessEntityID = PC.BusinessEntityID;

-- INNER JOIN: 19118 rows (brings only rows with registered credit card)
-- LEFT JOIN:  19972 rows (brings rows without registered credit card as well)

-- 854 people who don't have a registered credit card
SELECT 19972 - 19118; 


-- =============================================
-- LESSON 19 - UNION
-- =============================================

-- Example 1: Combining queries from two tables
SELECT [ProductID], [Name], [ProductNumber]
FROM Production.Product 
WHERE Name LIKE '%Chain%'
UNION
SELECT [ProductID], [Name], [ProductNumber]
FROM Production.Product 
WHERE Name LIKE '%Decal%'
ORDER BY Name;

-- Example 2: Combining queries from two tables
SELECT FirstName, Title, MiddleName
FROM Person.Person
WHERE Title = 'Mr.'
UNION
SELECT FirstName, Title, MiddleName
FROM Person.Person
WHERE MiddleName = 'A';


-- =============================================
-- LESSON 20 - SELF JOIN
-- =============================================

-- Database: Northwind (named as 'CursoSQLJonathan')

-- Find all customers who live in the same region
SELECT A.ContactName, A.Region, B.ContactName, B.Region
FROM CUSTOMERS A, CUSTOMERS B
WHERE A.Region = B.Region;

-- Find (name and hire date) of all employees hired in the same year
SELECT A.FirstName, A.HireDate, B.FirstName, B.HireDate
FROM Employees A, Employees B
WHERE DATEPART(YEAR, A.HireDate) = DATEPART(YEAR, B.HireDate);

/*
ACTIVITY

Activity 1: In the Order Details table, find which products have the same discount percentage.
*/

-- Activity 1
SELECT A.productId, A.discount, B.productID, B.discount
FROM [Order Details] A, [Order Details] B
WHERE A.Discount = B.Discount;


-- =============================================
-- LESSON 21 - SUBQUERIES (SUBSELECT)
-- =============================================

-- Create a report of all registered products with a sale price above the average

-- Example without subqueries
SELECT AVG(ListPrice)
FROM Production.Product;

SELECT *
FROM Production.Product
WHERE ListPrice > 438.66;

-- Now with subqueries (subselect)
SELECT *
FROM Production.Product
WHERE ListPrice > (SELECT AVG(ListPrice) FROM Production.Product);

-- Name of employees who have the job title 'Design Engineer'
-- Problem: This solution is not dynamic
SELECT *
FROM Person.Person
WHERE BusinessEntityID IN (5, 6, 15);

SELECT *
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer';

-- Solution with SUBQUERIES (dynamic)
SELECT FirstName
FROM Person.Person
WHERE BusinessEntityID IN (
    SELECT BusinessEntityID 
    FROM HumanResources.Employee
    WHERE JobTitle = 'Design Engineer'
);

-- Alternative solution with JOIN
SELECT P.FirstName
FROM Person.Person P
INNER JOIN HumanResources.Employee E ON 
    P.BusinessEntityID = E.BusinessEntityID
    AND E.JobTitle = 'Design Engineer';

-- TIP: Select 'Display Estimated Execution Plan' to evaluate 
-- the best option in terms of processing performance

/*
ACTIVITY

Activity 1: Find all addresses that are in the state of 'Alberta'.
Feel free to bring all information.
*/

-- Activity 1
SELECT *
FROM Person.Address
WHERE StateProvinceID IN (
    SELECT StateProvinceID 
    FROM Person.StateProvince
    WHERE Name = 'Alberta'
);


-- =============================================
-- LESSON 22 - DATEPART
-- =============================================

-- Reference: https://learn.microsoft.com/en-us/sql/t-sql/functions/datepart-transact-sql

-- DATEPART can be used to get information from date columns
-- For example, extract the month, day, year...

SELECT SalesOrderID, DATEPART(month, OrderDate) as Month
FROM Sales.SalesOrderHeader;

SELECT SalesOrderID, DATEPART(day, OrderDate) as Day
FROM Sales.SalesOrderHeader;

SELECT SalesOrderID, DATEPART(year, OrderDate) as Year
FROM Sales.SalesOrderHeader;

-- Example: Organize the average amount due per month
SELECT AVG(TotalDue) as Average, DATEPART(month, OrderDate) as Month
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(month, OrderDate)
ORDER BY Month;

-- Example: Organize by year
SELECT AVG(TotalDue) as Average, DATEPART(year, OrderDate) as Year
FROM Sales.SalesOrderHeader
GROUP BY DATEPART(year, OrderDate)
ORDER BY Year;


-- =============================================
-- LESSON 23 - STRING MANIPULATION
-- =============================================

-- Reference: https://learn.microsoft.com/en-us/sql/t-sql/language-elements/string-operators-transact-sql

-- CONCAT: Join information from multiple columns
SELECT CONCAT(FirstName, ' ', LastName) as FullName
FROM Person.Person;

-- UPPER: Convert to uppercase
SELECT UPPER(FirstName) as NAME
FROM Person.Person;

-- LOWER: Convert to lowercase
SELECT LOWER(FirstName) as name
FROM Person.Person;

-- LEN: Get the length of a string
SELECT LEN(FirstName) as Length
FROM Person.Person;

-- SUBSTRING: Extract parts of strings
SELECT FirstName, SUBSTRING(FirstName, 1, 3) as Abbrev
FROM Person.Person;

-- REPLACE: Replace a string with another
SELECT ProductNumber, REPLACE(ProductNumber, '-', '#') as Replaced
FROM Production.Product;


-- =============================================
-- LESSON 24 - MATHEMATICAL OPERATIONS
-- =============================================

-- Common mathematical functions
-- Operators: + (addition), - (subtraction), * (multiplication), / (division)

SELECT UnitPrice + LineTotal
FROM Sales.SalesOrderDetail;

-- ROUND: Rounding
SELECT ROUND(LineTotal, 2), LineTotal
FROM Sales.SalesOrderDetail;

-- SQRT: Square root
SELECT SQRT(LineTotal)
FROM Sales.SalesOrderDetail;


-- =============================================
-- LESSON 25 - DATA TYPES
-- =============================================

-- (Theoretical lesson - no SQL code needed)
-- Reference in notes.md


-- =============================================
-- LESSON 26 - PRIMARY AND FOREIGN KEYS
-- =============================================

-- (Theoretical lesson - no SQL code needed)
-- Reference in notes.md


-- =============================================
-- LESSON 27 - CREATE TABLE
-- =============================================

-- Creating the YouTube Lite database with two tables: Channel and Video

-- Creating the Channel table
CREATE TABLE Channel (
    ChannelId INT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    SubscriberCount INT DEFAULT 0,
    CreationDate DATETIME NOT NULL
);

-- Creating the Video table
CREATE TABLE Video (
    VideoId INT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL,
    Views INT DEFAULT 0,
    Likes INT DEFAULT 0,
    Dislikes INT DEFAULT 0,
    Duration INT NOT NULL,
    ChannelId INT FOREIGN KEY REFERENCES Channel(ChannelId)
);


-- =============================================
-- LESSON 28 - INSERT INTO
-- =============================================

-- Creating a test table
CREATE TABLE Lesson(
    Id INT PRIMARY KEY,
    Name VARCHAR(200)
);

SELECT * FROM Lesson;

-- Inserting a single row of values
INSERT INTO Lesson(Id, Name)
VALUES(1, 'Lesson 1');

SELECT * FROM Lesson;

-- Inserting multiple rows of values
INSERT INTO Lesson(Id, Name)
VALUES
    (2, 'Lesson 2'),
    (3, 'Lesson 3'),
    (4, 'Lesson 4');

SELECT * FROM Lesson;

-- Creating a new table from data from another table
SELECT * INTO NewTable FROM Lesson;

SELECT * FROM NewTable;


-- =============================================
-- LESSON 29 - UPDATE
-- =============================================

SELECT * FROM Lesson;

-- Testing UPDATE without WHERE
UPDATE Lesson
SET Name = 'Test';

SELECT * FROM Lesson;

-- Testing UPDATE with WHERE
UPDATE Lesson
SET Name = 'Changed'
WHERE Id = 3;

SELECT * FROM Lesson;


-- =============================================
-- LESSON 30 - DELETE
-- =============================================

SELECT * FROM Lesson;

DELETE FROM Lesson
WHERE Name = 'Changed';

SELECT * FROM Lesson;


-- =============================================
-- LESSON 31 - ALTER TABLE
-- =============================================

-- Creating YouTube table
CREATE TABLE YouTube (
    Id INT PRIMARY KEY,
    Name VARCHAR(150) NOT NULL UNIQUE,
    Category VARCHAR(200) NOT NULL,
    CreationDate DATETIME NOT NULL
);

-- Add a column named Active of type BIT
ALTER TABLE YouTube
ADD Active BIT;

SELECT * FROM YouTube;

-- Change the limit of a column from 200 to 300 characters
ALTER TABLE YouTube
ALTER COLUMN Category VARCHAR(300) NOT NULL;

SELECT * FROM YouTube;

-- Rename a column
-- Run specific procedure: EXEC sp_RENAME 'currentTable.currentColumn', 'newColumnName', 'COLUMN'
EXEC sp_RENAME 'YouTube.Name', 'ChannelName', 'COLUMN';

SELECT * FROM YouTube;

-- Rename the table
EXEC sp_rename 'YouTube', 'YouTube2';

SELECT * FROM YouTube2;


-- =============================================
-- LESSON 32 - DROP TABLE
-- =============================================

-- Note: DROP TABLE and TRUNCATE TABLE are theoretical
-- They are documented in notes.md


-- =============================================
-- LESSON 33 - CHECK CONSTRAINT
-- =============================================

CREATE TABLE DriverLicense (
    Id INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Age INT CHECK (Age >= 18)
);

SELECT * FROM DriverLicense;

-- Trying to insert a value that doesn't meet the condition (error)
INSERT INTO DriverLicense (Id, Name, Age) 
VALUES (1, 'Rafael', 17);

-- Trying to insert a value that meets the condition (success)
INSERT INTO DriverLicense (Id, Name, Age) 
VALUES (1, 'Rafael', 18);

SELECT * FROM DriverLicense;


-- =============================================
-- LESSON 34 - NOT NULL CONSTRAINT
-- =============================================

-- Trying to create a row without a required (non-null) information (error)
INSERT INTO DriverLicense (Id, Name, Age) 
VALUES (1, NULL, 19);

-- Correct insertion
INSERT INTO DriverLicense (Id, Name, Age) 
VALUES (1, 'Jonathan', 19);


-- =============================================
-- LESSON 35 - UNIQUE CONSTRAINT
-- =============================================

-- Recreating the table with UNIQUE constraint
DROP TABLE DriverLicense;

CREATE TABLE DriverLicense (
    Id INT NOT NULL,
    Name VARCHAR(255) NOT NULL,
    Age INT CHECK (Age >= 18),
    LicenseCode INT NOT NULL UNIQUE
);

SELECT * FROM DriverLicense;

-- Valid insertion
INSERT INTO DriverLicense (Id, Name, Age, LicenseCode)
VALUES (1, 'Robert', 19, 123456);

-- Trying to create another row with duplicate license code (error)
INSERT INTO DriverLicense (Id, Name, Age, LicenseCode)
VALUES (2, 'Robert', 19, 123456);


-- =============================================
-- LESSON 36 - VIEWS
-- =============================================

CREATE VIEW [Simplified People] AS
SELECT FirstName, MiddleName, LastName
FROM Person.Person
WHERE Title = 'Ms.';

SELECT * FROM [Simplified People];


-- =============================================
-- FINAL REMARKS
-- =============================================
-- End of SQL Fundamentals course scripts