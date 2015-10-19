USE employer_dev;

SELECT
	exp.npid AS npid,
	exp.overall_score AS overall_score,
	ST_DISTANCE(POINT(-118.4, 34.2), POINT(loc.longitude, loc.latitude)) * 69.1 AS distance,
	hosp.name AS hospital
FROM
	provider_experience exp
	JOIN
	provider_location loc
		ON
			exp.npid = loc.npid
	JOIN
	provider_hospitals hosp
		ON
			hosp.npid = exp.npid
WHERE
	exp.group_type = 'SPX'
	AND exp.group_code = 'pcp'
	AND ST_DISTANCE(POINT(-118.4, 34.2), POINT(loc.longitude, loc.latitude)) * 69.1 < 25
-- AND hosp.name = 'Cedars Sinai Medical Center'
ORDER BY
	exp.overall_score DESC
	-- distance
LIMIT 10;