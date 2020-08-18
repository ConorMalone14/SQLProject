--Project 1

USE Northwind
SELECT * FROM Customers
SELECT * FROM Products
SELECT * FROM Employees
SELECT * FROM Orders
--1.1
SELECT CustomerID, CompanyName, "Address", City, Region, PostalCode, Country FROM Customers WHERE City='London' OR City = 'Paris'
--1.2
SELECT * FROM Products WHERE QuantityPerUnit LIKE '%bottles%'
--1.3
SELECT p.ProductName, p.QuantityPerUnit, s.CompanyName, s.Country 
FROM Products p INNER JOIN Suppliers s ON p.SupplierID=s.SupplierID WHERE QuantityPerUnit LIKE '%bottles%'
--1.4
SELECT c.CategoryName, COUNT(p.ProductID) AS "Total" FROM Products p 
INNER JOIN Categories c ON c.CategoryID=p.CategoryID GROUP BY c.CategoryName
--1.5
SELECT CONCAT(TitleOfCourtesy, ' ',FirstName,' ', LastName) AS "Name", City FROM Employees
--1.6
SELECT r.RegionDescription AS "Region Name", SUM((od.UnitPrice * od.Quantity)*(1-od.Discount)) AS "Total for Region" 
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN EmployeeTerritories et ON et.EmployeeID=o.EmployeeID
INNER JOIN Territories t ON et.TerritoryID=t.TerritoryID
INNER JOIN Region r ON r.RegionID=t.RegionID
GROUP BY r.RegionDescription
--1.7
SELECT Count(OrderID) AS"Total" FROM Orders WHERE Freight >100 AND (ShipCountry='USA' OR ShipCountry='UK')
--1.8
SELECT TOP 1 od.OrderID, (MAX(sq.Discount)) AS "Max Discount"
FROM [Order Details] od INNER JOIN
(SELECT o1.OrderID, SUM(UnitPrice*Quantity*Discount) AS "Discount" 
FROM [Order Details] o1 GROUP BY o1.OrderID) sq ON sq.OrderID = od.OrderID 
GROUP BY od.OrderID ORDER BY "Max Discount" DESC

--2
--2.1
CREATE DATABASE conorm_db
DROP DATABASE conorm_db
USE conorm_db
DROP TABLE Spartans
CREATE TABLE Spartans(
    seperate_title VARCHAR(10),
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    university VARCHAR(20),
    course_taken VARCHAR(20),
    mark INT,
    skills VARCHAR(200)
)

--2.2
INSERT INTO Spartans(
    seperate_title, first_name, last_name, university, course_taken, mark, skills
)VALUES(
    'Mr.', 'Tim', 'Timmy', 'Oxford', 'Knitting',  100, 'Very good at Knitting'
);
SELECT * FROM Spartans

--3
USE Northwind
SELECT * FROm Employees
--3.1
SELECT CONCAT(e.TitleOfCourtesy, ' ',e.FirstName,' ', e.LastName) AS "Name", 
CONCAT(s.TitleOfCourtesy, ' ',s.FirstName,' ', s.LastName) AS "Superior"
FROM Employees e
LEFT JOIN Employees s ON e.ReportsTo=s.EmployeeID

--3.2

SELECT s.CompanyName, SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) AS "Supplier Total."
FROM Suppliers s INNER JOIN
Products p ON s.SupplierID = p.SupplierID
INNER JOIN [Order Details] od ON p.ProductID=od.ProductID GROUP BY CompanyName 
having SUM (od.UnitPrice*od.Quantity*(1-od.Discount))>10000 ORDER BY "Supplier Total." DESC

--3.3
SELECT TOP 10 CustomerID, SUM(UnitPrice*Quantity*(1-Discount)) AS "Total"
FROM Orders o 
INNER JOIN [Order Details] od ON o.OrderID=od.OrderID 
WHERE o.OrderDate >= '1998/1/1' GROUP BY CustomerID ORDER BY Total DESC

--3.4
SELECT * FROM Orders

SELECT FORMAT(OrderDate, 'MMM-yy') AS "Month", AVG(DATEDIFF(d,OrderDate,ShippedDate))AS "Average Ship Time" 
FROM Orders
GROUP BY FORMAT(OrderDate, 'MMM-yy') 
ORDER BY FORMAT (CAST(FORMAT(OrderDate, 'MMM-yy') AS DATE), 'MMM-yy')

SELECT CAST(FORMAT(OrderDate, 'yyyy MMM') AS DATE) FROM Orders
SELECT FORMAT(OrderDate, 'MMM-yy') FROM Orders


--SELECT CAST(FORMAT(OrderDate, 'MMM-yy') AS DATE) FROM Orders