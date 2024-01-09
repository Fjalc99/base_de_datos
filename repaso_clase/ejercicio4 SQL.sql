/*1.Seleccionar el COMPANY_NAME y CONTACT_NAME de aquellos CUSTOMERS que hayan hecho pedidos (ORDERS).*/

SELECT DISTINCT company_name, contact_name
FROM customers c JOIN orders o ON (c.customer_id = o.customer_id) 


/*2.Seleccionar el número de pedidos que hemos enviado en la década de los 90 con las empresas 
Federal Shipping o United Package.*/

SELECT COUNT (order_id)
FROM orders JOIN shippers ON (ship_via=shipper_id)
WHERE company_name IN ('Federal Shipping') 
OR company_name IN ('United Package')
AND EXTRACT (YEAR from shipped_date) BETWEEN 1990 and 1999
	
/*3.Seleccionar el nombre de aquellos productos que han sido solicitados en algún pedido.*/

SELECT DISTINCT product_name
FROM order_details JOIN products USING (product_id)
WHERE discontinued = '1'
					
				 

/*4.Seleccionar la suma de los importes "cobrados" en todos los pedidos realizados en el año 96.*/

SELECT SUM(p.unit_price + p.units_on_order)
FROM order_details JOIN products p USING (product_id)
				   JOIN orders USING (order_id)	
WHERE EXTRACT (YEAR from order_date ) IN (1996)

/*5.Seleccionar el nombre de contacto del cliente y el del empleado para aquellos clientes y empleados que han participado
en pedidos donde la diferencia entre la fecha de envío y la fecha de requisito sea menos de 20 días*/

SELECT c.contact_name, e.first_name
FROM customers c JOIN orders o ON (c.customer_id = o.customer_id) 
				 JOIN employees e USING (employee_id)			
WHERE shipped_date >= required_date + '20days'::interval






