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

SELECT visits.date_of_visit, animals.name, vets.name FROM visits
LEFT JOIN animals ON visits.animal_id = animals.id
RIGHT JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'William Tatcher'
ORDER BY visits.date_of_visit;

SELECT animals.id, vets.name, animals.name FROM visits
JOIN animals ON visits.animal_id = animals.id
LEFT JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez';

SELECT vets.name AS vet_name, species.name as species FROM specialization
JOIN species ON specialization.species_id = species.id
RIGHT JOIN vets ON specialization.vet_id = vets.id;

SELECT animals.id, vets.name, animals.name, date_of_visit FROM visits
JOIN vets ON visits.vet_id = vets.id
JOIN animals ON visits.animal_id = animals.id
WHERE vets.name = 'Stephanie Mendez' 
AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

SELECT animal_id, animals.name, COUNT(animal_id) FROM visits
JOIN animals ON visits.animal_id = animals.id
GROUP BY animal_id, animals.name
order by COUNT(animal_id);

SELECT animal_id, animals.name, vets.name AS vet_name, date_of_visit FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
order by date_of_visit;
 
SELECT date_of_visit, animals.*, vets.* AS max_visit FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
order by date_of_visit desc;

SELECT vets.id AS vet_id, specialization.species_id AS specialization_id,
species.name AS species_name, species.id AS animal_species_id FROM visits
LEFT JOIN vets ON visits.vet_id = vets.id
LEFT JOIN animals ON visits.animal_id = animals.id
LEFT JOIN species ON animals.species_id = species.id
LEFT JOIN specialization ON vets.id = specialization.vet_id
WHERE vets.id != 3 
AND specialization.species_id != species.id 
OR specialization.species_id IS NULL
order by vets.id;

SELECT vets.name, species.id AS animal_species_id, species.name AS animal_species_name, count(species.id) FROM visits
LEFT JOIN vets ON visits.vet_id = vets.id 
LEFT JOIN animals ON visits.animal_id = animals.id
LEFT JOIN species ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, species.id;