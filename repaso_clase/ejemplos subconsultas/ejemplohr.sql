SELECT department_name, 
(
	SELECT COUNT (*)
	FROM departments JOIN employees USING 
)