/*
Clase 2 - Esquemas en la Base de Datos
*/
SELECT *
FROM public.film;

SHOW search_path;

CREATE SCHEMA sales;

SET search_path TO sales, public;

CREATE TABLE staff(
    staff_id SERIAL PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

SELECT * 
FROM staff;

SELECT * 
FROM sales.staff;

SELECT * 
FROM public.staff;

SET search_path TO public;

GRANT USAGE ON SCHEMA nombre_esquema
TO nombre_rol;

GRANT CREATE ON SCHEMA nombre_esquema
TO nombre_usuario;