/*SELECT *
FROM producto

BEGIN;
INSERT INTO producto (nombre, precio)
VALUES ('Macbook Pro M3 16/512', 2599.99);
COMMIT;

BEGIN;
INSERT INTO PEDIDO (cliente)
VALUES ('Luismi')
RETURNING *;
SAVEPOINT guarda_pedido


INSERT INTO detalle_pedido
VALUES (1017, 4,(SELECT precio FROM producto WHERE num_producto = 1017),1)


ROLLBACK TO SAVEPOINT guarda_pedido;

SELECT *
FROM detalle_pedido */

SELECT *
FROM pedido;