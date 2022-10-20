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