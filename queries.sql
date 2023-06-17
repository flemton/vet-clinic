/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE NOT name = 'Gabumon';
SELECT * FROM animals WHERE weight_kg  BETWEEN 10.4 and 17.3;

BEGIN;
SAVEPOINT save1;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK TO SAVEPOINT save1;
SELECT * FROM animals;
COMMIT;

BEGIN;
SAVEPOINT begin;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
SAVEPOINT middle;
UPDATE animals SET species = 'pokemon' WHERE name IS NULL;
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;

BEGIN;
SAVEPOINT save1;
DELETE FROM animals;
ROLLBACK TO SAVEPOINT save1;
COMMIT;

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT delete;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SAVEPOINT delete;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE neutered = false;
SELECT COUNT(escape_attempts) FROM animals WHERE neutered = true;
SELECT MIN(weight_kg) FROM animals WHERE species = 'pokemon';
SELECT MAX(weight_kg) FROM animals WHERE species = 'pokemon';
SELECT MIN(weight_kg) FROM animals WHERE species = 'digimon';
SELECT MAX(weight_kg) FROM animals WHERE species = 'digimon';
SELECT AVG(escape_attempts) FROM animals 
WHERE species = 'digimon' and (date_of_birth > '1990-01-01' and date_of_birth < '2000-12-31');
SELECT AVG(escape_attempts) FROM animals 
WHERE species = 'pokemon' and (date_of_birth > '1990-01-01' and date_of_birth < '2000-12-31');

SELECT name AS animal_name, full_name AS owner FROM animals 
JOIN owners ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody Pond';

SELECT * FROM animals 
JOIN species ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';

SELECT * FROM owners 
RIGHT JOIN animals 
ON animals.owner_id = owners.id;

SELECT species.name, COUNT(animals.name) FROM animals 
JOIN species ON animals.species_id = species.id 
GROUP BY (species.name);

SELECT animals.name, owners.full_name FROM animals 
LEFT JOIN species ON animals.species_id = species.id 
RIGHT JOIN owners ON owners.id = animals.owner_id 
WHERE species.name = 'Digimon' and owners.full_name = 'Jennifer Orwell';

SELECT * FROM owners 
RIGHT JOIN animals ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

SELECT owners.full_name, COUNT(animals.name) FROM animals 
JOIN owners ON animals.owner_id = owners.id 
GROUP BY (owners.full_name);