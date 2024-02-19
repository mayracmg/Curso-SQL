/*
Clase 24 - Indices
*/
SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'public'
ORDER BY tablename, indexname;

SELECT indexname, indexdef
FROM pg_indexes
WHERE tablename = 'film';

EXPLAIN
SELECT *
FROM film_large
WHERE id <= 100;

CREATE UNIQUE INDEX idx_film_large_1 ON film_large(id);

DROP INDEX idx_film_large_1;

CREATE INDEX idx_film_large_2 ON film_large USING btree (id);
CREATE INDEX idx_film_large_3 ON film_large USING HASH (title);

EXPLAIN
SELECT *
FROM film_large
WHERE extra @> '"title"=>"Chamber Italian"' :: hstore

CREATE INDEX idx_film_large_4 ON film_large USING gin (extra);
CREATE INDEX idx_film_large_5 ON film_large USING brin (id);

EXPLAIN
SELECT *
FROM film_large
WHERE "location" <@ circle '((0, 0), 15)';

CREATE INDEX idx_film_large_6 ON film_large USING gist (location);

DROP INDEX idx_film_large_6;

EXPLAIN
SELECT *
FROM film_large
WHERE "location" <@ box(point(0, 0), point(10, 10));

CREATE INDEX idx_film_large_7 ON film_large USING spgist ("location");

SELECT *
FROM film_large
ORDER BY title ASC, description desc

CREATE INDEX idx_film_large_8 ON film_large (title, description DESC);

CREATE INDEX index_name ON table_name (expression);

SELECT *
FROM film_large
WHERE LOWER(title) = 'purple movie'

CREATE INDEX idx_film_large_9 ON film_large (LOWER(title));

CREATE INDEX index_name
ON table_name(column_list)
WHERE condition;

SELECT *
FROM film_large
WHERE id <= 100000

CREATE INDEX idx_film_large_10 ON film_large (id)
WHERE id <= 100000;

SELECT pg_size_pretty(pg_total_relation_size('film_large')) AS total_size,
  pg_size_pretty(pg_relation_size('film_large')) AS data_size,
  pg_size_pretty(pg_total_relation_size('film_large') - pg_relation_size('film_large')) AS index_size
FROM pg_tables
WHERE tablename = 'film_large';