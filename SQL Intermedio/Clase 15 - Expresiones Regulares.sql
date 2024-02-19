/*
Clase 15 - Expresiones Regulares
*/
SELECT email, regexp_instr(email, '[@]+', 1, 1, 1) 
FROM staff;

SELECT regexp_instr('ema@il@dsfd', '[@]+', 1, 1, 1);

SELECT regexp_instr('texto correo@gmail.com mas texto otrocorreo@gmail.com', '[a-z]+@[a-z]+.[a-z]+', 1, 2, 0);

SELECT email, regexp_instr(email, '@+', 1, 1, 1) 
FROM staff;

SELECT email, regexp_instr('ddd email@gmail.com dads otro@gmail.com', '@+', 1, 3, 1) 
FROM staff;

SELECT regexp_instr('texto correo@gmail.com mas texto otrocorreo@gmail.com', 
'[a-z]+@[a-z]+.[a-z]{3}', 1, 1, 0);


SELECT regexp_like('texto correo@gmail.com mas texto otrocorreo@gmail.com', 
'[a-z]+@[a-z]+.[a-z]{3}');

SELECT postal_code, regexp_like(postal_code, '\d+'),
CASE WHEN regexp_like(postal_code, '\d+') THEN to_number(postal_code, '999999')
ELSE 0 END postal_code2
FROM address;

SELECT regexp_match('ddd 22-02-2023 dsafsdfas 01-01-2021', '\d{2}-\d{2}-\d{4}');

SELECT regexp_matches('ddd 22-02-2023 dsafsdfas 01-01-2021', 
'\d{2}-\d{2}-\d{4}', 'g');

SELECT regexp_replace('ddd 22-02-2023 dsafsdfas 01-01-2021', 
'\d{2}-\d{2}-\d{4}', 'FECHA', 'g');

SELECT address, regexp_replace(address, '[a-zA-Z]+', '', 'g')
FROM address;

SELECT address, regexp_split_to_array(address, '[a-zA-Z]+')
FROM address;

SELECT regexp_count('texto mas texto otrocorreo@gmail.com', 
'[a-z]+@[a-z]+.[a-z]{3}');

SELECT address, regexp_substr(address, '[a-zA-Z]+', 1, 3)
FROM address;