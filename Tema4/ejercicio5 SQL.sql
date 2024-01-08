/*1.Seleccionar los nombres de los productos que hayan sido solicitados en pedidos que 
hayan sido enviados por la empresa United Package.*/

SELECT DISTINCT product_name
FROM shippers JOIN orders ON (shipper_id = ship_via)
			JOIN order_details USING (order_id)
			JOIN products USING (product_id)
WHERE company_name = 'United Package'

/*2.Seleccionar el nombre del producto y el de su categoría que se hayan incluido en algún pedido, 
para todos aquellos pedidos solicitados en un día de Agosto*/

SELECT DISTINCT product_name, category_name
FROM orders  JOIN order_details USING (order_id)
			   JOIN products USING (product_id)
			   JOIN categories USING (category_id)
WHERE TO_CHAR (order_date, 'MM') = '08'

/*3.Seleccionar el nombre de todas las empresas que sean clientes, hayan realizado pedidos o no.*/

SELECT company_name
FROM customers 
			 

/*4.Seleccionar el nombre de los empleados que han atendido pedidos realizados por clientes de Brasil (Brazil).*/

SELECT DISTINCT e.first_name, e.last_name
FROM  customers c  JOIN orders USING (customer_id) 
			JOIN employees e USING (employee_id)
WHERE c.country = 'Brazil'
		

/*5.Seleccionar el nombre de la categoría y los productos que se han pedido en aquellos pedidos 
que han sido atendidos por Janet Leverling (EMPLOYEE).*/

SELECT DISTINCT product_name, category_name
FROM orders JOIN employees USING (employee_id)
			JOIN order_details USING (order_id)
			JOIN products USING (product_id)
			JOIN categories USING (category_id)
WHERE first_name = 'Janet'
AND last_name = 'Leverling'

/*6.Diseña una consulta (incluyendo su solución) para la base de datos NORTHWIND que contenga los siguientes elementos.
- La salida del select no será SELECT *
- Debe realizar el JOIN de al menos 3 tablas.
- Uno de los JOINs debe, obligatoriamente, ser un JOIN ON
- Al menos uno de los JOINs debe ser lateral
- Al menos, tendrá tres condiciones en el WHERE (conectadas con AND u OR)
- Debe ordenar la salida por algún criterio.
*/

/*Selecciona el nombre del producto en el año 1997 y que le empresa que envia el paquete sea 'Federal Shipping'*/

SELECT DISTINCT product_name
FROM shippers s LEFT JOIN orders ON (shipper_id = ship_via)
			  JOIN order_details USING (order_id)
			  JOIN products USING (product_id)
			  JOIN categories  USING (category_id)
WHERE TO_CHAR (order_date, 'YYYY') = '1997'
AND s.company_name = 'Federal Shipping'


