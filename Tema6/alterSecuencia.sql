DROP TABLE IF EXISTS producto CASCADE;

CREATE TABLE producto (
	num_producto 	SERIAL,	
	nombre 			TEXT,
	precio 			NUMERIC,
CONSTRAINT pk_productos PRIMARY KEY (num_producto)
);

INSERT INTO producto ( nombre, precio) VALUES
	('Queso', 9.99),
	('Pan', 0.99),
	('Leche', 1.25);
	
--Con esto podemos modificar la secuencia 
ALTER SEQUENCE producto_num_producto_seq
RESTART WITH 1000;
--INCREMENT BY 10 -- Asi hacemos que el id se incremente de 10 en 10 

ALTER SEQUENCE producto_num_producto_seq
INCREMENT BY 10;
-----------------------------------------------------------------------

INSERT INTO producto (nombre, precio) 
VALUES	('Manzana', 2.00)
INSERT INTO producto (nombre, precio)
VALUES ('Pera', 3.00)

INSERT INTO producto(nombre, precio)
VALUES ('Mango', 4.00)

INSERT INTO producto (nombre, precio)
VALUES ('Ipad 12', 100.00)

INSERT INTO producto (num_producto, nombre, precio)
VALUES (3,'Monster', 8.00)

INSERT INTO producto (nombre, precio)
VALUES ('Kinder bueno',1.20)
-----------------------------------------------------------------------

--Actualizar tablas 
UPDATE producto SET precio = 3.00
WHERE num_producto = 3;

ALTER TABLE producto
ADD COLUMN disponible boolean;

UPDATE producto
SET disponible = true;

UPDATE producto 
SET nombre  = 'Monster',
precio = 20.0
WHERE num_producto = 1;

-- Actualizar el precio de los productos que valgan
-- más de 150 euros para descontarles un 10%

UPDATE producto
SET precio = precio - (precio * (10.0/100))
WHERE precio < 100;

UPDATE producto
SET precio = precio - (precio * (10.0/100))
WHERE precio = (
	SELECT MAX (precio)
	FROM producto
)

----------------------------------------------------------------
--Eliminacion de filas

DELETE FROM producto --Esto borra todo

DELETE FROM producto
WHERE num_producto = 3 ;

SELECT *
FROM producto
ORDER BY num_producto ;
------------------------------------------------------------------

CREATE TABLE pedido (
	num_pedido SERIAL,
	fecha		TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	cliente 	VARCHAR(100),
	CONSTRAINT pk_pedido PRIMARY KEY (num_pedido)
)

CREATE TABLE detalle_pedido (
	num_producto INTEGER,
	num_pedido INTEGER,
	precio		NUMERIC,
	cantidad	INTEGER,
	CONSTRAINT pk_detalle_pedido PRIMARY KEY (num_producto, num_pedido)
)

ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido_pedido
FOREIGN KEY (num_pedido)
REFERENCES pedido,
ADD CONSTRAINT fk_detalle_pedido_producto
FOREIGN KEY (num_producto)
REFERENCES producto;

INSERT INTO pedido (cliente)
VALUES ('Luismi el hacker')
RETURNING num_pedido

INSERT INTO detalle_pedido
VALUES (1,1,9.99,10)

DELETE FROM detalle_pedido
WHERE num_pedido = 1
RETURNING *;

