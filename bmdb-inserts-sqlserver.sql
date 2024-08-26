-- bmdb inserts
-- insert movies
INSERT INTO Movie (title, year, rating, director) VALUES
('Ghostbusters: Frozen Empire', 2024, 'PG-13', 'Jason Reitman'),
('Ant-Man', 2015, 'PG-13', 'Peyton Reed'),
('Avengers: Endgame', 2019, 'PG-13', 'Anthony Russo, Joe Russo');


Select * from Movie;


-- insert actors
-- Actors for Ghostbusters: Frozen Empire
INSERT INTO Actor (firstName, lastName, gender, birthDate) VALUES
('Mckenna', 'Grace', 'F', '2006-06-25'),  -- Phoebe Spengler
('Finn', 'Wolfhard', 'M', '2002-12-23'),  -- Trevor Spengler
('Carrie', 'Coon', 'F', '1981-01-24'),     -- Callie Spengler
('Paul', 'Rudd', 'M', '1969-04-06');       -- Gary Grooberson

-- Actors for Ant-Man (Paul Rudd already inserted, so only new actors here)
INSERT INTO Actor (firstName, lastName, gender, birthDate) VALUES
('Evangeline', 'Lilly', 'F', '1979-08-03'), -- Hope van Dyne
('Michael', 'Douglas', 'M', '1944-09-25'); -- Hank Pym

-- Actors for Avengers: Endgame
INSERT INTO Actor (firstName, lastName, gender, birthDate) VALUES
('Robert', 'Downey Jr.', 'M', '1965-04-04'), -- Tony Stark
('Chris', 'Evans', 'M', '1981-06-13'),      -- Steve Rogers
('Scarlett', 'Johansson', 'F', '1984-11-22'); -- Natasha Romanoff

SELECT *
  FROM Actor;
-- insert credits
-- Credits for Ghostbusters: Frozen Empire
INSERT INTO Credit (movieId, actorId, role) VALUES
(1, 1, 'Phoebe Spengler'),
(1, 2, 'Trevor Spengler'),
(1, 3, 'Callie Spengler'),
(1, 4, 'Gary Grooberson');

-- Credits for Ant-Man
INSERT INTO Credit (movieId, actorId, role) VALUES
(2, 4, 'Scott Lang'),
(2, 5, 'Hope van Dyne'),
(2, 6, 'Hank Pym');

-- Credits for Avengers: Endgame
INSERT INTO Credit (movieId, actorId, role) VALUES
(3, 7, 'Tony Stark'),
(3, 8, 'Steve Rogers'),
(3, 9, 'Natasha Romanoff');

select * from credit