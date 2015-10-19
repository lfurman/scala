USE employer_dev;

SELECT
	exp.group_code,
	exp.group_type,
	hosp.name,
	COUNT(hosp.npid)
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
	ST_DISTANCE(POINT(-118.4, 34.2), POINT(loc.longitude, loc.latitude)) * 69.1 < 25
	AND exp.group_code IS NOT NULL AND exp.group_code != ''
GROUP BY
	exp.group_code,
	exp.group_type,
	hosp.name
ORDER BY
	exp.group_type,
	exp.group_code,
	hosp.name;