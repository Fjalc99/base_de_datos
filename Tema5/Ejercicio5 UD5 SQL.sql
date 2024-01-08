/*1. Selecciona la media, agrupada por nombre de aeropuerto de salida, del % de ocupación de los vuelos. PISTA: 
tendrás que incluir una subconsulta dentro de otra y, en la interior, usar una subconsulta en el select :S (o bien usar WITH)*/
WITH porcentaje_ocupacion AS 
(
	SELECT id_vuelo, COUNT (id_reserva) * 100 / max_pasajeros AS "media"
	FROM vuelo JOIN avion USING (id_avion)
			   JOIN reserva USING (id_vuelo)
	GROUP BY id_vuelo, max_pasajeros
)

SELECT ROUND (AVG (media),2), origen.nombre
FROM vuelo JOIN aeropuerto origen ON (desde = origen.id_aeropuerto)
		   JOIN porcentaje_ocupacion USING (id_vuelo)
GROUP BY origen.nombre
/*2. Selecciona el tráfico de pasajeros (es decir, personas que han llegado en un vuelo o personas que han salido en un vuelo) 
agrupado por mes (independiente del año) y aeropuerto.*/ 

/*INVESTIGA: Tienes que hacer uso de la cláusula UNION, y piensa en hacer primero el tráfico de salida, después el de llegada 
(en consultas diferentes pero casi idénticas) y posteriormente en sumarlo.*/

(
	SELECT COUNT (*) AS "num_salidas" , TO_CHAR (salida, 'FMMonth') AS "mes", o.nombre 
	FROM vuelo JOIN aeropuerto o ON (desde = o.id_aeropuerto)
			   JOIN reserva USING (id_vuelo)
	GROUP BY salida, o.nombre 
	

UNION

	SELECT  COUNT (*) AS "num_llegadas" , TO_CHAR (llegada, 'FMMonth') AS "mes", d.nombre 
	FROM vuelo JOIN aeropuerto d ON (hasta = d.id_aeropuerto)
			   JOIN reserva USING (id_vuelo)
	GROUP BY llegada, d.nombre
) 



/*3. Suponiendo que el 30% del precio de cada billete son beneficios (y el 70% son gastos), ¿cuál es el trayecto que más 
rendimiento económico da? Es decir, ¿en qué trayecto estamos ganando más dinero? ¿Y con el que menos? Lo puedes hacer en 
consultas diferentes usando WITH*/

WITH beneficio AS 
(
	SELECT id_vuelo, ABS (precio - (precio * COALESCE (descuento,1)) * 0.30) AS "benef"
	FROM vuelo 
)

SELECT o.nombre, d.nombre
FROM vuelo JOIN aeropuerto o ON (desde = o.id_aeropuerto)
		   JOIN aeropuerto d ON (hasta = d.id_aeropuerto)
		   JOIN beneficio USING (id_vuelo)
WHERE benef >= ALL 
(
	SELECT benef
	FROM beneficio
)
OR benef <= ALL
(
	SELECT benef
	FROM beneficio
)


/*4. Seleccionar el nombre y apellidos de los clientes que no han hecho ninguna reserva para un vuelo que salga en el tercer 
trimestre desde Sevilla.*/

SELECT DISTINCT c.nombre, c.apellido1, c.apellido2
FROM cliente c JOIN reserva USING (id_cliente)
			 JOIN vuelo USING (id_vuelo)
			 JOIN aeropuerto origen ON (desde = origen.id_aeropuerto)
WHERE id_cliente NOT IN 
(
	SELECT id_cliente 
	FROM reserva JOIN vuelo USING (id_vuelo)
	WHERE TO_CHAR (salida, 'Q') = '3'
	AND origen.ciudad = 'Sevilla'
)
/*5. Selecciona el nombre y apellidos de aquellos clientes cuyo gasto en reservas de vuelos con origen en España (Sevilla, 
Málaga, Madrid, Bilbao y Barcelona) ha sido superior a la media total de gasto de vuelos con origen fuera de España.*/


SELECT DISTINCT c.nombre, c.apellido1, c.apellido2
FROM cliente c JOIN reserva USING (id_cliente)
			   JOIN vuelo v USING (id_vuelo)
			   JOIN aeropuerto origen ON (desde = origen.id_aeropuerto)
			   JOIN aeropuerto destino ON (v.hasta = destino.id_aeropuerto)
			  
WHERE origen.ciudad IN ('Sevilla','Málaga','Madrid','Bilbao','Barcelona')
AND precio * (1 - (COALESCE(descuento,0)/100)) >
(
	SELECT AVG (precio * (1 - (COALESCE(descuento,0)/100)))
	FROM cliente c JOIN reserva USING (id_cliente)
			   JOIN vuelo v USING (id_vuelo)
			   JOIN aeropuerto origen ON (desde = origen.id_aeropuerto)
			   JOIN aeropuerto destino ON (hasta = destino.id_aeropuerto)
	WHERE origen.ciudad IN ('Sevilla','Málaga','Madrid','Bilbao','Barcelona')
AND destino.ciudad NOT IN ('Sevilla','Málaga','Madrid','Bilbao','Barcelona')
)