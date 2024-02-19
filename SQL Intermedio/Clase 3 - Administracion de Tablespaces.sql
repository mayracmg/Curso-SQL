/*
Clase #3: Administración de Tablespaces 
*/
CREATE TABLESPACE ts_primary 
LOCATION 'c:\pgdata\primary';

CREATE DATABASE logistics 
TABLESPACE ts_primary;

CREATE TABLE deliveries (
    delivery_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    order_date DATE, 
    customer_id INT
);

INSERT INTO deliveries(order_date, customer_id)
VALUES('2020-08-01',1);

ALTER TABLESPACE dvdrental 
RENAME TO dvdrental_raid;

ALTER TABLESPACE dvdrental_raid 
OWNER to hr;

CREATE TABLESPACE demo
LOCATION 'c:/pgdata/demo';

CREATE DATABASE dbdemo 
TABLESPACE = demo;

CREATE TABLE test (
	ID serial PRIMARY KEY,
	title VARCHAR (255) NOT NULL
) TABLESPACE demo;

SELECT ts.spcname, cl.relname
FROM pg_class cl
JOIN pg_tablespace ts ON cl.reltablespace = ts.oid
WHERE ts.spcname = 'demo';

DROP TABLESPACE demo;

ALTER DATABASE dbdemo
SET TABLESPACE = pg_default;

DROP TABLESPACE demo;