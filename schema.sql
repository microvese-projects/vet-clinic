/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

ALTER TABLE animals ADD COLUMN species TEXT;

-- create owners table
CREATE TABLE OWNERS(ID INT GENERATED ALWAYS AS IDENTITY, FULL_NAME TEXT, AGE INT, PRIMARY KEY(ID));
-- create species table
CREATE TABLE SPECIES(ID INT GENERATED ALWAYS AS IDENTITY, NAME TEXT, PRIMARY KEY(ID));
