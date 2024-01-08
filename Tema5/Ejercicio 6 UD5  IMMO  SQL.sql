/*Selecciona, agrupando por vendedor, el precio final medio de pisos y casas que se han vendido en cada provincia. 
Debe aparecer el nombre del vendedor, la provincia y el precio medio.*/

WITH precio_final_pisos_casas AS 
(
	SELECT provincia,ROUND (AVG (precio_final),2) AS "precio_media"
	FROM vendedor v JOIN operacion o USING (id_vendedor)
				  JOIN inmueble i USING (id_inmueble)
				   JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
	WHERE t.nombre IN ('Casa','Piso')
	AND i.tipo_operacion = 'Venta'
	GROUP BY provincia
)

SELECT precio_media, v.nombre, i.provincia
FROM vendedor v JOIN operacion o USING (id_vendedor)
			  JOIN inmueble i USING (id_inmueble)
			  JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
			  JOIN precio_final_pisos_casas USING (provincia)  	   
GROUP BY precio_media, v.nombre, i.provincia

/*Seleccionar la suma del precio final, agrupado por provincia, de aquellos locales donde su precio sea superior al producto 
del número de metros cuadrados de ese local por el precio medio del metro cuadrado de los locales de esa provincia.*/

WITH suma_precio_final AS 
(
	SELECT provincia, SUM (precio_final) AS "suma_final"
	FROM operacion o JOIN inmueble i USING (id_inmueble)
				   JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
	WHERE t.nombre IN ('Local')
	GROUP BY provincia
)

SELECT suma_final, provincia
FROM operacion o JOIN inmueble i USING (id_inmueble)
				 JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
				 JOIN suma_precio_final USING (provincia)
WHERE suma_final > 
(
	SELECT AVG (precio / superficie)
	FROM operacion o JOIN inmueble i USING (id_inmueble)
)
GROUP BY suma_final, provincia
/*Selecciona la media de pisos vendidos al día que se han vendido en cada provincia. Es decir, debes calcular primero el número 
de pisos que se han vendido cada día de la semana en cada provincia, y después, sobre eso, calcular la media por provincia.*/

WITH numero_pisos AS
(
	SELECT provincia, COUNT (id_inmueble) AS "media_pisos", TO_CHAR (fecha_operacion, 'Day') AS "dia"
	FROM operacion o JOIN inmueble i USING (id_inmueble)
				   JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
	WHERE t.nombre = 'Piso'
	AND i.tipo_operacion = 'Venta'
	GROUP BY provincia, dia
)
 
SELECT ROUND (AVG (media_pisos),2), dia , provincia
FROM  operacion o JOIN inmueble i USING (id_inmueble)
				   JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
				   JOIN numero_pisos USING (provincia)
GROUP BY media_pisos, provincia, dia

/*Selecciona el cliente que ha comprado más barato cada tipo de inmueble (casa, piso, local, …). Debe aparecer el nombre del 
cliente, la provincia del inmueble, la fecha de operación, el precio final y el nombre del tipo de inmueble. 
¿Te ves capaz de modificar la consulta para que en lugar de que salga el más barato, salgan los 3 más baratos?*/

SELECT c.nombre, i.provincia, o.fecha_operacion, o.precio_final, t.nombre
FROM comprador c JOIN operacion o USING (id_cliente)
			   JOIN inmueble i USING (id_inmueble)
			   JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE i.tipo_operacion = 'Venta'
AND precio_final IN 
(
	SELECT MIN (precio_final) 
	FROM comprador c JOIN operacion o2 USING (id_cliente)
			  		 JOIN inmueble i USING (id_inmueble)
			  		 JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
	WHERE i.tipo_operacion = 'Venta'
	GROUP BY t.nombre
	ORDER BY MIN (o2.precio_final)
	
)
ORDER BY t.nombre, o.fecha_operacion

/*De entre todos los clientes que han comprado un piso en Sevilla, selecciona a los que no han realizado ninguna compra en fin 
de semana.*/

SELECT DISTINCT c.nombre, i.tipo_operacion, provincia 
FROM comprador c JOIN operacion o USING (id_cliente)
			   JOIN inmueble i USING (id_inmueble)
			   JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE i.tipo_operacion = 'Venta'
AND t.nombre = 'Piso'
AND i.provincia = 'Sevilla' 
AND c.id_cliente NOT IN 
(	
	SELECT DISTINCT c2.id_cliente
	FROM comprador c2 JOIN operacion USING (id_cliente)
					  JOIN inmueble i2 USING (id_inmueble)
	WHERE EXTRACT (isodow from fecha_operacion)BETWEEN 6 AND 7
	AND i2.tipo_operacion = 'Venta'
)
/*El responsable de la inmobiliaria quiere saber el rendimiento de operaciones de alquiler que realiza cada vendedor durante los 
días de la semana (de lunes a sábado). Se debe mostrar el nombre del vendedor, el % del número de operaciones de alquiler que ha 
realizado en ese día de la semana ese vendedor y el precio medio por metro cuadrado de las operaciones de alquiler que ha 
realizado ese vendedor en ese día de la semana.*/



WITH precio_medio AS 
(
	SELECT id_inmueble, ROUND (AVG (precio / superficie),2) AS "media", TO_CHAR (fecha_operacion, 'Day') AS "dia"
	FROM operacion o JOIN inmueble i USING (id_inmueble)
	GROUP BY dia, id_inmueble
)


SELECT v.nombre, dia, media
FROM vendedor v JOIN operacion o USING (id_vendedor)
			  JOIN inmueble i USING (id_inmueble)
			  JOIN precio_medio USING (id_inmueble)
WHERE EXTRACT (isodow from fecha_operacion) BETWEEN 1 AND 6
AND tipo_operacion = 'Alquiler'
GROUP BY v.nombre, dia, media


/*Elabora el enunciado de una consulta que incluya una su consulta correlacionada o que sea ideal para resolver con el 
operador WITH*/

/*Seleccionar el locslrd  que se han alquilado más caro de cada provincia. 
Debe aparecer la provincia, el nombre del comprador, la fecha de la operación y la cuantía.*/

SELECT c.nombre, provincia, precio_final
FROM comprador c JOIN operacion o USING (id_cliente) 
			   JOIN inmueble i USING (id_inmueble)
			   JOIN tipo t ON (tipo_inmueble = t.id_tipo)
WHERE tipo_operacion = 'Alquiler'
AND t.nombre = 'Local'
AND precio_final >= ALL
				 (
 					SELECT precio_final
					FROM operacion JOIN inmueble i2 USING (id_inmueble)
					 			   JOIN tipo t ON (tipo_inmueble = t.id_tipo)
					WHERE i.provincia = i2.provincia
					 AND tipo_operacion = 'Alquiler'
					 AND t.nombre = 'Local'
				 )
