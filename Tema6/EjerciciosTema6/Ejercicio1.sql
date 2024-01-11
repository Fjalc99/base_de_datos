DROP TABLE IF EXISTS libro CASCADE
CREATE TABLE libro(
	isbn 				VARCHAR (13), 
	titulo				VARCHAR (80) NOT NULL,
	dni_autor			VARCHAR (9) NOT NULL,
	cod_genero 			INTEGER NOT NULL,
	cod_editorial		INTEGER NOT NULL,
	CONSTRAINT pk_isbn PRIMARY KEY (isbn)
)

DROP TABLE IF EXISTS autor CASCADE
CREATE TABLE autor (
	dni					VARCHAR (9),
	nombre				VARCHAR (100) NOT NULL,
	nacionalidad		VARCHAR (80),
	CONSTRAINT pk_dni PRIMARY KEY (dni)
)

DROP TABLE IF EXISTS editorial CASCADE
CREATE TABLE editorial(
	cod_editorial		SERIAL,
	nombre				VARCHAR (100) NOT NULL,
	direccion			VARCHAR (150),
	poblacion 			VARCHAR (60),
	CONSTRAINT pk_cod_editorial PRIMARY KEY (cod_editorial)
)

DROP TABLE IF EXISTS genero CASCADE
CREATE TABLE genero (
	id_genero 			SERIAL,
	nombre				VARCHAR (100) NOT NULL,
	descripcion 		TEXT,
	CONSTRAINT pk_id_genero PRIMARY KEY (id_genero)
)

DROP TABLE IF EXISTS edicion CASCADE
CREATE TABLE edicion (
	isbn 				VARCHAR (13),
	fecha_publicacion	DATE,
	cantidad 			INTEGER,
	CONSTRAINT cantidad_ediciones CHECK (cantidad > 0),
	CONSTRAINT pk_edicion PRIMARY KEY (isbn, fecha_publicacion)
)