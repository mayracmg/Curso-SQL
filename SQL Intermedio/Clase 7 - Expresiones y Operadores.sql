/*
Clase 7 - Expresiones y Operadores
*/
SELECT amount, CASE WHEN amount < 3 THEN 'Barato' 
	WHEN amount >= 3 AND amount < 5 THEN 'Promedio' 	
	ELSE 'Caro' END case_end,
NULLIF(staff_id, 1) null_if
FROM payment;

SELECT address_id, address, address2, coalesce(address2, '')
FROM address;

SELECT amount, 
NULLIF(CASE WHEN amount < 3 THEN 'Barato' 
	WHEN amount >= 3 AND amount < 5 THEN 'Promedio' 	
	ELSE 'Caro' END , 'Caro') null_if
FROM payment;

SELECT *
FROM country
WHERE (CASE WHEN country IN ('Guatemala', 'Honduras', 'Costa Rica', 'Honduras') THEN 'Centro America'
WHEN country IN ('Mexico', 'Canada', 'United States') THEN 'Norte America'
ELSE 'Otro' END) = 'Otro'

SELECT *
FROM payment
WHERE CASE WHEN amount < 3 THEN 'Barato' 
	WHEN amount >= 3 AND amount < 5 THEN 'Promedio' 	
	ELSE 'Caro' END = 'Caro';

SELECT *, GREATEST(1, 2, 3), least(1, 2, 3)
FROM film;

SELECT first_name, last_name,
	EXTRACT(YEAR FROM last_update) AS YEAR,
	EXTRACT(MONTH FROM last_update) AS MONTH,
	EXTRACT(DAY FROM last_update) AS DAY
FROM actor;

SELECT actor_id, first_name, last_name, 
	NOW() - last_update days_between
FROM actor;

SELECT customer_id, amount, amount / 1.12 monto_sin_iva, amount - (amount / 1.12) IVA
FROM payment;

SELECT first_name || '-' || last_name, LEFT(first_name, 1) inicial, right(first_name, 1) FINAL,
REPLACE(first_name, 'i', '*') REPLACE, substring(first_name, 2, 5),
TRIM('    mayra    ') trim, ltrim('   mayra   ') ltrim, rtrim('   mayra   ') rtrim
FROM staff;

SELECT amount, CONCAT('Clasificacion: ', 
	NULLIF(CASE WHEN amount < 3 THEN 'Barato' 
	WHEN amount >= 3 AND amount < 5 THEN 'Promedio' 	
	ELSE 'Caro' END , 'Caro'))
FROM payment;

SELECT amount, 
length(CONCAT('Clasificacion: ', 
	NULLIF(CASE WHEN amount < 3 THEN 'Barato' 
	WHEN amount >= 3 AND amount < 5 THEN 'Promedio' 	
	ELSE 'Caro' END , 'Caro'))) * 2 - 1
FROM payment;

SELECT *, (SELECT AVG(amount) FROM payment) PROMEDIO
FROM payment
WHERE CASE WHEN amount < 3 THEN 'Barato' 
	WHEN amount >= 3 AND amount < (SELECT AVG(amount) FROM payment) THEN 'Promedio' 	
	ELSE 'Caro' END = 'Caro';
	
SELECT rental_duration, rental_duration < 5
FROM film;

SELECT rental_duration, title < 5
FROM film;

SELECT rental_duration, rental_duration < 4 < 5
FROM film;

SELECT *, address2 IS NULL is_null, address2 IS UNKNOWN IS_UNKNOWN
FROM address;

SELECT staff_id, first_name, active, active IS NULL is_null, active IS UNKNOWN IS_UNKNOWN,
active IS NOT NULL is_null, active IS NOT UNKNOWN IS_UNKNOWN
FROM staff;

SELECT MAX(length), category_id
FROM film
INNER JOIN film_category USING(film_id)
GROUP BY category_id;

SELECT title, length
FROM film
WHERE length >= ALL(
    SELECT MAX(length)
    FROM film
    INNER JOIN film_category USING(film_id)
    GROUP BY  category_id );
	
SELECT MAX(length), category_id
FROM film
INNER JOIN film_category USING(film_id)
GROUP BY category_id;

SELECT title, length
FROM film
WHERE length >= ANY(
    SELECT MAX(length)
    FROM film
    INNER JOIN film_category USING(film_id)
    GROUP BY  category_id );

SELECT title, length
FROM film
WHERE EXISTS(
    SELECT MAX(length)
    FROM film
    INNER JOIN film_category USING(film_id)
    GROUP BY  category_id );

SELECT title, length
FROM film F
WHERE EXISTS(
    SELECT MAX(length), category_id
    FROM film 
    INNER JOIN film_category USING(film_id)
    WHERE length * 4 < F.length
    GROUP BY  category_id );