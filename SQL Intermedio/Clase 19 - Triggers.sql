/*
Clase 19 - Triggers
*/
ALTER TABLE staff DISABLE TRIGGER bi_staff;
ALTER TABLE staff DISABLE TRIGGER ALL;

CREATE OR REPLACE FUNCTION clean_staff_data() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
	NEW.first_name = initcap(NEW.first_name);
  	NEW.last_name = initcap(NEW.last_name);
  	NEW.email = LOWER(NEW.email);
  
  	IF NEW.active IS NULL THEN
  		NEW.active = FALSE;
  	END IF;
  
  	IF NEW.username IS NULL THEN
  		NEW.username = LOWER(NEW.first_name);
  	END IF;
	
	--NEW.address_id = 5000;
  
  	RETURN NEW;
END;
$$

CREATE TRIGGER bi_staff 
   BEFORE INSERT
   ON staff
   FOR EACH ROW 
       EXECUTE PROCEDURE clean_staff_data()
       
SELECT *
FROM staff


INSERT INTO staff (first_name, last_name, address_id, email, store_id)
VALUES ('MAYRA', 'MORATAYA', 1, 'MAYRA.morataya@gmAIL.COM', 1);

INSERT INTO staff (first_name, last_name, address_id, email, store_id, username)
VALUES ('MAYRA', 'MORATAYA', 1, 'MAYRA.morataya@gmAIL.COM', 1, 'mayra');


CREATE OR REPLACE FUNCTION update_staff_data() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN
	UPDATE staff
	SET first_name = INITCAP(first_name)
	WHERE staff_id = NEW.staff_id;
  
  	RETURN NEW;
END;
$$

CREATE TABLE staff_log(
	staff_log_id SERIAL PRIMARY KEY,
	staff_id INT,
	staff_data JSON,
	event VARCHAR(20),
	last_update TIMESTAMP DEFAULT NOW()
);

ALTER TABLE staff DISABLE TRIGGER ALL;
ALTER TABLE staff ENABLE TRIGGER aiudt_staff;


CREATE OR REPLACE FUNCTION generate_staff_log() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
DECLARE 
	v_data JSON;
BEGIN
	
	IF TG_OP = 'INSERT' THEN
		v_data := row_to_json(NEW);
	ELSE
		v_data := row_to_json(OLD);
	END IF;
	
	INSERT INTO staff_log (staff_id, staff_data, event)
	VALUES (NEW.staff_id, v_data, TG_OP);
  
  	RETURN NEW;
END;
$$


CREATE TRIGGER aiudt_staff 
   AFTER INSERT OR UPDATE OR DELETE
   ON staff
   FOR EACH ROW 
       EXECUTE PROCEDURE generate_staff_log()
	   
	   
DROP TRIGGER bi_staff ON staff
DROP TRIGGER aiudt_staff ON staff


CREATE OR REPLACE FUNCTION generate_truncate_log() 
   RETURNS TRIGGER 
   LANGUAGE PLPGSQL
AS $$
BEGIN

   	INSERT INTO staff_log (staff_id, staff_data, event)
	VALUES (NULL, NULL, TG_OP);
   
	RETURN NULL;
END;
$$  


CREATE TRIGGER at_staff 
   AFTER TRUNCATE
   ON staff
   FOR EACH STATEMENT 
       EXECUTE PROCEDURE generate_truncate_log();