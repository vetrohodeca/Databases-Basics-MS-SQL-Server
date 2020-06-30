USE SoftUni
GO

CREATE OR ALTER PROC dbo.usp_GetEmployeesSalaryAbove35000 
AS
SELECT FirstName, LastName FROM Employees
WHERE Salary>35000

GO

CREATE PROC dbo.usp_GetEmployeesSalaryAboveNumber (@MinSalary DECIMAL(18,4))
AS
SELECT FirstName, LastName FROM Employees
WHERE Salary>=@MinSalary

EXEC usp_GetEmployeesSalaryAboveNumber 48100

GO

CREATE PROC usp_GetTownsStartingWith (@StartString NVARCHAR (MAX))
AS 
BEGIN
DECLARE @Length int = LEN(@StartString)
SELECT Towns.[Name] FROM Towns  
WHERE LEFT(Towns.[Name], @Length ) = @StartString
END

GO
CREATE PROC usp_GetEmployeesFromTown (@TownName NVARCHAR (MAX))
AS 
BEGIN
SELECT e.FirstName, e.LastName FROM Employees AS e
INNER JOIN Addresses AS a
ON e.AddressID= a.AddressID
INNER JOIN Towns AS t
On a.TownID=t.TownID
WHERE t.Name = @TownName 
END

GO

CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) RETURNS NVARCHAR(10)
BEGIN 
DECLARE  @SalaryLevel VARCHAR(10)
IF(@salary < 30000) SET  @SalaryLevel = 'Low'
ELSE IF(@salary >=30000 AND @salary<=50000) SET @SalaryLevel= 'Average'
ELSE SET @SalaryLevel = 'High'
RETURN @SalaryLevel
END

GO

CREATE PROCEDURE usp_EmployeesBySalaryLevel(@LevelOfSalary VARCHAR(10))
AS
BEGIN 
	SELECT FirstName, LastName FROM Employees
	WHERE dbo.ufn_GetSalaryLevel(Salary)= @LevelOfSalary
END

GO

CREATE FUNCTION ufn_IsWordComprised(@setOfLetters nvarchar(255),  @word nvarchar(255))
RETURNS bit
AS
BEGIN 
    DECLARE @l int = 1;
    DECLARE @exist bit = 1;
    WHILE LEN(@word) >= @l AND @exist > 0
    BEGIN
      DECLARE @charindex int; 
      DECLARE @letter char(1);
      SET @letter = SUBSTRING(@word, @l, 1)
      SET @charindex = CHARINDEX(@letter, @setOfLetters, 0)
      SET @exist =
        CASE
            WHEN  @charindex > 0 THEN 1
            ELSE 0
        END;
      SET @l += 1;
    END

    RETURN @exist
END

GO

CREATE PROCEDURE usp_DeleteEmployeesFromDepartment (@departmentId INT) 
AS 
BEGIN 

	DELETE FROM EmployeesProjects
	WHERE EmployeeID IN(
							SELECT EmployeeID  FROM Employees
							WHERE DepartmentID = @departmentId
						)
	UPDATE Employees
	SET ManagerID= NULL
	WHERE ManagerID IN (
							SELECT EmployeeID  FROM Employees
							WHERE DepartmentID = @departmentId
						)
	ALTER TABLE Departments
	ALTER COLUMN ManagerID INT

	UPDATE Departments
	SET ManagerID=NULL
	WHERE ManagerID IN (
							SELECT EmployeeID  FROM Employees
							WHERE DepartmentID = @departmentId
						)
	DELETE FROM Employees
	WHERE DepartmentID= @departmentId

	DELETE FROM Departments
	WHERE DepartmentID=@departmentId

	SELECT COUNT(*) FROM Employees 
	WHERE DepartmentID= @departmentId
END

GO

CREATE OR ALTER PROC dbo.usp_GetHoldersFullName 
AS 
BEGIN
SELECT FirstName+ ' '+ LastName FROM AccountHolders AS FullName
END

EXEC dbo.usp_GetHoldersFullName 

GO

CREATE PROC dbo.GetHoldersWithBalanceHigherThan  (@minBalance DECIMAL(18,4))
AS 
BEGIN 
	SELECT FirstName, LastName FROM Account AS a
	INNER JOIN AccountHolder AS ah
	ON a.AccountHolder= ah.Id
	GROUP BY FirstName, LastName
END

