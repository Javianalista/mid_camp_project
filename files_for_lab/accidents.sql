USE mid_camp_project;

-- First of all i need the postal code, so i'm going to use all
-- tables to obtain it.


SELECT * FROM mid_camp_project.accidents;
SELECT * FROM mid_camp_project.code_postal_code;
SELECT * FROM mid_camp_project.postal_code;

-- ESTA VALE
CREATE TABLE IF NOT EXISTS final AS 
SELECT ua.*, pc.postal_code
FROM mid_camp_project.unique_accidents ua
INNER JOIN mid_camp_project.code_postal_code cpc USING(id_district)
INNER JOIN mid_camp_project.postal_code pc USING(id_street)
WHERE ((ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street))
OR ((ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street))
OR ((ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street))
OR ((ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name)) 
OR ua.street LIKE pc.street_name 
GROUP BY ua.id_accident
ORDER by ua.id ASC;

-- Y ESTA
SELECT ua.*
FROM mid_camp_project.unique_accidents ua
WHERE NOT EXISTS (
	SELECT * FROM mid_camp_project.final f
	WHERE ua.id = f.id 
    );

ALTER TABLE ll ADD postal_code text;

SELECT * 
FROM mid_camp_project.tbl
UNION
SELECT * 
FROM mid_camp_project.ll
ORDER BY id;


SELECT *,
CASE
WHEN week_day IN ('Monday','Tuesday','Wednesday','Thursday') THEN 'weekday'
ELSE 'weekend'
END AS 'weekday_or_weekend'
FROM mid_camp_project.accidents
GROUP BY id_accident;
-----------
SELECT a.*, 
CASE
WHEN a.week_day IN ('Monday','Tuesday','Wednesday','Thursday') THEN 'weekday'
ELSE 'weekend'
END AS 'weekday_or_weekend',
CASE
WHEN (a.street LIKE pc.type_of_street) AND (a.street LIKE pc.street_name) AND (a.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street) THEN pc.postal_code
WHEN (a.street LIKE pc.street_name) AND (a.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street) THEN pc.postal_code
WHEN (a.street LIKE pc.type_of_street) AND (a.street LIKE pc.street_name) THEN pc.postal_code
WHEN a.street LIKE pc.street_name THEN pc.postal_code
ELSE 0
END AS 'postal_code'
FROM mid_camp_project.accidents a
LEFT JOIN mid_camp_project.code_postal_code cpc USING(id_district)
LEFT JOIN mid_camp_project.postal_code pc USING(id_street)

GROUP BY a.id_accident;


DROP temporary TABLE tbl;

DROP temporary TABLE ll;

CREATE temporary TABLE IF NOT EXISTS tbl AS 
SElECT *
FROM mid_camp_project.accidents
GROUP BY id_accident;

SELECT * FROM tbl;

SELECT ua.*,
CASE
WHEN (ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street) THEN pc.postal_code
WHEN (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street) THEN pc.postal_code
WHEN (ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) THEN pc.postal_code
WHEN ua.street LIKE pc.street_name THEN pc.postal_code
ELSE 0
END AS 'postal_code'
FROM mid_camp_project.unique_accidents ua
LEFT JOIN mid_camp_project.code_postal_code cpc USING(id_district)
LEFT JOIN mid_camp_project.postal_code pc USING(id_street)
WHERE IF (ua.street LIKE pc.street_name, postal_code = pc.postal_code, postal_code = 0)
GROUP BY ua.id_accident
ORDER BY id ASC;




SELECT ua.*, 
CASE
WHEN (ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street) THEN pc.postal_code
WHEN (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street) THEN pc.postal_code
WHEN (ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) THEN pc.postal_code
WHEN ua.street LIKE pc.street_name THEN pc.postal_code
ELSE NULL
END AS 'postal_code', a.id
FROM mid_camp_project.unique_accidents ua
LEFT JOIN mid_camp_project.code_postal_code cpc USING(id_district)
LEFT JOIN mid_camp_project.postal_code pc USING(id_street)
WHERE IF ((ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street), postal_code = pc.postal_code,
IF((ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street), postal_code = pc.postal_code, 
IF((ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name), postal_code = pc.postal_code, 
IF(ua.street LIKE pc.street_name,postal_code = pc.postal_code, postal_code = 0))))
GROUP BY ua.id_accident
ORDER BY id ASC;


SELECT *
FROM mid_camp_project.unique_accidents
(
	SELECT ua.id
	FROM mid_camp_project.unique_accidents ua
	LEFT JOIN mid_camp_project.code_postal_code cpc USING(id_district)
	LEFT JOIN mid_camp_project.postal_code pc USING(id_street)
	WHERE ua.street LIKE pc.street_name
	GROUP BY ua.id_accident
	ORDER BY id ASC
	) THEN (
		SELECT ua.*,
		CASE
	WHEN (ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street) THEN pc.postal_code
	WHEN (ua.street LIKE pc.street_name) AND (ua.number BETWEEN pc.start_of_the_street AND pc.end_of_the_street) THEN pc.postal_code
	WHEN (ua.street LIKE pc.type_of_street) AND (ua.street LIKE pc.street_name) THEN pc.postal_code
	WHEN ua.street LIKE pc.street_name THEN pc.postal_code
	ELSE 0
	END AS 'postal_code'
	FROM mid_camp_project.unique_accidents ua
	LEFT JOIN mid_camp_project.code_postal_code cpc USING(id_district)
	LEFT JOIN mid_camp_project.postal_code pc USING(id_street)
	WHERE IF (ua.street LIKE pc.street_name, postal_code = pc.postal_code, postal_code = 0)
	GROUP BY ua.id_accident
	HAVING id = ua.id
    )
ELSE (
	SELECT *
    FROM mid_camp_project.unique_accidents
    GROUP BY id_accident
    HAVING id = ua.id
    ):

SELECT *
FROM mid_camp_project.tbl;

SELECT t.*
FROM mid_camp_project.tbl t
WHERE t.id BETWEEN MIN(t.id) AND MAX(t.id)
WHERE t.id NOT EXISTS (
	SELECT * FROM mid_camp_project.unique_accidents ua
	WHERE t.id = ua.id
    );

SELECT a.*, 
CASE
WHEN a.week_day IN ('Monday','Tuesday','Wednesday','Thursday') THEN 'weekday'
ELSE 'weekend'
END AS 'weekday_or_weekend', pc.postal_code AS postal_code
FROM mid_camp_project.accidents a
INNER JOIN mid_camp_project.code_postal_code cpc USING(id_district)
INNER JOIN mid_camp_project.postal_code pc USING(id_street)
WHERE a.street LIKE pc.street_name
GROUP BY a.id_accident
ORDER BY a.id ASC;

SELECT * FROM ll
GROUP BY street;


SELECT l.*, pc.postal_code AS postal_code
FROM mid_camp_project.ll l
INNER JOIN mid_camp_project.code_postal_code cpc USING(id_district)
INNER JOIN mid_camp_project.postal_code pc USING(id_street)
WHERE l.street LIKE pc.street_name
GROUP BY l.id_accident
ORDER BY l.id ASC;

