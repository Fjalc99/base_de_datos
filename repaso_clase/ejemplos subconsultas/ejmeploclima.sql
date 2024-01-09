--Seleccionar, para cada estación meteorológica, la fecha en la que ha tenido una tempereatura_máxima menor
--Debe aparecer la provincia, el nombre de la estacion
--la fecha y la temperatura_máxima

SELECT estacion, provincia, fecha, temperatura_maxima
FROM climatologia c1
WHERE temperatura_maxima <= 
ALL (
		SELECT temperatura_maxima
		FROM climatologia c2
		WHERE c1.estacion = c2.estacion
	)