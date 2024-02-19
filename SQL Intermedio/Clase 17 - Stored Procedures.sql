/*
Clase 17 - Stored Procedures
*/
CREATE SCHEMA reports;

CREATE TABLE reports.daily_payments (
	daily_payment_id SERIAL PRIMARY KEY,
	payment_date DATE,
	staff_id INT REFERENCES public.staff(staff_id),
	total_transactions INT,
	total_amount NUMERIC(5, 2),
	average_amount NUMERIC(5, 2),
	min_amount NUMERIC(5, 2),
	max_amount NUMERIC(5, 2),
	execution_date TIMESTAMP,
	execution_user VARCHAR(50),
	execution_number INT
);

SELECT payment_date::date, 
	staff_id, 
	COUNT(payment_id) total_transactions, 
	SUM(amount) total_amount,
	AVG(amount) average_amount,
	MIN(amount) min_amount,
	MAX(amount) max_amount
FROM payment
--WHERE payment_date::date = current_date
GROUP BY payment_date::date, staff_id;

INSERT INTO payment VALUES (DEFAULT, 1, 1, 1, 10, CURRENT_TIMESTAMP);
INSERT INTO payment VALUES (DEFAULT, 1, 1, 1, 100, CURRENT_TIMESTAMP);
INSERT INTO payment VALUES (DEFAULT, 2, 2, 2, 20, CURRENT_TIMESTAMP);
INSERT INTO payment VALUES (DEFAULT, 2, 2, 2, 200, CURRENT_TIMESTAMP);

CREATE OR REPLACE PROCEDURE reports.generate_daily_payments ()
LANGUAGE plpgsql    
AS $$
DECLARE
	v_execution_number INT;
	v_execution_date TIMESTAMP = CURRENT_TIMESTAMP;
	v_execution_user reports.daily_payments.execution_user%TYPE := USER;
BEGIN

	SELECT COALESCE(MAX(execution_number) + 1, 1)
	INTO v_execution_number
	FROM reports.daily_payments
	WHERE payment_date = CURRENT_DATE;
	
    INSERT INTO reports.daily_payments (
		payment_date,
		staff_id,
		total_transactions,
		total_amount,
		average_amount,
		min_amount,
		max_amount,
		execution_date,
		execution_user,
		execution_number
    )
    SELECT payment_date::DATE, 
		staff_id, 
		COUNT(payment_id), 
		SUM(amount),
		AVG(amount),
		MIN(amount),
		MAX(amount),
		v_execution_date,
		v_execution_user,
		v_execution_number
	FROM payment
	WHERE payment_date::date = current_date
	GROUP BY payment_date::date, staff_id;

	COMMIT;

END;
$$

DROP PROCEDURE reports.generate_daily_payments(date);

DO $$
DECLARE 
	variable INT;
BEGIN 
	CALL reports.generate_daily_payments('2007-02-14', variable);
	
	RAISE NOTICE '%', variable;

END; $$

CREATE OR REPLACE PROCEDURE reports.generate_daily_payments (
	IN p_payment_date DATE,
	OUT p_execution_number INT
)
LANGUAGE plpgsql    
AS $$
DECLARE
	v_execution_number INT;
	v_execution_date TIMESTAMP = CURRENT_TIMESTAMP;
	v_execution_user reports.daily_payments.execution_user%TYPE := USER;
BEGIN

	SELECT COALESCE(MAX(execution_number) + 1, 1)
	INTO v_execution_number
	FROM reports.daily_payments
	WHERE payment_date = p_payment_date;
	
    INSERT INTO reports.daily_payments (
		payment_date,
		staff_id,
		total_transactions,
		total_amount,
		average_amount,
		min_amount,
		max_amount,
		execution_date,
		execution_user,
		execution_number
    )
    SELECT payment_date::DATE, 
		staff_id, 
		COUNT(payment_id), 
		SUM(amount),
		AVG(amount),
		MIN(amount),
		MAX(amount),
		v_execution_date,
		v_execution_user,
		v_execution_number
	FROM payment
	WHERE payment_date::date = p_payment_date
	GROUP BY payment_date::date, staff_id;

	p_execution_number = v_execution_number;

	IF p_execution_number >= 10 THEN
		ROLLBACK;
		RAISE NOTICE 'You cant execute this anymore.';
	ELSE
		COMMIT;
	END IF;

	RAISE NOTICE 'Execution Number: %', p_execution_number;

	--COMMIT;
	--ROLLBACK;
END;
$$

CALL reports.generate_daily_payments('2007-02-19', :variable);

ALTER PROCEDURE reports.generate_daily_payments(date, int) RENAME TO generate_daily_report;
ALTER PROCEDURE reports.generate_daily_payments(integer, integer) OWNER TO usuarioX;

ALTER PROCEDURE reports.generate_daily_report(date, int) SET SCHEMA public;
ALTER PROCEDURE public.generate_daily_report(date, int) SET SCHEMA reports;

TRUNCATE TABLE reports.daily_payments RESTART IDENTITY;
ON CONFLICT ON CONSTRAINT daily_payments_pkey
	DO NOTHING;