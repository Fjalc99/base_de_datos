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


--CHECK 
CREATE TABLE producto(
	num_producto 		INTEGER,
	nombre		 		TEXT,
	precio		 		NUMERIC,
	precio_descontado 	NUMERIC,
	CONSTRAINT precio_positivo CHECK (precio > 0),
	CONSTRAINT precio_descontado_positivo CHECK (precio_descontado > 0),
	CONSTRAINT descuento_valido CHECK (precio_descontado < precio)
);

INSERT INTO producto(precio)
VALUES ('1')
------------------------------------------------------------------------
--PRIMARY KEY 
drop table producto

CREATE TABLE producto(
	num_producto		INTEGER,
	nombre				TEXT,
	precio				NUMERIC,
	CONSTRAINT pk_productos PRIMARY KEY (num_producto)
);

INSERT INTO producto
VALUES ('1','Switch','299.00')
-------------------------------------------------------------------------
--seguir poniendolo
CREATE TABLE pedido(
	id_pedido INTEGER,
	num_producto	INTEGER,
	cantidad INTEGER,
	CONSTRAINT  pk_pedido 
)

------------------------------------------------------------------------------
--El tipo de dato de una clave primaria si es serial debemos poner un de tipo integer que corresponda
--Y el tipo de ser igual siempre que no sea serial
DROP TABLE alumno

CREATE TABLE alumno(
	id_alumno SERIAL,
	nommbre	TEXT,
	CONSTRAINT pk_alumno PRIMARY KEY (id_alumno)
);

CREATE TABLE asignatura(
	id_asignatura SERIAL,
	nombre VARCHAR (100),
	profesor VARCHAR (200),
	CONSTRAINT pk_asignatura PRIMARY KEY (id_asignatura)
);

CREATE TABLE matricula(
	id_alumno INTEGER,
	id_asignatura INTEGER,
	anio_escolar VARCHAR(10),
	CONSTRAINT pk_matricula PRIMARY KEY (id_alumno, id_asignatura, anio_escolar),
	CONSTRAINT fk_matricula_alumno FOREIGN KEY (id_alumno) REFERENCES alumno,
	CONSTRAINT fk_matricula_asignatura FOREIGN KEY (id_asignatura) REFERENCES asignatura
	
);

CREATE TABLE nota (
	id_alumno INTEGER,
	id_asignatura INTEGER,
	anio_escolar VARCHAR (10),
	tipo_evaluacion VARCHAR (1),
	nota NUMERIC(4,2),
	CONSTRAINT pk_nota PRIMARY KEY
	(id_alumno, id_asignatura, anio_escolar,
	tipo_evaluacion),
	CONSTRAINT ck_nota_tipo_evaluacion
	CHECK (tipo_evaluacion IN ('1','2','3','F')),
	CONSTRAINT fk_nota_matricula FOREIGN KEY (id_alumno, id_asignatura, anio_escolar) 
	REFERENCES matricula (id_alumno, id_asignatura, anio_escolar)
	
);
