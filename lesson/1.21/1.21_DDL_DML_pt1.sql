-- .read 'lesson\1.21\1.21_DDL_DML_pt1.sql'
USE data_jobs;

DROP DATABASE IF EXISTS jobs_mart;


CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;


SELECT * 
FROM information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

-- DROP SCHEMA IF EXISTS staging;

-- CREATE TABLE

CREATE TABLE IF NOT EXISTS staging.preffered_roles (
    role_id INTEGER PRIMARY KEY ,
    role_name VARCHAR
);

SELECT * 
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';

-- DROP TABLE IF EXISTS staging.preffered_roles;

-- INSERT TABLE

INSERT INTO staging.preffered_roles (role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'Software Engineer');

SELECT * 
FROM Staging.preffered_roles;

-- ALTER TABLE

ALTER TABLE staging.preffered_roles
ADD COLUMN preffered_roles BOOLEAN;

-- ALTER TABLE staging.preffered_roles
-- DROP COLUMN preffered_roles;

UPDATE staging.preffered_roles
SET preffered_roles = TRUE
WHERE role_id = 1 OR role_id = 2;


UPDATE staging.preffered_roles
SET preffered_roles = FALSE
WHERE role_id = 3;


ALTER TABLE staging.preffered_roles
RENAME TO prirority_roles;

SELECT * 
FROM Staging.prirority_roles;

ALTER TABLE staging.prirority_roles
RENAME COLUMN preffered_roles TO prirority_lvl;

ALTER TABLE staging.prirority_roles
ALTER COLUMN prirority_lvl TYPE INTEGER;

UPDATE staging.prirority_roles
SET prirority_lvl = 3
WHERE role_id = 3;

SELECT * 
FROM Staging.prirority_roles;