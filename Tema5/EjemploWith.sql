--Seleccionar 

WITH precio_medio_alquiler AS (
	SELECT AVG (precio_final) as "media"
	FROM inmueble JOIN operacion USING (id_inmueble)
	WHERE tipo_operacion = 'Alquiler'
)

SELECT *
FROM inmueble JOIN operacion USING (id_inmueble)
WHERE precio_final >= ALL (
	SELECT media
	FROM precio_medio_alquiler
)