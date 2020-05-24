CREATE DATABASE Minions

USE Minions

CREATE TABLE Minions(
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	AGE TINYINT
)

CREATE TABLE Towns(
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)

ALTER TABLE Minions 
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id) 

INSERT INTO Towns( Id, [Name])
	VALUES 
		  (1, 'Sofia'),
		  (2, 'Plovdiv'),
		  (3, 'Varna')

INSERT INTO Minions(Id, [Name], Age, TownId)
	VALUES 
	(1, 'Kevin', 22, 1),
	(2, 'Bob', 15, 3),
	(3, 'Steward', NULL, 2)

TRUNCATE TABLE Minions

DROP TABLE Minions

DROP TABLE Towns

CREATE TABLE USERS
(   Id BIGINT  PRIMARY KEY IDENTITY NOT NULL,
	Username VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR (26) NOT NULL,
	ProfilePictrue VARBINARY(MAX) 
	CHECK(DATALENGTH(ProfilePictrue) <= 90*1024), 
	LastLoginTime DATETIME2 NOT NULL,
	IsDeleted BIT NOT NULL
)
INSERT INTO Users( Username, [Password], LastLoginTime, IsDeleted)
VALUES
('Pesho0', '123456', '05.19.2020', 0),
('Pesho1', '123456', '05.19.2020', 0),
('Pesho2', '123456', '05.19.2020', 1),
('Pesho3', '123456', '05.19.2020', 0),
('Pesho4', '123456', '05.19.2020', 1)

DELETE FROM Users WHERE Id =5 

ALTER TABLE Users
DROP CONSTRAINT [PK__USERS__3214EC074DD43DD4]

ALTER TABLE Users
ADD CONSTRAINT PK_Users_CompositeIdUsername
PRIMARY KEY(Id, Username)

ALTER TABLE Users
ADD CONSTRAINT CK_Users_PasswordLength
Check(LEN([Password])>=5)

ALTER TABLE Users
ADD CONSTRAINT DF_USERS_LastLoginTime
DEFAULT GETDATE() FOR LastLoginTime

INSERT INTO Users( Username, [Password], IsDeleted)
VALUES
('PeshoNoTime', '123456', 0)

ALTER TABLE Users 
DROP CONSTRAINT PK_Users_CompositeIdUsername

ALTER Table Users
ADD CONSTRAINT PK_Users_Id
PRIMARY KEY(Id)

ALTER TABLE Users
ADD CONSTRAINT CK_Users_UsernameLength
CHECK(LEN(Username) >=3)

SELECT * FROM Users

Create DATABASE SoftUni

USE SoftUni

CREATE TABLE Towns(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Addresses(
	Id INT PRIMARY KEY IDENTITY,
	AddressText NVARCHAR(100) NOT NULL,
	[Name] INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

CREATE TABLE Departments(
	ID INT PRIMARY KEY IDENTITY, 
	[Name] NVARCHAR(50) NOT NULL
)

INSERT INTO Towns([Name])
	VALUES
		  ('Sofia'),
		  ('Plovdiv'),
		  ('Varna'),
		  ('Burgas')

INSERT INTO Departments([Name])
	VALUES 
		   ('Engieering'),
		   ('Sales'),
		   ('Marketing'),
		   ('Software Development'),
		   ('Quality Assurance')
CREATE TABLE Employees(
	ID INT PRIMARY KEY Identity,
	FirstName NVARCHAR(50) NOT NULL,
	MiddleName NVARCHAR(50),
	LastName NVARCHAR(50) NOT NULL,
	JobTitle NVARCHAR(30) NOT NULL,
	DepartmentID INT FOREIGN KEY REFERENCES Departments(Id),
	HireDate DATE NOT NULL,
	Salary DECIMAL (7,2) NOT NULL,
	AddressID INT FOREIGN KEY REFERENCES Addresses(Id) 
)

INSERT INTO Employees(FirstName, MiddleName,LastName, JobTitle, DepartmentID, HireDate, Salary)
	VALUES
		  ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer',4,'02/01/2013', 3500.00),
		  ('Perar', 'Petrov', 'Petrov', 'Seinor Enginner', 1, '03/02/2004', 4000.00),
		  ('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '08/28/2016',525.25),
		  ('Georgi', 'Terziev', 'Ivanov', 'Sales', 2, '12/09/2007', 3000.00)

CREATE TABLE People(	
	Id INT PRIMARY KEY Identity,
	[Name] NVARCHAR(50) NOT NULL,
	Picture VARBINARY(MAX) 
	CHECK(DATALENGTH(Picture) <= 20*1024), 
	Height DECIMAL(3,2),
	[Weight] Decimal(5,2),
	Gender CHAR NOT NULL,
	Birthdate DATE NOT NULL,
	Biography NVARCHAR(MAX))

INSERT INTO People ([Name], Gender, BirthDate)
VALUES
('Pesho0', 'm', '05.19.2020'),
('Pesho1', 'm', '05.19.2020'),
('Pesho2', 'm', '05.19.2020'),
('Pesho3', 'm', '05.19.2020'),
('Pesho4', 'm', '05.19.2020')




SELECT* FROM Towns
ORDER BY [Name] ASC

SELECT* FROM Departments
ORDER BY [Name] ASC

SELECT* FROM Employees
ORDER BY Salary DESC


SELECT [Name] FROM Towns
ORDER BY [Name] ASC

SELECT [Name] FROM Departments
ORDER BY [Name] ASC

SELECT 	FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

UPDATE Employees 
SET Salary += Salary*0.1
SELECT Salary FROM Employees




CREATE DATABASE Movies

CREATE TABLE Directors
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
DirectorName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
)

CREATE TABLE Genres
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
GenreName NVARCHAR(50) NOT NULL,
Notes NVARCHAR(MAX)
)

CREATE TABLE Categories
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
CategoryName NVARCHAR(100) NOT NULL,
Notes NVARCHAR(MAX)
)

CREATE TABLE Movies
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
Title NVARCHAR(200) NOT NULL,
DirectorId INT NOT NULL,
CONSTRAINT FK_Movies_Directors FOREIGN KEY (DirectorId) REFERENCES Directors (Id),
CopyrightYear DATE DEFAULT GETDATE(),
Length FLOAT NOT NULL,
GenreId INT NOT NULL,
CONSTRAINT FK_Movies_Genres FOREIGN KEY (GenreId) REFERENCES Genres (Id),
CategoryId INT NOT NULL,
CONSTRAINT FK_Movies_Categories FOREIGN KEY (CategoryId) REFERENCES Categories (Id),
Rating FLOAT DEFAULT 0.00,
Notes NVARCHAR(MAX)
)


INSERT Directors
(DirectorName, Notes)
VALUES
('Goshko', 'BlablaGoshkoisHere'),
('Peshko', 'This is Peshko'),
('Stoyan', 'I smell noobs :D'),
('St', 'I smell noobs :D'),
('Sto', 'I smell noobs :D')

INSERT Genres
(GenreName)
VALUES
('Adventure'),
('Sci-fi'),
('Fantasy'),
('Horror'),
('Romance')

INSERT Categories
(CategoryName)
VALUES
('NewMovies'),
('OldMovies'),
('StupidMovies'),
('NotFunMovies'),
('ChinaMovies')

INSERT Movies
(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
VALUES
('Movie1', 1, '2000-12-24', 65.5, 1, 1 , DEFAULT , NULL),
('Movie2', 2, '2000-12-25', 40.5, 2, 1 , DEFAULT , NULL),
('Movie3', 3, '2000-12-26', 50.5, 3, 2 , DEFAULT , NULL),
('Movie4', 2, '2000-12-27', 120.5, 1, 1 , DEFAULT , NULL),
('Movie5', 1, DEFAULT, 80, 3, 2 , DEFAULT , 'Hello its a note')
CREATE DATABASE CarRental1

Use CarRental1

CREATE TABLE Categories
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
CategoryName NVARCHAR(100) NOT NULL,
DailyRate Decimal(6,2) NOT NULL,
WeeklyRate Decimal(6,2),
MonthlyRate Decimal(7,2),
WeekendRate Decimal(6,2)
)

CREATE TABLE Cars
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
PlateNumber NVARCHAR(10) NOT NULL,
Manufacturer NVARCHAR(20) NOT NULL,
CarYear INT NOT NULL,
CategoryId INT NOT NULL,
Doors TINYINT,
Condition NVARCHAR(20),
Picture VARBINARY(MAX) ,
Available NVARCHAR(5) NOT NULL
)

CREATE TABLE Employees
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
Title NVARCHAR(20) NOT NULL,
Notes NVARCHAR(MAX)
)

CREATE TABLE Customers
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
FullName NVARCHAR(50) NOT NULL,
DriverLicenseNumber VARCHAR(20) NOT NULL,
[Address] NVARCHAR(40),
City NVARCHAR (20),
ZipCode INT,
Notes NVARCHAR(MAX)
)

CREATE TABLE RentalOrders
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
EmployeeId INT NOT NULL,
CONSTRAINT CK_EmployeesRentalOrders FOREIGN KEY (EmployeeId) REFERENCES Employees (Id),
CustomerId INT NOT NULL,
CONSTRAINT CK_CustomersRentalOrders FOREIGN KEY (CustomerId) REFERENCES Customers (Id),
CarId INT NOT NULL,
CONSTRAINT CK_CarRentalOrders FOREIGN KEY (CarId) REFERENCES Cars(Id),
KilometerageStart INT NOT NULL,
KilometrageEnd INT NOT NULL,
TotalKilometrage INT,
StartDate DATETIME2 NOT NULL,
EndDate DATETIME2 NOT NULL,
TotalDays INT,
RateApplied Decimal(7,2) NOT NULL,
TaxRate DECIMAL(7,2) NOT NULL,
OrderStatus NVARCHAR(20) ,
Notes NVARCHAR(MAX)
)

INSERT INTO Categories(CategoryName,DailyRate)
VALUES ('Car', 20),
	   ('Bus', 30),
	   ('SUV', 40)

--SELECT * FROM Categories

INSERT INTO Cars(PlateNumber,Manufacturer,CarYear,CategoryId,Available)
VALUES ('A 1111 SV', 'VW', 1999, 1, 'Yes'),
	   ('A 1111 SS', 'VW', 1999, 1, 'Yes'),
	   ('A 1111 SC', 'VW', 1999, 1, 'Yes')

--SELECT * FROM Cars

INSERT INTO Employees(FirstName, LastName, Title)
VALUES ('Pesho', 'Ivanov', 'Chistach'),
	   ('Pesho', 'Ivanov', 'Prodavach'),
	   ('Pesho', 'Ivanov', 'Mehanik')

--SELECT * FROM Employees

INSERT INTO Customers(FullName, DriverLicenseNumber)
VALUES ('Ivan Georgiev', '123456'),
	   ('Ivan Georgiev', '1234567'),
	   ('Ivan Georgiev', '1234568')

--SELECT * FROM Custormers

INSERT INTO RentalOrders(EmployeeId, CustomerId, CarId, KilometerageStart,
KilometrageEnd,StartDate,EndDate,RateApplied,TaxRate)
VALUES (1,1,1,123456,124000,'10/12/2019','10/14/2019',240.00, 120.00),
	   (2,2,2,123456,124000,'10/10/2019','10/12/2019',240.00, 120.00),
	   (3,3,3,123456,124000,'10/10/2019','10/12/2019',240.00, 120.00)

--SELECT* FROM RentalOrders



CREATE DATABASE Hotel


CREATE TABLE Employees
(
Id INT NOT NULL IDENTITY PRIMARY KEY,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
Title NVARCHAR(20) NOT NULL,
Notes NVARCHAR(MAX)
)

CREATE TABLE Customers
(
AccountNumber INT NOT NULL IDENTITY PRIMARY KEY,
FirstName NVARCHAR(15) NOT NULL,
LastName NVARCHAR(15) NOT NULL,
PhoneNumber VARCHAR(15) NOT NULL,
EmergencyName NVARCHAR(15),
EmergencyNumber VARCHAR(15),
Notes NVARCHAR(MAX)
)

CREATE TABLE RoomStatus
(
RoomStatus NVARCHAR (20) PRIMARY KEY,
Notes NVARCHAR(MAX)
)

CREATE TABLE RoomTypes
(
RoomType NVARCHAR (20) PRIMARY KEY,
Notes NVARCHAR(MAX)
)

CREATE TABLE BedTypes
(
BedType NVARCHAR (20) PRIMARY KEY,
Notes NVARCHAR(MAX)
)

CREATE TABLE Rooms
(
RoomNumber INT PRIMARY KEY IDENTITY,
RoomType NVARCHAR(20) FOREIGN KEY (RoomType) REFERENCES RoomTypes(RoomType),
BedType NVARCHAR(20) FOREIGN KEY (BedType) REFERENCES BedTypes(BedType),
Rate DECIMAL(6,2),
RoomStatus NVARCHAR(50),
Notes NVARCHAR(MAX)
)

CREATE TABLE Payments(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
PaymentDate DATE,
AccountNumber INT,
FirstDateOccupied INT,
LastDateOccupied INT,
TotalDays INT,
AmountCharged DECIMAL(14,2),
TaxRate DECIMAL(8, 2),
TaxAmount DECIMAL(8, 2),
PaymentTotal DECIMAL(15, 2),
Notes NVARCHAR(MAX)
)

CREATE Table Occupancies(
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id),
DateOccupied DATE,
AccountNumber INT,
RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber),
RateApplied DECIMAL(6,2),
PhoneCharge DECIMAL(6,2),
Notes NVARCHAR(MAX)
)


INSERT INTO Employees
VALUES
('Velizar', 'Velikov', 'Receptionist', 'Nice customer'),
('Ivan', 'Ivanov', 'Concierge', 'Nice one'),
('Elisaveta', 'Bagriana', 'Cleaner', 'Poetesa')

INSERT INTO Customers
VALUES
( 'Ginka', 'Shikerova', '359888777888', 'Sistry mi', '7708315342', 'Kinky'),
( 'Chaika', 'Stavreva', '359888777888', 'Sistry mi', '7708315342', 'Lawer'),
( 'Mladen', 'Isaev', '359888777888', 'Sistry mi', '7708315342', 'Wants a call girl')

INSERT INTO RoomStatus(RoomStatus, Notes)
VALUES
(1,'Refill the minibar'),
(2,'Check the towels'),
(3,'Move the bed for couple')


INSERT INTO RoomTypes (RoomType, Notes)
VALUES
('Suite', 'Two beds'),
('Wedding suite', 'One king size bed'),
('Apartment', 'Up to 3 adults and 2 children')

INSERT INTO BedTypes
VALUES
('Double', 'One adult and one child'),
('King size', 'Two adults'),
('Couch', 'One child')


INSERT INTO Rooms (Rate, Notes)
VALUES
(12,'Free'),
(15, 'Free'),
(23, 'Clean it')

INSERT INTO Payments (EmployeeId, PaymentDate, AmountCharged)
VALUES
(1, '12/12/2018', 2000.40),
(2, '12/12/2018', 1500.40),
(3, '12/12/2018', 1000.40)

INSERT INTO Occupancies (EmployeeId, RateApplied, Notes) VALUES
(1, 55.55, 'too'),
(2, 15.55, 'much'),
(3, 35.55, 'typing')

UPDATE Payments 
SET TaxRate = TaxRate*0.97
SELECT TaxRate FROM Payments

TRUNCATE TABLE Occupancies
 
USE SoftUni
UPDATE Employees
SET Salary*=1.1
SELECT Salary FROM Employees