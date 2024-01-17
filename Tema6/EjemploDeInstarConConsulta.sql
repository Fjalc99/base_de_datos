CREATE TABLE temperatura_jaen(
	fecha				DATE,
	estacion			VARCHAR(200),
	provincia			VARCHAR(100),
	temperatura_media	NUMERIC(4,2),
	CONSTRAINT pk_temperatura_jaen PRIMARY KEY (fecha, estacion)
)

--Con esto insertamos datos usando una consulta
INSERT INTO temperatura_jaen
SELECT fecha, estacion, provincia, temperatura_media
FROM climatologia
WHERE provincia = 'Jaén'

ALTER TABLE temperatura_jaen
DROP COLUMN provincia

SELECT *
FROM temperatura_jaen