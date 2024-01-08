/*1. Selecciona el top 3 de pisos vendidos más caros en Sevilla a lo largo del año 2019
(puedes investigar el uso de LIMIT para hacerlo)*/

SELECT *
FROM operacion o JOIN inmueble i USING (id_inmueble)
			   JOIN vendedor v USING (id_vendedor)
			  JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE i.provincia = 'Sevilla'
AND TO_CHAR (fecha_operacion, 'YYYY') = '2019'
AND t.nombre = 'Piso'
AND i.tipo_operacion = 'Venta'
ORDER BY precio_final DESC
LIMIT 3;

/*2. Selecciona el precio medio de los alquileres en Málaga en los meses de Julio y Agosto (da igual de qué año).*/

SELECT ROUND (AVG (precio_final),2)
FROM operacion o JOIN inmueble i USING (id_inmueble)
			   JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE i.tipo_operacion = 'Alquiler'	
AND i.provincia = 'Málaga'
AND TO_CHAR (fecha_alta, 'MM') IN ('07','08')


/*3. Selecciona los inmuebles que se han vendido en Jaén y Córdoba en los últimos 3 meses del año 2019 o 2020.*/

SELECT *
FROM  operacion JOIN inmueble USING (id_inmueble)
WHERE provincia IN ('Jaén','Córdoba')
AND tipo_operacion = 'Venta'
AND TO_CHAR (fecha_operacion, 'Q') IN ('4')
AND TO_CHAR (fecha_operacion, 'YYYY') IN ('2019','2020')

/*4. Selecciona el precio medio de las ventas de Parking en la provincia de Huelva para aquellas 
operaciones que se realizaran entre semana (de Lunes a Viernes).*/

SELECT ROUND (AVG(precio_final),2)
FROM  operacion o JOIN inmueble i USING (id_inmueble)
				JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE provincia = 'Huelva'
AND i.tipo_operacion = 'Venta'
AND t.nombre = 'Parking'
AND TO_CHAR (fecha_operacion, 'ID') BETWEEN '1' AND '5' 


/*5. Selecciona aquellos pisos que han tardado en venderse entre 3 y 6 meses en la provincia de Granada.*/

SELECT *
FROM operacion o JOIN inmueble i USING (id_inmueble)
				JOIN tipo t ON (t.id_tipo = i.tipo_inmueble)
WHERE t.nombre = 'Piso'
AND i.tipo_operacion = 'Venta'
AND provincia = 'Granada'
AND AGE (fecha_operacion, fecha_alta)
BETWEEN '3 mon'::interval AND '6 mon'::interval;

/*Diseña una consulta (incluyendo su solución) para la base de datos INMO que contenga los siguientes elementos.
- La salida del select no será SELECT *
- Debe realizar el JOIN de al menos 3 tablas.
- Uno de los JOINs debe, obligatoriamente, ser un JOIN ON
- Al menos una de las condiciones debe estar relacionada con fechas
- Debe ordenar la salida por algún criterio.
*/

/* Selecciona el nombre de los compradores de inmuebles 'Industrial' que estan en ventas y el precio final, 
en las provincias de Sevilla y Córdoba en el año 2020, Ordenalo de forma ASC */

SELECT c.nombre, precio_final
FROM operacion o JOIN inmueble i USING (id_inmueble)
			   JOIN tipo t ON (id_tipo = tipo_inmueble)
			   JOIN comprador c USING (id_cliente)
WHERE i.tipo_operacion = 'Venta'
AND t.nombre = 'Industrial'
AND provincia IN ('Sevilla','Córdoba')
AND TO_CHAR (fecha_alta, 'YYYY') = '2020'
ORDER BY precio_final ASC
