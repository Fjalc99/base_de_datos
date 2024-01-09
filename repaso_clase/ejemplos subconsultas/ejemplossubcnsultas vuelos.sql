/*Seleccionar la media de vuelos que sale cada día, independientemente del aeropuerto que salga el vuelo*/

SELECT *
FROM (
		SELECT desde, salida
		FROM vuelo
		WHERE EXTRACT (isodow from salida)BETWEEN 1 and 7
		)
		
------------------------------------------------------------		
SELECT dia, AVG(cant)
FROM (
		SELECT TO_CHAR (salida, 'Day') as "dia", salida::date, COUNT (*) as "cant"
		FROM vuelo
		GROUP BY TO_CHAR (salida, 'Day'), salida::date, EXTRACT (isodow from salida)
	 )
GROUP BY dia, cant
ORDER BY cant
	