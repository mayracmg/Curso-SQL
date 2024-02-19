/*
Clase 27 - Fine Tunning
*/
EXPLAIN 
SELECT * 
FROM film;

EXPLAIN 
SELECT * 
FROM film
WHERE film_id = 1;

EXPLAIN 
SELECT * 
FROM film
WHERE film_id = 1
OR film_id = 2;

EXPLAIN 
SELECT * 
FROM film
WHERE film_id <= 2;