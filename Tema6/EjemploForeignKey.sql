CREATE TABLE emp (
	id_emp	SERIAL,
	nombre 	VARCHAR (100),
	cod_dep INTEGER,
	id_jefe INTEGER,
	CONSTRAINT pk_emp PRIMARY KEY (id_emp)
)


CREATE TABLE dep (
	cod_dep SERIAL,
	
)

ALTER TABLE emp
ADD CONSTRAINT fk_emp_emp FOREIGN KEY (id_jefe) REFERENCES emp (id_emp),
ADD CONSTRAINT fk_emp_dep FOREIGN KEY (cod_dep) REFERENCES dep (cod_dep);

ALTER TABLE dep
ADD CONSTRAINT fk_dep_emp FOREIGN (id_jefe_dep) REFERENCES emp (id_emp)