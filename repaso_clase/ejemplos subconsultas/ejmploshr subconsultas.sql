SELECT AVG (maximo)
FROM 
(	SELECT department_name, MAX (salary) as "maximo"
	FROM departments JOIN employees USING (department_id)
	GROUP BY department_name
)datos;

--Seleccionar el nº medio de empleados que tiene cada departamento

SELECT AVG (employee)
FROM (
		SELECT COUNT (employee_id) , department_id
		FROM employees JOIN departments USING (department_id)
		GROUP BY department_id
)

SELECT AVG (cant)
FROM(
		SELECT COUNT (*) as "cant"
		FROM employees
		GROUP BY department_id
)

--Seleccionar aquellos empleados que cobran más que todos los empleados del departamento de Administration

SELECT *
FROM employees
WHERE salary > ALL (
					SELECT salary
					FROM employees JOIN departments USING (department_id)
					WHERE department_name = 'Purchasing'
			   )














