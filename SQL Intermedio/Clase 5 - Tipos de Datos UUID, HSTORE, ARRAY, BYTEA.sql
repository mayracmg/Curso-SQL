/*
Clase 5 - Tipos de Datos UUID, HSTORE, ARRAY, BYTEA
*/
CREATE TEMP TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR (255) NOT NULL,
    pages SMALLINT NOT NULL CHECK (pages > 0),
	words INT NOT NULL CHECK (words >= 0)
);

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

SELECT uuid_generate_v1();
SELECT uuid_generate_v4();

CREATE TEMP TABLE contacts (
    contact_id uuid DEFAULT uuid_generate_v4 (),
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    phone VARCHAR,
    PRIMARY KEY (contact_id)
);

INSERT INTO contacts (first_name,last_name,email,phone)
VALUES('John','Smith','john.smith@example.com','408-237-2345'),
('Jane','Smith','jane.smith@example.com','408-237-2344'),
('Alex','Smith','alex.smith@example.com','408-237-2343');

SELECT *
FROM contacts;

CREATE TABLE public.actor2 (
	actor_id serial4 NOT NULL PRIMARY KEY,
	first_name varchar(45) NOT NULL,
	last_name varchar(45) NOT NULL,
	last_update timestamp NOT NULL DEFAULT now()
);

INSERT INTO actor2 (first_name, last_name)
VALUES ('may', 'mortaya');

ALTER SEQUENCE actor2_actor_id_seq restart with 2000;
ALTER SEQUENCE actor2_actor_id_seq INCREMENT BY 2;

SELECT *
FROM actor2;

CREATE EXTENSION hstore;

CREATE TEMP TABLE books (
	id serial primary key,
	title VARCHAR (255),
	attr hstore
);

INSERT INTO books (title, attr)
VALUES
	(
		'PostgreSQL Tutorial',
		'"paperback" => "243",
	   "publisher" => "postgresqltutorial.com",
	   "language"  => "English",
	   "ISBN-13"   => "978-1449370000",
		 "weight"    => "11.2 ounces"'
	);

INSERT INTO books (title, attr)
VALUES
	('PostgreSQL Cheat Sheet',
		'
"paperback" => "5",
"publisher" => "postgresqltutorial.com",
"language"  => "English",
"ISBN-13"   => "978-1449370001",
"weight"    => "1 ounces"
'	);

SELECT attr
FROM books;

SELECT attr -> 'ISBN-13' AS isbn
FROM books;

SELECT title, attr -> 'weight' AS weight
FROM books
WHERE attr -> 'ISBN-13' = '978-1449370000';

SELECT title
FROM books
WHERE attr @> '"weight"=>"11.2 ounces"' :: hstore;

SELECT title
FROM books
WHERE attr @> '"ISBN-13"=>"978-1449370000"' :: hstore;

UPDATE books
SET attr = attr || '"freeshipping"=>"yes"' :: hstore;

UPDATE books
SET attr = attr || '"freeshipping"=>"no"' :: hstore;

UPDATE books 
SET attr = delete(attr, 'freeshipping');

SELECT title, attr->'publisher' as publisher, attr
FROM books
WHERE attr ? 'publisher';

SELECT title
FROM books
WHERE attr ?& ARRAY [ 'language', 'weight' ];

SELECT akeys (attr)
FROM books;

SELECT skeys (attr)
FROM books;

SELECT avals (attr)
FROM books;

SELECT svals (attr)
FROM books;

SELECT title, hstore_to_json (attr) json
FROM books;

SELECT title, (EACH(attr) ).*
FROM books;

CREATE TEMP TABLE contacts (
	id serial PRIMARY KEY,
	name VARCHAR (100),
	phones TEXT []
);

INSERT INTO contacts (name, phones)
VALUES('John Doe',ARRAY [ '(408)-589-5846','(408)-589-5555' ]);

INSERT INTO contacts (name, phones)
VALUES('Lily Bush','{"(408)-589-5841"}'),
      ('William Gate','{"(408)-589-5842", "(408)-589-58423"}');

SELECT name, phones
FROM contacts;

SELECT name, phones [1]
FROM contacts;

SELECT name
FROM contacts
WHERE phones[2] = '(408)-589-58423';

UPDATE contacts
SET phones[2] = '(408)-589-5843'
WHERE ID = 3;

UPDATE contacts
SET phones = '{"(408)-589-5843"}'
WHERE id = 3;

SELECT name, phones
FROM contacts
WHERE '(408)-589-5555' = ANY (phones);

SELECT name, unnest(phones)
FROM contacts;

SET bytea_output = 'hex';
SELECT '\xDEADBEEF'::bytea;

SET bytea_output = 'escape';
SELECT 'abc \153\154\155 \052\251\124'::bytea;
