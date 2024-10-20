-- Recap SQL for DSA:

-- Refresher on how to perform basic query and how the database works:
-- SELECT Clause: everything = *
-- Select department table, the employee table and vendor table. Let's explore the database a little!

SELECT *
FROM humanresources.department;

SELECT *
FROM humanresources.employee;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT some columns:

-- Select only name, start time and end time.

SELECT 
	name,
	starttime,
	endtime
FROM humanresources.shift;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT DISTINCT values: Unique column value

-- Distinct group names from department and businessentityid from jobcandidate

SELECT DISTINCT groupname
FROM humanresources.department;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LIMIT: As the name suggest it limits the number of *rows* shown at the end result

-- Limit the table productvendor to 10 rows

SELECT *
FROM purchasing.productvendor
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT MDAS: Multiplcation/division/addition/subtraction

-- From the customer table Multiplcation/division/addition/subtraction the store_id

SELECT
	customerid,
	storeid * 10,
	storeid / 10,
	storeid + 10,
	storeid - 10
FROM sales.customer
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Q1: SELECT the DISTINCT title, last name, middlename and first_name of each person from the person schema. Return only 231 rows.
--A1;

SELECT DISTINCT
	title,
	lastname,
	middlename,
	firstname
FROM person.person
LIMIT 231;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: = 

SELECT 
	jobtitle,
	maritalstatus,
	gender
FROM humanresources.employee
WHERE gender = 'M';

-- When dealing with NULL values
SELECT *
FROM purchasing.productvendor
WHERE onorderqty IS NULL;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: Arithmetic filter

-- From customer table, territoryid = 4
SELECT DISTINCT territoryid
FROM sales.customer
WHERE territoryid = 4
-- WHERE territoryid <> 4
-- WHERE territoryid >= 4
-- WHERE territoryid <= 4
LIMIT 100;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: OR clause

-- From employee table, select either Design Engineer or Tool Designer
SELECT *
FROM humanresources.employee
WHERE jobtitle = 'Design Engineer'
	OR jobtitle = 'Tool Designer';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: AND clause

-- From employee, gender must be Male and maritalstatus must be single
SELECT * 
FROM humanresources.employee
WHERE gender = 'M'
	AND maritalstatus = 'S';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: Combined OR & AND clause

-- From the employee table pick either, marital status as single and gender male or marital status as married and gender female.
SELECT 
	jobtitle,
	gender,
	maritalstatus,
	vacationhours,
	sickleavehours
FROM humanresources.employee
WHERE (maritalstatus = 'S' AND gender = 'M') 
	OR (maritalstatus = 'M' AND gender = 'F');

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Example of poor formatting and logic using AND and OR clause
-- From the salesperson table select territory_id either 4 or 6 and salesquota either 250000 or 300000

SELECT *
FROM sales.salesperson
WHERE territoryid = 4 OR territoryid = 6 
	AND salesquota = 250000 OR salesquota = 300000; -- 7
	
SELECT *
FROM sales.salesperson
WHERE (territoryid = 4 OR territoryid = 6 )
	AND (salesquota = 250000 OR salesquota = 300000); -- 4

--Note: AND takes higher priority than OR

-- Reformatted version:
-- The importance of having good SQL formatting when writing your SQL code.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: IN clause
--Q: Find all the employees whose birthdate fall on these dates.

-- '1977-06-06'
-- '1984-04-30'
-- '1985-05-04'

SELECT *
FROM humanresources.employee
WHERE birthdate IN (
	'1977-06-06', 
	'1984-04-30', 
	'1985-05-04'
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: LIKE clause
-- The placement of the wildcard, %, affects what is getting filtered out.

-- From the person table, select all the firstname starting with a 'J'
-- Works very similar to excel find function

SELECT *
FROM person.person
-- WHERE firstname LIKE 'J%';
-- WHERE firstname LIKE '%J%';
WHERE firstname LIKE '%J';

-- But what if you know the number of letters in the firstname?

SELECT *
FROM person.person
WHERE firstname LIKE 'J___';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- We can use things like UPPER() and LOWER() clause

SELECT *
FROM person.person
-- WHERE LOWER(firstname) LIKE '%a%';
WHERE UPPER(firstname) LIKE '%A%';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: NOT clause

-- From the person table, lastname should not contain A in it.

SELECT *
FROM person.person
WHERE lastname NOT LIKE '%A%';

-- From the employee table, choose middle name that contain

SELECT *
FROM humanresources.employee
WHERE birthdate NOT IN (
	'1977-06-06', 
	'1984-04-30', 
	'1985-05-04'
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- GROUP BY clause: For aggregate values
-- For us to use when we want to use aggregates.

-- From employee table, group by gender

SELECT 
	gender
FROM humanresources.employee
GROUP BY gender;

-- We can also group more than one column

SELECT 
	gender,
	maritalstatus,
	jobtitle
FROM humanresources.employee
GROUP BY 
	gender,
	maritalstatus,
	jobtitle;
-- GROUP BY 1, 2, 3;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- All the AGGREGATES!

SELECT
	gender,
	
	COUNT(gender) AS headcount, -- 45 msec
	COUNT(*) AS headcount, -- 40 msec
	COUNT(1) AS headcount, -- 47 msec
	
	COUNT(jobtitle) AS jobtitle, -- This will just be the same as count(gender)
	COUNT(DISTINCT jobtitle) AS unique_jobtitle,
	
	SUM(vacationhours) AS total_vacation_hours,
	AVG(vacationhours) AS average_vacation_hours,
	MAX(sickleavehours) AS max_vacation_hours,
	MIN(sickleavehours) AS min_vacation_hours
	
	ROUND(AVG(vacationhours), 4) AS rounded_average,
	CEILING(AVG(vacationhours)) AS ceiling_average,
	FLOOR(AVG(vacationhours)) AS floor_average,

FROM humanresources.employee
GROUP BY gender; 

-- Q2: Analyse if the marital status of each gender affects the number of vacation hours one will take
-- A2:

SELECT 
	gender,
	maritalstatus,
	AVG(vacationhours) AS average_vacation_hours
FROM humanresources.employee
GROUP BY 1, 2;

-- From employee table, ORDER BY hiredate, ASC and DESC

SELECT *
FROM humanresources.employee
ORDER BY hiredate ASC; -- hiredate earliest

SELECT *
FROM humanresources.employee
ORDER BY hiredate DESC; -- hiredate latest

-- Sort table using two or more values

SELECT 
	jobtitle,
	gender
FROM humanresources.employee
ORDER BY jobtitle DESC, gender DESC;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- HAVING clause:
SELECT
	jobtitle,
	AVG(sickleavehours) AS sickleavehours
FROM humanresources.employee
-- WHERE AVG(sickleavehours) > 50 -- aggregate functions require the use of HAVING
GROUP BY jobtitle
HAVING AVG(sickleavehours) > 50;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q3: From the customer table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
-- A3:

SELECT 
	territoryid,
	COUNT(*) AS customers
FROM sales.customer
WHERE personid IS NOT NULL
	and storeid IS NOT NULL
GROUP BY territoryid
HAVING COUNT(*) > 40;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OFFSET: Using the employee table find the other the other employees except the top 10 oldest employees.
SELECT 
	jobtitle,
	birthdate
FROM humanresources.employee
ORDER BY birthdate ASC
OFFSET 10;

-- Q4: Another common whiteboard question, from the salesperson table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
-- A4:
SELECT
	terrtitoryid,
	bonus
FROM sales.salesperson
ORDER BY bonus DESC
LIMIT 1
OFFSET 1

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Best practise: When exploring a new table:
/*
	Why should we use the example mentioned below?
	1) We don't have to generate the entire table to understand what kind of information the table stores.
	2) Much faster using this compared to generating the entire multi-million row table
	3) So people don't think you are a noob
*/

SELECT * -- Select the necessary columns
FROM humanresources.employee
WHERE gender = 'M'
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: INNER 1

-- Inner join to get product information along with its subcategory name and category name

SELECT *
FROM production.product;

SELECT *
FROM production.productsubcategory;

SELECT *
FROM production.productcategory;

SELECT 
	product.productid,
	product.name AS productname, 
	productcategory.name AS categoryname,
	productsubcategory.name AS subcategoryname
FROM production.product AS product
INNER JOIN production.productsubcategory AS productsubcategory 
				ON product.productsubcategoryid = productsubcategory.productsubcategoryid
INNER JOIN production.productcategory AS productcategory
				ON productsubcategory.productcategoryid = productcategory.productcategoryid
ORDER BY 3, 4, 2;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: INNER 2
-- Let's create a base table in the humanresources schema, where we are able to get each employee's department history and department name

-- How I would like to approach the question! Finding out if there is any issue etc etc


-- Employee table -----------

SELECT *
FROM humanresources.employee;

-- Is it unique?
SELECT
	businessentityid,
	COUNT(*) AS duplicates
FROM humanresources.employee
GROUP BY businessentityid
HAVING COUNT(*) > 1;
-- Unique table!
-----------------------------

-- Employee Department History table

SELECT *
FROM humanresources.employeedepartmenthistory;

-- Is it unique?
SELECT 
	businessentityid,
	COUNT(*) AS duplicates
FROM humanresources.employeedepartmenthistory
GROUP BY businessentityid
HAVING COUNT(*) > 1;
-- Not Unique table!
-----------------------------

-- Department table----------

SELECT *
FROM humanresources.department;

-- No unique form one!
SELECT
	CONCAT(name, groupname) AS specialkey,
	COUNT(*) AS duplicates
FROM humanresources.department
GROUP BY CONCAT(name, groupname)
HAVING COUNT(*) > 1;
-- Unique table!
-----------------------------

-- Let's find all the employee, their respecitve departments and the time they served there. Bonus if you can find out the duration in days each employee spent
-- in each department! Duration in days cannot be NULL.

SELECT 
	employee.businessentityid,
	employee.jobtitle,
	employee.organizationnode,
	department.name AS department_name,
	department.groupname AS department_groupname,
	employeedepartmenthistory.startdate,
	employeedepartmenthistory.enddate,
	
	-- Bonus
	COALESCE(employeedepartmenthistory.enddate, CURRENT_DATE) - employeedepartmenthistory.startdate AS duration_days
	
FROM humanresources.employee AS employee
INNER JOIN humanresources.employeedepartmenthistory AS employeedepartmenthistory
				ON employee.businessentityid = employeedepartmenthistory.businessentityid
INNER JOIN humanresources.department AS department
				ON employeedepartmenthistory.departmentid = department.departmentid;
				
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JOINS: LEFT

-- Q5: List all employees and their associated email addresses,  
-- display their full name and email address.

SELECT 
	CONCAT(person.firstname, ' ', person.middlename, ' ', person.lastname) AS full_name,
	emailaddress.emailaddress AS email 
FROM humanresources.employee AS employee
LEFT JOIN person.person AS person
			 ON employee.businessentityid = person.businessentityid
LEFT JOIN person.emailaddress AS emailaddress
       ON employee.businessentityid = emailaddress.businessentityid;

-- Q6: Can LEFT JOIN cause duplication? How?
-- A6: It depends on the relationship that both tables share, if it is one to one unlikely and if one to many there could be
-- a chance for duplication.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: RIGHT
-- Write a query to retrieve all sales orders and their corresponding customers. If a sales order exists without an associated customer, 
-- include the sales order in the result.

SELECT 
    salesorderheader.salesorderid AS salesorderid, 
    salesorderheader.orderdate AS orderdate, 
    customer.customerid AS customerid, 
    customer.personid AS personid
FROM sales.salesorderheader AS salesorderheader
RIGHT JOIN sales.customer AS customer
				ON salesorderheader.customerid = customer.customerid;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: FULL OUTER JOIN

-- Write a query to retrieve a list of all employees and customers, and if either side doesn't have a FirstName, 
-- use the available value from the other side. Use FULL OUTER JOIN and COALESCE.

SELECT 
    COALESCE(employee.firstname, c.firstname) AS firstname,
    COALESCE(employee.lastname, c.lastname) AS lastname
FROM humanresources.employee AS employee
FULL OUTER JOIN sales.customer AS customer
						 ON employee.businessentityid = customer.personid;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: CROSS JOINS

-- Explanation: A CROSS JOIN in SQL combines every row from the first table with every row from the second table. This type of join creates a Cartesian product, 
-- meaning that if the first table has 10 rows and the second table has 5 rows, the result will have 10 * 5 = 50 rows. 
-- A CROSS JOIN does not require any relationship or matching columns between the two tables.

-- Example: Good for arranging one person to meet multiple people

-- Write a query to generate all possible combinations of product categories and product models. Show the category name and the model name.

SELECT 
	name
FROM production.productcategory;

SELECT 
	name
FROM production.productmodel;

SELECT 
    productcategory.name AS categoryname, 
    productionmodel.name AS modelname
FROM production.productcategory AS productcategory
CROSS JOIN production.productmodel AS productionmodel;

-- Each category name is matched to each model name

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNION, stacking the tables on top of each other without having duplicates

SELECT 
	firstname, 
	lastname, 
	CONCAT(firstname, ' ', middlename, ' ', lastname) AS fullname,
FROM person.person

UNION

SELECT 
	firstname, 
	lastname,
	CONCAT(firstname, ' ', middlename, ' ', lastname) AS fullname,
FROM person.person;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- UNION ALL: EVERYTHING

-- Write a query to retrieve all sales orders and purchase orders, displaying the order ID and order date. 
-- Use UNION ALL to combine the sales and purchase order data, keeping all duplicates.

SELECT 
	salesorderid AS orderid, 
	orderdate
FROM sales.salesorderheader

UNION ALL

SELECT 
	purchaseorderid AS orderid, 
	orderdate
FROM purchasing.purchaseorderheader;

-- Remember how they work and their functionalities

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STRING FUNCTION
-- DATE handling, CONCAT()

-- Getting parts of the date out

SELECT 
	EXTRACT(YEAR FROM orderdate) AS year,
	EXTRACT(QUARTER FROM orderdate) AS quarter,
	EXTRACT(MONTH FROM orderdate) AS month,
	EXTRACT(WEEK FROM orderdate) AS week,
	EXTRACT(DAY FROM orderdate) AS day,
	EXTRACT(HOUR FROM orderdate) AS hour,
	EXTRACT(MINUTE FROM orderdate) AS minute,
	EXTRACT(SECOND FROM orderdate) AS seconds,
	
	CAST(orderdate AS TIME) AS time,
	CAST(orderdate AS DATE) AS date
FROM sales.salesorderheader;

-- DATETIME manipulations

SELECT
	orderdate AT TIME ZONE 'UTC' AT TIME ZONE 'Asia/Singapore' AS local_time,
	CURRENT_DATE AS today,
	CURRENT_DATE + INTERVAL '10 days' AS add_days,
	CURRENT_DATE - INTERVAL '10 days' AS minus_days,
	CURRENT_DATE + INTERVAL '1 month' AS add_months
FROM sales.salesorderheader
WHERE territoryid = 1
	AND EXTRACT(YEAR FROM orderdate) = 2011;

-- Use string functions to format employee names and email addresses
SELECT
    CAST(person.businessentityid AS int),
		CAST(person.businessentityid AS numeric) / 2,
		CAST(person.businessentityid AS decimal) / 2,
		CAST(emailaddress.emailaddress AS VARCHAR(100)),
		
    UPPER(person.lastname) AS upperlastname,
		LOWER(person.lastname) AS lowerlastname,
		
    LENGTH(person.firstname) AS firstnamelength,
		
    LEFT(emailaddress.emailaddress, 10) AS endemail,
		RIGHT(emailaddress.emailaddress, 10) AS startemail,
		
		SUBSTRING(emailaddress.emailaddress, 1, 5) AS partialemail,
		REPLACE(emailaddress.emailaddress, '@adventure-works.com', '@gmail.com') AS new_email,
    CONCAT(person.firstname, ' ', person.lastname, person.firstname) AS fullname
		
FROM person.person AS person
INNER JOIN person.emailaddress AS emailaddress
				ON person.businessentityid = emailaddress.businessentityid;
				
-- From the following table write a query in  SQL to find the  email addresses of employees and groups them by city. 
-- Return top ten rows.

SELECT 
	address.city, 
	STRING_AGG(CAST(emailaddress.emailaddress AS VARCHAR(10485760)), ';') AS emails 
FROM person.businessentityaddress AS businessentityaddress  
INNER JOIN person.address AS address
				ON businessentityaddress.addressid = address.addressid
INNER JOIN person.emailaddress AS emailaddress 
				ON businessentityaddress.businessentityid = emailaddress.businessentityid
GROUP BY address.city
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--CASE FUNCTION: CASE WHEN THEN ELSE END

-- Write a query to categorize sales orders based on the total amount (TotalDue). If the total amount is less than 1000, categorize it as "Low", 
-- if it's between 1000 and 5000, categorize it as "Medium", and if it's greater than 5000, categorize it as "High".

SELECT 
    salesorderheader.salesorderid AS salesorderid, 
    salesorderheader.totaldue AS totaldue,
    CASE 
        WHEN salesorderheader.totaldue < 1000 THEN 'Low'
        WHEN salesorderheader.totaldue BETWEEN 1000 AND 5000 THEN 'Medium'
        ELSE 'High'
    END AS ordercategory
FROM sales.salesorderheader AS salesorderheader;

-- Q7: Write a query to calculate bonuses for each employee. The bonus is calculated based on both their total sales and their length of employment:

-- If an employee has sales greater than 500,000 and has been employed for more than 5 years, they get a 15% bonus.
-- If their sales are greater than 500,000 but they’ve been employed for less than 5 years, they get a 10% bonus.
-- If their sales are between 100,000 and 500,000, they get a 5% bonus, regardless of years of service.
-- If their sales are less than 100,000, they get no bonus.

-- A7:
SELECT 
    employee.businessentityid AS employeeid,
    employee.hiredate AS hiredate,
    COALESCE(SUM(salesorderheader.totaldue), 0) AS totalsales,
    CASE 
        WHEN COALESCE(SUM(salesorderheader.totaldue), 0) > 500000 
					AND DATEDIFF(YEAR, employee.hiredate, GETDATE()) > 5 THEN '15% Bonus'
        WHEN COALESCE(SUM(salesorderheader.totaldue), 0) > 500000 
					AND DATEDIFF(YEAR, employee.hiredate, GETDATE()) <= 5 THEN '10% Bonus'
        WHEN COALESCE(SUM(salesorderheader.totaldue), 0) BETWEEN 100000 AND 500000 THEN '5% Bonus'
        ELSE 'No Bonus'
    END AS bonus
FROM humanresources.employee AS employee
LEFT JOIN sales.salesorderheader AS salesorderheader
			 ON employee.businessentityid = salesorderheader.salespersonid
GROUP BY 
    employee.businessentityid,
    employee.hiredate;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- In this file we will cover the following advance stuff:

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Window Functions: AGGREGATES

/*
-- Explanation:
	A window function in SQL allows you to perform calculations across a set of table rows that are somehow related to the current row. 
	Unlike regular aggregate functions (such as SUM, COUNT, AVG), window functions do not group the result into a single output. 
	Instead, they return a value for every row while using a "window" of rows to perform the calculation.
*/

-- Let’s say we want to calculate the running total of sales for each salesperson, partitioned by their ID (so each salesperson gets their own total), 
-- and ordered by the order date.

SELECT *
FROM sales.salesorderheader;

SELECT 
    salesorderid,
    salespersonid,
    orderdate,
    totaldue,
    SUM(totaldue) OVER (PARTITION BY salespersonid ORDER BY orderdate) AS runningtotal
FROM sales.salesorderheader
WHERE salespersonid IS NOT NULL
ORDER BY 
    salespersonid, 
		orderdate;

-- Retrieving distinct active employee names along with salary statistics per department:

SELECT DISTINCT 
	department.name,
  MIN(rate) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS minsalary, -- Minimum salary per department
	MAX(rate) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS maxsalary, -- Maximum salary per department
	AVG(rate) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS avgsalary, -- Average salary per department
	COUNT(employeedepartmenthistory.businessentityid) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS EmployeesPerDept 
FROM humanresources.employeepayhistory AS employeepayhistory
INNER JOIN humanresources.employeedepartmenthistory AS employeedepartmenthistory
        ON employeepayhistory.businessentityid = employeedepartmenthistory.businessentityid  
INNER JOIN humanresources.department AS department
        ON department.departmentid = employeedepartmenthistory.departmentid
WHERE employeedepartmenthistory.enddate IS NULL --Active  
ORDER BY 1;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Window Functions: 
	-- RANK: Assigns a rank to each row, with gaps in rank if there are ties.
	-- DENSE_RANK: Assigns a rank to each row, without gaps in rank for ties.
	-- ROW_NUMBER: Assigns a unique sequential number to each row, even with ties.

-- DENSE_RANK:
-- Question: Write a query to rank products by their ListPrice, ensuring that there are no gaps in the rank values even if some products have the same price.

SELECT 
    product.productid,
    product.name AS productname,
    product.listprice,
--     DENSE_RANK() OVER (ORDER BY product.listprice DESC) AS pricerank
    ROW_NUMBER() OVER (ORDER BY product.listprice DESC) AS pricerank --
-- 		RANK() OVER (ORDER BY product.listprice DESC) AS pricerank
FROM production.product AS product
ORDER BY pricerank;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LAG() and LEAD()

-- Write a query to show each sales order and its TotalDue, along with the previous order's TotalDue for the same customer and to display each order and its OrderDate, 
-- along with the next order's OrderDate for the same customer. 

-- Use the LEAD() function to retrieve the next order's date.
-- Use the LAG() function to retrieve the previous order’s total.

SELECT 
    salesorderid, 
    customerid, 
    orderdate, 
		LEAD(orderdate, 1) OVER (PARTITION BY customerid ORDER BY orderdate) AS nextorderdate,
    totaldue, 
    LAG(totaldue, 1) OVER (PARTITION BY customerid ORDER BY orderdate) AS previousordertotal
FROM sales.salesorderheader
ORDER BY 
    customerid, 
		orderdate;
		
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Subqueries

-- Write a query to retrieve the customer ID and total amount of their orders, but only for customers who have placed orders with a total greater than 10,000. 
-- Use a subquery to filter the customers.

SELECT 
	customerid,
	SUM(totaldue) AS total_expenditure
FROM sales.salesorderheader
WHERE customerid IN (
	SELECT 
			customerid 
	FROM sales.salesorderheader 
	GROUP BY 1
	HAVING SUM(totaldue) > 100000
)
GROUP BY customerid;

-- Find the top 5 best sales person alongside their total sales using subquery and window function
SELECT 
    salespersonid, 
    totalsales 
FROM (
	SELECT 
		salespersonid, 
		SUM(totaldue) AS totalsales,
		RANK() OVER(ORDER BY SUM(totaldue) DESC) AS ranking
	FROM sales.salesorderheader 
	GROUP BY salespersonid
) AS sales_summary
WHERE ranking <= 5;

-- Q1: Write a query to retrieve products whose prices are above the average price in the database.
-- A1:

SELECT 
    name, 
    listprice 
FROM production.product 
WHERE listprice > (
	SELECT 
			AVG(listprice) 
	FROM production.product
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Common Table Expressions (CTEs)

-- Question: Write a query to calculate the average order amount for each customer using a CTE.
WITH averageorderamount AS (
	SELECT 
			customerid, 
			ROUND(AVG(totaldue), 2) AS avg_order_amount
	FROM sales.salesorderheader
	GROUP BY customerid
)

SELECT
	customerid, 
	avg_order_amount
FROM averageorderamount
ORDER BY 
	avg_order_amount DESC;

-- Question: Write a query to find the total quantity sold for each product using a CTE.
-- sales.salesorderdetail, production.product

WITH productsalesquantity AS (
	SELECT 
			productid, 
			SUM(orderqty) AS total_quantity_sold
	FROM sales.salesorderdetail
	GROUP BY productid
)

SELECT 
    psq.productid, 
    p.name, 
    psq.total_quantity_sold
FROM productsalesquantity psq
INNER JOIN production.product p 
				ON psq.productid = p.productid
ORDER BY total_quantity_sold DESC;


-- Q2: Write a query to retrieve the most recent order for each customer, using ROW_NUMBER() and a CTE to assign a unique rank to each order, starting with the most recent.
-- A2:

WITH rankedorders AS (
    SELECT 
        salesorderheader.customerid, 
        salesorderheader.salesorderid, 
        salesorderheader.orderdate,
        ROW_NUMBER() OVER (PARTITION BY salesorderheader.customerid ORDER BY salesorderheader.orderdate DESC) AS rownum
    FROM sales.salesorderheader AS salesorderheader
)

SELECT 
	customerid, 
	salesorderid, 
	orderdate
FROM rankedorders
WHERE rownum = 1
ORDER BY customerid;


-- Q3: What's the difference between CTE and subquery?
-- A3: Usability, CTE you can call on the question more than once!

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Temporary Tables

-- Write a query to first calculate the total sales amount for each salesperson and then, using the second CTE, calculate the average sales per salesperson. 
-- Display the salespersons who have above-average total sales.

-- First CTE: Calculate total sales for each salesperson
WITH salespersalesperson AS (
	SELECT 
		salespersonid, 
		SUM(totaldue) AS total_sales
	FROM sales.salesorderheader
	WHERE salespersonid IS NOT NULL
	GROUP BY salespersonid
),

-- Second CTE: Calculate the average total sales across all salespersons
averagesales AS (
	SELECT 
			AVG(total_sales) AS avg_sales
	FROM salespersalesperson
)

SELECT 
	sp.salespersonid, 
	sp.total_sales
INTO TEMPORARY TABLE temptable
FROM salespersalesperson sp
WHERE sp.total_sales > (
	SELECT 
		avg_sales
	FROM averagesales
)
ORDER BY sp.total_sales DESC;

SELECT * 
FROM temptable;

-- Used when you are handling alot of data and writing a very long and complex SQL script, especially helpful when creating a new table with new metrics to solve
-- a new problem statement.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating a Database

CREATE DATABASE mydatabase;
-- Rmb to refresh!

-- The locale provider controls how text-related operations, like sorting and comparing strings, are handled based on language and regional rules. When creating a new database

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating a Schema in the new database!

-- Change connection using the plug connector at the top
-- Change to mydatabase

CREATE SCHEMA leetcode;
CREATE SCHEMA personal;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Creating Tables

-- Let's populate some tables in our new database!

-- Loading CSV:

CREATE TABLE personal.persons (
  id SERIAL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  dob DATE,
  email VARCHAR(255),
  PRIMARY KEY (id)
);

SELECT * FROM personal.persons;

COPY personal.persons(first_name, last_name, dob, email)
FROM '/Users/junyeow/Desktop/persons.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM personal.persons;

-- Restoring an entire database
-- Restore the dvdrental database!


-- DROP tables in your schema

DROP TABLE personal.persons;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Inserting Data & Constraints

CREATE TABLE personal.employees (
	employee_id SERIAL PRIMARY KEY,               -- Primary key with auto-increment
	favourite_num INT,
	first_name VARCHAR(50) NOT NULL,              -- Cannot be NULL
	last_name VARCHAR(50) NOT NULL,               -- Cannot be NULL
	email VARCHAR(100) UNIQUE NOT NULL,           -- Must be unique and cannot be NULL
	hire_date DATE NOT NULL DEFAULT CURRENT_DATE, -- Defaults to today's date if not specified
	salary NUMERIC(10, 2) CHECK (salary > 0)     -- Salary must be greater than 0
-- 	department_id INT REFERENCES departments(department_id) -- Foreign key referencing 'departments' example
);

-- Inserting valid data
INSERT INTO personal.employees (favourite_num, first_name, last_name, email, salary)
VALUES (7, 'John', 'Doe', 'john.doe@example.com', 50000.00),
			 (7, 'Jane', 'Smith', 'jane.smith@example.com', 60000.00);

SELECT * FROM personal.employees;

INSERT INTO personal.employees (favourite_num, first_name, last_name, email, hire_date, salary)
VALUES (8, 'Mark', 'Jones', 'mark.jones@example.com', '2023-01-15', 55000.00);

SELECT * FROM personal.employees;

DROP TABLE personal.employees;
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Update & Delete Operations

-- Update the salary of an employee
UPDATE personal.employees
SET salary = salary + 5000
WHERE employee_id = 1;

SELECT * FROM personal.employees;

-- Delete an employee from the table
DELETE FROM personal.employees
WHERE employee_id = 3;

SELECT * FROM personal.employees;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Stored Procedures

-- Stored procedures in PostgreSQL allow you to encapsulate SQL code in a reusable block that can perform actions like updates, inserts, and more.
-- Basically like python functions

-- Create a stored procedure to give a raise to an employee
CREATE OR REPLACE PROCEDURE personal.give_raise(_employee_id INT, _raise_amount NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE personal.employees
    SET salary = salary + _raise_amount
    WHERE employee_id = _employee_id;
END;
$$;

-- Call the stored procedure to give an employee a raise
CALL personal.give_raise(1, 3000);

SELECT * FROM personal.employees;

DROP PROCEDURE personal.give_raise(integer,numeric);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Functions *

-- Functions in PostgreSQL allow you to return values or perform calculations and return results. They can also be used in queries like any other expression.

-- Create a function to calculate annual salary
CREATE OR REPLACE FUNCTION personal.calculate_annual_salary(_employee_id INT)
RETURNS NUMERIC
LANGUAGE plpgsql
AS $$
DECLARE
    annual_salary NUMERIC;
BEGIN
    SELECT salary * 12 INTO annual_salary
    FROM personal.employees
    WHERE employee_id = _employee_id; -- Use the parameter _employee_id
    
    RETURN annual_salary;
END;
$$;

-- Get the annual salary of an employee
SELECT personal.calculate_annual_salary(1);

-- But you can do that using Views as well

CREATE VIEW personal.employee_annual_salaries AS
SELECT 
    employee_id, 
    salary, 
    salary * 12 AS annual_salary
FROM 
    personal.employees;

SELECT * FROM personal.employee_annual_salaries;

-- Q: So what's the difference between VIEWS and tables?
-- A: A view is a virtual table and a table is a database object that stores actual data.
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Triggers *

-- Triggers are special procedures that are automatically invoked by PostgreSQL when certain events (like inserts, updates, or deletes) happen on a table.

-- Create a salary_log table to track salary changes
CREATE TABLE personal.salary_log (
    log_id SERIAL PRIMARY KEY,
    employee_id INT,
    old_salary NUMERIC,
    new_salary NUMERIC,
    change_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create a trigger function to log salary changes
CREATE OR REPLACE FUNCTION personal.log_salary_change()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    -- Insert the old and new salary into the salary_log table
    INSERT INTO personal.salary_log (employee_id, old_salary, new_salary)
    VALUES (NEW.employee_id, OLD.salary, NEW.salary);
    
    RETURN NEW;
END;
$$;

-- Create a trigger to call the log_salary_change function on salary updates
CREATE TRIGGER salary_update_trigger
AFTER UPDATE OF salary
ON personal.employees
FOR EACH ROW
EXECUTE FUNCTION personal.log_salary_change();

-- Update an employee's salary to test the trigger
UPDATE personal.employees
SET salary = salary + 5000
WHERE employee_id = 1;

UPDATE personal.employees
SET salary = salary + 5000
WHERE employee_id = 2;

-- Check the salary_log table to see the changes logged
SELECT * FROM personal.salary_log;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
