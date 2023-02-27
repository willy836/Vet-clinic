/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals
WHERE name LIKE '%mon';

SELECT name FROM animals
WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

SELECT name FROM animals
WHERE neutered = TRUE AND escape_attempts < 3;

SELECT date_of_birth FROM animals
WHERE name = 'Agumon' OR name = 'Pikachu';

SELECT name, escape_attempts FROM animals
WHERE weight_kg > 10.50;

SELECT * FROM animals
WHERE neutered = TRUE;

SELECT * FROM animals
WHERE name NOT LIKE 'Gabumon';

SELECT * FROM animals
WHERE weight_kg >= 10.40 AND weight_kg <= 17.30;

BEGIN;
UPDATE animals
SET species = 'unspecified';

BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

BEGIN;
UPDATE animals
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

UPDATE animals
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';

COMMIT;

BEGIN;
DELETE FROM animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT SP1;
UPDATE animals
SET weight_kg = weight_kg * -1;
ROLLBACK TO SP1;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

COMMIT;


SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, MAX(escape_attempts) FROM animals
GROUP BY neutered;

SELECT species, MIN(weight_kg) as min_weight, MAX(weight_kg) as max_weight 
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) as avg_escape_att
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- Query multiple tables - answers
SELECT name, full_name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT * FROM owners
LEFT JOIN animals ON owners.id = animals.owner_id;

SELECT species.name, COUNT(animals.id) as animal_count FROM animals
JOIN species ON animals.species_id = species.id
GROUP BY species.name;

SELECT * FROM animals
JOIN species ON animals.species_id = species.id
JOIN owners ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

SELECT * FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.id) as animals_count FROM animals
JOIN owners ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY animals_count DESC
LIMIT 1;

-- Queries for many-to-many relationships - answers
SELECT animals.name as animal_name FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) as different_animals_visited FROM visits
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name as vet_name, species.name as specialty FROM vets
LEFT JOIN specializations ON vets.id = specializations.vets_id
LEFT JOIN species ON specializations.species_id = species.id
ORDER BY vets.name;

SELECT animals.name as animal_name FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animals.name as animal_name, COUNT(animals.id) as visits_count FROM animals
JOIN visits ON animals.id = visits.animals_id
GROUP BY animal_name
ORDER BY visits_count DESC
LIMIT 1;

SELECT animals.name as animal_name, date_of_visit FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
ORDER BY date_of_visit ASC
LIMIT 1;

SELECT * FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN vets ON visits.vets_id = vets.id
ORDER BY date_of_visit DESC
LIMIT 1;

SELECT COUNT(*) as visits_count FROM visits
JOIN animals ON visits.animals_id = animals.id
JOIN vets ON visits.vets_id = vets.id
JOIN specializations ON visits.vets_id = specializations.vets_id
WHERE animals.species_id != specializations.species_id;

SELECT species.name as species_name, COUNT(*) as species_count FROM animals
JOIN visits ON animals.id = visits.animals_id
JOIN species ON animals.species_id = species.id
JOIN vets ON visits.vets_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species_name
ORDER BY species_count DESC
LIMIT 1;

-- Database performance audit
-- Update owners table; age column
UPDATE owners
SET age = 34
WHERE id = 1;

UPDATE owners
SET age = 19
WHERE id = 2;

UPDATE owners
SET age = 45
WHERE id = 3;

UPDATE owners
SET age = 77
WHERE id = 4;

UPDATE owners
SET age = 14
WHERE id = 5;

UPDATE owners
SET age = 38
WHERE id = 6;

explain analyze SELECT COUNT(*) FROM visits where animals_id = 4;
-- Execution Time: 3,658, 239 ms

SELECT COUNT(*) FROM visits where animals_id = 4;
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animals_id = 4
-- Before improving execution time

SELECT COUNT(*) FROM visits where animals_id = 4;
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animals_id = 4;
CREATE INDEX animals_id_asc ON visits(animals_id ASC);
-- After improving execution time by indexing

SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
-- Before improving execution time

SELECT * FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT * FROM visits where vets_id = 2;
CREATE INDEX vets_id_asc ON visits(vets_id ASC);
-- After improving execution time by indexing

--ADD CODE HERE