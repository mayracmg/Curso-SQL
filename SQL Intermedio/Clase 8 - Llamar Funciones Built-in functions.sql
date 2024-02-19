/*
Clase 8 - Llamar Funciones Built-in functions
*/
SELECT rental_duration, rental_duration % 2, mod(rental_duration, 2), round(replacement_cost, 1)
FROM film;

SELECT amount / 1.12, round(amount / 1.12, 2), trunc(amount / 1.12)
FROM payment;

SELECT PI(), power(2, 2) cuadrado, power(2, 3) cubo, random();

SELECT CURRENT_DATE, current_time, 
date_part('century', DATE '2023-01-01'),
date_part('century', DATE '1923-01-01'),
extract(century FROM DATE '1923-01-01'),
LOCALTIME, TO_DATE('2023_01_01', 'yyyy_mm_dd');

SELECT UPPER(first_name), LOWER(last_name), initcap('mayRA')
FROM staff;

SELECT first_name || '-' || last_name, CONCAT(first_name, ' ', last_name),
first_name || NULL con_null, concat(first_name, null) concat_con_null,
concat_ws(first_name, last_name, '.')
FROM staff;

SELECT first_name || '-' || last_name, CONCAT(first_name, ' ', last_name),
concat_ws(', ', first_name, last_name, 'otro')
FROM staff;

SELECT substring(customer_id, 1, 2)
FROM payment;

SELECT substring(CAST(customer_id AS VARCHAR), 1, 2)
FROM payment;

SELECT title, POSITION('a' IN title), split_part(title, ' ', 1), split_part(title, ' ', 2), split_part(title, ' ', 3)
FROM film;

SELECT title, string_to_array(title, ' '), UNNEST(string_to_array(title, ' '))
FROM film;

SELECT title, replace(title, 'a', '-')
FROM film;

SELECT address, REPLACE(REPLACE(REPLACE(REPLACE(address, '1', ''), '2', ''), '3', ''), '4', '')
FROM address;

SELECT address, REGEXP_REPLACE(address, '[[:digit:]]', '', 'g') regex
FROM address;