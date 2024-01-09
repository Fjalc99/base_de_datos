SELECT first_name, last_name,
(
	SELECT COUNT (*)
	FROM employees
	WHERE manager_id = e.employee_id
)

FROM employees e
WHERE employee_id IN (
						SELECT manager_id
						FROM employees
						)
