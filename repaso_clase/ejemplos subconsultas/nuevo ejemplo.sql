SELECT company_name,
	SUM(unit_price * quantity * (1 - discount)),
	(
		SELECT AVG (importe)
		FROM (
				SELECT SUM(unit_price * quantity * (1 - discount))	
				FROM orders JOIN order_details USING (order_id)
				GROUP BY company_name
			 )
	)
FROM customers JOIN orders USING (customer_id)
			   JOIN order_details 