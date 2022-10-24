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


/*----------Forth day----------------------*/
-- BEGIN;
INSERT INTO vets (name, age, date_of_graduation)
VALUES
('William Tatcher', 45, '23-04-2000'),
('Maisy Smith', 26, '17-01-2019'),
('Stephanie Mendez', 64, '04-05-1981'),
('Jack Harkness', 38, '08-06-2008');
--COMMIT;


--BEGIN;
INSERT INTO join_specializations(species_id, vets_id)
VALUES
(3, 1),
(3, 3),
(4, 3),
(4, 4);
--COMMIT;

--BEGIN;
INSERT INTO join_visits(animals_id, vets_id, visit_date)
VALUES
(1, 1, '24-05-2020'),
(1, 3, '22-07-2020'),
(2, 4, '02-02-2021'),
(3, 2, '05-01-2020'),
(3, 2, '08-03-2020'),
(3, 2, '14-05-2020'),
(4, 3, '04-05-2021'),
(5, 4, '24-02-2021'),
(6, 2, '21-12-2019'),
(6, 1, '10-08-2020'),
(6, 2, '07-04-2021'),
(7, 3, '29-09-2019'),
(8, 4, '03-10-2020'),
(8, 4, '04-11-2020'),
(9, 2, '24-01-2019'),
(9, 2, '15-05-2019'),
(9, 2, '27-02-2020'),
(9, 2, '03-08-2020'),
(10, 3, '24-05-2020'),
(10, 1, '11-01-2021');
--COMMIT;


/*-----------testing speed---------------*/
-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO join_visits (animals_id, vets_id, visit_date) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';
