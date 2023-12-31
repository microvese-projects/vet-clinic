/* Populate database with sample data. */

INSERT INTO animals 
  (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES 
  ('Agumon', '2020-02-03', 0, true, 10.23),
  ('Gabumon', '2018-11-15', 2, true, 8.0),
  ('Pikachu', '2021-01-07', 1, false, 15.04),
  ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals 
  (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
  ('Charmander', '2020-08-02', 0, false, -11),
  ('Plantmon', '2021-11-15', 2, true, -5.7),
  ('Squirtle', '1993-04-02', 3, false, -12.13),
  ('Angemon', '2005-06-12', 1, true, -45),
  ('Boarmon', '2005-06-07', 7, true, 20.4),
  ('Blossom', '1998-08-13', 3, true, 17),
  ('Ditto', '2022-05-14', 4, true, 22);

BEGIN;
INSERT INTO owners 
  (FULL_NAME, AGE)
VALUES
  ('Sam Smith', 34),
  ('Jennifer Orwell', 19),
  ('Bob', 45),
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38);
COMMIT;

BEGIN;
INSERT INTO species
  (name)
VALUES
  ('Pokemon'),
  ('Digimon');
COMMIT;

-- add species id to animals table 
BEGIN;
UPDATE animals
SET species_id = 2
WHERE NAME LIKE '%mon';

UPDATE animals 
SET species_id = 1
WHERE species_id IS NULL;
COMMIT;

-- Update owner ids
BEGIN;
-- sam smith
UPDATE animals 
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Sam Smith'
)
WHERE name IN ('Agumon');
-- jennifer orwell
UPDATE animals 
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Jennifer Orwell'
)
WHERE name IN ('Gabumon', 'Pikachu');
-- Bob
UPDATE animals 
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Bob'
)
WHERE name IN ('Devimon', 'Plantmon');
-- Melody Pond
UPDATE animals 
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Melody Pond'
)
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');
-- Dean Winchester
UPDATE animals 
SET owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Dean Winchester'
)
WHERE name IN ('Angemon', 'Boarmon');
COMMIT;

-- insert vets data
BEGIN;
INSERT INTO vets
  (NAME, AGE, DATE_OF_GRADUATION)
VALUES
  ('WILLIAM TATCHER', 45, '2000-04-23'),
  ('MAISY SMITH', 26, '2019-01-17'),
  ('STEPHANIE MENDEZ', 64, '1981-05-04'),
  ('JACK HARKNESS', 38, '2008-06-08');
COMMIT;

-- insert specializations data 
BEGIN;
INSERT INTO specializations
  (SPECIES_ID, VET_ID)
SELECT species.id, vets.id
FROM species
CROSS JOIN vets
WHERE 
  species.name = 'Pokemon' AND (vets.name = 'WILLIAM TATCHER' OR vets.name = 'STEPHANIE MENDEZ')
OR 
  species.name = 'Digimon' AND (vets.name = 'STEPHANIE MENDEZ' OR vets.name = 'JACK HARKNESS');
COMMIT;

-- insert visitation data

-- agumon and william
BEGIN;
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-05-24'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Agumon' AND vets.name = 'WILLIAM TATCHER';
-- agumon and stephanie
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-07-22'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Agumon' AND vets.name = 'STEPHANIE MENDEZ';
-- GABUMON AND JACK
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2021-02-02'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Gabumon' AND vets.name = 'JACK HARKNESS';
-- PIKACHU AND MAISY
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-01-05'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Pikachu' AND vets.name = 'MAISY SMITH';

INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-03-08'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Pikachu' AND vets.name = 'MAISY SMITH';

INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-03-14'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Pikachu' AND vets.name = 'MAISY SMITH';

-- DEVIMON AND STEPHANIE
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2021-05-04'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Devimon' AND vets.name = 'STEPHANIE MENDEZ';

-- CHARMANDER AND JACK
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2021-02-24'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Charmander' AND vets.name = 'JACK HARKNESS';

-- PLANTMON AND MAISY
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2019-12-21'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Plantmon' AND vets.name = 'MAISY SMITH';

-- PLANTMON AND WILLIAM 
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-08-10'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Plantmon' AND vets.name = 'WILLIAM TATCHER';

-- PLANTMON AND MAISY 
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2021-04-07'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Plantmon' AND vets.name = 'MAISY SMITH';

-- SQUIRTLE AND STEPHANIE
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2019-09-29'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Squirtle' AND vets.name = 'STEPHANIE MENDEZ';

-- ANGEMON AND JACK
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-10-03'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Angemon' AND vets.name = 'JACK HARKNESS';

INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-11-04'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Angemon' AND vets.name = 'JACK HARKNESS';

-- BOARMON AND MAISY
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2019-01-24'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Boarmon' AND vets.name = 'MAISY SMITH';

INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2019-05-15'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Boarmon' AND vets.name = 'MAISY SMITH';

INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-02-27'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Boarmon' AND vets.name = 'MAISY SMITH';

INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-08-03'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Boarmon' AND vets.name = 'MAISY SMITH';

-- BLOSSOM AND STEPHANIE
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2020-05-24'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Blossom' AND vets.name = 'STEPHANIE MENDEZ';

-- BLOSSOM AND WILLIAM
INSERT INTO visits 
  (ANIMAL_ID, VET_ID, VISIT_DATE)
SELECT animals.id, vets.id, '2021-01-11'
FROM animals
CROSS JOIN vets
WHERE 
  animals.name = 'Blossom' AND vets.name = 'WILLIAM TATCHER';

COMMIT;