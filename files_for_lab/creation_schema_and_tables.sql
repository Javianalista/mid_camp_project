CREATE SCHEMA `mid_camp_project`;

USE mid_camp_project;

DROP TABLE accidents;

CREATE TABLE accidents(
	id INT,
    date DATE,
    hour VARCHAR(255),
    week_day VARCHAR(255),
    district VARCHAR(255),
    street VARCHAR(255),
    id_accident VARCHAR(255),
    number_of_victims INT,
    type_of_accident VARCHAR(255),
    vehicle VARCHAR(255),
    type_of_person VARCHAR(255),
    gender VARCHAR(255),
    gravity VARCHAR(255),
    age VARCHAR(255),
    id_district INT,
    PRIMARY KEY (id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/accidents.csv' 
INTO TABLE accidents 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM mid_camp_project.accidents;

DROP TABLE postal_code;

CREATE TABLE postal_code(
	id INT,
    id_street INT,
    type_of_street VARCHAR(255),
    useless VARCHAR(255),
    street_name VARCHAR(255),
    postal_code INT,
    PRIMARY KEY (id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/postal_code_finished.csv' 
INTO TABLE postal_code 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

DROP TABLE code_postal_code;


CREATE TABLE code_postal_code(
	id INT,
    type_of_street VARCHAR(255),
    useless VARCHAR(255),
    street_name VARCHAR(255),
    id_street INT,
    id_district INT,
    complete_street_name VARCHAR(255),
    PRIMARY KEY (id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/code_postal_code_finished.csv' 
INTO TABLE code_postal_code 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;










