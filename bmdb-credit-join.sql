-- Join to produce summary of all movies and their respective credits
USE bmdb;

-- Result set should look like:
-- Movie Year Rating Actor (First and Last Name) Role

SELECT Title, Year, Rating, LastName + ', ' + FirstName  AS Actor, Role
  FROM Credit C
  JOIN Movie M ON M.Id = C.MovieId
  JOIN Actor A ON A.Id = C.ActorId
 ORDER BY Title, LastName;
