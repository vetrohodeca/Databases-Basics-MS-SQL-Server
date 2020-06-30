CREATE DATABASE Bitbucket

USE Bitbucket

CREATE Table Users
(
 Id INT Primary Key Identity,
 Username NVARCHAR(30) NOT NULL,
 Password NVARCHAR(30) NOT NULL,
 Email NVARCHAR(50) NOT NULL
)

CREATE Table Repositories
(
 Id INT Primary Key Identity,
 Name NVARCHAR(50) NOT NULL
)

CREATE Table RepositoriesContributors
(
 RepositoryId INT FOREIGN KEY REFERENCES Repositories (Id) NOT NULL,
 ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL,
 PRIMARY KEY (RepositoryId,ContributorId)  
)

CREATE Table Issues
( 
 Id INT PRIMARY KEY IDENTITY,
 Title NVARCHAR(255) NOT NULL,
 IssueStatus CHAR(6) NOT NULL,
 RepositoryId INT REFERENCES Repositories(Id) NOT NULL,
 AssigneeId INT REFERENCES Users (Id) NOT NULL,
)

CREATE Table Commits
(
 Id INT PRIMARY KEY IDENTITY,
 Message CHAR(255) NOT NULL,
 IssueId INT FOREIGN KEY REFERENCES Issues(Id),
 RepositoryId INT FOREIGN KEY REFERENCES Repositories(Id) NOT NULL,
 ContributorId INT FOREIGN KEY REFERENCES Users(Id) NOT NULL
 )

 CREATE TABLE Files
 (
  Id INT PRIMARY KEY IDENTITY,
  Name CHAR(100) NOT NULL,
  Size DECIMAL(15,2) NOT NULL,
  ParentId INT FOREIGN KEY REFERENCES Files(Id),
  CommitId INT FOREIGN KEY REFERENCES Commits(Id) NOT NULL
 )

 INSERT INTO Files (Name,Size,ParentId,CommitId)
 VALUES
 ('Trade.idk',	2598.0,	1,	1),
 ('menu.net',	9238.31,	2,	2),
 ('Administrate.soshy',	1246.93,	3,	3),
 ('Controller.php',  7353.15,	4,	4),
 ('Find.java',	9957.86,	5,	5),
 ('Controller.json',	14034.87,	3,	6),
 ('Operate.xix',	7662.92,	7,	7)

 INSERT INTO Issues (Title,	IssueStatus,RepositoryId,AssigneeId)
 VALUES
 ('Critical Problem with HomeController.cs file', 'open  ',	1,	4),
 ('Typo fix in Judge.html', 'open  ', 4,3),
 ('Implement documentation for UsersService.cs'	,'closed' ,8 ,2),
 ('Unreachable code in Index.cs', 'open  ',9,8)

 UPDATE Issues SET IssueStatus = 'Closed'
 WHERE AssigneeId = 6

 DELETE FROM RepositoriesContributors
 WHERE RepositoryId IN(
 SELECT Id FROM Repositories
 WHERE Name='Softuni-Teamwork'
 )

 DELETE FROM Issues
 WHERE RepositoryId IN(
 SELECT Id FROM Repositories
 WHERE Name='Softuni-Teamwork'
 )

 SELECT Id,Message,RepositoryId,ContributorId FROM Commits
 ORDER BY Id, Message,RepositoryId,ContributorId

 SELECT Id,Name,Size FROM Files
 WHERE Size>1000 AND Name LIKE '%html%'
 ORDER BY Size DESC, Id ASC, Name ASC

 SELECT i.Id, u.Username +' : '+i.Title FROM Users u
 INNER JOIN Issues AS i
 ON I.AssigneeId=U.Id
 ORDER BY i.Id DESC, i.AssigneeId ASC
 SELECT * FROM Files

SELECT f1.Id,f1.Name,CONCAT(f1.Size,'KB') AS SizeFROM Files f1LEFT JOIN Files f2 ON f1.Id=f2.ParentIdWHERE f2.ParentId IS NULLORDER BY f1.Id ASC, f1.Name ASC, f1.Size DESCSELECT TOP (5) r.Id, r.Name, COUNT(c.RepositoryId) AS [Commits] FROM Repositories AS rINNER JOIN Commits AS c	ON c.RepositoryId=r.IdLEFT JOIN RepositoriesContributors AS rc
ON rc.RepositoryId = r.IdGROUP BY r.Id, r.NameORDER BY [Commits] DESC, r.Id, r.[Name]SELECT u.Username, AVG(f.Size) AS Size FROM	Commits as cJOIN Users AS uON c.ContributorId=u.IdJOIN Files AS fON f.CommitId=c.IdGROUP BY u.UsernameORDER BY Size DESC, u.Username 