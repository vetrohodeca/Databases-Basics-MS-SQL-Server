USE [SoftUni]

SELECT FirstName, LastName FROM Employees
WHERE FirstName LIKE 'SA%' --името започва със SA и след това може да има нещо, може и да няма

SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'

SELECT FirstName FROM Employees 
WHERE DepartmentID IN (3, 10) AND -- 2te chisla samo
DATEPART (YEAR, HireDate) BETWEEN 1995 AND 2005 -- mejdu 2te chisla

SELECT FirstName, LastName FROM Employees 
WHERE NOT (JobTitle LIKE '%engineer%')

SELECT [Name] FROM Towns
WHERE LEN([Name]) = 5 OR Len([NAME]) = 6
ORDER BY [Name] ASC

SELECT * FROM Towns
WHERE LEFT([Name], 1) IN ('M', 'K', 'B', 'E')
ORDER BY [Name] ASC

SELECT * FROM Towns
WHERE LEFT([Name], 1) NOT IN ('B', 'R', 'D')
ORDER BY [Name] ASC

GO
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName
FROM Employees
WHERE DATEPART (YEAR, HireDate) >2000

SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5

SELECT EmployeeID, FirstName, LastName, Salary,
DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
FROM Employees
WHERE Salary BETWEEN 10000 AND 50000
ORDER BY Salary DESC

USE Geography

SELECT CountryName AS [Country Name], IsoCode AS [ISO Code]FROM Countries 
WHERE CountryName LIKE '%a%a%a%'
ORDER BY IsoCode

SELECT p.PeakName, r.RiverName,LOWER(CONCAT
(p.PeakName, SUBSTRING(r.RiverName,2,LEN(r.RiverName)-1))) 
AS [Mix] FROM Peaks AS p, Rivers AS r
WHERE RIGHT(p.PeakName,1)=LEFT(r.RiverName,1)
ORDER BY [Mix] 

USE Diablo

Select TOP (50) [Name], FORMAT([Start],'yyyy-MM-dd') AS [Start] FROM Games AS g
WHERE DATEPART(YEAR,[Start]) IN ( 2011, 2012)
ORDER BY [Start], [Name] 

SELECT Username, SUBSTRING ( [Email],CHARINDEX( '@', [Email] ) + 1,
LEN([Email])) AS [Domain Name] 
FROM Users
ORDER By [Domain Name] ASC, Username ASC

SELECT Username, IpAddress FROM Users
WHERE IpAddress Like '___.1_%._%.___'
ORDER BY Username

SELECT [Name],
  CASE 
	 WHEN DATEPART(HOUR, [Start]) BETWEEN 0 and 11 THEN 'Morning'
	 WHEN DATEPART(HOUR, [Start]) BETWEEN 11 and 17 THEN 'Afternoon'
	 ELSE 'Evening'	
  END AS [Part of the Day],
  CASE
	WHEN Duration <=3 THEN 'Extra Short'
	WHEN Duration BETWEEN 4 and 6 THEN 'Short'
	WHEN Duration >6 THEN 'Long'
	ELSE 'Extra Long'
  END AS [Duration]
FROM GAMES
ORDER BY [Name], [Duration],[Part of the Day]


SELECT ProductName, OrderDate, 
    DATEADD(DAY,3,OrderDate) AS [Pay Due],
    DATEADD(MONTH,1,OrderDate) AS [Deliver Due]
    FROM Orders