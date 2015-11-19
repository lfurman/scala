#!/bin/sh

# initialize variables
DB_HOST=mysql-scala1.cxo3zvgkyfwz.us-west-1.rds.amazonaws.com
DB_USERNAME=root
DB_PASSWORD=135Pos8fert

mysql -u ${DB_USERNAME} -p${DB_PASSWORD} -h ${DB_HOST} -e "

USE mdinsider_poc;

SET SQL_SAFE_UPDATES = 0;

UPDATE
	docfinder_master_fact doc
JOIN (
	SELECT
		npid,
		GROUP_CONCAT(
			CONCAT(
				'{\"code\":\"', search_code,',\"scoreComponents\":{\"overall\":', overall_score, ',\"median\":', median_score, ',\"background\":', background_score, ',\"experience\":', experience_score, '}}'
			)
			SEPARATOR ','
		) score_components
	FROM
		provider_scores_nx_terms
	GROUP BY
		npid
) nx_scores
ON
	doc.npid = nx_scores.npid
SET
	doc.diagnoses_treated = REPLACE(doc.diagnoses_treated, \"]\", CONCAT(nx_scores.score_components, \"]\"));
"