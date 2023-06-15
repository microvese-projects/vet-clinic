/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' and '2019-12-31';
SELECT name FROM animals WHERE neutered=true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name!='Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;

-- Transactions
BEGIN;
DELETE FROM animals WHERE date_of_birth >= '2022-01-01';
SAVEPOINT SVP1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO SVP1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(name) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(name) FROM animals  WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT MAX(escape_attempts) AS max, neutered
FROM animals
GROUP BY neutered
ORDER BY max DESC
LIMIT 1;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg)
AS maxWeight, MIN(weight_kg)
AS minWeight
FROM animals
GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts)
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name AS AnimalName
FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name AS AnimalName, species.name AS Type
FROM animals
JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT owners.full_name AS OWNER, animals.name AS AnimalName
FROM animals
FULL JOIN owners
ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name as species, COUNT(animals.name)
FROM animals
JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT species.name AS Species, animals.name AS AnimalName, owners.full_name AS owner
FROM animals
JOIN species
ON animals.species_id = species.id
JOIN owners
ON animals.owner_id = owners.id
WHERE species.name = 'Digimon'
AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name, animals.escape_attempts, owners.full_name
FROM animals
JOIN owners
ON owners.id = animals.owner_id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name)
FROM animals
JOIN owners
ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(animals.name) DESC
LIMIT 1;

-- Last animal seen by william tatcher
SELECT animals.name AS animal_name
FROM animals
CROSS JOIN visits
CROSS JOIN vets
WHERE vets.name = 'WILLIAM TATCHER'
AND vets.id = visits.vet_id
AND animals.id = visits.animal_id
ORDER BY visit_date DESC
LIMIT 1;