-- DELETE STATEMENT
SELECT *
  FROM SalesPerson;

-- CRUD: Create, Read, Update, Delete
--SELECT *
DELETE
  FROM SalesPerson
 WHERE Id = 1;

-- Delete 'em all!
DELETE
  FROM SalesPerson;

-- bmdb crud stuff
-- Insert a Movie
INSERT INTO Movie (Title, Year, Rating, Director)
VALUES
('Star Wars: Episode IV - A New Hope', 1977, 'PG', 'George Lucas'),
('Dummy Movie', 2024, 'R', 'Test Director');

SELECT *
  FROM Movie;

-- UPDATE Statement
UPDATE Movie
   SET Title = 'Super Awesome Movie',
       Rating = 'PG-13'
 WHERE Id = 5;

DELETE
  FROM MOVIE
 WHERE Id = 5;

-- Add an actor for this movie
-- Star Wars IV, Mark Hamill - Luke Skywalker 9/25/51
INSERT INTO Actor (FirstName, LastName, Gender, Birthdate)
VALUES
('Mark', 'Hamill', 'M', '1951-09-25');

SELECT * 
  FROM Actor;

-- Add credit
INSERT INTO Credit (MovieId, ActorId, Role)
VALUES
(4, 1, 'Luke Skywalker');

-- JOIN 3 tables to show the movie - actor - and role info
SELECT Title, Year, FirstName, LastName, Role
  FROM Credit C
  JOIN Movie M ON C.MovieId = M.Id
  JOIN Actor A ON C.ActorId = A.Id;