#!/bin/sh

# initialize variables
DB_HOST=mysql-scala1.cxo3zvgkyfwz.us-west-1.rds.amazonaws.com
DB_USERNAME=root
DB_PASSWORD=135Pos8fert

mysql -u ${DB_USERNAME} -p${DB_PASSWORD} -h ${DB_HOST} -e "

USE mdinsider_poc;

ALTER TABLE provider_experience DISABLE KEYS;
DELETE FROM provider_experience;
ALTER TABLE provider_experience ROW_FORMAT = Fixed;
LOAD DATA LOCAL INFILE 'provider_experience.txt' INTO TABLE provider_experience FIELDS TERMINATED BY '|'
(
	npid,
	group_type,
	group_code,
	@overall_score,
	@median_score,
	@background_score,
	@experience_score,
	@top_percentile
)
SET
    overall_score = NULLIF(@overall_score,''),
    median_score = NULLIF(@median_score,''),
    background_score = NULLIF(@background_score,''),
    experience_score = NULLIF(@experience_score,''),
    top_percentile = NULLIF(@top_percentile,'');
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
"
