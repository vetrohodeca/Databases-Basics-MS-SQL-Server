CREATE DATABASE TripService
DROP DATABASE TripService
USE TripService

CREATE TABLE Cities
(
 Id INT PRIMARY KEY IDENTITY,
 Name NVARCHAR(20) NOT NULL,
 CountryCode CHAR(2) NOT NULL
)

CREATE TABLE Hotels
(
 Id INT PRIMARY KEY IDENTITY,
 Name NVARCHAR(30) NOT NULL,
 CityId INT FOREIGN KEY REFERENCES Cities NOT NULL,
 EmployeeCount INT NOT NULL,
 BaseRate DECIMAL(15,2)
)

CREATE TABLE Rooms
(
 Id INT PRIMARY KEY IDENTITY,
 Price Decimal (15,2) NOT NULL,
 Type NVARCHAR(20) NOT NULL,
 Beds INT NOT NULL,
 HotelId INT FOREIGN KEY REFERENCES Hotels NOT NULL
)

CREATE TABLE Trips
(
 Id INT PRIMARY KEY IDENTITY,
 RoomId INT FOREIGN KEY REFERENCES Rooms,
 BookDate  DATETIME2 NOT NULL,
 ArrivalDate DATETIME2 NOT NULL,
 ReturnDate DATETIME2 NOT NULL,
 CancelDate DATETIME2 ,
 CHECK (BookDate<=ArrivalDate),
 CHECK(ArrivalDate<=ReturnDate) 
) 

CREATE TABLE Accounts
(
 Id INT PRIMARY KEY IDENTITY,
 FirstName NVARCHAR(50) NOT NULL,
 MiddleName NVARCHAR(20),
 LastName NVARCHAR(50) NOT NULL,
 CityId INT FOREIGN KEY REFERENCES Cities NOT NULL,
 BirthDate DATETIME2 NOT NULL,
 Email NVARCHAR(100) UNIQUE NOT NULL
)

CREATE TABLE AccountsTrips
(
 AccountId INT FOREIGN KEY REFERENCES Accounts NOT NULL,
 TripId INT FOREIGN KEY REFERENCES Trips NOT NULL,
 Luggage INT  CHECK(Luggage>=0) NOT NULL,
)

INSERT INTO Accounts VALUES
('John', 'Smith', 'Smith', 34, '1975-07-21', 'j_smith@gmail.com'),
('Gosho',NULL, 'Petrov', 11, '1978-05-16', 'g_petrov@gmail.com'),
('Ivan', 'Petrovich', 'Pavlov',	59,	'1849-09-26', 'i_pavlov@softuni.bg'),
('Friedrich', 'Wilhelm', 'Nietzsche', 2, '1844-10-15',	'f_nietzsche@softuni.bg')

INSERT INTO Trips VALUES
(101, '2015-04-12', '2015-04-14', '2015-04-20',	'2015-02-02'),
(102, '2015-07-07',	'2015-07-15', '2015-07-22',	'2015-04-29'),
(103, '2013-07-17',	'2013-07-23', '2013-07-24',	NULL),
(104, '2012-03-17',	'2012-03-31', '2012-04-01',	'2012-01-10'),
(109, '2017-08-07',	'2017-08-28', '2017-08-29',	NULL)

UPDATE Rooms
SET Price=Price+Price*0.14
WHERE HotelId IN(5,7,9)

DELETE FROM AccountsTrips
WHERE AccountId IN(
SELECT Id FROM Accounts
WHERE Id=47
)
DELETE FROM Accounts
WHERE Id=47

SELECT a.FirstName, a.LastName,  FORMAT(a.BirthDate, 'MM-dd-yyyy'), c.[Name] AS Hometown, a.Email FROM Accounts AS a
INNER JOIN Cities AS c
ON c.Id=a.CityId
WHERE a.FirstName LIKE '[e]%'
ORDER BY c.Name ASC

SELECT c.Name ,COUNT(h.CityID) AS Hotels FROM Cities AS c
INNER JOIN Hotels as h
ON h.CityID=c.Id
GROUP BY h.CityId, c.Name
ORDER BY COUNT(h.CityID) DESC, c.Name


SELECT a.Id,a.FirstName+ ' '+ a.LastName AS FullName, MAX(DATEDIFF(day, ArrivalDate,ReturnDate)) AS LongestTrip,MIN (DATEDIFF(day, ArrivalDate,ReturnDate)) AS ShotestTrip FROM Accounts AS a
INNER JOIN AccountsTrips AS at
ON at.AccountId=a.Id
INNER JOIN Trips AS t
ON t.Id= at.TripId
GROUP BY a.Id, t.CancelDate,a.MiddleName, a.FirstName, a.LastName
HAVING t.CancelDate IS NULL AND a.MiddleName IS NULL
ORDER BY LongestTrip DESC, ShotestTrip ASC



SELECT TOP(10) c.Id ,c.Name, c.CountryCode, Count(a.Id) AS Accounts FROM Cities AS c
JOIN Accounts as a
ON a.CityId= c.Id
GROUP BY c.Name, c.Id,c.CountryCode
ORDER BY COUNT(a.Id) DESC


SELECT a.Email,c.Name FROM Accounts AS a
INNER JOIN Cities AS c
ON c.Id= a.CityId


SELECT a.Id, a.Email, c.Name,  Count(a.Id) AS Trips FROM Accounts AS a
INNER JOIN AccountsTrips AS ac
ON ac.AccountId=a.Id
INNER JOIN Trips AS t
ON t.Id=ac.TripId
INNER JOIN Rooms AS r
ON r.Id= t.RoomId
INNER JOIN Hotels AS h
ON h.Id=r.HotelId
INNER JOIN Cities as c
ON c.Id=h.CityId
WHERE a.CityId=h.CityId
GROUP BY a.Id, a.Email, c.Name
ORDER BY Count(a.Id) DESC, a.Id ASC


SELECT t.Id, a.FirstName+' '+a.MiddleName+' '+a.LastName AS FullName, c.Name AS [From] FROM Trips AS t
JOIN AccountsTrips AS at
ON t.Id=at.TripId
JOIN Accounts AS a
ON a.Id=at.AccountId
JOIN Cities AS c
ON c.Id=a.CityId
ORDER BY FullName, TripId


SELECT t.Id, CONCAT(a.FirstName,' ',a.MiddleName,' ',a.LastName) AS [Full Name],
c.Name AS [From],ci.[Name] AS [To],
CASE
 WHEN CancelDate IS NULL
 THEN CONCAT(DATEDIFF(day, t.ArrivalDate, t.ReturnDate), ' days') 
 ELSE 'Canceled' 
 END AS Duration
FROM Accounts AS a
INNER JOIN Cities AS c
ON c.Id=a.CityId
INNER JOIN AccountsTrips AS ac 
ON a.Id=ac.AccountId
INNER JOIN Trips AS t 
ON t.Id=ac.TripId
INNER JOIN Rooms as r
ON r.Id= t.RoomId
INNER JOIN Hotels as h
ON h.Id=r.HotelId
INNER JOIN Cities as ci
ON h.CityId=ci.Id
ORDER BY [Full Name] ASC, TripId