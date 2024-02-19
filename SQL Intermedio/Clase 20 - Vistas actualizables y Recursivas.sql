/*
Clase 20 - Vistas actualizables y Recursivas
*/
DROP VIEW actors_with_A;

CREATE VIEW actors_with_A AS 
SELECT *
FROM actor 
WHERE first_name LIKE 'A%'
WITH CHECK OPTION;

SELECT *
FROM actors_with_A;

SELECT *
FROM actor;

INSERT INTO actors_with_A (first_name, last_name)
VALUES ('Test', 'Test');

UPDATE actors_with_A
SET last_update = now()
WHERE actor_id = 2;

CREATE OR REPLACE RECURSIVE VIEW actors (first_name) AS 
SELECT first_name
FROM actor
WHERE actor_id = 1

UNION
	SELECT DISTINCT a.first_name
	FROM actor a
	INNER JOIN actors act ON lower(RIGHT(act.first_name, 1)) = lower(LEFT(a.first_name, 1));

SELECT *
FROM actors;

DROP VIEW actors;

SELECT COUNT(1)
FROM actor;

CREATE RECURSIVE VIEW number_sequence(n) AS 
(
	SELECT 1 as n
   	UNION ALL
   	SELECT n + 1 FROM number_sequence
);

SELECT * 
FROM number_sequence 
LIMIT 100;