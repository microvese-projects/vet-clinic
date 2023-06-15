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