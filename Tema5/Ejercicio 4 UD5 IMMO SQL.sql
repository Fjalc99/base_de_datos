/*Seleccionar el piso que se ha vendido más caro de cada provincia. 
Debe aparecer la provincia, el nombre del comprador, la fecha de la operación y la cuantía.*/

SELECT c.nombre, provincia, precio_final
FROM comprador c JOIN operacion o USING (id_cliente) 
			   JOIN inmueble i USING (id_inmueble)
			   JOIN tipo t ON (tipo_inmueble = t.id_tipo)
WHERE tipo_operacion = 'Venta'
AND t.nombre = 'Piso'
AND precio_final >= ALL
				 (
 					SELECT precio_final
					FROM operacion JOIN inmueble i2 USING (id_inmueble)
					 			   JOIN tipo t ON (tipo_inmueble = t.id_tipo)
					WHERE i.provincia = i2.provincia
					 AND tipo_operacion = 'Venta'
					 AND t.nombre = 'Piso'
				 )



/*Seleccionar los alquileres más baratos de cada provincia y mes (da igual el día y el año). 
Debe aparecer el nombre de la provincia, el nombre del mes, el resto de atributos de la tabla inmueble y el 
precio final del alquiler.*/

SELECT i. *, TO_CHAR(o.fecha_operacion, 'Month') as "mes" , precio_final
FROM inmueble i JOIN operacion o USING (id_inmueble)
WHERE i.tipo_operacion = 'Alquiler'
AND precio_final <= ALL 
(
	SELECT precio_final
	FROM inmueble i2 JOIN operacion o USING (id_inmueble)
	WHERE i.tipo_operacion = 'Alquiler'
	AND i.provincia = i2.provincia
)



