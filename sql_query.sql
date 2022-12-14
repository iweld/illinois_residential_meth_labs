/* 
 * Illinois Residential Meth Labs: The scourge of rural America
 *  
*/

/*

Clean Data

Although the data was prepared in Excel, I wanted to do a large part of the 
data cleaning using SQL to display the process.


The orginal table structure of the 'residental' Meth Labs table.  I will limit
the query to the first 10 records.

*/

SELECT * FROM residential LIMIT 10;

-- Result:

incident_id|incident_date|incident_address       |incident_city|incident_zip|incident_county|
-----------+-------------+-----------------------+-------------+------------+---------------+
          1|   2001-01-11|1286 55th avenue       |avon         |61415       |fulton         |
          2|   2001-01-14|1120 north amos street |springfield  |62702       |sangamon       |
          3|   2001-01-23|3351 terminal road: #25|springfield  |62702       |sangamon       |
          4|   2001-02-20|1005 south shumway     |taylorville  |62568       |christian      |
          5|   2001-03-10|15126 montgomery trail |hillsboro    |62049       |montgomery     |
          6|   2001-04-20|1005 west monroe street|bloomington  |61701       |mclean         |
          7|   2001-06-05|207 briarwood drive    |payson       |62360       |adams          |
          8|   2001-06-29|200 fulton street      |galesburg    |61402       |knox           |
          9|   2001-07-05|22333 east 13th road   |harvel       |62538       |montgomery     |
         10|   2001-07-14|125 north road         |irving       |62051       |montgomery     |

/*
	Let's check for any duplicate entries.  We will create a query that will 
	flag for duplicate entries if they have the same 'incident_date', 'incident_address' and 'incident_city'.  Common street names
	can have similar addresses in different cities.  To ensure that common street names don't give us a false duplicate, I am also 
	checking the city name.
         
*/
         
SELECT 
	incident_date,
	incident_address,
	incident_city,
	count(*)
FROM
	residential
GROUP BY 
	incident_date,
	incident_address,
	incident_city
HAVING
	count(*) > 1;

-- Results:

incident_date|incident_address             |incident_city|count|
-------------+-----------------------------+-------------+-----+
   2017-02-03|3226 spring lake road        |manito       |    2|
   2005-09-27|502 north morrison: apt. b.  |collinsville |    2|
   2012-08-17|1107 north 3rd street        |quincy       |    2|
   2007-07-03|110 north 54th street        |quincy       |    2|
   2002-12-12|1316 12th avenue             |east moline  |    2|
   2015-01-11|315 west walnut street       |harrisburg   |    2|
   2010-03-31|5023 west paradise lane      |quincy       |    2|
   2014-02-11|6072 east mount pleasant lane|olney        |    2|
   2003-11-04|1015 emery street            |galesburg    |    2|
   2014-07-21|53 david street              |cahokia      |    2|
   
/*
	This dataset has 10 duplicate entries.  We will remove the duplicates from our newly
	copied table.
         
*/
   
DELETE 
FROM
	residential AS rc1
USING 
	residential AS rc2
WHERE
	rc1.incident_id > rc2.incident_id
AND
	rc1.incident_address = rc2.incident_address
AND
	rc1.incident_date = rc2.incident_date;

-- Let's once again check for duplicates.

SELECT 
	incident_date,
	incident_address,
	incident_city,
	count(*)
FROM
	residential
GROUP BY 
	incident_date,
	incident_address,
	incident_city
HAVING
	count(*) > 1;

-- Results:

incident_date|incident_address|incident_city|count|
-------------+----------------+-------------+-----+

    
-- Create a new table that copies the original table structure.        
DROP TABLE IF EXISTS residential_cleaned;
CREATE TABLE residential_cleaned AS 
TABLE residential
WITH NO DATA;

/*

Copy the data from the original table to our newly created table.  We will also ensure that all
characters are lower-case and any extra spaces are removed from the data.

I also want to remove the street number address and just leave the street name.

*/
INSERT INTO residential_cleaned (
	SELECT 
		incident_id,
		incident_date,
		trim(lower(substring(incident_address, length(split_part(incident_address, ' ', 1))+1, length(incident_address)))),
		trim(lower(incident_city)),
		trim(incident_zip),
		trim(lower(incident_county))
	FROM residential
);

-- Test table with the same query above.
SELECT * FROM residential_cleaned LIMIT 10;

-- Results:

incident_id|incident_date|incident_address  |incident_city|incident_zip|incident_county|
-----------+-------------+------------------+-------------+------------+---------------+
          1|   2001-01-11|55th avenue       |avon         |61415       |fulton         |
          2|   2001-01-14|north amos street |springfield  |62702       |sangamon       |
          3|   2001-01-23|terminal road: #25|springfield  |62702       |sangamon       |
          4|   2001-02-20|south shumway     |taylorville  |62568       |christian      |
          5|   2001-03-10|montgomery trail  |hillsboro    |62049       |montgomery     |
          6|   2001-04-20|west monroe street|bloomington  |61701       |mclean         |
          7|   2001-06-05|briarwood drive   |payson       |62360       |adams          |
          8|   2001-06-29|fulton street     |galesburg    |61402       |knox           |
          9|   2001-07-05|east 13th road    |harvel       |62538       |montgomery     |
         10|   2001-07-14|north road        |irving       |62051       |montgomery     |
         
-- What is the total number of unique row entries?
         
SELECT 
	count(*)
FROM 
	residential_cleaned;

-- Results:

count|
-----+
 3206|
 
 -- What is the earliest and latest incident date?
 
SELECT
	min(incident_date) AS earliest_date,
 	max(incident_date) AS latest_date
FROM
	residential_cleaned;

-- Results:

earliest_date|latest_date|
-------------+-----------+
   2001-01-11| 2021-10-01|
	


      










         
         
         
         
