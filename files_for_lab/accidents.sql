USE mid_camp_project;

-- First of all i need the postal code, so i'm going to use all
-- tables to obtain it.


SELECT * FROM mid_camp_project.accidents;
SELECT * FROM mid_camp_project.code_postal_code;
SELECT * FROM mid_camp_project.postal_code;

SELECT *, 
CASE
WHEN week_day IN ('Monday','Tuesday','Wednesday','Thursday') THEN 'weekday'
ELSE 'weekend'
END AS 'weekday_or_weekend', pc.postal_code AS postal_code
FROM mid_camp_project.accidents a
LEFT JOIN mid_camp_project.code_postal_code cpc USING(id_district)
LEFT JOIN mid_camp_project.postal_code pc USING(id_street)
WHERE pc.street_name LIKE '%'a.street'%';

(
	SELECT street_name
    FROM mid_camp_project.postal_code
    GROUP BY street_name);

pc.street_name;