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


/*-------------Forth day------------------*/
/*List all the ANIMALS with visits date to confirm
correct insertion of data
joining 3 tables*/
SELECT A.name, V.name, visit.visit_date
FROM animals A
JOIN join_visits visit ON visit.animals_id=A.id
JOIN vets V ON visit.vets_id=V.id;

--1
/*Who was the last animal seen by William Tatcher?*/
SELECT A.name, V.name, visit.visit_date
FROM animals A
JOIN join_visits visit ON visit.animals_id=A.id
JOIN vets V ON visit.vets_id=V.id
WHERE V.name='William Tatcher'
ORDER BY visit.visit_date DESC LIMIT 1
;

--2
/*How many different animals did Stephanie Mendez see?*/
SELECT DISTINCT A.name, V.name, visit.visit_date
FROM animals A
JOIN join_visits visit ON visit.animals_id=A.id
JOIN vets V ON visit.vets_id=V.id
WHERE V.name='Stephanie Mendez'
;

--3
/*List all vets and their specialties,
including vets with no specialties.*/
SELECT V.name, S.name
FROM vets V
LEFT JOIN join_specializations JS ON V.id=JS.vets_id
LEFT JOIN species S ON JS.species_id=S.id
;

--4
/*List all animals that visited Stephanie Mendez between
 April 1st and August 30th, 2020.*/
SELECT DISTINCT A.name, V.name, visit.visit_date
FROM animals A
JOIN join_visits visit ON visit.animals_id=A.id
JOIN vets V ON visit.vets_id=V.id
WHERE V.name='Stephanie Mendez'
  AND visit.visit_date BETWEEN
    '01-04-2020' AND '30-08-2020'
;

--5
/*What animal has the most visits to vets?*/
SELECT A.name, COUNT(*)
FROM animals A
JOIN join_visits visit ON visit.animals_id=A.id
GROUP BY A.name
ORDER BY count DESC
LIMIT 1
;

--6
/*Who was Maisy Smith's first visit?*/
SELECT A.name, V.name, visit.visit_date
FROM animals A
JOIN join_visits visit ON visit.animals_id=A.id
JOIN vets V ON visit.vets_id=V.id
WHERE V.name='Maisy Smith'
ORDER BY visit.visit_date ASC
LIMIT 1
;

--7
/*Details for most recent visit:
animal information, vet information,
and date of visit.*/
SELECT A.*, V.*, visit.visit_date
FROM animals A
JOIN join_visits visit ON visit.animals_id=A.id
JOIN vets V ON visit.vets_id=V.id
ORDER BY visit.visit_date DESC
LIMIT 1
;


--8
/*How many visits were with a vet
 that did not specialize in that
 animal's species?*/

 /*HELPER helped me to get the data and understad
 that know I needed to look where the animal_specie
 was diffirent than the vet Specialization
 even with the vet null speciality I must include it
 because she does not have speciality*/
SELECT
visit.visit_date, visit.vets_id as vet_visited,
JS.species_id as vet_specialization,
A.name, A.species_id as animal_specie
FROM join_visits visit
LEFT JOIN animals A ON visit.animals_id=A.id
LEFT JOIN join_specializations JS ON visit.vets_id=JS.vets_id
WHERE A.species_id<>JS.species_id OR JS.species_id ISNULL
;

 /* SOLUTION Then USING that helper
 now I just need to return the count with out display
 data the count should be 16*/
SELECT
COUNT(*)
FROM join_visits visit
LEFT JOIN animals A ON visit.animals_id=A.id
LEFT JOIN join_specializations JS ON visit.vets_id=JS.vets_id
WHERE A.species_id<>JS.species_id OR JS.species_id ISNULL
;


--9
/*What specialty should Maisy Smith consider getting?
 Look for the species she gets the most.*/

/*HELPER To solve this I will use almost the same query
I will add just the vets table to display the vet's name
now I should filter just by Maisy Smith
and also join the species table*/
SELECT
visit.visit_date, visit.vets_id as vet_visited,
V.name as vet_name,
JS.species_id as vet_specialization,
A.name, A.species_id as animal_specie,
S.name as animal_specie_name
FROM join_visits visit
LEFT JOIN animals A ON visit.animals_id=A.id
LEFT JOIN join_specializations JS ON visit.vets_id=JS.vets_id
LEFT JOIN vets V ON visit.vets_id=V.id
LEFT JOIN species S ON A.species_id = S.id
WHERE V.name = 'Maisy Smith'
;

/* SOLUTION Then we want group by specie return the count
and order by desec and get the most*/
SELECT
COUNT(*), S.name
FROM join_visits visit
LEFT JOIN animals A ON visit.animals_id=A.id
LEFT JOIN join_specializations JS ON visit.vets_id=JS.vets_id
LEFT JOIN vets V ON visit.vets_id=V.id
LEFT JOIN species S ON A.species_id = S.id
WHERE V.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY count DESC LIMIT 1
;


/*-----------testing speed---------------*/
explain analyze SELECT COUNT(*) FROM join_visits where animals_id = 4;
explain analyze SELECT * FROM join_visits where vets_id = 2;
explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';