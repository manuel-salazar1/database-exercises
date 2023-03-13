show databases;
use join_example_db;
select database();
show tables;
-- #1
SELECT *
FROM roles
;
-- #1
SELECT *
FROM users
;
-- #2
SELECT *
FROM users
JOIN roles on users.role_id = roles.id
;

-- #2
SELECT *
FROM users
LEFT JOIN roles on users.role_id = roles.id
;
-- #2
SELECT *
FROM users
RIGHT JOIN roles on users.role_id = roles.id
;

-- #3
SELECT roles.name, COUNT(*)
FROM users
RIGHT JOIN roles on users.role_id = roles.id
GROUP BY roles.name
;

-- **EMPLOYEES DATABASE EXERCISES**

use employees;
select database();
show tables;

/* #2
Using the example in the Associative Table Joins section as a guide, 
write a query that shows each department along with the name of the current manager for that department.
*/

SELECT departments.dept_name as "Department Name", 
	CONCAT(employees.first_name, ' ', employees.last_name) as "Department Manager"
FROM employees
JOIN dept_manager USING (emp_no)
JOIN departments on dept_manager.dept_no = departments.dept_no
WHERE to_date > NOW()
GROUP BY departments.dept_name, employees.first_name, employees.last_name
ORDER BY departments.dept_name
;

/* #3
Find the name of all departments currently managed by women.
*/

SELECT departments.dept_name as "Department Name"
	, CONCAT(employees.first_name, ' ', employees.last_name) as "Department Manager"
FROM employees
JOIN dept_manager USING (emp_no)
JOIN departments on dept_manager.dept_no = departments.dept_no
WHERE to_date > NOW()
	AND gender = "F"
GROUP BY departments.dept_name, employees.first_name, employees.last_name
ORDER BY departments.dept_name
;

/* #4
Find the current titles of employees currently working in the Customer Service department.
*/

SELECT titles.title as "Title", COUNT(*)
FROM employees
JOIN titles on employees.emp_no = titles.emp_no
JOIN dept_emp on employees.emp_no = dept_emp.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no
WHERE titles.to_date > NOW()
	AND departments.dept_name = "customer service"
GROUP BY titles.title
ORDER BY titles.title
;

-- used USING statement
SELECT titles.title as "Titles", COUNT(*)
FROM employees
JOIN titles USING (emp_no)
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE titles.to_date > NOW()
	AND dept_emp.to_date > NOW()
	AND	departments.dept_name = "customer service"
GROUP BY titles.title
ORDER BY titles.title
;

/* #5
Find the current salary of all current managers.
*/

SELECT departments.dept_name as "Department Name" 
	, CONCAT(employees.first_name, ' ', employees.last_name) as "Name", salaries.salary as "Salary"
FROM employees
JOIN dept_manager USING (emp_no)
JOIN departments USING (dept_no)
JOIN salaries USING (emp_no)
WHERE dept_manager.to_date > NOW()
	AND salaries.to_date > NOW()
GROUP BY departments.dept_name, employees.first_name, employees.last_name, salaries.salary
ORDER BY departments.dept_name
; -- :)

/* #6
Find the number of current employees in each department.
*/

SELECT dept_no, departments.dept_name as dept_name, COUNT(*) as num_employees
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE dept_emp.to_date > NOW()
GROUP BY dept_no, departments.dept_name
ORDER BY dept_no
; -- (:

/* #7
Which department has the highest average salary? Hint: Use current not historic information.
*/

SELECT departments.dept_name as dept_name, (AVG(salaries.salary)) as average_salary
FROM employees
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
JOIN salaries USING (emp_no)
WHERE salaries.to_date > NOW()
	AND	dept_emp.to_date > NOW()
GROUP BY departments.dept_name
ORDER BY AVG(salaries.salary) DESC
LIMIT 1
;

/* #8
Who is the highest paid employee in the Marketing department?
*/

SELECT employees.first_name, employees.last_name -- , MAX(salaries.salary)
FROM employees
JOIN salaries USING (emp_no)
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
WHERE departments.dept_name LIKE "marketing"
	AND salaries.to_date > NOW()
    AND dept_emp.to_date > NOW()
GROUP BY employees.first_name, employees.last_name
ORDER BY MAX(salaries.salary) DESC
LIMIT 1
; -- :)

/* #9
Which current department manager has the highest salary?
*/

SELECT employees.first_name as first_name, employees.last_name, salaries.salary as salary, departments.dept_name as dept_name
FROM employees
JOIN salaries USING (emp_no)
JOIN dept_manager USING (emp_no)
JOIN departments USING (dept_no)
WHERE salaries.to_date > NOW()
	AND dept_manager.to_date > NOW()
GROUP BY employees.first_name, employees.last_name, salaries.salary, departments.dept_name
ORDER BY MAX(salaries.salary) DESC
LIMIT 1
;

/* #10
Determine the average salary for each department. Use all salary information and round your results.
*/

SELECT departments.dept_name, ROUND(AVG(salaries.salary), 0)
FROM employees
JOIN salaries USING (emp_no)
JOIN dept_emp USING (emp_no)
JOIN departments USING (dept_no)
GROUP BY departments.dept_name
ORDER BY AVG(salaries.salary) DESC
; -- :)

/* BONUS #1
Bonus Find the names of all current employees, their department name, and their current manager's name.
*/

SELECT  CONCAT(employees.first_name, ' ', employees.last_name) as "Employee Name"
	, departments.dept_name as "Department Name"
	, CONCAT(employees_manager.first_name, ' ', employees_manager.last_name)
FROM employees
JOIN dept_emp on employees.emp_no = dept_emp.emp_no
JOIN departments on dept_emp.dept_no = departments.dept_no

JOIN dept_manager on dept_emp.dept_no =  dept_manager.dept_no
JOIN employees as employees_manager on dept_manager.emp_no = employees_manager.emp_no

-- JOIN departments as departments_manager on dept_manager.dept_no = departments.dept_no
WHERE dept_emp.to_date > NOW()
 	AND dept_manager.to_date > NOW()	
;


SELECT CONCAT(first_name, ' ', last_name), dept_name
FROM employees
JOIN dept_manager on employees.emp_no = dept_manager.emp_no
JOIN departments on dept_manager.dept_no = departments.dept_no
WHERE dept_manager.to_date > NOW()
;

/* Bonus #2
Bonus Who is the highest paid employee within each department.

*/








