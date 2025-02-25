/*1. Selecciona el total de hombres de las provincias de Extremadura 
en el año 2002 y 2003 (demografia_basica)*/ 

/*SELECT sum (hombres) AS "total"
FROM demografia_basica
WHERE provincia IN ('Cáceres','Badajoz')
AND anio IN ('2002','2003') */

/*2. Selecciona, ordenando de mayor a menor aquellas provincias y años en los que hubo una población superior o igual a 600.000 
personas o de hombres o de mujeres (demografia_basica). Como resultado se deben mostrar todas las columnas de cada fila. */

/*SELECT *
FROM demografia_basica
WHERE ((hombres >= 600000) OR
(mujeres >= 600000))
ORDER BY (hombres+mujeres) DESC */

/*3. Acota la búsqueda anterior para que sea solamente de los últimos 5 años */

/*SELECT *
FROM demografia_basica
WHERE ((hombres >= 600000) OR
	   (mujeres >= 600000))
  AND anio BETWEEN 2015 AND 2019
  
ORDER BY (hombres+mujeres) DESC */

/*4. Selecciona cuántas mujeres de entre 20 y 29 años vivían en Andalucía en el año 2018 (demografia_avanzada). Ordena la 
salida por número de habitantes (menor a mayor) NOTA: No debe aparecer el total, sino el desglose por provincia y 
rango de edad */

/*SELECT * 
FROM demografia_avanzada
WHERE provincia IN ('Sevilla','Córdoba','Huelva',
					'Jaén','Málaga','Cadiz',
					'Granada','Almería')
AND anio IN ('2018')
AND sexo IN ('M')
AND edad_menor >= 20
AND edad_mayor <= 29
ORDER BY numero_habitantes DESC */

/*5.Selecciona el número de hombres que vivían en la comunidad de Madrid entre los años 2010 y 2015 (ambos inclusive), donde 
el rango de edad sea menores de 20 años o mayores de 65 (demografia_avanzada). La salida se debe ordenar por anio 
(menor a mayor), número de habitantes (mayor a menor) y edad (menor a mayor) */

SELECT *
FROM demografia_avanzada
WHERE provincia IN ('Madrid')
AND anio BETWEEN 2010 AND 2015
AND (edad_menor >= 20 OR edad_mayor <= 65)
ORDER BY anio, numero_habitantes DESC, edad_menor; 


