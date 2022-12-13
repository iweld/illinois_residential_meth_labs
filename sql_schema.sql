/*
	Illinois Residential Meth Labs
*/


DROP TABLE IF EXISTS residential;
CREATE TABLE residential (
	incident_id int PRIMARY KEY,
	incident_date date,
	incident_address TEXT,
	incident_city TEXT,
	incident_zip varchar(5),
	incident_county text
);

-- Import csv from wheverever you have it stored.  Note the delimiter.

COPY residential
FROM
'C:\Users\Jaime\Desktop\git-repo\illinois_residential_meth_labs\csv\illinois_residential_meth_labs_2001-2021.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM residential

DROP TABLE IF EXISTS illinois_county_data;
CREATE TABLE illinois_county_data (
	county_name TEXT PRIMARY KEY,
	population_rank SMALLINT,
	population_2010 int,
	population_2022 int,
	population_growth numeric,
	land_area smallint,
	population_density numeric,
	population_percentage numeric
);

-- Import csv from wheverever you have it stored.  Note the delimiter.

COPY illinois_county_data
FROM
'C:\Users\Jaime\Desktop\git-repo\illinois_residential_meth_labs\csv\county_population_2022.csv'
DELIMITER ',' CSV HEADER;

SELECT * FROM illinois_county_data;


