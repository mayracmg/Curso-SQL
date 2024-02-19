/*
Clase 13 - Copiar / Clonar tablas
*/
CREATE TABLE film3 AS (SELECT * FROM film) WITH NO DATA;

SELECT *
FROM film3;

CREATE TABLE film2 AS
SELECT *
FROM film;

CREATE TABLE action_film AS
SELECT film_id,
    title,
    release_year,
    length,
    rating
FROM film
INNER JOIN film_category USING (film_id)
WHERE category_id = 1;

SELECT * 
FROM action_film;

CREATE TABLE film5 (LIKE film);

CREATE TABLE country2()
INHERITS (country);

SELECT *
FROM country2;

SELECT *
FROM country;

INSERT INTO country2 (country)
VALUES ('Guatemala 1')

UPDATE country 
SET country = 'Guatemala Copy'
WHERE country_id =  141;

SELECT *
FROM ONLY country;

CREATE UNLOGGED TABLE city_copy
AS TABLE city;