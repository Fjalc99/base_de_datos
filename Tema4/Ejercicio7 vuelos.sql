/*¿Cuál es el descuento medio obtenido en vuelos donde el origen sea España y el destino fuera de España, 
siempre que estos vuelos no se hayan realizado en fin de semana (contaremos como fin de semana los Viernes a 
partir de las 15:00)?*/


SELECT ROUND (AVG (descuento),2)
FROM vuelo  JOIN aeropuerto origen ON (desde = origen.id_aeropuerto)
			JOIN aeropuerto destino ON (hasta = destino.id_aeropuerto)
WHERE origen.ciudad IN ('Madrid','Sevilla','Bilbao','Málaga','Barcelona')
AND destino.ciudad IN ('París','Ámsterdam','Londres','Berlín','Nueva York','Ankara')
AND TO_CHAR (salida , 'ID') = ('1')
AND TO_CHAR (salida , 'ID') = ('2')
AND TO_CHAR (salida , 'ID') = ('3')
AND TO_CHAR (salida , 'ID') = ('4')