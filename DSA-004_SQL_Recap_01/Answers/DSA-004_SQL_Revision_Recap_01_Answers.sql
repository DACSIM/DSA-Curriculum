-- Tutorial: Getting used to SQL is a very important step in landing a job or an internship in tech! 
-- Lets practise using adventureworks

-- Be sure to keep praticising!
-- Here are some questions to practise your skill using the Adventureworks db.

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q1: From the following table humanresources.employee write a query in SQL to retrieve all the rows and columns from the employee table in the Adventureworks database. 
-- Sort the result set in ascending order on jobtitle.
-- humanresources.employee table

SELECT *  
FROM humanresources.employee  
ORDER BY jobtitle;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q2: From the following table person.person write a query in SQL to return all rows and a subset of the columns (firstName, lastName, businessentityid) from the person table in the AdventureWorks database. 
-- The third column heading is renamed to employee_id. Arranged the output in ascending order by lastname.

SELECT 
	firstname, 
	lastname, 
	businessentityid as employee_id  
FROM person.person   
ORDER BY lastname;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q3: From the following table write a query in SQL to return only the rows for product that have a sellstartdate that is not NULL and a productline of 'T'. 
-- Return productid, productnumber, and name. Change the name to productname. Arranged the output in ascending order on name.

-- production.product

SELECT 
	productid, 
	productnumber, 
	name AS productname
FROM production.product
WHERE sellstartdate IS NOT NULL
	AND production.product.productline= 'T'
ORDER BY name;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q4:From the following table write a query in SQL to calculate the total freight paid by each customer. Return customerid and total freight. 
-- Sort the output in ascending order on customerid

-- sales.salesorderheader

SELECT 
	customerid, 
	SUM(freight) AS total_freight 
FROM sales.salesorderheader
GROUP BY customerid
ORDER BY customerid ASC;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q5:From the following table write a query in SQL to retrieve the number of employees for each City. Return city and number of employees. 
-- Sort the result in ascending order on city.

-- person.businessentityaddress

SELECT 
	a.city, 
	COUNT(b.addressid) num_of_employees 
FROM person.businessentityaddress AS b
INNER JOIN person.address AS a  
        ON b.addressid = a.addressid
GROUP BY a.city
ORDER BY a.city;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q6: From the following tables write a query in SQL to make a list of contacts who are designated as 'Purchasing Manager'. 
-- Return BusinessEntityID, LastName, and FirstName columns. Sort the result set in ascending order of LastName, and FirstName.

-- person.businessentitycontact, person.contacttype, person.person

SELECT 
	pp.businessentityid, 
	lastname, 
	firstname
FROM person.businessentitycontact AS pb 
INNER JOIN person.contacttype AS pc
				ON pb.ContactTypeID = pc.ContactTypeID
INNER JOIN person.person AS pp
				ON pb.PersonID = pp.BusinessEntityID
WHERE pc.Name = 'Purchasing Manager'
ORDER BY
	lastname, 
	firstname;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q7: From the following table sales.salesorderdetail  write a query in  SQL to retrieve the total cost of each salesorderID that exceeds 100000. 
-- Return SalesOrderID, total cost. Round to 2 decimal place and add the dollar sign at the front.

SELECT 
    salesorderid, 
    CONCAT('$', ROUND(SUM(orderqty * unitprice),2)) AS order_cost 
FROM sales.salesorderdetail 
GROUP BY salesorderid
HAVING SUM(orderqty*unitprice) > 100000.00 
ORDER BY 
    salesorderid;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q8:From the following person.person table write a query in  SQL to retrieve those persons whose last name begins with letter 'R' and firstname end with 'n'. 
-- Return lastname, and firstname and display the result in ascending order on firstname and descending order on lastname columns.

SELECT 
	lastname, 
	firstname 
FROM person.person  
WHERE lastname LIKE 'R%'
	AND firstname LIKE '%n'
ORDER BY 
	firstname ASC, 
	lastname DESC;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q9: From the following humanresources.department table write a query in  SQL to skip the first 5 rows and return the next 5 rows from the sorted result set.

SELECT 
	departmentid, 
	name, 
	groupname
FROM humanresources.department
ORDER BY departmentid   
OFFSET 5  
LIMIT 5;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Q10:From the following tables write a query in  SQL to find the persons whose last name starts with letter 'L'. 
-- Return BusinessEntityID, FirstName, LastName, and PhoneNumber. Sort the result on lastname and firstname.

-- person.person, person.personphone

SELECT 
	person.businessentityid,
	person.firstname,
	person.lastname,
	personphone.phonenumber
FROM person.person AS person
INNER JOIN person.personphone AS personphone
				ON person.businessentityid = personphone.businessentityid
WHERE person.lastname LIKE 'L%'
ORDER BY
	person.firstname,
	person.lastname;

-------------------------------------------------------------------------------------------------------------------------------------------