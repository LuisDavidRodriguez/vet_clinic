/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
('Agumon', '03-02-2020', 2, true, 10.23),
('Gabumon', '15-11-2018', 2, true, 8),
('Pikachu', '07-01-2021', 1, false, 15.04),
('Devimon', '12-05-2017', 5, true, 11)
;

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
('Charmander', '08-02-2020', 0, false, 11.0),
('Plantmon', '15-11-2021', 2, true, 5.7),
('Squirtle', '02-04-1993', 3, false, 12.13),
('Angemon', '12-06-2005', 1, true, 45.0),
('Boarmon', '07-06-2005', 7, true, 20.4),
('Blossom', '13-10-1998', 3, true, 17.0),
('Ditto', '14-05-2022', 4, true, 22.0);

//Change to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

/*Update species ended in name mon*/;
BEGIN;
UPDATE animals SET species='digimon' WHERE name LIKE '%mon';
UPDATE animals SET species='pokemon' WHERE species='0';
COMMIT;

/*Delete and roll back*/
BEGIN;
DELETE FROM animals;
ROLLBACK;
vet_clinic=# SELECT * FROM animals;

/*Delete all animals born after Jan 1st, 2022. Create a savepoint for the transaction.*/
BEGIN;
DELETE FROM animals WHERE date_of_birth > '01-01-2022';
SAVEPOINT S1;
UPDATE animals SET weight_kg=weight_kg*-1;
ROLLBACK TO S1;
SELECT * FROM animals;
UPDATE animals SET weight_kg=weight_kg*-1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/* How many animals are there? */
SELECT COUNT(*) FROM animals;
/*How many animals have never tried to escape?*/
SELECT COUNT(*) FROM animals WHERE escape_attempts=0;
/*What is the average weight of animals?*/
SELECT AVG(weight_kg) FROM animals;
/*Who escapes the most, neutered or not neutered animals?*/
SELECT neutered, AVG(escape_attempts) FROM animals GROUP BY neutered ORDER BY AVG DESC LIMIT 1;
/*What is the minimum and maximum weight of each type of animal?*/
SELECT MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight, species FROM animals GROUP BY species;
/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
SELECT AVG(escape_attempts) as escape_AVG, species FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '31-12-2000' GROUP BY species;



/*-------------------THIRD DAY-------------*/
BEGIN;
INSERT INTO owners (full_name, age)
VALUES
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodi Whittaker', 38);

BEGIN;
INSERT INTO species (name)
VALUES
('Pokemon'),
('Digimon');

SELECT * FROM species;

COMMIT;

/*Set species*/
BEGIN;
UPDATE animals
SET species_id=4
WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals
SET species_id=3
WHERE species_id ISNULL;

SELECT * FROM animals;

/*Set Owners*/
BEGIN;
UPDATE animals
SET owner_id=7
WHERE name='Agumon';

UPDATE animals
SET owner_id=8
WHERE name='Gabumon' or name='Pikachu';

UPDATE animals
SET owner_id=9
WHERE name='Devimon' or name='Plantmon';

UPDATE animals
SET owner_id=10
WHERE name='Charmander' or name='Squirtle' or name='Blossom';

UPDATE animals
SET owner_id=11
WHERE name='Angemon' or name='Boarmon';