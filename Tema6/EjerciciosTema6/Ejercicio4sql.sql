--Borrado de tablas
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS estaciones CASCADE;
DROP TABLE IF EXISTS bicicletas CASCADE;
DROP TABLE IF EXISTS uso CASCADE;

--Creacion de tablas

CREATE TABLE usuarios (
	dni 				VARCHAR (10),
	nombre 				VARCHAR (200) NOT NULL,
	apellidos			VARCHAR (200) NOT NULL,
	direccion 			VARCHAR (200),
	telefono 			VARCHAR (15) NOT NULL,
	email 				VARCHAR (350) NOT NULL,
	passw				VARCHAR (8),
	saldo_disponible	NUMERIC DEFAULT 0 NOT NULL,
	CONSTRAINT pk_dni PRIMARY KEY (dni),
	CONSTRAINT ck_contraseña_valida CHECK (LENGTH(passw) BETWEEN 4 and 8),
	CONSTRAINT ck_espacios_blanco CHECK (passw NOT ILIKE '%%')
);

CREATE TABLE estaciones (
	cod_estacion 		VARCHAR (300),
	num_estacion		SERIAL NOT NULL,
	direccion			VARCHAR (300) NOT NULL,
	latitud				NUMERIC NOT NULL,
	longitud			NUMERIC NOT NULL,
	CONSTRAINT pk_cod_estacion PRIMARY KEY (cod_estacion),
	CONSTRAINT ck_estacion_comenienza_e CHECK (cod_estacion LIKE 'E%')
);

CREATE TABLE bicicletas (
	cod_bicicleta		SERIAL,
	marca				VARCHAR (100) NOT NULL,
	modelo				VARCHAR (100) NOT NULL,
	fecha_alta			DATE NOT NULL,
	CONSTRAINT pk_cod_bicicleta PRIMARY KEY (cod_bicicleta)
);

CREATE TABLE uso (
	estacion_salida		VARCHAR (200),
	fecha_salida		DATE,
	dni_usuario			VARCHAR (10),
	cod_bicicleta		INTEGER,
	estacion_llegada	VARCHAR (200),
	fecha_llegada		DATE NOT NULL,
	CONSTRAINT pk_uso PRIMARY KEY (estacion_salida, fecha_salida, dni_usuario, cod_bicicleta, estacion_llegada) 
);

-- Añado la fecha de baja a la tabla usuario
ALTER TABLE usuarios ADD COLUMN fecha_baja DATE;
----

--Claves externas

ALTER TABLE uso ADD FOREIGN KEY (estacion_salida) REFERENCES estaciones (cod_estacion);
ALTER TABLE uso ADD FOREIGN KEY (dni_usuario) REFERENCES usuarios (dni);
ALTER TABLE uso ADD FOREIGN KEY (cod_bicicleta) REFERENCES bicicletas (cod_bicicleta);
ALTER TABLE uso ADD FOREIGN KEY (estacion_llegada) REFERENCES estaciones (cod_estacion);

--Consulta
SELECT (EXTRACT(HOUR from fecha_llegada) - EXTRACT(HOUR from fecha_salida))*60*0.001||
    '€' AS "Coste Sistema"
FROM usuarios JOIN uso ON (dni=dni_usuario);



