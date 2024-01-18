DROP TABLE IF EXISTS alumnos CASCADE;
DROP TABLE IF EXISTS empresas CASCADE;
DROP TABLE IF EXISTS alumnos_asisten CASCADE;
DROP TABLE IF EXISTS cursos	CASCADE;
DROP TABLE IF EXISTS profesores	CASCADE;
DROP TABLE IF EXISTS tipos_cursos CASCADE;
DROP TABLE IF EXISTS notas CASCADE;



CREATE TABLE alumnos (
	dni 			VARCHAR(10),
	nombre			VARCHAR(200),
	direccion		VARCHAR(200),
	telefono		VARCHAR(30),
	edad			SMALLINT,
	empresa			VARCHAR(200),
	CONSTRAINT pk_dni PRIMARY KEY (dni)
); 

CREATE TABLE empresas (
	cif				VARCHAR(10),
	nombre			VARCHAR(200),
	direccion		VARCHAR(200),
	telefono		VARCHAR(30),
	CONSTRAINT pk_cif PRIMARY KEY (cif)
);

CREATE TABLE alumnos_asisten (
	dni				VARCHAR(10),
	n_concreto		INTEGER,
	CONSTRAINT pk_alumnos_asisten PRIMARY KEY (dni, n_concreto)
);

CREATE TABLE cursos (
	n_concreto 		INTEGER,
	fecha_inicio	DATE,
	fecha_fin		DATE,
	dni_profesor	VARCHAR(10),
	tipo_curso		INTEGER,
	CONSTRAINT pk_n_concreto PRIMARY KEY (n_concreto)
);

CREATE TABLE profesores (
	dni				VARCHAR(10),
	nombre			VARCHAR(200),
	apellido		VARCHAR(200),
	telefono		VARCHAR(30),
	direccion		VARCHAR(200),
	CONSTRAINT pk_dni_profesores PRIMARY KEY (dni)
);

CREATE TABLE tipos_cursos (
	cod_curso		INTEGER,
	duracion		INTEGER,
	programa		VARCHAR(200),
	titulo			VARCHAR(200),
	CONSTRAINT pk_cod_curso PRIMARY KEY (cod_curso)
);

CREATE TABLE notas (
	dni 			VARCHAR(10),
	n_concreto		INTEGER,
	nota			SMALLINT,
	CONSTRAINT pk_notas PRIMARY KEY (dni, n_concreto)
);

ALTER TABLE alumnos_asisten ADD FOREIGN KEY (dni) REFERENCES alumnos (dni);
ALTER TABLE alumnos ADD FOREIGN KEY (dni) REFERENCES empresas (cif);
ALTER TABLE alumnos_asisten ADD FOREIGN KEY (n_concreto) REFERENCES cursos (n_concreto); 
ALTER TABLE cursos ADD FOREIGN KEY (dni_profesor) REFERENCES profesores (dni);
ALTER TABLE cursos ADD FOREIGN KEY (tipo_curso) REFERENCES tipos_cursos (cod_curso);
ALTER TABLE notas ADD FOREIGN KEY (dni) REFERENCES alumnos (dni);
ALTER TABLE notas ADD FOREIGN KEY (n_concreto) REFERENCES cursos (n_concreto);


INSERT INTO empresas (cif, nombre, direccion, telefono)
VALUES (123654789,'Biciletas Manolo','Conde Bustillo 17','955879632'),
	   (365987412,'Reparaciones Paco','Poligono pisa 32','955741963'),
	   (698523741,'Fruteria Rocio','Avd Palmera 45','955624857')
	   
INSERT INTO alumnos (nombre, direccion, telefono, edad, empresa)

