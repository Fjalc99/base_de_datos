/*1. Seleccionar el salario máximo de cada departamento, mostrando el nombre del departamento y dicha cantidad.*/

SELECT COALESCE (department_name, 'Sin departamento'), MAX(salary)
FROM employees LEFT JOIN departments USING (department_id)
GROUP BY department_name

/*2. Seleccionar el salario mínimo de cada departamento, para aquellos departamentos cuyo salario mínimo sea menor que 5000$.*/

SELECT department_name, MIN(salary)
FROM employees JOIN departments USING (department_id)
GROUP BY department_name
HAVING MIN(salary) < 5000

/*3. Seleccionar el número de empleados que trabajan en cada oficina, mostrando el STREET_ADDRESS y dicho número; 
hay que ordenar la salida de mayor a menor.*/

SELECT street_address, COUNT (employee_id) AS "numero_empleados" 
FROM employees JOIN departments USING (department_id)
			   JOIN locations USING (location_id)
GROUP BY street_address
ORDER BY numero_empleados  DESC;

/*4. Modificar la consulta anterior para que muestre las localizaciones que no tienen ningún empleado.*/

SELECT street_address, COUNT (employee_id) AS "numero_empleados" 
FROM employees JOIN departments USING (department_id)
			  RIGHT JOIN locations USING (location_id)
GROUP BY street_address
ORDER BY numero_empleados  DESC;



/*5. Seleccionar el salario que es cobrado a la vez por más personas. Mostrar dicho salario y el número de personas.*/

SELECT salary, COUNT (employee_id) AS "Empleados"
FROM employees
GROUP BY salary
HAVING COUNT (employee_id) > 1

/*6. Seleccionar el número de empleados que empezaron a trabajar cada año, ordenando la salida por el año.*/

SELECT EXTRACT (year from hire_date) AS "año", COUNT (employee_id) AS "Empleados"
FROM employees
GROUP BY año

