USE employer_dev;

SELECT
	exp.group_type,
	exp.group_code,
	ROUND(exp.overall_score),
	COUNT(exp.npid) cnt
FROM
	provider_experience exp
JOIN
	provider_location loc
ON
	exp.npid = loc.npid
WHERE
	ST_DISTANCE(POINT(-118.4, 34.2), POINT(loc.longitude, loc.latitude)) * 69.1 < 100
GROUP BY
	exp.group_type,
	exp.group_code,
	ROUND(exp.overall_score)
ORDER BY
	exp.group_type,
	exp.group_code,
	ROUND(exp.overall_score) DESC;