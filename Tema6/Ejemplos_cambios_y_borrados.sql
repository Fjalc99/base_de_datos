DROP TABLE IF EXISTS producto CASCADE
DROP TABLE IF EXISTS pedido CASCADE
DROP TABLE IF EXISTS items_pedido CASCADE

CREATE TABLE producto (
num_producto INTEGER,
nombre TEXT,
precio NUMERIC,
CONSTRAINT pk_producto PRIMARY KEY (num_producto)
);
CREATE TABLE pedido (
id_pedido INTEGER,
direccion_envio TEXT,
CONSTRAINT pk_pedido PRIMARY KEY (id_pedido)
);
CREATE TABLE items_pedido (
num_producto INTEGER,
id_pedido INTEGER,
cantidad INTEGER,
CONSTRAINT pk_items_pedido PRIMARY KEY (num_producto, id_pedido),
CONSTRAINT fk_items_pedido_producto FOREIGN KEY (num_producto)
REFERENCES producto ON DELETE RESTRICT,
CONSTRAINT fk_items_pedido_pedido FOREIGN KEY (id_pedido) REFERENCES
pedido ON DELETE CASCADE
);

INSERT INTO producto
VALUES (1,'MacBook',999.99),
	   (2,'MacBook M3',2552.63)
	   
INSERT INTO pedido
VALUES (1,'Conde de bustillo 17'),
	   (2,'Avenida de la palmera')
	   
INSERT INTO items_pedido
VALUES (1,1,1),
	   (2,2,100)
	   
DELETE FROM producto WHERE num_producto 
	   
SELECT *
FROM pedido
	   
--Añadir una columna-------------------------
ALTER TABLE pedido
ADD COLUMN cliente VARCHAR (200),
ADD COLUMN dni_cliente VARCHAR (10)

--Borrar una columna-------------------------- 
ALTER TABLE pedido
DROP COLUMN cliente

----------------------------------------------

ALTER TABLE pedido
--ADD CONSTRAINT -- Añadir una restriccion 
ALTER COLUMN dni_cliente SET NOT NULL;


-----------------------------------------------
ALTER TABLE producto
ADD CONSTRAINT ck_precio_positivo
CHECK (precio > 0);
-----------------------------------------------

CREATE TABLE cliente(
	dni 		VARCHAR(10),
	nombre 		VARCHAR(200) NOT NULL,
	CONSTRAINT pk_cliente PRIMARY KEY (dni)
);

INSERT INTO cliente
VALUES ('12345678N','Salesianos Triana')

ALTER TABLE pedido
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (dni_cliente) REFERENCES cliente
ON DELETE CASCADE

--Desactivar una clave externa



------------------------------------------------
--Cambio de tipo siempre que sean del mismo tipo

ALTER TABLE producto 
ALTER COLUMN nombre TYPE VARCHAR (200)
------------------------------------------------


