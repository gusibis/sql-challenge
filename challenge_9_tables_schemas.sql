

-- drop table departments;
-- drop table employees;
-- drop table dept_emp;
-- drop table dept_manager;
-- drop table salaries;
-- drop table titles;

CREATE TABLE "departments" (
  "dept_no" VARCHAR(255) PRIMARY KEY,
  "dept_name" VARCHAR(255) NOT NULL
);

CREATE TABLE "titles" (
  "title_id" VARCHAR(255) PRIMARY KEY,
  "title" VARCHAR(255) NOT NULL
);

CREATE TABLE "employees" (
  "emp_no" INT PRIMARY KEY,
  "emp_title_id" VARCHAR(40) NOT NULL,
  "birth_date" DATE NOT NULL,
  "first_name" VARCHAR(255) NOT NULL,
  "last_name" VARCHAR(255) NOT NULL,
  "sex" CHAR(1) NOT NULL,
  "hire_date" DATE NOT NULL
);

CREATE TABLE "dept_emp" (
  "emp_no" INT NOT NULL,
  "dept_no" VARCHAR(255) NOT NULL,
  PRIMARY KEY ("emp_no", "dept_no")
);

CREATE TABLE "dept_manager" (
  "dept_no" VARCHAR(255) NOT NULL,
  "emp_no" INT NOT NULL,
  PRIMARY KEY ("dept_no", "emp_no")
);

CREATE TABLE "salaries" (
  "emp_no" INT PRIMARY KEY NOT NULL,
  "salary" INT NOT NULL
);

ALTER TABLE "dept_emp" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD FOREIGN KEY ("dept_no") REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");

ALTER TABLE "salaries" ADD FOREIGN KEY ("emp_no") REFERENCES "employees" ("emp_no");
