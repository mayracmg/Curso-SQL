/*
Clase 12 - UPDATE JOIN, DELETE USING, UPSERT, MERGE
*/
SELECT *
FROM film;

SELECT *
FROM category

UPDATE film f
SET rental_rate = rental_rate + 0.5
FROM film_category fc
INNER JOIN category c ON fc.category_id = c.category_id
WHERE fc.film_id = f.film_id
AND c.name = 'Comedy';

SELECT * 
FROM film_category fc, film f, category c 
WHERE fc.film_id = f.film_id
AND c.category_id = fc.category_id
AND c.name = 'Comedy'
AND f.rental_duration = 5

DELETE FROM film_category fc
USING film f, category c 
WHERE fc.film_id = f.film_id
AND c.category_id = fc.category_id
AND c.name = 'Comedy'
AND f.rental_duration = 5;

SELECT *
FROM city
WHERE city_id >= 600;

SELECT *
FROM country;

INSERT INTO city (city_id, city, country_id)
VALUES(601, 'Guatemala', 115) 
ON CONFLICT ON CONSTRAINT city_pkey 
DO NOTHING;

INSERT INTO city (city_id, city, country_id)
VALUES(601, 'Guatemala City', 115) 
ON CONFLICT ON CONSTRAINT city_pkey 
DO UPDATE SET city = 'Guatemala City';

MERGE INTO address a
USING city c
ON c.city_id = a.city_id
WHEN MATCHED AND a.city_id = 1 AND a.postal_code IS NULL
THEN
  UPDATE SET postal_code = '11111'
WHEN MATCHED AND a.city_id = 2 
THEN
  UPDATE SET address2 = 'Test'
WHEN NOT MATCHED THEN
  INSERT (address, district, city_id, phone)
  VALUES ('Panajachel', 'Solola', 1, '12345678');


BEGIN;

MERGE INTO address a
USING city c
ON c.city_id = a.city_id
WHEN MATCHED AND a.city_id = 1
THEN
  UPDATE SET postal_code = '44444'
WHEN MATCHED AND c.city_id > 600
THEN
  DELETE;
 
ROLLBACK;