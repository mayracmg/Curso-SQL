/*
Clase 11 - Truncate Table
*/
TRUNCATE TABLE payment;

TRUNCATE TABLE rental, inventory;

INSERT INTO inventory (film_id, store_id)
VALUES (1, 1);

TRUNCATE TABLE table_name 
CASCADE;

SELECT *
FROM film;

SELECT *
FROM film_category;

SELECT *
FROM film_actor;

TRUNCATE TABLE film
CASCADE;