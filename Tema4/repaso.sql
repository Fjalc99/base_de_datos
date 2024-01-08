/*3.(INMO) Selecciona el nombre del comprador, el nombre del vendedor, la provincia y la fecha de operación de las 
viviendas (casa y piso) alquiladas en el tercer trimestre de año en las provincias de Huelva, Sevilla y Almería. 
Ordena la salida por fecha de operación descendentemente.*/


/*SELECT c.nombre, v.nombre, i.provincia, o.fecha_operacion
FROM vendedor v JOIN operacion o USING (id_vendedor)
				JOIN comprador c USING (id_cliente)
				JOIN inmueble i USING (id_inmueble)
				JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE i.provincia IN ('Sevilla','Huelva','Almería')
AND i.tipo_operacion = 'Alquiler'
AND t.nombre IN ('Casa','Piso')
AND TO_CHAR (o.fecha_operacion, 'Q') = '3'
ORDER BY o.fecha_operacion DESC*/


/*4.(INMO) Modifica la consulta anterior para que las viviendas que fueran vendidas en un plazo de entre 35 y 45 días 
desde que se dieron de alta en la inmobiliaria.*/

/*SELECT c.nombre, v.nombre, i.provincia,
    o.fecha_operacion
FROM vendedor v JOIN operacion o USING (id_vendedor)
				JOIN comprador c USING (id_cliente)
				 JOIN inmueble i USING (id_inmueble)
				JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE i.provincia IN ('Sevilla','Huelva','Almería')
AND i.tipo_operacion = 'Venta'
AND t.nombre IN ('Casa','Piso')
AND age(fecha_operacion, fecha_alta)
BETWEEN '35 day'::interval AND '45 day'::interval

/*(INMO) Calcula el precio máximo y precio mínimo por metro cuadrado de venta de inmuebles que no sean viviendas 
(no sean Piso o Casa) en provincias que contengan una n (mayúscula o minúscula), siempre que los inmuebles se hayan 
vendido en un mes que escrito de forma completa en inglés tenga entre 5 y 7 caracteres.*/

SELECT MAX (o.precio_final / i.superficie), 
	   MIN (o.precio_final / i.superficie) 
FROM operacion o JOIN inmueble i USING (id_inmueble)
			   JOIN tipo t ON (i.tipo_inmueble = t.id_tipo)
WHERE i.provincia ILIKE  '%n%'
AND t.nombre NOT IN ('Piso','Casa')
AND i.tipo_operacion = 'Venta'
AND LENGTH (TO_CHAR(fecha_operacion, 'FMMonth'))BETWEEN 5 AND 7 */
			   
----------------------------------------------------------------------------------------------------------------

/*Seleccionar el nombre de los vendedores, la operación, la provincia, la fechad de alta, fecha de operación y el 
precio final de la provincia de Sevilla que los vendedores contengan una 'e' en su nombre y el tipo de operación sea 
'Alquiler' y se haya realizado los jueves de agosto y los domingos de abril. Ordenarlo por fecha de alta ascendente y 
precio final descendente.*/

SELECT v.nombre, i.tipo_operacion, i.provincia, o.fecha_operacion, o.precio_final 
FROM  vendedor v JOIN operacion o USING (id_vendedor)
				JOIN inmueble i USING (id_inmueble)
				JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE i.provincia = 'Sevilla'
AND v.nombre LIKE '%e%'
AND i.tipo_operacion = 'Alquiler'
AND (
	(		
	EXTRACT(isodow from fecha_operacion) = '4'
	AND 
	EXTRACT(month from fecha_operacion)='8' 
	)

	OR 
	
	(
    EXTRACT(isodow from fecha_operacion)= '7'
    AND 
	EXTRACT(month from fecha_operacion)= '4'
	)
	)
	
ORDER BY fecha_alta ASC, precio_final DESC





AND (
      (
        EXTRACT(day from fecha_operacion) BETWEEN 15 AND 31
        AND
        EXTRACT(month from fecha_operacion) = 1        
    )
      OR
    (
        EXTRACT(day from fecha_operacion) BETWEEN
        1 AND
            EXTRACT(day from (DATE_TRUNC('month',fecha_operacion)
             + '1 mon'::interval - '1 day'::interval)::date)
        AND
        EXTRACT(month from fecha_operacion) = 2
    )
      OR
    (
        EXTRACT(day from fecha_operacion) BETWEEN 1 AND 15
        AND
        EXTRACT(month from fecha_operacion) = 3            
    )    
  )