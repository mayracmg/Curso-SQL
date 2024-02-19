/*
Clase 14 - Foreign Key
*/
CREATE TABLE sales.products (
    product_no integer PRIMARY KEY,
    name text,
    price numeric
);

CREATE TABLE sales.orders (
    order_id integer PRIMARY KEY,
    shipping_address text
);

CREATE TABLE sales.order_items (
	order_item_id serial,
    product_no integer REFERENCES sales.products,
    order_id integer REFERENCES sales.orders,
    quantity integer,
    PRIMARY KEY (order_item_id)
);

INSERT INTO sales.products VALUES (1, 'Galletas', 10);
INSERT INTO sales.products VALUES (2, 'Chocolates', 20);
INSERT INTO sales.products VALUES (3, 'Brownies', 30);

INSERT INTO sales.orders VALUES (1, 'Guatemala');
INSERT INTO sales.orders VALUES (2, 'Antigua');
INSERT INTO sales.orders VALUES (3, 'Xela');

INSERT INTO sales.order_items (product_no, order_id, quantity) VALUES (1, 1, 10);
INSERT INTO sales.order_items (product_no, order_id, quantity) VALUES (1, 2, 20);
INSERT INTO sales.order_items (product_no, order_id, quantity) VALUES (1, 3, 30);
INSERT INTO sales.order_items (product_no, order_id, quantity) VALUES (2, 1, 40);
INSERT INTO sales.order_items (product_no, order_id, quantity) VALUES (2, 2, 50);
INSERT INTO sales.order_items (product_no, order_id, quantity) VALUES (2, 3, 60);

SELECT *
FROM products;

SELECT *
FROM orders;

SELECT *
FROM order_items;

BEGIN;

DELETE 
FROM products
WHERE product_no = 1;

ROLLBACK;

DROP TABLE sales.order_items;

CREATE TABLE sales.order_items (
	  order_item_id serial,
    product_no integer REFERENCES sales.products ON DELETE NO ACTION,
    order_id integer REFERENCES sales.orders ON DELETE RESTRICT,
    quantity integer,
    PRIMARY KEY (order_item_id)
);

DELETE 
FROM products
WHERE product_no = 1;

DELETE 
FROM orders
WHERE order_id = 1;

DROP TABLE sales.order_items;

CREATE TABLE sales.order_items (
	  order_item_id serial,
    product_no integer REFERENCES sales.products ON DELETE SET NULL,
    order_id integer DEFAULT 3 REFERENCES sales.orders ON DELETE SET DEFAULT,
    quantity integer,
    PRIMARY KEY (order_item_id)
);

DROP TABLE sales.order_items;

CREATE TABLE sales.order_items (
	order_item_id serial,
    product_no integer REFERENCES sales.products ON DELETE CASCADE,
    order_id integer DEFAULT 3 REFERENCES sales.orders ON DELETE CASCADE,
    quantity integer,
    PRIMARY KEY (order_item_id)
);

BEGIN;

UPDATE products
SET product_no = 4
WHERE product_no = 1;

UPDATE orders
SET order_id = 4
WHERE order_id = 1;

ROLLBACK;

DROP TABLE sales.order_items;

CREATE TABLE sales.order_items (
	order_item_id serial,
	product_no integer REFERENCES sales.products ON UPDATE CASCADE,
	order_id integer REFERENCES sales.orders ON UPDATE CASCADE,
	quantity integer,
	PRIMARY KEY (order_item_id)
);

DROP TABLE sales.order_items;

CREATE TABLE sales.order_items (
	order_item_id serial,
	product_no integer REFERENCES sales.products ON UPDATE SET NULL,
	order_id integer DEFAULT 3 REFERENCES sales.orders ON UPDATE SET DEFAULT,
	quantity integer,
	PRIMARY KEY (order_item_id)
);

DROP TABLE sales.order_items;

CREATE TABLE sales.order_items (
	order_item_id serial,
	product_no integer REFERENCES sales.products,
	order_id integer REFERENCES sales.orders,
	quantity integer,
	name text REFERENCES sales.products (name),
	PRIMARY KEY (order_item_id)
);

DROP TABLE sales.order_items;
DROP TABLE sales.products;

CREATE TABLE sales.products (
    product_no integer PRIMARY KEY,
    name TEXT UNIQUE,
    price numeric
);

CREATE TABLE sales.order_items (
	order_item_id serial,
	product_no integer REFERENCES sales.products,
	order_id integer REFERENCES sales.orders,
	quantity integer,
	name text REFERENCES sales.products (name),
	PRIMARY KEY (order_item_id)
);

INSERT INTO sales.order_items VALUES (DEFAULT, 1, 1, 10, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 1, 2, 20, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 1, 3, 30, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 2, 1, 40, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 2, 2, 50, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 2, 3, 60, NULL);

DROP TABLE sales.order_items;
DROP TABLE sales.products;

CREATE TABLE sales.order_items (
	order_item_id serial,
	product_no integer REFERENCES sales.products,
	order_id integer REFERENCES sales.orders,
	quantity integer,
	name text REFERENCES sales.products (name),
	PRIMARY KEY (order_item_id)
);

INSERT INTO sales.order_items VALUES (DEFAULT, 1, 1, 10, 'Galletas');
INSERT INTO sales.order_items VALUES (DEFAULT, 1, 2, 20, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 1, 3, 30, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 2, 1, 40, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 2, 2, 50, NULL);
INSERT INTO sales.order_items VALUES (DEFAULT, 2, 3, 60, NULL);
