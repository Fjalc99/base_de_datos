/*Selecciona los clientes que han comprado casas en Almería, siendo el precio final mayor que el 
precio medio de las casas vendidas en Almería.*/

SELECT c.nombre
FROM tipo t JOIN inmueble i ON (i.tipo_inmueble = t.id_tipo)
			JOIN operacion o USING (id_inmueble)
			JOIN comprador c USING (id_cliente)
WHERE precio_final >= 
   (
	SELECT AVG (precio)
	FROM tipo t JOIN inmueble i ON (i.tipo_inmueble = t.id_tipo)
			JOIN operacion o USING (id_inmueble)
	WHERE i.tipo_operacion = 'Venta'
	AND t.nombre = 'Casa'
	AND i.provincia = 'Almería'
	)
AND i.tipo_operacion = 'Venta'
AND t.nombre = 'Casa'
AND i.provincia = 'Almería'

/*Selecciona de todos los vendedores a aquellos que solo vendieron inmuebles de tipo Parking*/

SELECT v.nombre
FROM vendedor v JOIN operacion o USING (id_vendedor)
			  JOIN inmueble i USING (id_inmueble)
			  JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE id_vendedor NOT IN (
							SELECT id_vendedor
							FROM vendedor v JOIN operacion o USING (id_vendedor)
											JOIN inmueble i USING (id_inmueble)
			  								JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
							WHERE t.nombre = 'Parking'
						 )
