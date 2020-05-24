--CREATE DATABASE Demo

USE Demo

--CREATE TABLE Person(
	--Id INT PRIMARY KEY IDENTITY,
	--[Name] NVARCHAR(50) NOT NULL,
	--Height DECIMAL(5,2) NOT NULL
--	)

INSERT INTO Person([Name], Height)
VALUES
('Pesho', 100),
('Gosho', 100.55),
('Ivan', 100.5)

SELECT* FROM Person

INSERT INTO Person ([Name], Height)
VALUES 
('Big Number1', 100.1271212)

SELECT * FROM Person

USE [SoftUni]

SELECT * FROM Departments

SELECT Name FROM Departments

SELECT Salary FROM Employees

SELECT FirstName, LastName, Salary FROM Employees

SELECT FirstName, MiddleName,LastName FROM Employees   

SELECT FirstName + '.'+ LastName + '@softuni.bg' AS [Email] FROM Employees

SELECT DISTINCT  Salary FROM Employees

SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative'

SELECT FirstName, LastName, JobTitle FROM Employees
WHERE Salary>=20000 AND Salary<=30000

SELECT CONCAT(FirstName, ' ',MiddleName+' ',LastName) 
AS[FullName] FROM Employees
WHERE Salary IN (25000,14000,12500,23600 )

SELECT FirstName, LastName FROM Employees WHERE ManagerID IS NULL

SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary >50000
ORDER BY Salary DESC

SELECT TOP (5) FirstName, LastName FROM Employees
ORDER BY Salary DESC

SELECT FirstName, LastName FROM Employees 
WHERE DepartmentID != 4

SELECT * FROM Employees
ORDER BY Salary DESC, FirstName ASC, LastName DESC, MiddleName ASC
GO

CREATE VIEW V_EmployeeNameJobTitle
AS
(SELECT 
	   CONCAT (FirstName, ' ', ISNULL(MiddleName, ''), ' ', LastName) AS [Full Name],
	   JobTitle
FROM Employees)

GO

SELECT * FROM V_EmployeeNameJobTitle

SELECT  DISTINCT  JobTitle FROM Employees

SELECT TOP (10) * FROM Projects 
ORDER BY StartDate ASC, Name ASC

SELECT TOP (7) FirstName, LastName, HireDate FROM Employees 
ORDER BY HireDate DESC

UPDATE Employees 
SET Salary= Salary * 1.12
WHERE DepartmentID IN(1,2,4,11)

SELECT Salary From Employees
USE Geography

SELECT CountryName, CountryCode,
CASE
WHEN CurrencyCode= 'EUR' THEN 'Euro'
ELSE 'Not Euro'
END AS [Currency]
FROM Countries
ORDER BY CountryName

SELECT TOP (30) CountryName, Population FROM Countries
WHERE ContinentCode= 'EU'
ORDER BY Population DESC

SELECT PeakName FROM Peaks
ORDER BY PeakName ASC



SELECT Name FROM Characters
ORDER BY Name ASC