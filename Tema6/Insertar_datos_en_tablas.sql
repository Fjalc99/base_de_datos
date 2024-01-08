CREATE TABLE my_first_table(
	first_colummn text,
	second_colummn integer
);

SELECT *
FROM my_first_table


INSERT INTO my_first_table VALUES ('HOLA',1)

CREATE TABLE productos(
	num_producto integer,
	nombre 		 text,
	precio 		 numeric
);

DROP TABLE productos;

CREATE TABLE productos(
	num_producto  integer,
	nombre 		  text,
	precio        numeric DEFAULT 9.99
);

INSERT INTO productos
VALUES (1,'Minigolf para el WC')


INSERT INTO productos
VALUES (1,'Dardos para niños', 5.99)