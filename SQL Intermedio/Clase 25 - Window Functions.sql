/*
Clase 25 - Window Functions
*/
SELECT customer_id, amount, SUM(amount) OVER ()
FROM payment;

SELECT C.first_name, C.last_name, P.payment_id, P.amount
FROM payment P
INNER JOIN customer C ON P.customer_id = C.customer_id;

SELECT C.first_name, C.last_name, SUM(P.amount) Total
FROM payment P
INNER JOIN customer C ON P.customer_id = C.customer_id
GROUP BY C.first_name, C.last_name;

SELECT  SUM(P.amount) Total
FROM payment P
INNER JOIN customer C ON P.customer_id = C.customer_id;

SELECT C.first_name, C.last_name, P.payment_id, P.amount, 
SUM(P.amount) OVER (PARTITION BY c.customer_id)
FROM payment P
INNER JOIN customer C ON P.customer_id = C.customer_id
ORDER BY C.last_name;

SELECT C.first_name, C.last_name, P.payment_id, P.amount, 
ROW_NUMBER() OVER (PARTITION BY c.last_name ORDER BY p.AMOUNT)
FROM payment P
INNER JOIN customer C ON P.customer_id = C.customer_id
ORDER BY C.last_name;

SELECT C.first_name, C.last_name, P.payment_id, P.amount, 
SUM(P.amount) OVER (PARTITION BY c.customer_id),
AVG(P.amount) OVER w,
COUNT(P.amount) OVER x
FROM payment P
INNER JOIN customer C ON P.customer_id = C.customer_id
WINDOW w AS (PARTITION BY c.customer_id)
, x AS (PARTITION BY p.payment_id)
ORDER BY C.last_name;

SELECT C.first_name, C.last_name, P.payment_id, P.amount, P.payment_date,
LEAD(P.payment_date, 3) OVER (PARTITION BY c.customer_id ORDER BY P.payment_date),
LAG(P.payment_date) OVER (PARTITION BY c.customer_id ORDER BY P.payment_date)
FROM payment P
INNER JOIN customer C ON P.customer_id = C.customer_id
ORDER BY C.last_name, P.payment_date;