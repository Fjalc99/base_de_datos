--Borrado de tablas
DROP TABLE IF EXISTS docentes CASCADE;
DROP TABLE IF EXISTS actividades CASCADE;
DROP TABLE IF EXISTS alumnos CASCADE;
DROP TABLE IF EXISTS asignacion_act CASCADE;
DROP TABLE IF EXISTS asistencia_act CASCADE;

--Creacion de tablas

CREATE TABLE docentes (
	dni				SERIAL,
	nombre			VARCHAR(200) NOT NULL,
	telefono		VARCHAR (15) NOT NULL,
	anio_ingreso	DATE,
	CONSTRAINT pk_dni PRIMARY KEY (dni)
);

CREATE TABLE actividades (
	id_act			SERIAL,
	nombre			VARCHAR(200) NOT NULL,
	duracion		TIMESTAMP NOT NULL,
	CONSTRAINT pk_id_act PRIMARY KEY (id_act)
);

CREATE TABLE alumnos (
	cod_alumno		SERIAL,
	nombre			VARCHAR(200) NOT NULL,
	telefono		VARCHAR(15) NOT NULL,
	nivel 			VARCHAR(50) NOT NULL,
	CONSTRAINT pk_cod_alumno PRIMARY KEY (cod_alumno) 
	
);

CREATE TABLE asignacion_act (
	id_doc			SERIAL,
	id_act			INTEGER,
	dia_semana		DATE,
	hora			TIMESTAMP,
	CONSTRAINT pk_asginacion_act PRIMARY KEY (id_doc, id_act, dia_semana, hora)
);

CREATE TABLE asistencia_act (
	id_alum			INTEGER,
	id_act			INTEGER,
	id_doc			INTEGER,
	CONSTRAINT pk_asistencia_act PRIMARY KEY (id_alum, id_act)
);

--FKs
ALTER TABLE asignacion_act ADD FOREIGN KEY (id_doc) REFERENCES docentes (dni); 
ALTER TABLE asignacion_act ADD FOREIGN KEY (id_act) REFERENCES actividades (id_act);
ALTER TABLE asistencia_act ADD FOREIGN KEY (id_alum) REFERENCES alumnos (cod_alumno);
ALTER TABLE asistencia_act ADD FOREIGN KEY (id_act) REFERENCES actividades (id_act);


