/*Seleccionar los 3 aeropuertos que menos tráfico de llegada (menos personas llegando a ellos en un vuelo) 
han registrado en un mes de Enero, Febrero o Marzo*/

SELECT  destino.nombre, COUNT (id_cliente) as "numero_clientes"
FROM vuelo v JOIN aeropuerto destino ON (hasta = destino.id_aeropuerto)
			JOIN reserva USING (id_vuelo)
WHERE EXTRACT (month from fecha_reserva) BETWEEN 1 and 3
GROUP BY destino.nombre
ORDER BY numero_clientes ASC
LIMIT 3

/*Selecciona el origen y el destino de los 10 vuelos con una duración menor. Debes realizarlo usando subconsultas.*/

SELECT origen.nombre, destino.nombre
FROM vuelo v JOIN aeropuerto origen ON (v.desde = origen.id_aeropuerto)
			 JOIN aeropuerto destino ON (v.hasta = destino.id_aeropuerto) 
WHERE llegada - salida  IN (
					SELECT llegada - salida
					FROM vuelo v JOIN aeropuerto origen ON (v.desde = origen.id_aeropuerto)
			 					 JOIN aeropuerto destino ON (v.hasta = destino.id_aeropuerto) 
					ORDER BY llegada - salida				
					LIMIT 10
			   )
LIMIT 10	
	
/*Selecciona el importe que la aerolínea de la base de datos de vuelos ha ingresado por cada uno de los vuelos que se han 
realizado en fin de semana (es decir, que han salido entre viernes y domingo) en los meses de Julio y Agosto (da igual el año).*/


SELECT SUM (precio * COALESCE (descuento ,1))
FROM vuelo JOIN reserva USING (id_vuelo)
WHERE EXTRACT (isodow from salida)BETWEEN 5 and 7
AND EXTRACT (month from salida) BETWEEN 7 and 8
