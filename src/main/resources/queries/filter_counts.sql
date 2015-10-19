SELECT
	hosp.name,
	COUNT(exp.npid)
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
JOIN
	provider_languages lang
ON
	exp.npid = lang.npid
WHERE
	exp.group_type = 'SPX'
	AND exp.group_code = '207XX0005X'
	AND ST_DISTANCE(POINT(-118.4, 34.2), POINT(loc.longitude, loc.latitude)) * 69.1 < 25
-- AND get_distance_in_miles_between_geo_locations(34.2, -118.4, loc.latitude, loc.longitude) < 25
-- AND hosp.name = 'Cedars Sinai Medical Center'
GROUP BY
	hosp.name;