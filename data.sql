/* Populate animals table */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Agumon', date '2020-02-03', 0, TRUE, 10.23);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Gabumon', date '2018-11-15', 2, TRUE, 8.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Pikachu', date '2021-01-07', 1, FALSE, 15.04);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Devimon', date '2017-05-12', 5, TRUE, 11.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Charmander', date '2020-02-08', 0, FALSE, -11.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Plantmon', date '2021-11-15', 2, TRUE, -5.70);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Squirtle', date '1993-04-02', 3, FALSE, -12.13);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Angemon', date '2005-06-12', 1, TRUE, -45.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Boarmon', date '2005-06-07', 7, TRUE, 20.40);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Blossom', date '1998-10-13', 3, TRUE, 17.00);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES('Ditto', date '2022-05-14', 4, TRUE, 22.00);

-- Populate owners table
INSERT INTO owners (full_name, age)
VALUES('Sam Smith', 34);
INSERT INTO owners (full_name, age)
VALUES('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
VALUES('Bob', 45);
INSERT INTO owners (full_name, age)
VALUES('Melody Pond', 77);
INSERT INTO owners (full_name, age)
VALUES('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
VALUES('Jodie Whittaker', 38);

-- Populate species table
INSERT INTO species (name)
VALUES('Pokemon');

INSERT INTO species (name)
VALUES('Digimon');

-- Include species_id value
BEGIN;
UPDATE animals
SET species_id = 1
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 2
WHERE name NOT LIKE '%mon';

COMMIT;

-- Include owner information
BEGIN;
UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name = 'Gabumon' OR name = 'Pikachu';

UPDATE animals
SET owner_id = 3
WHERE name = 'Devimon' OR name = 'Plantmon';

UPDATE animals
SET owner_id = 4
WHERE name = 'Charmander' OR name = 'Squirtle' OR name = 'Blossom';

UPDATE animals
SET owner_id = 5
WHERE name = 'Angemon' OR name = 'Boarmon';

COMMIT;