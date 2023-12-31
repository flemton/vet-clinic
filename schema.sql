/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id              INT GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(250),
    date_of_birth   DATE NOT NULL,
    escape_attempts INT,
    neutered        BOOLEAN,
    weight_kg       DECIMAL,
    species_id      INT,
    owner_id        INT,
    PRIMARY KEY(id),
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species (id) ON DELETE SET NULL,
    CONSTRAINT fk_owner FOREIGN KEY(owner_id) REFERENCES owners (id) ON DELETE SET NULL
);

CREATE TABLE owners (
    id              INT GENERATED ALWAYS AS IDENTITY,
    full_name       VARCHAR(250),
    age             INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id              INT GENERATED ALWAYS AS IDENTITY,
    name            VARCHAR(250),
    PRIMARY KEY(id),
);

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

CREATE TABLE visits (
  animal_id INT REFERENCES animals(id),
  vet_id INT REFERENCES  vets(id),
  date_of_visit DATE,
  PRIMARY KEY (animal_id, vet_id, date_of_visit)
); 
