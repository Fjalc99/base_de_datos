SELECT '1982-09-18'::date
		'2015-05-02 12:00:00'::timestamp;
		
SELECT 'today'::date
		'now'::timestamp
SELECT CURRENT_DATE, CURRENT_TIMESTAMP

SELECT  '1 year 1 month'::interval;

SELECT +'1 year 1 month'::interval;

SELECT CURRENT_DATE + 1;

SELECT '1 year'::interval + '2 year'::interval;

SELECT CURRENT_DATE - '1999-07-20'::date;

SELECT '1 year'::interval * 3;

SELECT TO_CHAR (salida, 'DD/MM/YYYY HH24:MI:SS')
FROM vuelos;

SELECT TO_CHAR (salida, 'DD/Month/YYYY HH24:MI:SS')
FROM vuelos;

SELECT TO_CHAR (salida, 'DD/FMMonth/YYYY HH24:MI:SS')
FROM vuelos;

SELECT * 
FROM vuelos
WHERE TO_CHAR(salida, 'MM') = '04'

SELECT * 
FROM vuelos
WHERE TO_CHAR(salida, 'MM/YYYY') = '04/2021'