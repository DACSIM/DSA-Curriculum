-- Refresher on how to perform basic query and how the database works:

-- SELECT Clause: everything = *

-- Select department table, the employee table and vendor table. Let's explore the database a little!

SELECT *
FROM humanresources.department;

SELECT *
FROM humanresources.employee;

SELECT *
FROM purchasing.vendor;

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

SELECT DISTINCT businessentityid
FROM humanresources.jobcandidate;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- From different schemas: sales

SELECT *
FROM sales.customer;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- LIMIT: As the name suggest it limits the number of *rows* shown at the end result

-- Limit the table productvendor to 10 rows and purchaseorderdetail to 100 rows

SELECT *
FROM purchasing.productvendor
LIMIT 10;

SELECT *
FROM purchasing.purchaseorderdetail
LIMIT 100;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- SELECT MDAS: Multiplcation/division/addition/subtraction

-- From the customer table Multiplcation/division/addition/subtraction the store_id

SELECT
	customerid,
	storeid * 10
-- 	storeid / 10
-- 	storeid + 10 
-- 	storeid - 10 
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

SELECT *
FROM humanresources.department
WHERE groupname = 'Research and Development';

-- When dealing with NULL values
SELECT *
FROM purchasing.productvendor
WHERE onorderqty IS NULL;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: Arithmetic filter

-- From customer table, territoryid = 4
SELECT *
FROM sales.customer
WHERE territoryid = 4
LIMIT 100;

-- From person table, emailpromotion <> 0
SELECT *
FROM person.person
WHERE emailpromotion <> 0
LIMIT 100;

-- From employee table, vacationhours >= 99
SELECT *
FROM humanresources.employee
WHERE vacationhours >= 99
LIMIT 100;

-- From employee table, sickleavehours <= 20
SELECT *
FROM humanresources.employee
WHERE sickleavehours <= 20
LIMIT 100;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--WHERE clause: OR clause

-- From employee table, select either Design Engineer or Tool Designer
SELECT *
FROM humanresources.employee
WHERE jobtitle = 'Design Engineer'
	OR jobtitle = 'Tool Designer';

-- From product, select either Black or Silver
SELECT *
FROM production.product 
WHERE color = 'Black'
	OR color = 'Silver';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- WHERE clause: AND clause

-- From Vendor, preferredvendorstatus and activeflag must be TRUE
SELECT *
FROM purchasing.vendor
WHERE preferredvendorstatus = TRUE
	AND activeflag = TRUE;

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

-- Example of poor formatting and logic.
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

SELECT *
FROM sales.salesperson
WHERE territoryid = 4 
	OR territoryid = 6 AND salesquota = 250000 
	OR salesquota = 300000; -- 7

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

-- Find all the middle names that contains either A or B or C.

SELECT *
FROM person.person
WHERE middlename IN (
	'A', 
	'B', 
	'C'
)
LIMIT 100;

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

SELECT *
FROM humanresources.employee
WHERE birthdate LIKE '1969-01-29%';
-- Only works for string!

-- But what if you know the number of letters in the firstname?

SELECT *
FROM person.person
WHERE firstname LIKE 'J___';

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- What if we want firstnames that contains the letter a inside?

SELECT *
FROM person.person
-- WHERE firstname LIKE '%a%';
WHERE firstname LIKE '%A%'; -- not tallying

-- We have two varying results, we can use things like UPPER() and LOWER() clause

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

-- From employee table, group by maritalstatus

SELECT 
	maritalstatus
FROM humanresources.employee
GROUP BY maritalstatus;

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
	CEILING(AVG(vacationhours)) AS ceiling_average,
	FLOOR(AVG(vacationhours)) AS floor_average,
	ROUND(AVG(vacationhours), 4) AS rounded_average,
	
	MAX(sickleavehours) AS max_vacation_hours,
	MIN(sickleavehours) AS min_vacation_hours
	
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

-- Sorting by Average

SELECT
	jobtitle,
	AVG(vacationhours) AS average_vacation_hours
FROM humanresources.employee
GROUP BY jobtitle
ORDER BY AVG(vacationhours) DESC;

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
	COUNT(*)
FROM sales.customer
WHERE personid IS NOT NULL
	and storeid IS NOT NULL
GROUP BY territoryid
HAVING COUNT(*) > 40;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- OFFSET: Using the employee table find the other the other employees except the top 10 oldest employees.
SELECT *
FROM humanresources.employee
ORDER BY birthdate ASC;

SELECT *
FROM humanresources.employee
ORDER BY birthdate ASC
OFFSET 10;

-- Q4: From the salesperson table, where customer has a personid and a storeid, find the territory that has higher than 40 customers
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

SELECT *
FROM humanresources.employee
WHERE gender = 'M'
LIMIT 10;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: INNER

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
				
-- Let's create a base table in the humanresources schema, where we are able to get each employee's department history and department name

-- Employee table

SELECT *
FROM humanresources.employee;

SELECT
	businessentityid,
	COUNT(*) AS duplicates
FROM humanresources.employee
GROUP BY businessentityid
HAVING COUNT(*) > 1;
-- Unique table!

-- Employee Department History table

SELECT *
FROM humanresources.employeedepartmenthistory;

SELECT 
	businessentityid,
	COUNT(*) AS duplicates
FROM humanresources.employeedepartmenthistory
GROUP BY businessentityid
HAVING COUNT(*) > 1;
-- Not Unique table!

-- Department table

SELECT *
FROM humanresources.department;

SELECT
	CONCAT(name, groupname) AS specialkey,
	COUNT(*) AS duplicates
FROM humanresources.department
GROUP BY CONCAT(name, groupname)
HAVING COUNT(*) > 1;

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

-- List all products along with their total sales quantities, including products that have never been sold. 
-- For products that have not been sold, display the sales quantity as zero.
-- Sort by total orders descending

SELECT *
FROM production.product;

SELECT *
FROM sales.salesorderdetail;

SELECT 
    product.productid,
    product.name AS productname,
    COALESCE(SUM(salesorderdetail.orderqty), 0) AS totalsalesquantity
FROM production.product AS product
LEFT JOIN sales.salesorderdetail AS salesorderdetail
			 ON product.productid = salesorderdetail.productid
GROUP BY 
    product.productid, 
		product.name
ORDER BY 
	COALESCE(SUM(salesorderdetail.orderqty), 0) DESC;

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
			 
-- Retrieve a list of all individual customers id, firstname along with the total number of orders they have placed 
-- and the total amount they have spent, removing customers who have never placed an order. 

SELECT *
FROM person.person;

SELECT *
FROM sales.customer;

SELECT *
FROM sales.salesorderheader;

SELECT
	customer.customerid,
	person.firstname,
	COUNT(salesorderid) AS purchases,
	ROUND(SUM(subtotal), 2) AS cost
FROM sales.customer AS customer
LEFT JOIN person.person AS person
			 ON customer.personid = person.businessentityid
LEFT JOIN sales.salesorderheader AS salesorderheader 
			 ON customer.customerid = salesorderheader.customerid
GROUP BY 
	customer.customerid,
	person.firstname
HAVING ROUND(SUM(subtotal), 2) IS NOT NULL;

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

-- Write a query to find all employees and their corresponding sales orders. If an employee doesn’t have any sales orders, 
-- still include them in the result, and if there are sales orders without an associated employee, include those as well.

SELECT 
    employee.businessentityid AS employeeid,
    salesorderheader.salesorderid
FROM humanresources.employee AS employee
FULL OUTER JOIN sales.salesorderheader AS salesorderheader
						 ON employee.businessentityid = salesorderheader.salespersonid;
		
-- Write a query to retrieve a list of all employees and customers, and if either side doesn't have a FirstName, 
-- use the available value from the other side. Use FULL OUTER JOIN and COALESCE.

SELECT 
    COALESCE(employee.firstname, c.firstname) AS firstname,
    COALESCE(employee.lastname, c.lastname) AS lastname
FROM humanresources.employee AS employee
FULL OUTER JOIN sales.customer AS customer
						 ON employee.businessentityid = customer.personid;
						 
-- Write a query to list all employees along with their associated sales orders. Include employees who may not have any sales orders. 
-- Use the COALESCE function to handle NULL values in the SalesOrderID column.

SELECT
    employee.employeeid,
    employee.firstname,
    employee.lastname,
    COALESCE(salesorderheader.salesorderid, 'No Sales Order') AS salesorderid
FROM humanresources.employee AS employee
FULL OUTER JOIN sales.salesorderheader AS salesorderheader
						 ON employee.employeeid = salesorderheader.salespersonid
ORDER BY employee.employeeid;

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- JOINS: CROSS JOINS

-- Explanation: A CROSS JOIN in SQL combines every row from the first table with every row from the second table. This type of join creates a Cartesian product, 
-- meaning that if the first table has 10 rows and the second table has 5 rows, the result will have 10 * 5 = 50 rows. 
-- A CROSS JOIN does not require any relationship or matching columns between the two tables.

-- Example: Good for arranging one person to meet multiple people

-- Write a query to generate all possible combinations of product categories and product models. Show the category name and the model name.

SELECT 
    productcategory.name AS categoryname, 
    productionmodel.name AS modelname
FROM 
    production.productcategory AS productcategory
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

-- Union them together segregating employee and customer

SELECT *
FROM person.person;

SELECT *
FROM sales.customer;

SELECT 
	firstname, 
	lastname, 
	CONCAT(firstname, ' ', middlename, ' ', lastname) AS fullname,
	'Employee' AS category
FROM person.person AS person
INNER JOIN humanresources.employee AS employee 
				ON person.businessentityid = employee.businessentityid

UNION

SELECT 
	firstname, 
	lastname,
	CONCAT(firstname, ' ', middlename, ' ', lastname) AS fullname,
	'Customer' AS category
FROM person.person AS person
INNER JOIN sales.customer AS customer
				ON person.businessentityid = customer.personid
WHERE customer.storeid IS NULL;

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

-- Categorize products based on their list price
SELECT 
	productid,
	name,
	listprice,
	CASE 
		WHEN listprice = 0 THEN 'Free'
		WHEN listprice < 50 THEN 'Budget'
		WHEN listprice BETWEEN 50 AND 1000 THEN 'Mid-range'
		ELSE 'Premium'
	END AS pricecategory
FROM production.product;

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

-- If time permits:
-- Window Functions
-- AGGREGATE

-- Explanation:
/*
A window function in SQL allows you to perform calculations across a set of table rows that are somehow related to the current row. 
Unlike regular aggregate functions (such as SUM, COUNT, AVG), window functions do not group the result into a single output. 
Instead, they return a value for every row while using a "window" of rows to perform the calculation.
*/

-- Let’s say we want to calculate the running total of sales for each salesperson, partitioned by their ID (so each salesperson gets their own total), 
-- and ordered by the order date.

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
	AVG(rate) OVER (PARTITION BY employeedepartmenthistory.departmentid) AS avgsalary -- Average salary per department
	COUNT(employeedepartmenthistory.businessentityid) OVER (PARTITION BY edh.DepartmentID) AS EmployeesPerDept 
FROM humanresources.employeepayhistory AS employeepayhistory
INNER JOIN humanresources.employeedepartmenthistory AS employeedepartmenthistory
        ON employeepayhistory.businessentityid = employeedepartmenthistory.businessentityid  
INNER JOIN humanresources.department AS department
        ON department.departmentid = employeedepartmenthistory.departmentid
WHERE employeedepartmenthistory.endate IS NULL --Active  
ORDER BY 
	department.name;
	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------