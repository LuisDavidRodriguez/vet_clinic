/* Database schema to keep the structure of entire database. */

vet_clinic=# CREATE TABLE animals(
vet_clinic(# id INT GENERATED ALWAYS AS IDENTITY,
vet_clinic(# name VARCHAR(15) not null,
vet_clinic(# date_of_birth date,
vet_clinic(# escape_attempts INT,
vet_clinic(# neutered BOOLEAN DEFAULT false,
vet_clinic(# weight_kg FLOAT DEFAULT 0
vet_clinic(# );
CREATE TABLE
           
ALTER TABLE animals
ADD species VARCHAR(20) NOT NULL DEFAULT '0'
;

/*Third day*/
CREATE TABLE owners(
  id INT GENERATED ALWAYS AS IDENTITY,
  full_name VARCHAR(30) NOT NULL DEFAULT 0,
  age INT,
  PRIMARY KEY(id)
);

CREATE TABLE species(
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(30) NOT NULL DEFAULT 0,
  PRIMARY KEY(id)
);

SELECT * FROM animals;

BEGIN;
ALTER TABLE animals
ADD PRIMARY KEY(id);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD species_id INT;

ALTER TABLE animals
ADD owner_id INT;
COMMIT;


BEGIN;

/*Set relation between owners and animals*/
ALTER TABLE animals
ADD CONSTRAINT FK_owners_animals
FOREIGN KEY (owner_id)
REFERENCES owners (id)
ON DELETE CASCADE;

/*Set realtion between species and owners*/
ALTER TABLE animals
ADD CONSTRAINT FK_species_animals
FOREIGN KEY (species_id)
REFERENCES species (id)
ON DELETE CASCADE;

COMMIT;


/*-----------forth day---------------*/
/*
Create a table named vets with the following columns:
id: integer (set it as autoincremented PRIMARY KEY)
name: string
age: integer
date_of_graduation: date
*/
BEGIN;
CREATE TABLE vets (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name VARCHAR(30) NOT NULL DEFAULT '0',
  age INT,
  date_of_graduation date
);

/*There is a many-to-many relationship between the 
tables species and vets: a vet can specialize in multiple species,
and a species can have multiple vets specialized in it. Create a "join table"
called specializations to handle this relationship.*/

CREATE TABLE join_specializations(
  species_id INT,
  vets_id INT,
  PRIMARY KEY (species_id, vets_id)
);

ALTER TABLE join_specializations
ADD FOREIGN KEY (species_id) REFERENCES species(id)
ON DELETE CASCADE
;

ALTER TABLE join_specializations
ADD FOREIGN KEY (vets_id) REFERENCES vets(id)
ON DELETE CASCADE
;
COMMIT;

/*There is a many-to-many relationship between the tables animals
 and vets: an animal can visit multiple vets and one vet can be 
 visited by multiple animals. Create a "join table" called visits 
 to handle this relationship, it should also keep track of the date of the visit.*/

CREATE TABLE join_visits(
  animals_id INT,
  vets_id INT,
  visit_date date,
  PRIMARY KEY (animals_id, vets_id, visit_date),
  CONSTRAINT animals_visits
  FOREIGN KEY(animals_id)
    REFERENCES animals(id)
    ON DELETE CASCADE 
);

ALTER TABLE join_visits
  ADD FOREIGN KEY(vets_id)
  REFERENCES vets(id)
  ON DELETE CASCADE
;

/*SINCE I FORGOT TO ADD THE DATE >.<
well in the upper code I added the date jaja but 
in the real life I had forgotten it
so I used this codes to first delete the constraint
because was only taking animals_id and vets_id
then I added the column date and finally I just create 
the constrain again now with the 3 columns
AND ALSO SET IT AS A PRIMARY KEY BECAUSE 
THERE COULD BE THE SAME POKEMON VISITING 
THE SAME VET BUT IN DIFFERENT DATES*/
--Drop the previous constrint
ALTER TABLE join_visits
DROP CONSTRAINT join_visits_pkey; 

--add the date column

-- set the date column as part of the primary key
ALTER TABLE join_visits
PRIMARY KEY (animals_id, vets_id, visit_date); 