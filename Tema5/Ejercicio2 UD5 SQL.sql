/*1. Seleccionar el número de pedidos atendidos por cada empleado, sí y sólo si dicho número está entre 100 y 150.*/

SELECT first_name, last_name, COUNT (order_id)
FROM orders JOIN employees USING (employee_id)
GROUP BY first_name, last_name
HAVING COUNT (order_id) BETWEEN 100 AND 150

/*2. Seleccionar el nombre de las empresas que no han realizado ningún pedido.*/

SELECT s.company_name
FROM shippers s LEFT JOIN orders o ON (o.ship_via = s.shipper_id)
WHERE order_id IS NULL

--Con subsconsulta
SELECT company_name
FROM customers
WHERE customer_id NOT IN(
			SELECT DISTINCT customer_id
			FROM orders
			);
---------------------------------------------------
SELECT category_name, COUNT (DISTINCT product_id) as "cantidad"
FROM categories JOIN products USING (category_id)
				JOIN order_details USING (product_id)
GROUP BY category_name
HAVING COUNT (DISTINCT product_id) = 
( SELECT MAX (cantidad)
  FROM (
  		SELECT COUNT (DISTINCT product_id) as "cantidad"
	  	FROM categories JOIN products USING (category_id)
	  					JOIN order_details USING (product_id)
	  	GROUP BY category_name
  )datos);


/*3. Seleccionar la categoría que tiene más productos diferentes solicitados en pedidos. Mostrar el nombre de la 
categoría y dicho número.*/

SELECT DISTINCT category_name, COUNT (product_name) AS "Numero productos"
FROM orders JOIN order_details USING (order_id)
			JOIN products USING (product_id)
			JOIN categories USING (category_id)
GROUP BY category_name

-- Ejercicio corregido
SELECT category_name, COUNT(DISTINCT product_id)
FROM categories JOIN products USING(category_id)
		JOIN order_details USING(product_id)
GROUP BY category_name
ORDER BY COUNT(DISTINCT product_id) DESC
LIMIT 1;

/*4. Si suponemos que nuestro margen de beneficio con los productos es de un 25% (es decir, el 25% de su precio, 
son beneficios, y el 75% son costes), calcular la cantidad de beneficio que hemos obtenido, agrupado por categoría y producto. 
Las cantidades deben redondearse a dos decimales.*/

SELECT category_name, product_name, ROUND (AVG(unit_price - (unit_price * 75/100))::numeric,2)
FROM  products JOIN categories USING (category_id)
GROUP BY category_name, product_name
--------------------------------------------------
--Ejercicio corregido
SELECT category_name, product_name, 
		ROUND(SUM((od.unit_price * quantity * (1-discount))::numeric*0.25),2) AS "Beneficio"
FROM order_details od JOIN products USING (product_id)
		JOIN categories USING (category_id)
GROUP BY category_name, product_name;


/*5. Selecciona aquellos clientes (CUSTOMERS) para los que todos los envíos que ha recibido (sí, todos) los haya 
transportado (SHIPPERS) la empresa United Package.*/
SELECT DISTINCT c.contact_name, s.company_name
FROM customers c JOIN orders o USING (customer_id)
			    JOIN shippers s ON (o.ship_via = s.shipper_id)
WHERE s.company_name = 'United Package'


-------------------------------------------------------------------
-- Ejercicio corregido

SELECT DISTINCT c.company_name
FROM customers c JOIN orders USING (customer_id)
        JOIN shippers ON (shipper_id=ship_via)
WHERE customer_id NOT IN (
            SELECT customer_id
            FROM orders JOIN shippers
                ON (shipper_id=ship_via)
            WHERE company_name != 'United Package'
);



