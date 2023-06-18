/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id              INT GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(250),
    date_of_birth   DATE NOT NULL,
    escape_attempts INT,
    neutered        BOOLEAN,
    weight_kg       DECIMAL,
    PRIMARY KEY(id)
);
ALTER TABLE animals ADD species varchar(255);

CREATE TABLE owners (
    id              INT GENERATED ALWAYS AS IDENTITY,
    full_name       VARCHAR(250),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id              INT GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(250),
    PRIMARY KEY(id)
);

BEGIN;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species (id) ON DELETE SET NULL;
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners (id) ON DELETE SET NULL;
COMMIT;

CREATE TABLE vets (
    id                  INT GENERATED ALWAYS AS IDENTITY,
    name                VARCHAR(250),
    age                 INT,
    date_of_graduation  DATE,
    PRIMARY KEY(id)
);

CREATE TABLE specialization (
    species_id          INT REFERENCES species (id) ON UPDATE CASCADE,
    vet_id              INT REFERENCES vets (id) ON UPDATE CASCADE,
    PRIMARY KEY (species_id, vet_id)
);
