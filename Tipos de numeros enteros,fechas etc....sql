SELECT (1/2.0)::real,  (1/3.0)::real;

CREATE TABLE producto_serial (
	id_producto SERIAL,
	nombre   	TEXT
);

INSERT INTO producto_serial (nombre)
VALUES ('Macbook Pro'),('DELL XPS')

CREATE TABLE inventario (
	id_producto		serial,
	fecha			timestamp,
	nombre 			text
);

INSERT INTO inventario (nombre)
VALUES ('Mánzana'),('Melón')

INSERT INTO inventario (fecha)
VALUES ('20/07/2023')



-----------------------------------------
CREATE TABLE alumno (
	cod_alumno 			serial,
	nombre 				varchar(150),
	apellido1 			varchar(150),
	apellido2 			varchar(150),
	nombre_completo 	varchar(450)
		GENERATED ALWAYS AS
	(nombre || '' || apellido1 || '' || apellido2)
	STORED,
	fecha_nacimiento  	date,
	edad_31_diciembre 	smallint,
	email 				varchar(320)
);

SELECT *
FROM alumno

