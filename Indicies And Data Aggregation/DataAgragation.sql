SELECT COUNT(Id) FROM WizzardDeposits as Count

SELECT MAX(MagicWandSize) FROM WizzardDeposits as LongestMagicWand

SELECT DepositGroup, MAX(MagicWandSize)AS LongestMagicWand FROM WizzardDeposits 
GROUP BY DepositGroup

SELECT TOP(2) DepositGroup FROM 
(SELECT DepositGroup, AVG(MagicWandSize) AS [AverageWandSize]
FROM WizzardDeposits
GROUP BY DepositGroup )
AS [AverageWandSizeQuery]
ORDER BY [AverageWandSize]

SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
GROUP BY DepositGroup

SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator ='Ollivander Family'
GROUP BY DepositGroup

SELECT DepositGroup ,SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator ='Ollivander Family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) <150000
ORDER BY TotalSum DESC

SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) FROM WizzardDeposits
GROUP BY DepositGroup,MagicWandCreator
ORDER BY MagicWandCreator ASC, DepositGroup ASC

SELECT [AgeGroup], COUNT (*) AS[WizzardsCount] 
FROM (SELECT 
CASE 
    WHEN age >= 0 AND age < 11 THEN '[0-10]'
    WHEN age >= 11 AND age < 21 THEN '[11-20]'
    WHEN age >= 21 AND age < 31 THEN '[21-30]'
    WHEN age >= 31 AND age < 41 THEN '[31-40]'
    WHEN age >= 41 AND age < 51 THEN '[41-50]'
    WHEN age >= 51 AND age < 61 THEN '[51-60]'
    WHEN age >= 61 THEN '[61+]'
	END AS [AgeGroup] ,*
FROM WizzardDeposits) AS [AgeGroupQuery]
GROUP BY [AgeGroup]

SELECT LEFT (FirstName ,1) AS FirstLetter FROM WizzardDeposits
WHERE DepositGroup='Troll Chest'
GROUP BY LEFT (FirstName ,1)
ORDER BY LEFT (FirstName ,1) ASC

SELECT DepositGroup,IsDepositExpired, AVG( DepositInterest)AS AverageInterest FROM WizzardDeposits
WHERE DepositStartDate>'01-01-1985'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC

SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

SELECT DepartmentID, MIN(Salary) AS MinimumSalary FROM Employees
WHERE DepartmentID IN (2,5,7) AND HireDate>'01-01-2000'
GROUP BY DepartmentID
ORDER BY DepartmentID ASC, MIN(Salary) DESC

SELECT * INTO EmployeesWithHighSalaries FROM Employees -- buta gi v nova tablica
WHERE Salary >30000
DELETE FROM EmployeesWithHighSalaries
WHERE ManagerID=42
UPDATE EmployeesWithHighSalaries 
SET Salary +=5000
WHERE DepartmentID=1
SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM EmployeesWithHighSalaries
GROUP BY DepartmentID

SELECT DepartmentID, MAX(Salary) AS MaxSalary FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) < 30000 OR MAX(Salary)>70000
ORDER BY DepartmentID

SELECT COUNT(Salary) AS Count FROM Employees
WHERE ManagerID IS  NULL