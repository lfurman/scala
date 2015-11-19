SELECT
	exp.npid,
	ROUND(exp.overall_score),
	ST_DISTANCE(POINT(loc.longitude, loc.latitude), POINT(-118.4, 34.2)) * 69.1 dist
FROM
	mdinsider_poc.provider_diagnoses exp
	JOIN
	mdinsider_poc.provider_location loc
		ON
			exp.npid = loc.npid
WHERE
	search_code = '13.8'
	AND ST_DISTANCE(POINT(loc.longitude, loc.latitude), POINT(-118.4, 34.2)) * 69.1 < 25
ORDER BY
	ROUND(exp.overall_score) DESC,
	dist
LIMIT 10;

SELECT
	exp.npid,
	ROUND(exp.overall_score),
	ST_DISTANCE(POINT(loc.longitude, loc.latitude), POINT(-118.4, 34.2)) * 69.1 dist
FROM
	mdinsider_poc.provider_procedures exp
	JOIN
	mdinsider_poc.provider_location loc
		ON
			exp.npid = loc.npid
WHERE
	search_code = '244'
	AND ST_DISTANCE(POINT(loc.longitude, loc.latitude), POINT(-118.4, 34.2)) * 69.1 < 25
ORDER BY
	ROUND(exp.overall_score) DESC,
	dist
LIMIT 10;

SELECT
	exp.npid,
	ROUND(exp.overall_score),
	ST_DISTANCE(POINT(loc.longitude, loc.latitude), POINT(-118.4, 34.2)) * 69.1 dist
FROM
	mdinsider_poc.provider_specialties exp
	JOIN
	mdinsider_poc.provider_location loc
		ON
			exp.npid = loc.npid
WHERE
	search_code = 'pcp'
	AND ST_DISTANCE(POINT(loc.longitude, loc.latitude), POINT(-118.4, 34.2)) * 69.1 < 25
ORDER BY
	ROUND(exp.overall_score) DESC,
	dist
LIMIT 10;

SELECT
	exp.npid,
	ROUND(exp.overall_score),
	ST_DISTANCE(POINT(loc.longitude, loc.latitude), POINT(-118.4, 34.2)) * 69.1 dist
FROM
	delivery.provider_scores_nx_terms exp
JOIN
	mdinsider_poc.provider_location loc
ON
	exp.npid = loc.npid
WHERE
	search_code = '200001'
	AND ST_DISTANCE(POINT(loc.longitude, loc.latitude), POINT(-118.4, 34.2)) * 69.1 < 25
ORDER BY
	ROUND(exp.overall_score) DESC,
	dist
LIMIT 10;