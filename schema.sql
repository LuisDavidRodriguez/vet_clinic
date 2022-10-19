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

