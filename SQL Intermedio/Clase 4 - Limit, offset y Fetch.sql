/*
Clase 4 - Limit, offset y Fetch
*/
SELECT film_id, title, release_year
FROM film
ORDER BY film_id
LIMIT 5;

SELECT film_id, title, release_year
FROM film
ORDER BY film_id
LIMIT 5 OFFSET 3;

SELECT film_id, title, rental_rate
FROM film
ORDER BY rental_rate DESC
LIMIT 10;

SELECT film_id, title
FROM film
ORDER BY title 
FETCH FIRST ROW ONLY;

SELECT film_id, title
FROM film
ORDER BY title 
FETCH FIRST 1 ROW ONLY;

SELECT film_id, title
FROM film
ORDER BY title 
FETCH FIRST 5 ROW ONLY;

SELECT film_id, title
FROM film
ORDER BY title 
OFFSET 5 ROWS 
FETCH FIRST 5 ROW ONLY;