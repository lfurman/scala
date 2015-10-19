#!/bin/sh

mysql -u root -e "

USE employer_dev;

ALTER TABLE provider_experience DISABLE KEYS;
DELETE FROM provider_experience;
ALTER TABLE provider_experience ROW_FORMAT = Fixed;
LOAD DATA LOCAL INFILE 'provider_experience.txt' INTO TABLE provider_experience FIELDS TERMINATED BY '|';
ALTER TABLE provider_experience ENABLE KEYS;

ALTER TABLE provider_location DISABLE KEYS;
DELETE FROM provider_location;
ALTER TABLE provider_location ROW_FORMAT = Fixed;
LOAD DATA LOCAL INFILE 'provider_location.txt' INTO TABLE provider_location FIELDS TERMINATED BY '|';
ALTER TABLE provider_location ENABLE KEYS;

ALTER TABLE provider_hospitals DISABLE KEYS;
DELETE FROM provider_hospitals;
ALTER TABLE provider_hospitals ROW_FORMAT = Fixed;
LOAD DATA LOCAL INFILE 'provider_hospitals.txt' INTO TABLE provider_hospitals FIELDS TERMINATED BY '|';
ALTER TABLE provider_hospitals ENABLE KEYS;

ALTER TABLE provider_languages DISABLE KEYS;
DELETE FROM provider_languages;
ALTER TABLE provider_languages ROW_FORMAT = Fixed;
LOAD DATA LOCAL INFILE 'provider_languages.txt' INTO TABLE provider_languages FIELDS TERMINATED BY '|';
ALTER TABLE provider_languages ENABLE KEYS;
"
