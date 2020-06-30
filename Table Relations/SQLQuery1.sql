CREATE DATABASE TableRelations

USE TableRelations

CREATE TABLE Passports
( PassportID INT PRIMARY KEY,
PassportNumber CHAR(8) NOT NULL)

CREATE TABLE Persons
(PersonID INT PRIMARY KEY,
FirstName NVARCHAR(50)  NOT NULL,
Salary DECIMAL(7,2) NOT NULL,
PassportID INT NOT NULL FOREIGN KEY REFERENCES Passports(PassportID) UNIQUE -- pri one to one UNIQUE
)

INSERT INTO Passports(PassportID, PassportNumber)
VALUES
('101',	'N34FG21B'),
('102',	'K65LO4R7'),
('103',	'ZE657QP2')

INSERT INTO Persons (PersonID, [FirstName], [Salary],[PassportID]) 
VALUES 
(1, 'Roberto', 43300, 102),
(2, 'Tom', 56100, 103),
(3, 'Yana', 60200, 101)

SELECT * FROM Persons

CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	EstablishedOn DATE NOT NULL
	)

CREATE TABLE Models(
	ModelID INT PRIMARY KEY,
	[Name] VARCHAR(50) NOT NULL,
	ManufacturerID INT NOT NULL FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
	)

INSERT INTO Manufacturers(ManufacturerID, [Name], EstablishedOn)
VALUES
(1, 'BMW', '03/07/1916'),
(2, 'Tesla', '01/01/2003'),
(3, 'Lada', '05/01/1966')

INSERT INTO Models(ModelID, [Name], ManufacturerID)
VALUES
(101, 'X1', 1),
(102, 'i6', 1),
(103, 'Model S', 2),
(104, 'Model X', 2),
(105, 'Model 3', 2),
(106, 'Nova', 3)

SELECT * FROM Models AS mo
JOIN Manufacturers AS ma
ON mo.ManufacturerID=ma.ManufacturerID

CREATE TABLE Students(
StudentID INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE Exams
(
ExamID INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE StudentsExams
(StudentID INT NOT NULL REFERENCES Students(StudentID),
ExamID INT NOT NULL REFERENCES Exams(ExamID),
PRIMARY KEY(StudentID, ExamID)) -- kompoziten primary key

INSERT INTO Students(StudentID,[Name])
VALUES
(1, 'Mila'),
(2, 'Toni'),
(3, 'Ron')

INSERT INTO Exams(ExamID,[Name])
VALUES
(101, 'SpringMVC'),
(102, 'Neo4j'),
(103, 'Oracle 11g')

INSERT INTO StudentsExams(StudentID, ExamID)
VALUES
(1, 101),
(1, 102),
(2, 101),
(3, 103),
(2, 102),
(2, 103)

SELECT * FROM StudentsExams AS se
JOIN Students AS s ON s.StudentID= se.StudentID
JOIN Exams AS e ON se.ExamID=e.ExamID 

CREATE TABLE Teachers 
(TeacherID INT PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL,
ManagerID INT FOREIGN KEY REFERENCES Teachers(TeacherID))

INSERT INTO Teachers (TeacherID, [Name], ManagerID)
VALUES 
(101,	'John',	NULL),
(102,	'Maya',	106),
(103,	'Silvia',	106),
(104,	'Ted',	105),
(105,	'Mark',	101),
(106,	'Greta',	101)


CREATE DATABASE University

USE[University]

CREATE TABLE Majors(
MajorID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL)

CREATE TABLE Students(
StudentID INT PRIMARY KEY IDENTITY,
StudentNumber VARCHAR(10) NOT NULL,
StudentName NVARCHAR(50) NOT NULL,
MajorID INT NOT NULL FOREIGN KEY REFERENCES Majors(MajorID)
)

CREATE TABLE Payments(
	PaymentID INT PRIMARY KEY IDENTITY,
	PaymantDate DATE NOT NULL,
	PaymentAmount DECIMAL(15,2) NOT NULL,
	StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID)
	)

CREATE TABLE Subjects(
SubjectID INT PRIMARY KEY IDENTITY, 
SubjectName NVARCHAR(50) NOT NULL)

CREATE TABLE Agenda(
StudentID INT NOT NULL FOREIGN KEY REFERENCES Students(StudentID),
SubjectID INT NOT NULL FOREIGN KEY REFERENCES Subjects(SubjectID),
PRIMARY KEY( StudentID, SubjectID)
)

USE [Geography]

SELECT MountainRange, PeakName, Elevation FROM Peaks
JOIN Mountains ON Peaks.MountainId = Mountains.Id
WHERE MountainRange='Rila'
ORDER BY Elevation DESC
SELECT * FROM Mountains

USE TableRelations

CREATE TABLE Cities 
(
CityID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR (50) NOT NULL)

CREATE Table Customers
(
CustomerID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR (50) NOT NULL,
BirthDay DATE ,
CityID INT NOT NULL FOREIGN KEY REFERENCES Cities(CityID))

CREATE TABLE ItemTypes
(ItemTypeID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR (50) NOT NULL)

CREATE TABLE Items 
(ItemID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR (50) NOT NULL,
ItemTypeID INT NOT NULL FOREIGN KEY REFERENCES ItemTypes(ItemTypeID))

CREATE Table Orders
(OrderID INT PRIMARY KEY IDENTITY,
CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerID))

CREATE TABLE OrderItems
(OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
ItemID INT FOREIGN KEY REFERENCES Items(ItemID),
PRIMARY KEY(OrderID, ItemId))


