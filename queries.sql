/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '01-01-2016' AND '31-12-2019';
SELECT name FROM animals WHERE neutered=true AND escape_attempts<3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT date_of_birth, escape_attempts FROM animals WHERE weight_kg>10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name!='Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
(Between is inclusive :D)

/*------------------Third day---------------------*/
/*What animals belong to Melody Pond*/
SELECT  A.name, O.full_name
FROM animals A
JOIN owners O ON O.id = A.owner_id
WHERE O.full_name='Melody Pond';

/*List animals that are pokemon*/
SELECT A.name
FROM animals A
JOIN species S ON S.id = A.species_id
WHERE S.name = 'Pokemon';

/*List all owners and their animals,
remember to include those that don't own any animal.*/
SELECT O.full_name, A.name
FROM owners O
LEFT JOIN animals A ON O.id = A.owner_id;

/*How many animals are there per species?*/
SELECT COUNT(*), S.name
FROM species S
JOIN animals A ON S.id = A.species_id
GROUP BY S.name;

/*List all Digimon owned by Jennifer Orwell.*/
SELECT A.name
FROM animals A
JOIN species S ON S.id = A.species_id
JOIN owners O ON O.id = A.owner_id
WHERE O.full_name = 'Jennifer Orwell' AND  S.name = 'Digimon';

/*List all animals owned by Dean Winchester that haven't tried to escape.*/
SELECT  A.name, O.full_name
FROM animals A
JOIN owners O ON O.id = A.owner_id
WHERE O.full_name='Dean Winchester' AND A.escape_attempts = 0;

/*Who owns the most animals?*/
/*First way*/
SELECT O.full_name, COUNT(*)
FROM owners O
JOIN animals A ON O.id = A.owner_id
GROUP BY O.full_name
ORDER BY count DESC LIMIT 1;
