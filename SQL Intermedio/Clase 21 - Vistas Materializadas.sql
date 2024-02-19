/*
Clase 21 - Vistas Materializadas
*/
CREATE VIEW long_films AS
SELECT film_id, title, description, rental_duration, length
FROM film
WHERE length > 180;

SELECT *
FROM long_films;

UPDATE film 
SET rental_duration = rental_duration * 2
WHERE film_id = 24

UPDATE film 
SET length = 100 --181
WHERE film_id = 24;

CREATE MATERIALIZED VIEW long_films_mat AS
SELECT film_id, title, description, rental_duration, length
FROM film
WHERE length > 180
WITH DATA;

SELECT *
FROM long_films_mat;

REFRESH MATERIALIZED VIEW long_films_mat;

DROP MATERIALIZED VIEW long_films_mat;

SELECT *
FROM film
WHERE film_id = 24;

REFRESH MATERIALIZED VIEW long_films_mat WITH NO DATA;

INSERT INTO long_films_mat 
VALUES (10000, 'test', 'test', 1, 1)

UPDATE long_films_mat 
SET length = 200 --181
WHERE film_id = 24;

DELETE FROM long_films_mat
WHERE film_id = 24;

REFRESH MATERIALIZED VIEW CONCURRENTLY long_films_mat WITH DATA;

CREATE UNIQUE INDEX long_films_mat_idx ON long_films_mat (film_id);

UPDATE film 
SET length = 181 --181
WHERE film_id = 24;