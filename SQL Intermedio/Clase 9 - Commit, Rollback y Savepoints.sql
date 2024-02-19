/*
Clase 9 - Commit, Rollback y Savepoints
*/
SELECT *
FROM country
WHERE country LIKE 'G%';

GRANT ALL PRIVILEGES ON country_country_id_seq TO Developer1;

BEGIN TRANSACTION;

INSERT INTO country (country) VALUES ('Guate');
INSERT INTO country (country) VALUES ('Guate2');

COMMIT;

END TRANSACTION;

UPDATE country SET country = 'Guate3' WHERE country_id = 174

ROLLBACK;

BEGIN;
	INSERT INTO country (country) VALUES ('Guate_1');
  INSERT INTO country (country) VALUES ('Guate_2');
END;

BEGIN;
	INSERT INTO country (country) VALUES ('Guate_1');
	SAVEPOINT savepoint_1;
	INSERT INTO country (country) VALUES ('Guate_2');
	SAVEPOINT savepoint_2;
	INSERT INTO country (country_id, country) VALUES (115, 'Guate_2');
END;

ROLLBACK TO SAVEPOINT savepoint_1;
COMMIT;

DELETE FROM country WHERE country_id > 115;

START TRANSACTION;

	INSERT INTO country (country) VALUES ('Guate_1');
	COMMIT AND CHAIN;
	INSERT INTO country (country) VALUES ('Guate_2');
	SAVEPOINT savepoint_1;
	INSERT INTO country (country_id, country) VALUES (115, 'Guate_2');

END;

ALTER SYSTEM SET max_prepared_transactions = 10;

BEGIN;
	INSERT INTO country (country) VALUES ('Guate_1');
	INSERT INTO country (country) VALUES ('Guate_2');
	PREPARE TRANSACTION 'test_prepare_1';

ROLLBACK PREPARED 'test_prepare_1'
COMMIT PREPARED 'test_prepare_1';

COMMIT PREPARED 'foobar';