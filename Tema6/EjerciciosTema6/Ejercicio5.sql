DROP TABLE IF EXISTS alumnos CASCADE;
DROP TABLE IF EXISTS empresas CASCADE;
DROP TABLE IF EXISTS alumnos_asisten CASCADE;
DROP TABLE IF EXISTS cursos	CASCADE;
DROP TABLE IF EXISTS profesores	CASCADE;
DROP TABLE IF EXISTS tipos_cursos CASCADE;




CREATE TABLE alumnos (
	dni 			VARCHAR(10),
	nombre			VARCHAR(200),
	direccion		VARCHAR(200),
	telefono		VARCHAR(30),
	edad			SMALLINT,
	empresa			VARCHAR(10), --Tiene que tener el mismo tamaño que su clave externa
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



ALTER TABLE alumnos_asisten ADD CONSTRAINT fk_alumnos_asisten_alumnos FOREIGN KEY (dni) REFERENCES alumnos (dni);
ALTER TABLE alumnos ADD CONSTRAINT fk_alumnos_empresas FOREIGN KEY (empresa) REFERENCES empresas (cif);
ALTER TABLE alumnos_asisten ADD CONSTRAINT fk_alumnos_asisten_curso FOREIGN KEY (n_concreto) REFERENCES cursos (n_concreto); 
ALTER TABLE cursos ADD CONSTRAINT fk_cursos_profesores FOREIGN KEY (dni_profesor) REFERENCES profesores (dni);
ALTER TABLE cursos ADD CONSTRAINT fk_curso_tipo_cursos FOREIGN KEY (tipo_curso) REFERENCES tipos_cursos (cod_curso);



INSERT INTO empresas (cif, nombre, direccion, telefono)
VALUES (123654789,'Biciletas Manolo','Conde Bustillo 17','955879632'),
	   (365987412,'Reparaciones Paco','Poligono pisa 32','955741963'),
	   (698523741,'Fruteria Rocio','Avd Palmera 45','955624857')
RETURNING *;
	   
INSERT INTO alumnos (nombre, dni, direccion, telefono, edad, empresa)
VALUES ('Paquito','12345678E','Avd andalucía nº43',658741239,26,123654789),
	   ('Manolo','12345623S','Mirador montepinar nº12',659874123,25,123654789),
	   ('Pepe','12345656Q','Calle sevilla nº35',658963741,17,123654789),
	   ('Manuel','12345675N','Pasaje de la cruz nº55',654785961,27,123654789),
	   ('Jose','12378678L','Fuensanta nº65',658458871,48,123654789),
	   ('David','12675678K','Valencina nº25',658458711,30,123654789),
	   ('Maria Luisa','19845678G','Santuario nº9',654439123,45,365987412),
	   ('Maria','12341278H','Avd aljarafe nº12',654219123,32,365987412),
	   ('Luisa','12347678R','Charco de la pava nº54',657849123,49,365987412),
	   ('Rosa','12345248A','Torre sevilla nº32',659849123,56,365987412),
	   ('Alejandro','18445678I','Calle córdoba nº25',650989123,23,365987412),
	   ('Sergio','12345378UJ','Calle málaga nº43',654129123,19,365987412),
	   ('Luis','12345698Ñ','Calle pisa nº12',658234259,21,698523741),
	   ('Moises','12344578P','Calle torregrosa nº32',658734259,34,698523741),
	   ('Carlos','12347978M','Calle tarragona nº45',658741259,18,698523741),
	   ('Bruno','12345848S','Calle asturias nº4',658746789,27,698523741),
	   ('Lorenzo','12334678Z','Calle galicia nº14',658749849,41,698523741),
	   ('Paco','12345665Y','Calle valencia nº34',658741229,31,698523741)
RETURNING *;
	   
INSERT INTO tipos_cursos (cod_curso, duracion, programa, titulo)
VALUES (125,200,'Informática','Ingeniero informático'),
	   (198,260,'Telecomunicaciones','Ingeniero en telecomunicaciones'),
	   (154,500,'Programacion','Desarrollador de aplicaciones'),
	   (165,400,'Proyectos de grafica publicitaria','Diseñadora gráfica')
RETURNING *;
	   
INSERT INTO cursos (n_concreto, fecha_inicio, fecha_fin, dni_profesor, tipo_curso)
VALUES (4,'15-04-2023','20-06-2023','12457896J',125),
	   (6,'16-03-2023','25-07-2023','14596387K',125),
	   (7,'17-03-2023','24-05-2023','56874129G',125),
	   (8,'05-02-2023','15-07-2023','14785298L',125),
	   (3,'09-09-2023','25-11-2023','15478987S',125),
	   (10,'02-03-2023','28-05-2023','1245789N',198),
	   (11,'06-04-2023','25-08-2023','2354789C',198),
	   (12,'14-05-2023','07-09-2023','4781529D',198),
	   (13,'15-06-2023','09-10-2023','4587961F',198),
	   (14,'28-02-2023','06-06-2023','2365987E',198),
	   (15,'26-03-2023','28-08-2023','2548764A',154),
	   (16,'25-03-2023','20-08-2023','1457851F',154),
	   (17,'14-05-2023','19-11-2023','5248749T',154),
	   (18,'09-03-2023','17-07-2023','5487197R',154),
	   (19,'22-04-2023','15-08-2023','4587448B',154),
	   (20,'25-07-2023','15-12-2023','4578451S',165),
	   (21,'23-01-2023','09-06-2023','3254789Y',165),
	   (22,'07-05-2023','03-09-2023','5874126I',165),
	   (23,'01-01-2023','23-04-2023','4253691X',165),
	   (24,'17-03-2023','20-07-2023','1247895M',165)
RETURNING *;
	   
INSERT INTO profesores (dni, nombre, apellido, telefono, direccion)
VALUES 	('12457896J','Manuel','Rodriguez Franco','668741987','Calle sevilla nº10'),
		('14596387K','Francisco','Dias Ruiz','665632984','Calle málaga nº9'),
		('56874129G','Luis David','Bermudez False','654987147','Calle huelva nº7'),
		('14785298L','Carlos','Calvo Lucena','658962147','Calle cordoba nº5'),
		('15478987S','Maria','Calado Polanco','654987147','Calle almeria nº4'),
		('1245789N','Mario','Salcedo Hernandez','658925417','Calle mirador nº2'),
		('2354789C','Alejandro','Salado Campos','955874687','Calle fuensanta nº7'),
		('4781529D','Jesus','Figueredo Tsispas','698574124','Calle murcia nº23'),
		('4587961F','Pol','Ruiz Cañellas','698587410','Calle alicante nº23'),
		('2365987E','Juan','Ceballos Jabato','687432148','Calle jaen'),
		('2548764A','Lorena','Cubo Fernandez','698574127','Calle campo nº13'),
		('1457851F','Andres','Rodriguez Flores','658963751','Calle flor nº5'),
		('5248749T','Marta','Mula Caceres','653287410','Calle arbol nº3'),
		('5487197R','Lorenzo','Gracia Fernandez','687984562','Calle pisa nº12'),
		('4587448B','Jose','Loco Calvo','658948623','Calle ruina nº1'),
		('4578451S','Lucia','Garcia Perez','698257413','Calle dolor nº24'),
		('3254789Y','Federico','Garcia Lorca','658741753','Calle poema nº22'),
		('5874126I','Rafael','Alberti Manco','657159846','Calle puerto nº21'),
		('4253691X','Angela','Moreno Ortiz','658714789','Calle puerta del puente nº16'),
		('1247895M','Gabriella','Medina Salazar','658974123','Calle venezuela nº36')
RETURNING *;
	 
UPDATE alumnos SET nombre = 'Lucas'
WHERE nombre = 'Jose';