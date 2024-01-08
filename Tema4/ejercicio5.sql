/*1. Selecciona la precipitación total media para todas las estaciones meteorológicas de la provincia de Sevilla para el mes de 
Abril de 2019. Redondea el resultado con 2 decimales */

/*SELECT ROUND(AVG(precipitacion_total),2)
FROM climatologia
WHERE provincia IN ('Sevilla')
AND fecha::text ILIKE '2019-04%' */

/* 2. Selecciona los datos meteorológicos para aquellas estaciones cuyo nombre contenga la letra E, en los últimos días del mes 
de Febrero, Marzo y Abril de 2019. Ordena los resultados por provincia ascendentemente, estación ascendentemente y fecha, 
descendentemente. */

/*SELECT *
FROM climatologia 
WHERE estacion ILIKE'%E%'
AND ( 
	fecha::text ILIKE '%-02-28' OR
	fecha::text ILIKE '%-03-31' OR
	fecha::text ILIKE '%-04-30'
	) 
ORDER BY provincia, estacion ASC, fecha DESC; */

/* 3. Selecciona la suma de la precipitación total acumulada en Galicia durante el mes de Septiembre de 2019 */

/*SELECT SUM (precipitacion_total) AS "Precipitacion Total"
FROM climatologia
WHERE provincia IN ('A coruña', 'Ourense', 'Lugo', 'Pontevedra')
AND fecha::text ILIKE ('2019-04%') */

/* 4.Selecciona el porcentaje de precipitación de cada tramo de horas (0 a 6, 6 a 12, 12 a 18, 18 a 24) con respecto de 
la precipitación total para las estaciones de Castilla La Mancha en la primavera de 2019 (21 Marzo a 20 de Junio). 
Como resultado de la consulta debe aparecer la fecha, estación, provincia, precipitación total y los porcentajes de cada 
tramo horario. Redondea los porcentajes con 2 decimales. */

/*SELECT fecha, estacion, provincia,
       precipitacion_total,
	CASE
		WHEN precipitacion_total = 0 THEN 0
		ELSE ROUND (((precipitacion_0_a_6 / precipitacion_total)*100),2)
		END AS "% 0 A 6",
	CASE 
		WHEN precipitacion_total = 0 THEN 0
		ELSE ROUND (((precipitacion_6_a_12 / precipitacion_total)*100),2)
		END AS "% 6 A 12",
	CASE
		WHEN precipitacion_total = 0 THEN 0
		ELSE ROUND (((precipitacion_12_a_18 / precipitacion_total) * 100),2)
		END AS "% 12 A 18",
	CASE
		WHEN precipitacion_total = 0 THEN 0
		ELSE ROUND (((precipitacion_18_a_24 / precipitacion_total)*100),2)
		END AS "% 18 A 24"
	
FROM climatologia
WHERE provincia IN ('Toledo', 'Guadalajara', 'Cuenca', 'Ciudad Real', 'Albacete') 
AND fecha BETWEEN '2019-03-21'::date
			  AND '2019-06-20'::date
ORDER BY fecha */
