DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS categoria CASCADE;
DROP TABLE IF EXISTS trabajador CASCADE;
DROP TABLE IF EXISTS pedido CASCADE;
DROP TABLE IF EXISTS detalle_pedido CASCADE;
DROP TABLE IF EXISTS comprador CASCADE;


CREATE TABLE producto (
	cod_producto 	SERIAL,
	nombre			VARCHAR (200) NOT NULL,
	descripcion		VARCHAR (300),
	pvp				NUMERIC NOT NULL,
	categoria		VARCHAR (200),
	CONSTRAINT pk_producto PRIMARY KEY (cod_producto)
);

CREATE TABLE categoria (
	id_categoria 	VARCHAR(200),
	nombre			VARCHAR(200) NOT NULL,
	descripcion		VARCHAR(300),
	CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE trabajador (
	num_trabajador 		INTEGER,
	nombre_completo		VARCHAR(200),
	email				VARCHAR (320),
	cuenta_corriente	VARCHAR (24),
	pass				VARCHAR(12),
	CONSTRAINT pk_trabajador PRIMARY KEY (num_trabajador),
	CONSTRAINT ck_arroba CHECK (email ILIKE '%@%'),
	CONSTRAINT ck_empieza_es_cuenta_corriente CHECK (cuenta_corriente LIKE 'ES%')
);


CREATE TABLE pedido (
	cod_pedido			INTEGER,
	fecha_pedido		DATE NOT NULL,
	num_trabajador		INTEGER NOT NULL,
	dni_comprador		VARCHAR(10) NOT NULL,
	CONSTRAINT pk_pedido PRIMARY KEY (cod_pedido)
);

CREATE TABLE detalle_pedido (
	cod_pedido			INTEGER,
	num_detalle			INTEGER,
	cantidad			INTEGER,
	cod_producto		INTEGER,
	precio				NUMERIC(5,2),
	descuento			INTEGER DEFAULT 0 NOT NULL,
	CONSTRAINT pk_detalle_pedido PRIMARY KEY (cod_pedido, num_detalle),
	CONSTRAINT ck_cantidad_positiva CHECK (cantidad > 0)
);


CREATE TABLE comprador (
	dni 				VARCHAR(10),
	nombre_completo		VARCHAR(200) NOT NULL,
	email				VARCHAR(320),
	direccion			VARCHAR(100),
	fecha_alta			DATE,
	CONSTRAINT pk_comprador PRIMARY KEY (dni),
	CONSTRAINT ck_arroba_email CHECK (email ILIKE '%@%')
);

ALTER TABLE producto ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria) REFERENCES categoria (id_categoria) ON DELETE SET NULL; --Mejor ponerlos null que borrar un producto
ALTER TABLE pedido ADD CONSTRAINT fk_pedido_trabajador FOREIGN KEY (num_trabajador) REFERENCES trabajador (num_trabajador) ON DELETE SET NULL, --Asi seguimos teniendo los registro de los pedidos 
ADD CONSTRAINT fk_pedido_comprador FOREIGN KEY (dni_comprador) REFERENCES comprador (dni);
ALTER TABLE detalle_pedido ADD CONSTRAINT fk_detalle_pedido_producto FOREIGN KEY (cod_producto) REFERENCES producto (cod_producto) ON DELETE CASCADE,
ADD CONSTRAINT fk_detalle_pedido_pedido FOREIGN KEY (cod_pedido) REFERENCES pedido (cod_pedido);


INSERT INTO categoria (id_categoria, nombre, descripcion)
VALUES ('1','Electronica','La mejor categoria')

INSERT INTO comprador (dni, nombre_completo, email)
VALUES ('12345678F','Fernando Fanegas','fernando.fanegas@yahoo.com')

INSERT INTO producto (nombre, pvp, categoria, descripcion)
VALUES ('TV LG 55',799.00,'Electronica','La mejor categoria')