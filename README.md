# sql-challenge Module 9

This Challenge is divided into three parts: data modeling, data engineering, and data analysis.

This assignment asks to download 6 CSV files with employees data for us to design and create a database to then perform queries on it, you can find these 6 files in tne folder 'EmployeeSQL' of this repository. 

Explored the files to dtermine what columns would be the primary keys, foreign keys, set data types and data constraints. 

After exploring the files I created an image and an excel file of the file names and column names of each file respectively.

You can see the CSV_files_colum_names.xlsx in this repository, I started the layout in plain text, see the image csv_files.png.

After reviewing the columns and data of the CSV files I created a basic diagram can be found in the repository with the name basic_diagram.png 
The basic diagram was done in VS Code using plain text. 

Then created a physical diagram. An image of the physical diagram was created using https://dbdiagram.io/, se the image named ERD_IMAGE.png in this repo. 

The character limit VARCHAR(255) was probably too large for names but for this small database would not be an issue and I decided it would be appropriate.  
I tried creating the tables in multiple orders and realized the order matters as one table must exist for the foreing keys to be referenced to existing primary keys. 
The dept_manager and the dept_emp tables used a composite primary key, this was hard to figure out on my own, but the dbdiagram.io sort of answered that for me when I imported the tables schemas. 
I thought it was easier than creating a surrogate primary key for the 2 tables. 

Please find the results of the queries in the folder named 'Results' found in this repository. 

Below you have the tables schemas and the queries. 
--
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

The queries as they were requested in the Data Analysis section were as follows.  

-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary FROM employees
INNER JOIN salaries ON employees.emp_no = salaries.emp_no
ORDER BY emp_no;


-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT employees.first_name, employees.last_name, employees.hire_date FROM employees 
WHERE CAST(employees.hire_date AS VARCHAR) LIKE '1986-%'
ORDER BY emp_no;


-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dept_manager.dept_no, departments.dept_name, dept_manager.emp_no, employees.last_name, employees.first_name FROM dept_manager
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no 
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no
ORDER BY emp_no;


-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name
SELECT dept_manager.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no = employees.emp_no 
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
ORDER BY emp_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT employees.first_name, employees.last_name, employees.sex FROM employees 
WHERE employees.first_name LIKE '%Hercules%' and employees.last_name LIKE 'B%' ORDER BY employees.sex;

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT employees.emp_no, employees.last_name, employees.first_name FROM employees 
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN dept_manager ON dept_emp.dept_no = dept_manager.dept_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales'
GROUP BY employees.emp_no
ORDER BY employees.emp_no;

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT DISTINCT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name FROM employees 
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN dept_manager ON dept_emp.dept_no = dept_manager.dept_no
INNER JOIN departments ON dept_manager.dept_no = departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development' 
ORDER BY employees.emp_no;


-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT employees.last_name, COUNT(*) as frequency_count from employees
GROUP BY employees.last_name
ORDER BY frequency_count DESC