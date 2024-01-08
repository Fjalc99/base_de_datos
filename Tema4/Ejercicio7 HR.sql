/*1.Selecciona el número de empleados que fueron contratados en el año 1997 en la que trabajen en 
una oficina situada en Bélgica.*/

SELECT COUNT (employee_id)
FROM employees JOIN departments USING (department_id)
			   JOIN locations USING (location_id)
			   JOIN countries USING (country_id)
WHERE country_name = 'Belgium'
AND TO_CHAR(hire_date, 'YYYY') = '1997'


/*2.Selecciona la media de salario máximo de los trabajadores de Administration en Asia.*/

SELECT AVG (max_salary)
FROM jobs j JOIN employees e ON (j.job_id = e.job_id)
		RIGHT JOIN departments USING (department_id)
			JOIN locations USING (location_id)
		JOIN countries USING (country_id)
	  RIGHT JOIN regions USING (region_id)
WHERE department_name = 'Administration'
AND region_name = 'Asia'