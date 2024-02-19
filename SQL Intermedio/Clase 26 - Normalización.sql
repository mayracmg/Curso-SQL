/*
Clase 26 - Normalización
*/
CREATE TABLE Rating (
	Rating_id SERIAL PRIMARY KEY,
	Description VARCHAR(50)
);

CREATE TABLE Special_Feature (
	Special_Feature_Id SERIAL PRIMARY KEY,
	Description TEXT
);

CREATE TABLE Special_Feature_Film (
	Special_Feature_Id INT REFERENCES Special_Feature,
	Film_id INT REFERENCES Film,
	PRIMARY KEY (Special_Feature_Id, Film_id)
);

ALTER TABLE film ADD COLUMN Rating_id INT;
ALTER TABLE film ADD CONSTRAINT film_rating_fk FOREIGN KEY (Rating_id) REFERENCES Rating(Rating_id);

INSERT INTO Rating (Description)
SELECT DISTINCT rating
FROM film;

UPDATE film
SET rating_id = (SELECT rating_id FROM rating WHERE description = CAST(rating AS varchar));

--ALTER TABLE film DROP COLUMN rating;

INSERT INTO special_feature (Description)
SELECT DISTINCT unnest(special_features)
FROM film;

INSERT INTO special_feature_film (film_id, special_feature_id)
SELECT film_id, S.special_feature_id
FROM (
	SELECT film_id, unnest(special_features) feature
	FROM film
) x
INNER JOIN special_feature S ON S.description = feature;

--ALTER TABLE film DROP COLUMN special_ratings;