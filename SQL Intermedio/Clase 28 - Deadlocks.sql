/*
Clase 28 - Deadlocks
*/
SELECT *
FROM city
WHERE country_id = 110;

BEGIN TRANSACTION;
DELETE FROM city WHERE country_id = 110;

ROLLBACK;

SELECT *
FROM city
WHERE country_id = 110;

BEGIN TRANSACTION;
UPDATE city SET city = 'GT' WHERE country_id = 110;

ROLLBACK;

SELECT pid, usename, state, query, wait_event_type, wait_event 
FROM pg_stat_activity
WHERE state = 'active';

INSERT INTO city (city, country_id) VALUES ('Guatemala City', 110);

SELECT current_setting('deadlock_timeout') AS deadlock_timeout;
SELECT current_setting('max_locks_per_transaction') AS max_locks_per_transaction;

SET deadlock_timeout(1s);
SET max_locks_per_transaction(64);