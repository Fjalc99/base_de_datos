/*Seleccionar el vuelo más largo (con mayor duración) de cada día de la semana. 
Debe aparecer el nombre del aeropuerto de salida, el de llegada, la fecha y hora de salida y llegada y la duración.*/

SELECT origen.nombre, destino.nombre, TO_CHAR(salida, 'Day') as "dia", salida, llegada, age (llegada, salida) as "duracion"
FROM vuelo  JOIN aeropuerto origen ON (desde = origen.id_aeropuerto)
			 JOIN aeropuerto destino ON (hasta = destino.id_aeropuerto)
WHERE age(llegada, salida) >= ALL 
(
	SELECT age (llegada,salida)
	FROM vuelo
	ORDER BY age (llegada, salida)
)


/*Seleccionar el cliente que más ha gastado en vuelos que salen del mismo aeropuerto. 
Debe aparecer el nombre del cliente, el nombre y la ciudad del aeropuerto y la cuantía de dinero que ha gastado.*/

SELECT c.nombre, -SUM(precio - (precio * COALESCE (descuento,1))) as "gasto", destino.nombre, destino.ciudad
FROM cliente c JOIN reserva r USING (id_cliente)
			 JOIN vuelo v USING (id_vuelo)
			 JOIN aeropuerto destino ON (desde = destino.id_aeropuerto)
GROUP BY c.nombre, destino.nombre, destino.ciudad
HAVING COUNT (id_vuelo) > 1
ORDER BY gasto DESC
LIMIT 1
