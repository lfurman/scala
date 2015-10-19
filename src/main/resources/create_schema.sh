#!/bin/sh

mysql -u root -e "

USE employer_dev;

SET SQL_SAFE_UPDATES = 0;

DROP TABLE IF EXISTS provider_experience;
CREATE TABLE IF NOT EXISTS provider_experience
(
	npid VARCHAR(10),
	group_type VARCHAR(5),
	group_code VARCHAR(10),
	overall_score FLOAT,
	median_score FLOAT,
	background_score FLOAT,
	experience_score FLOAT,
	top_percentile BIT
);

DROP TABLE IF EXISTS provider_location;
CREATE TABLE IF NOT EXISTS provider_location
(
	npid VARCHAR(10),
	latitude FLOAT,
	longitude FLOAT
);

DROP TABLE IF EXISTS provider_hospitals;
CREATE TABLE IF NOT EXISTS provider_hospitals
(
	npid VARCHAR(10),
	name VARCHAR(100),
	address VARCHAR(100),
	phone VARCHAR(50)
);

DROP TABLE IF EXISTS provider_languages;
CREATE TABLE IF NOT EXISTS provider_languages
(
	npid VARCHAR(10),
	language VARCHAR(20)
);

ALTER TABLE provider_location ENGINE = MyISAM;
ALTER TABLE provider_hospitals ENGINE = MyISAM;
ALTER TABLE provider_experience ENGINE = MyISAM;

ALTER TABLE provider_location ADD PRIMARY KEY (npid);
ALTER TABLE provider_hospitals ADD PRIMARY KEY (npid);
ALTER TABLE provider_hospitals ADD INDEX idx_hosp (name);

ALTER TABLE provider_languages ADD INDEX idx_lang (language);
ALTER TABLE provider_languages ADD INDEX (npid, language);

ALTER TABLE provider_experience ADD INDEX idx_exp (npid, group_type, group_code);
ALTER TABLE provider_experience ADD INDEX idx_grp (group_type, group_code);
ALTER TABLE provider_experience ADD INDEX idx_npid (npid);
ALTER TABLE provider_experience ADD INDEX idx_score (overall_score);

"
