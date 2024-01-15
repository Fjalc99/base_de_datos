DROP TABLE IF EXISTS invitado CASCADE
CREATE TABLE invitado(
	nroInvitado 	SERIAL,
	nombre 			VARCHAR (100),
	categoria 		VARCHAR (100),
	origen			VARCHAR (50),
	CONSTRAINT pk_nroInvitado PRIMARY KEY (nroInvitado)
);
DROP TABLE IF EXISTS teatro CASCADE
CREATE TABLE teatro (
	codTeat 		SERIAL,
	nombre			VARCHAR (100),
	direccion 		VARCHAR (100),
	cantAsientos	INTEGER,
	CONSTRAINT pk_codTeat PRIMARY KEY (codTeat)
);	

DROP TABLE IF EXISTS obra CASCADE
CREATE TABLE obra (
	codObra 		SERIAL,
	nombreObra		VARCHAR (100),
	autor			VARCHAR (100),
	CONSTRAINT pk_codObra PRIMARY KEY (codObra)
);

DROP TABLE IF EXISTS exhibe CASCADE
CREATE TABLE exhibe (
	codTeat 		SERIAL, --INTEGER, LAS FK NO SON NUNCA DE TIPO (SMALL/BIG) SERIAL
	fecha			DATE,
	codObra			SERIAL, --INTEGER,
	CONSTRAINT pk_exhibe PRIMARY KEY (codTeat, fecha)
);

DROP TABLE IF EXISTS tipo_asiento CASCADE
CREATE TABLE tipo_asiento (
	tipo 			VARCHAR (30),
	nombre			VARCHAR (100),
	descripcion		TEXT,
	CONSTRAINT pk_tipo_asiento PRIMARY KEY (tipo)
);

DROP TABLE IF EXISTS asiento_tipo CASCADE
CREATE TABLE asiento_tipo (
	nroAsiento 		SERIAL,
	tipo 			VARCHAR (30),
	CONSTRAINT pk_asiento_tipo PRIMARY KEY (nroAsiento)
);

DROP TABLE IF EXISTS precio CASCADE
CREATE TABLE precio (
	codTeat			SERIAL, --INTEGER,
	fecha			DATE,
	tipo 			VARCHAR (30),
	precio 			NUMERIC,
	CONSTRAINT pk_precio PRIMARY KEY (codTeat, fecha, tipo)
);

DROP TABLE IF EXISTS entrada CASCADE
CREATE TABLE entrada (
	codTeat 		SERIAL, --INTEGER
	fecha			DATE,	
	nroAsiento		SERIAL,	--INTEGER
	nroInvitado		SERIAL,	--INTEGER
	CONSTRAINT pk_entrada PRIMARY KEY (codTeat, fecha, nroAsiento)
);

ALTER TABLE exhibe ADD FOREIGN KEY (codTeat) REFERENCES teatro (codTeat);
ALTER TABLE exhibe ADD FOREIGN KEY (codObra) REFERENCES obra (codObra);	
ALTER TABLE asiento_tipo ADD FOREIGN KEY (tipo) REFERENCES tipo_asiento (tipo);
ALTER TABLE precio ADD FOREIGN KEY (codTeat, fecha) REFERENCES exhibe (codTeat, fecha);
ALTER TABLE precio ADD FOREIGN KEY (tipo) REFERENCES tipo_asiento (tipo);
ALTER TABLE entrada ADD FOREIGN KEY (codTeat, fecha) REFERENCES exhibe (codTeat, fecha);
ALTER TABLE entrada ADD FOREIGN KEY (nroAsiento) REFERENCES asiento_tipo (nroAsiento);
ALTER TABLE entrada ADD FOREIGN KEY (nroInvitado) REFERENCES invitado (nroInvitado);