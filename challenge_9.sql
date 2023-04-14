
-- drop table departments;
-- drop table employees;
-- drop table dept_emp;
-- drop table dept_manager;
-- drop table salaries;
-- drop table titles;

CREATE TABLE departments (
  dept_no VARCHAR(255) PRIMARY KEY,
  dept_name VARCHAR(255) NOT NULL
);
-- 
CREATE TABLE titles (
  title_id VARCHAR(255) PRIMARY KEY,
  title VARCHAR(255) NOT NULL
);
-- 
CREATE TABLE employees (
  emp_no INT PRIMARY KEY,
  emp_title_id VARCHAR(40) NOT NULL,
  birth_date DATE NOT NULL,
  first_name VARCHAR(255) NOT NULL,
  last_name VARCHAR(255) NOT NULL,
  sex CHAR(1) NOT NULL,
  hire_date DATE NOT NULL
);
-- 
CREATE TABLE dept_emp (
  emp_no INT NOT NULL,
  dept_no VARCHAR(255) NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  PRIMARY KEY (emp_no, dept_no)
);
-- 
CREATE TABLE dept_manager (
  dept_no VARCHAR(255) NOT NULL,
  emp_no INT NOT NULL,
  FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (dept_no, emp_no)
);
-- 
CREATE TABLE salaries (
  emp_no INT NOT NULL,
  salary INT NOT NULL,
  FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
  PRIMARY KEY (emp_no)
);
--Imported csv files 

--------------   Data Analysis ---------------- 
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
-- SELECT * FROM employees;
SELECT * FROM employees WHERE CAST(employees.hire_date AS VARCHAR) LIKE '1986-%'ORDER BY emp_no;

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
-- SELECT * FROM dept_manager;
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name FROM dept_manager
JOIN departments ON departments.dept_no = dept_manager.dept_no JOIN employees ON dept_manager.emp_no = employees.emp_no
ORDER BY emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name

