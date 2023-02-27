/* Database schema to keep the structure of entire database. */

CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(50);

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

/* Modify animals table */
ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY(species_id)
REFERENCES species(id)
ON DELETE CASCADE;

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owners
FOREIGN KEY(owner_id)
REFERENCES owners(id)
ON DELETE CASCADE;

-- Many-to-many relationships
CREATE TABLE vets (
	id INT GENERATED ALWAYS AS IDENTITY NOT NULL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	age INT NOT NULL,
	date_of_graduation DATE NOT NULL
);

CREATE TABLE specializations (
	vets_id INT NOT NULL,
	CONSTRAINT fk_vets
	FOREIGN KEY(vets_id)
	REFERENCES vets(id),
	species_id INT NOT NULL,
	CONSTRAINT fk_species
	FOREIGN KEY(species_id)
	REFERENCES species(id)
);

CREATE TABLE visits (
	vets_id INT NOT NULL,
	CONSTRAINT fk_vets
	FOREIGN KEY(vets_id)
	REFERENCES vets(id),
	animals_id INT NOT NULL,
	CONSTRAINT fk_animals
	FOREIGN KEY(animals_id)
	REFERENCES animals(id)
);

ALTER TABLE visits
ADD COLUMN date_of_visit DATE;

-- Database performance audit
ALTER TABLE owners
DROP COLUMN age;

ALTER TABLE owners
ADD COLUMN age INT; 

 