/*
Clase 16 - Crear Funciones
*/
CREATE OR REPLACE FUNCTION get_total_payment(payment decimal)
   RETURNS decimal 
   LANGUAGE plpgsql
  AS
$$
DECLARE
	tax_rate decimal = 0.12;
	comission_rate decimal = 0.05;
	total_payment decimal = 0;
BEGIN 
	total_payment = payment * (1 + tax_rate + comission_rate);
	RETURN total_payment;
END;
$$

SELECT get_total_payment(10)

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (1, 1, 1, 10*1.17, '2023-01-01')

INSERT INTO payment (customer_id, staff_id, rental_id, amount, payment_date)
VALUES (1, 1, 1, get_total_payment(10), '2023-01-01');

CREATE TABLE rates(
	rate_id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	sign SMALLINT NOT NULL DEFAULT 1 CHECK (sign IN (1, -1)),
	value NUMERIC(5, 2)
);

INSERT INTO rates (name, value) VALUES ('IVA', 0.12);
INSERT INTO rates (name, value) VALUES ('COMISION TC', 0.05);

SELECT *
FROM rates

CREATE OR REPLACE FUNCTION get_total_payment(payment decimal)
   RETURNS decimal 
   LANGUAGE plpgsql
  AS
$$
DECLARE
	--tax_rate decimal = 0.12;
	--comission_rate decimal = 0.05;
	total_payment decimal = 0;
BEGIN 
	SELECT (1 + SUM(sign * value)) * payment
	INTO total_payment
	FROM rates;
	
	--total_payment = payment * (1 + tax_rate + comission_rate);
	RETURN total_payment;
END;
$$

UPDATE rates
SET value = .15
WHERE name = 'IVA';

CREATE OR REPLACE FUNCTION get_total_payment(payment decimal, additional_discount decimal)
   RETURNS decimal 
   LANGUAGE plpgsql
  AS
$$
DECLARE
	total_payment decimal = 0;
BEGIN 
	SELECT (1 + SUM(sign * value)) * payment -  COALESCE(additional_discount, 0)
	INTO total_payment
	FROM rates;

	RETURN total_payment;
END;
$$

SELECT get_film_count(40, len_to => 90);

#SET TRANSACTION READ ONLY;

CREATE OR REPLACE FUNCTION get_payment_rates(payment decimal)
   RETURNS TABLE (name varchar(50), payment_rate decimal)
   LANGUAGE plpgsql
  AS
$$
DECLARE

BEGIN 
	
	RETURN QUERY
	SELECT r.name, payment * (1 + (sign * value)) payment_rate
	FROM rates r;

END;
$$

SELECT *
FROM get_payment_rates(10);