/*
Clase 23 - DBlinks
*/
CREATE EXTENSION IF NOT EXISTS dblink;
SELECT dblink_connect('mydblink', 'host=nombre_del_host dbname=nombre_de_la_base_de_datos user=nombre_de_usuario password=contraseña');

SELECT * 
FROM dblink('mydblink', 'SELECT * FROM tabla_remota')
 AS t(columna1 tipo1, columna2 tipo2, ...);

SELECT dblink_disconnect('mydblink');

SELECT dblink_connect('mydblink', 'host=localhost dbname=dvdrental_dev user=postgres password=maycode');

SELECT * 
FROM dblink('mydblink', 'SELECT film_id, title FROM film')
 AS t(film_id int, title varchar(255));

SELECT dblink_disconnect('mydblink');

SELECT dblink_exec('mydblink', 'insert into actor (first_name, last_name) values(''DBLink'', ''DBLink'');');

SELECT * 
FROM dblink('mydblink', 'SELECT actor_id, first_name FROM actor')
 AS t(actor_id int, first_name varchar(255));

SELECT *
FROM dblink_get_connections();

SELECT *
FROM dblink('host=localhost dbname=dvdrental_dev user=postgres password=maycode', 'SELECT actor_id, first_name, last_name FROM actor')
AS t(actor_id int, first_name varchar(255), last_name varchar(255))
WHERE t.actor_id = 203
 ;

INSERT INTO actor (actor_id, first_name, last_name)
SELECT *
FROM dblink('mydblink', 'SELECT actor_id, first_name, last_name FROM actor')
AS t(actor_id int, first_name varchar(255), last_name varchar(255))
WHERE t.actor_id = 203;