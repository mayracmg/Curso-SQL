/*
Clase 10 - GROUP BY, GROUPING SETS, CUBE, ROLLUP
*/
SELECT rating, rental_duration, max(replacement_cost) replacement_cost, round(avg(length), 2) length
FROM film
GROUP BY GROUPING SETS (
        (rating, rental_duration),
        (rating),
        (rental_duration)
        , ()
);

SELECT GROUPING(rating) grouping_rating, GROUPING(rental_duration) grouping_rental_duration,
grouping(rental_rate) grouping_rental_rate,
rating, rental_duration, max(replacement_cost) replacement_cost, round(avg(length), 2) length
FROM film
GROUP BY GROUPING SETS (
		(rating, rental_duration, rental_rate),
        (rating, rental_duration),
        (rating),
        (rental_duration)
);

SELECT GROUPING(rating) grouping_rating, GROUPING(rental_duration) grouping_rental_duration,
grouping(rental_rate) grouping_rental_rate,
rating, rental_duration, max(replacement_cost) replacement_cost, round(avg(length), 2) length
FROM film
GROUP BY GROUPING SETS (
		(rating, rental_duration, rental_rate),
        (rating, rental_duration),
        (rating),
        (rental_duration)
)
HAVING GROUPING(rating) = 0
AND GROUPING(rental_duration) = 0
AND GROUPING(rental_rate) = 1;

SELECT rating, rental_duration, rental_rate, max(replacement_cost) replacement_cost, round(avg(length), 2) length
FROM film
GROUP BY CUBE (rating, rental_duration, rental_rate);

SELECT rating, rental_duration, rental_rate, max(replacement_cost) replacement_cost
FROM film
GROUP BY rating, CUBE (rental_duration, rental_rate);

SELECT rating, rental_duration, max(replacement_cost) replacement_cost
FROM film
GROUP BY
ROLLUP (rating, rental_duration);

SELECT rating, rental_duration, rental_rate, max(replacement_cost) replacement_cost
FROM film
GROUP BY ROLLUP (rating, rental_duration, rental_rate);

SELECT rating, rental_duration, rental_rate, max(replacement_cost) replacement_cost
FROM film
GROUP BY rating, ROLLUP (rental_duration, rental_rate);