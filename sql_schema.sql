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


