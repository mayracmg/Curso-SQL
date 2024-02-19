/*
Clase 22 - Tablas Pivote
*/
SELECT f.title row_name, f.film_id, C.name category, 1 value
FROM film f
INNER JOIN film_category fc ON fc.film_id = f.film_id
INNER JOIN category C ON C.category_id = fc.category_id;

BEGIN;
INSERT INTO film_category (film_id, category_id)
VALUES (1, 3), (1, 4)

SELECT * 
FROM category;
ROLLBACK;

SELECT *
FROM crosstab(
  'SELECT f.title film, C.name category, ''✔️'' value
	FROM film f
	INNER JOIN film_category fc ON fc.film_id = f.film_id
	INNER JOIN category C ON C.category_id = fc.category_id
	ORDER BY 1, 2
	', 'SELECT name FROM category')
AS (film varchar(255), 
ACTION TEXT, 
Animation TEXT,
Children TEXT, 
Classics TEXT,
Comedy TEXT,
Documentary TEXT,
Drama TEXT,
FAMILY TEXT,
"FOREIGN" TEXT,
Games TEXT,
Horror TEXT,
Music TEXT,
"NEW" TEXT,
"Sci-Fi" TEXT,
Sports TEXT,
Travel text
);

SELECT EXTRACT(YEAR FROM payment_date) "YEAR", EXTRACT(MONTH FROM payment_date) "MONTH", amount
FROM payment

SELECT *
FROM crosstab(
  'SELECT extract(YEAR FROM payment_date) "YEAR", 
	extract(MONTH FROM payment_date) "MONTH", 
	SUM(amount) amount
	FROM payment
	GROUP BY "YEAR", "MONTH"
	ORDER BY 1, 2
	',
  'SELECT m FROM generate_series(1, 12) m'
) as (
  year INT,
  "Jan" decimal,
  "Feb" decimal,
  "Mar" decimal,
  "Apr" decimal,
  "May" decimal,
  "Jun" decimal,
  "Jul" decimal,
  "Aug" decimal,
  "Sep" decimal,
  "Oct" decimal,
  "Nov" decimal,
  "Dec" decimal
);

SELECT F.title Pelicula, I.store_id Tienda, COUNT(inventory_id) Unidades
FROM inventory I
INNER JOIN film F ON I.film_id = F.film_id
GROUP BY F.title, I.store_id
ORDER BY 1, 2;

SELECT *
FROM crosstab(
  'SELECT F.title pelicula,
	store_id AS tienda, 
	COUNT(inventory_id) unidades
	FROM inventory I
	INNER JOIN film F ON I.film_id = F.film_id
	GROUP BY pelicula, tienda
	ORDER BY 1, 2
	'
	)
AS (
	pelicula_dd VARCHAR(255),
	Tienda_1 BIGINT, 
	Tienda_2 BIGINT
);

SELECT *
FROM crosstab2(
  'SELECT cast(F.title as text) film,
	store_id stre, 
	cast(COUNT(inventory_id) as text) unidades
	FROM inventory I
	INNER JOIN film F ON I.film_id = F.film_id
	GROUP BY 1, 2
	ORDER BY 1, 2
	');

CREATE TYPE my_crosstab_int_12_cols AS (
    year INT,
    jan DECIMAL,
    feb DECIMAL,
    mar DECIMAL,
    apr DECIMAL,
    may DECIMAL,
    jun DECIMAL,
    jul DECIMAL,
    aug DECIMAL,
    sep DECIMAL,
    oct DECIMAL,
    nov DECIMAL,
    dec DECIMAL
);


CREATE OR REPLACE FUNCTION tablefunc_crosstab12(text)
    RETURNS setof my_crosstab_int_12_cols 
    AS '$libdir/tablefunc','crosstab' LANGUAGE C STABLE STRICT;

SELECT *
FROM tablefunc_crosstab12(
  'SELECT cast(extract(YEAR FROM payment_date) as int) "YEAR", 
	extract(MONTH FROM payment_date) "MONTH", 
	SUM(amount) amount
	FROM payment
	GROUP BY "YEAR", "MONTH"
	ORDER BY 1, 2
	');