#!/bin/sh

# initialize variables
NX_TERMS_COMMON_CAUSES_FILE=nx_terms_common_causes.txt
DB_HOST_NAME=mysql-scala1.cxo3zvgkyfwz.us-west-1.rds.amazonaws.com
DB_USERNAME=root
DB_PASSWORD=135Pos8fert

# read NX terms and their common causes and save to file
mysql -u ${DB_USERNAME} -p${DB_PASSWORD} -h ${DB_HOST_NAME} --skip-column-names --batch -e "

USE mdinsider_poc;

DROP TABLE IF EXISTS provider_scores_nx_terms;
CREATE TABLE IF NOT EXISTS provider_scores_nx_terms
(
	npid VARCHAR(10),
	search_code VARCHAR(10),
	overall_score FLOAT,
	median_score FLOAT,
	background_score FLOAT,
	experience_score FLOAT
);

SELECT
	search_code,
	REPLACE(REPLACE(REPLACE(common_causes, '\"', '\''), '[', ''), ']', '') common_causes
FROM
	delivery.151113_typeahead_search_fact
WHERE
	search_type = 'NX';
" > ${NX_TERMS_COMMON_CAUSES_FILE}

# read NX terms from file
while read NX_TERM_CODE COMMON_CAUSES; do

echo "NX_TERM_CODE: ${NX_TERM_CODE}"
echo "COMMON_CAUSES: ${COMMON_CAUSES}"
echo "Calculating scores..."

# calculate and insert provider score for each NX term
mysql -u ${DB_USERNAME} -p${DB_PASSWORD} -h ${DB_HOST_NAME} -e "

USE mdinsider_poc;

INSERT INTO provider_scores_nx_terms
SELECT
	exp1.npid,
	${NX_TERM_CODE},
	exp1.max_score,
	exp2.median_score,
	exp2.background_score,
	exp2.experience_score
FROM (
	SELECT
		npid,
		MAX(overall_score) max_score
	FROM
		provider_experience
	WHERE
		group_type = 'DX'
		AND group_code IN (${COMMON_CAUSES})
	GROUP BY
		npid
) exp1
JOIN (
	SELECT
		npid,
		group_code,
		median_score,
		background_score,
		experience_score,
		overall_score
	FROM
		provider_experience
	WHERE
		group_type = 'DX'
		AND group_code IN (${COMMON_CAUSES})
) exp2
ON
	exp1.npid = exp2.npid
	AND exp1.max_score = exp2.overall_score;
"

# close NX terms file
done < ${NX_TERMS_COMMON_CAUSES_FILE}

mysql -u ${DB_USERNAME} -p${DB_PASSWORD} -h ${DB_HOST_NAME} -e "
USE mdinsider_poc;

ALTER IGNORE TABLE provider_scores_nx_terms
ADD UNIQUE INDEX idx_npid_search_code (npid, search_code);
"
