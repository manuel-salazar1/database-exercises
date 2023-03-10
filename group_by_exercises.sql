show databases;
use chipotle;
select database();

-- EXAMPLE NOTES

SELECT DISTINCT item_name, quantity, COUNT(*) -- have to specify the item_name, cannot leave it *
FROM orders
WHERE item_name LIKE "%chicken%"
GROUP BY item_name, quantity
ORDER BY item_name
;

SELECT item_name, count(*)
FROM orders
WHERE item_name LIKE "%chicken%"
GROUP BY item_name
;

-- HAVING function similar to WHERE but AFTER we aggregated our data

show databases;
use employees;
select database();


/* #2
In your script, use DISTINCT to find the unique titles in the titles table. 
How many unique titles have there ever been? Answer that in a comment in your SQL file.
*/
-- A. 7 unique titles

SELECT DISTINCT title
FROM titles
;

/* #3
Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
*/

SELECT last_name
FROM employees
WHERE last_name LIKE "E%e"
GROUP BY last_name
;

/* #4
Write a query to to find all unique combinations of first and last names of all employees 
whose last names start and end with 'E'.
*/

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE "E%e"
GROUP BY first_name, last_name
;

/* #5
Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
*/ 
-- Chleq, Lindqvist, Qiwen

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%q%"
	AND last_name NOT LIKE "%qu%"
;

/* #6
Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
*/

SELECT last_name, count(*)
FROM employees
WHERE last_name LIKE "%q%"
	AND last_name NOT LIKE "%qu%"
GROUP BY last_name
;

/* #7
Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
*/

SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name
;

/* #8
Using your query that generates a username for all of the employees, 
generate a count employees for each unique username.
*/

SELECT CONCAT(
	  SUBSTR(LOWER(first_name), 1, 1)   -- LEFT(first_name, 1)
    , SUBSTR(LOWER(last_name), 1, 4)    -- LEFT(last_name, 4)
    , '_'
    , SUBSTR(birth_date, 6, 2)
    , SUBSTR(birth_date, 3, 2)) as username
    , COUNT(*)
FROM employees
GROUP BY username
;

/* #9
From your previous query, are there any duplicate usernames? 
What is the higest number of times a username shows up? 
Bonus: How many duplicate usernames are there from your previous query?
*/
-- A. YES / 6

SELECT CONCAT(
	  SUBSTR(LOWER(first_name), 1, 1)   -- LEFT(first_name, 1)
    , SUBSTR(LOWER(last_name), 1, 4)    -- LEFT(last_name, 4)
    , '_'
    , SUBSTR(birth_date, 6, 2)
    , SUBSTR(birth_date, 3, 2)) as username
    , COUNT(*)
FROM employees
GROUP BY username
HAVING COUNT(*) > 1 -- ADDED DURING REVIEW
ORDER BY COUNT(*) DESC -- ADDED DURING REVIEW
;


-- BONUS: MORE PRACTICE WITH AGGREGATE FUNCTIONS:

/* B1
Determine the historic average salary for each employee. 
When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
*/

SELECT ROUND(AVG(salary), 2), emp_no
FROM salaries
GROUP BY emp_no
;

/* B2
Using the dept_emp table, count how many current employees work in each department. 
The query result should show 9 rows, one for each department and the employee count.
*/

SELECT dept_no, COUNT(*)
FROM dept_emp
WHERE to_date > NOW()
GROUP BY dept_no
;

/* B3
Determine how many different salaries each employee has had. This includes both historic and current.
*/

SELECT emp_no, COUNT(*)
FROM salaries
GROUP BY emp_no
ORDER BY COUNT(*) DESC
;

/* B4
Find the maximum salary for each employee.
*/

SELECT MAX(salary), emp_no
FROM salaries
GROUP BY emp_no
;

/* B5
Find the minimum salary for each employee.
*/

SELECT MIN(salary), emp_no
FROM salaries
GROUP BY emp_no
;

/* B6
Find the standard deviation of salaries for each employee.
*/

SELECT ROUND(STDDEV(salary), 2), emp_no
FROM salaries
GROUP BY emp_no
;

/* B7
Now find the max salary for each employee where that max salary is greater than $150,000.
*/

SELECT MAX(salary), emp_no
FROM salaries
WHERE salary > 150000
GROUP BY emp_no
;

/* B8
Find the average salary for each employee where that average salary is between $80k and $90k.
*/

SELECT ROUND(AVG(salary), 2), emp_no
FROM salaries
WHERE salary BETWEEN 80000 AND 90000
GROUP BY emp_no
;










