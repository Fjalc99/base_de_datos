/*Selecciona el nombre del comprador, el nombre del vendedor, la provincia y la fecha de operación de las 
viviendas (casa y piso) alquiladas en el tercer trimestre de año en las provincias de Huelva, Sevilla y Almería. 
Ordena la salida por fecha de operación descendentemente.*/

SELECT  c.nombre, v.nombre, i.provincia, fecha_operacion
FROM comprador c JOIN operacion o USING (id_cliente) 
			   JOIN vendedor v USING (id_vendedor)
			   JOIN inmueble i USING (id_inmueble)	
			   JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE provincia IN ('Huelva','Sevilla','Almería')
AND tipo_operacion = 'Alquiler'
AND t.nombre IN ('Casa','Piso')
AND EXTRACT (MONTH from fecha_operacion) BETWEEN 07 and 09
ORDER BY fecha_operacion DESC

/*Modifica la consulta anterior para que las viviendas que fueran vendidas en un 
plazo de entre 35 y 45 días desde que se dieron de alta en la inmobiliaria.*/

SELECT *
FROM comprador c JOIN operacion o USING (id_cliente) 
			   JOIN vendedor v USING (id_vendedor)
			   JOIN inmueble i USING (id_inmueble)	
			   JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE EXTRACT (DAY from fecha_operacion) BETWEEN 35 and 45
AND EXTRACT (DAY from fecha_alta) BETWEEN 35 and 45

/* Calcula el precio máximo y precio mínimo por metro cuadrado de venta de inmuebles que no sean viviendas 
(no sean Piso o Casa) en provincias que contengan una n (mayúscula o minúscula), siempre que los inmuebles se 
hayan vendido en un mes que escrito de forma completa en inglés tenga entre 5 y 7 caracteres.*/

SELECT MAX(precio * superficie) AS "Precio maximo por metro cuadrado", 
		MIN(precio* superficie) AS "Precio mminimo por metro cuadrado"
FROM operacion o JOIN vendedor v USING (id_vendedor)
			   JOIN inmueble i USING (id_inmueble)
			   JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE t.nombre IN ('Parking','Oficina','Local','Suelo','Industrial')
AND provincia ILIKE '%n%'
AND LENGTH(TO_CHAR(fecha_operacion, '%Month'))BETWEEN 5 AND 7



