/*1.Selecciona los datos del inmueble sobre el que se ha realizado una operación un lunes de febrero o un viernes de 
marzo, que tenga más de 200 metros cuadrados y donde el nombre del vendedor contenga una A mayúscula o minúscula.*/

SELECT *
FROM inmueble JOIN operacion USING (id_inmueble)
			   JOIN vendedor  USING (id_vendedor)
WHERE superficie > 200 
AND  nombre ILIKE '%a%'
AND TO_CHAR (fecha_operacion, 'ID/MM') = '1/02'
OR TO_CHAR (fecha_operacion, 'ID/MM') = '5/03'

/*2.Selecciona el precio medio por metro cuadrado de los alquileres de viviendas en los meses de marzo y abril de 
cualquier año para las provincias costeras de Andalucía.*/

SELECT ROUND (AVG(precio/superficie),2) AS "El precio medio"
FROM inmueble JOIN tipo ON (tipo_inmueble = id_tipo)
WHERE EXTRACT (MONTH from fecha_alta) IN (3,4) 
AND provincia IN ('Almería','Cádiz','Huelva','Málaga','Granada')

/*3.¿Cuál es la media del porcentaje de diferencia entre el precio inicial (en la tabla inmueble) y el precio final 
(en la tabla operación) para aquellas operaciones de alquiler realizadas en enero de cualquier año, donde el 
tipo del inmueble es Oficina, Local o Suelo?*/

SELECT ROUND(AVG (precio - precio_final),2) AS "Media precio final"
FROM tipo t JOIN inmueble ON (tipo_inmueble = id_tipo) 
		 JOIN operacion USING (id_inmueble)
WHERE tipo_operacion = 'Alquiler'
AND t.nombre IN ('Local','Suelo','Oficina')
AND TO_CHAR (fecha_operacion, 'MM') = '01' 
				      

/*4.Seleccionar el nombre de aquellos compradores de Casa o Piso en las provincias de Jaén o Córdoba, donde el precio final 
de inmueble esté entre 150.000 y 200.000€, para aquellos inmuebles que han tardado entre 3 y 4 meses en venderse.*/

SELECT *
FROM tipo t JOIN inmueble ON (tipo_inmueble = id_tipo)
					JOIN operacion USING (id_inmueble)
					JOIN comprador c USING (id_cliente)
WHERE provincia IN ('Jaén','Córdoba')
AND t.nombre IN ('Casa','Piso')
AND precio_final > 150000 
AND precio_final < 200000

/*5.Selecciona la media del precio inicial (en la tabla inmueble), del precio final (en la tabla operación) y de la 
diferencia en porcentaje entre ellas de aquellas viviendas (Casa o Piso) en alquiler que tengan menos de 100 metros 
cuadrados y que hayan tardado un año o más en alquilarse.*/


SELECT ROUND (AVG(precio - precio_final),2) AS "Media Precios"
FROM tipo t JOIN inmueble ON (tipo_inmueble = id_tipo)
					JOIN operacion USING (id_inmueble)
WHERE tipo_operacion IN ('Alquiler')
AND superficie < 100
AND t.nombre IN ('Casa','Piso') 
					



/*6.Selecciona el alquiler de vivienda (Casa o Piso) más caro realizado en Julio o Agosto de cualquier año 
en la provincia de Huelva.*/

SELECT *
FROM tipo t JOIN inmueble ON (tipo_inmueble = id_tipo)
					JOIN operacion USING (id_inmueble)
WHERE t.nombre IN ('Casa','Piso')
AND provincia = ('Huelva')
AND tipo_operacion IN ('Alquiler')
AND EXTRACT (MONTH from fecha_operacion) IN (7,8)
AND precio > 3000
