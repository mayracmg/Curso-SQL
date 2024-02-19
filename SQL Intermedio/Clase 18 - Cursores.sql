/*
Clase 18 - Cursores
*/
DROP TABLE reports.daily_payments;

CREATE TABLE reports.daily_payments (
	daily_payment_id SERIAL PRIMARY KEY,
	payment_date DATE,
	staff_id INT REFERENCES public.staff(staff_id),
	staff_name TEXT,
	total_transactions INT,
	total_amount NUMERIC(10, 2),
	average_amount NUMERIC(10, 2),
	min_amount NUMERIC(10, 2),
	max_amount NUMERIC(10, 2),
	execution_date TIMESTAMP,
	execution_user VARCHAR(50)
);

CREATE OR REPLACE FUNCTION reports.get_staff_name(IN p_staff_id INT)
  RETURNS varchar 
 LANGUAGE plpgsql
AS $$
DECLARE
	v_staff_name varchar;
BEGIN
	SELECT CONCAT(first_name, ' ', last_name) staff_name
	INTO v_staff_name
	FROM public.staff
	WHERE staff_id = p_staff_id;

	RETURN v_staff_name;
END;
$$
;

SELECT reports.get_staff_name(1);

CREATE OR REPLACE PROCEDURE reports.insert_daily_report(
	IN p_payment_date DATE,
	IN p_staff_id INT,
	IN p_staff_name VARCHAR(100),
	IN p_total_transactions INT,
	IN p_total_amount NUMERIC(10, 2),
	IN p_average_amount NUMERIC(10, 2),
	IN p_min_amount NUMERIC(10, 2),
	IN p_max_amount NUMERIC(10, 2),
	OUT p_inserted_id INT
)
 LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO reports.daily_payments (
		payment_date,
		staff_id,
		staff_name,
		total_transactions,
		total_amount,
		average_amount,
		min_amount,
		max_amount,
		execution_date,
		execution_user
	)
	VALUES (
		p_payment_date,
		p_staff_id,
		p_staff_name,
		p_total_transactions,
		p_total_amount,
		p_average_amount,
		p_min_amount,
		p_max_amount,
		CURRENT_TIMESTAMP,
		USER
	)
	RETURNING daily_payment_id 
	INTO p_inserted_id;

END;
$$
;

DO $$
DECLARE
	c_daily_payments CURSOR FOR
		SELECT total_transactions, execution_user
		FROM daily_payments;
	
	v_row RECORD;
BEGIN
	OPEN c_daily_payments;

    LOOP
        FETCH c_daily_payments INTO v_row;
        EXIT WHEN NOT FOUND;
       
       	IF v_row.total_transactions >= 200 THEN 

	        UPDATE daily_payments
	        SET execution_user = 'cursor'
	        WHERE CURRENT OF c_daily_payments;

			/*
			DELETE 
	        FROM daily_payments
	        WHERE CURRENT OF c_daily_payments;
			*/
       
       END IF;
    END LOOP;

    CLOSE c_daily_payments;
	
END;$$


--Logica anterior
CREATE OR REPLACE FUNCTION get_payment_rates(p_payment DECIMAL)
   RETURNS TABLE (name VARCHAR(50), payment_rate DECIMAL)
   LANGUAGE plpgsql
  AS
$$
DECLARE

BEGIN 
	
	RETURN QUERY
	SELECT r.name, p_payment * (1 + (sign * value)) payment_rate
	FROM rates r;

END;
$$

SELECT *
FROM get_payment_rates(10);

CREATE OR REPLACE FUNCTION get_payment_rates()
   RETURNS refcursor
   LANGUAGE plpgsql
  AS
$$
DECLARE
	c_payment_rates CURSOR IS
		SELECT 'IVA' name, amount * 0.12 iva, amount * 1.12 total
		FROM public.payment;
BEGIN 

	OPEN c_payment_rates;
	
	RETURN c_payment_rates;

END;
$$


DO $$
DECLARE
	
	cursor_result refcursor;
	v_row RECORD;
BEGIN
	cursor_result := get_payment_rates();
	
	LOOP
		FETCH FROM cursor_result
		INTO v_row;

		IF NOT FOUND THEN
			EXIT;
		END IF;

		RAISE NOTICE 'Hi %', v_row.total;
	
	END LOOP;
	CLOSE cursor_result;
	
END;$$