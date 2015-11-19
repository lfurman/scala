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
	AND (
		group_code IN ('5.4', '5.11', '17.1.2', '16.4.1', '7.3.1.2', '3.8.5')
		OR group_code IN ('5.8.2', '5.15.6')
		OR group_code IN ('16.2.3.2', '13.2.1', '13.8', '6.9.1')
		OR group_code IN ('13.3.3.7', '13.3.3.4', '13.3.2', '13.3.3.2')
		OR group_code IN ('7.2.4.4', '7.2.4.1', '7.2.3', '7.2.2.2')
		OR group_code IN ('16.12', '7.3.1.2', '9.4.1.2')
		OR group_code IN ('2.3', '8.1.1', '8.2.4', '8.8.3')
		OR group_code IN ('9.6.4.2', '9.7', '9.4.4', '9.1', '9.12.3')
		OR group_code IN ('1.1.1', '8.2.4', '8.8.3')
		OR group_code IN ('8.1.1', '8.1.2', '17.1.2', '13.8')
		OR group_code IN ('1.1.1', '8.2.4', '8.8.3')
		OR group_code IN ('8.1.5.4', '6.8.1', '8.1.3', '16.12')
		OR group_code IN ('8.1.5.4', '6.8.1', '8.1.3', '16.12')
		OR group_code IN ('4.1.3.7', '5.8.2', '6.9.2', '13.8', '17.1.8')
		OR group_code IN ('4.1.3.7', '5.8.2', '6.9.2', '13.8', '17.1.8')
		OR group_code IN ('4.1.3.7', '5.8.2', '6.9.2', '13.8', '17.1.8')
		OR group_code IN ('9.6.2', '10.1.5', '9.12.3')
		OR group_code IN ('9.4.1.2', '9.4.4', '9.5.2')
		OR group_code IN ('9.7', '5.11', '9.8', '2.2.3', '1.3.2')
		OR group_code IN ('10.1.3', '10.1.4', '10.1.5', '10.1.2.1')
		OR group_code IN ('16.7', '13.2.2.2', '16.7.5', '13.8')
		OR group_code IN ('4.1.3.7', '5.8.2', '6.9.2', '13.8')
		OR group_code IN ('4.1.3.7', '5.8.2', '6.9.2', '13.8')
		OR group_code IN ('13.2.2.2', '16.7.6.1', '16.7.5', '13.8')
		OR group_code IN ('4.1.3.7', '5.8.2', '6.9.2', '13.8')
		OR group_code IN ('13.3.3.7', '13.3.3.4', '13.3.2', '13.3.3.2', '13.8')
		OR group_code IN ('4.1.3.7', '5.8.2', '6.9.2', '13.8')
		OR group_code IN ('8.9', '4.2.1', '7.1.1')
		OR group_code IN ('10.1.4', '10.1.5')
		OR group_code IN ('13.2.3', '13.8', '6.9.1')
		OR group_code IN ('8.1.5.4')
		OR group_code IN ('10.1.4', '10.1.5', '10.2.1')
		OR group_code IN ('9.9.1', '9.4.3', '9.1', '9.12.3')
		OR group_code IN ('13.7', '7.3.1.2')
		OR group_code IN ('9.1', '9.12.3')
		OR group_code IN ('8.1.5.4', '8.1.2', '8.2.4', '8.3.2.1')
		OR group_code IN ('6.7.5', '6.7.6', '16.8')
		OR group_code IN ('9.5.1.1', '10.2.3', '10.1.5', '10.2.2')
		OR group_code IN ('13.8', '13.9')
		OR group_code IN ('16.12', '8.1.2')
		OR group_code IN ('6.7.1', '6.7.3', '6.7.4', '6.7.2.3', '6.7.2.2')
		OR group_code IN ('13.2.2.2', '13.2.2.1', '16.7.6.1')
	)
	AND overall_score IS NULL;