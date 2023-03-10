show databases;
use employees;
select database();
show tables;

/* #2
Write a query to to find all employees whose last name starts and ends with 'E'. 
Use concat() to combine their first and last name together as a single column named full_name.
*/

SELECT CONCAT(first_name, ' ', last_name) as full_name
-- 	, emp_no
--  , birth_date
--  , first_name
--  , last_name
--  , gender
--  , hire_date
FROM employees
WHERE last_name LIKE "E%e"
;

-- #3 Convert the names produced in your last query to all uppercase.

SELECT CONCAT(UPPER(first_name), ' ', UPPER(last_name)) as full_name
	, emp_no
    , birth_date
    , first_name
    , last_name
    , gender
    , hire_date
FROM employees
WHERE last_name LIKE "E%e"
;

-- #4 Use a function to determine how many results were returned from your previous query.

SELECT COUNT(*)
FROM employees
WHERE last_name LIKE "E%e"
;

/* #5
Find all employees hired in the 90s and born on Christmas. 
Use datediff() function to find how many days they have been working at the company 
(Hint: You will also need to use NOW() or CURDATE()),
*/

SELECT datediff(NOW(), hire_date) as tenure_in_days
	, emp_no
    , birth_date
    , first_name
    , last_name
    , gender
    , hire_date
FROM employees
WHERE hire_date LIKE "199%"
	AND birth_date LIKE "%12-25"
-- ORDER BY tenure_in_days DESC
;

-- #6 Find the smallest and largest current salary from the salaries table.

SELECT MIN(salary), MAX(salary)
FROM salaries
WHERE to_date > NOW() -- how to find current salary
;

/* #7
Use your knowledge of built in SQL functions to generate a username for all of the employees. 
A username should be all lowercase, and consist of the first character of the employees first name, 
the first 4 characters of the employees last name, an underscore, the month the employee was born, 
and the last two digits of the year that they were born. 
Below is an example of what the first 10 rows will look like:

i.e. Georgi Facello, 1953-09-02, username = gface_0953

*/

SELECT CONCAT(
	  SUBSTR(LOWER(first_name), 1, 1)   -- LEFT(first_name, 1)
    , SUBSTR(LOWER(last_name), 1, 4)    -- LEFT(last_name, 4)
    , '_'
    , SUBSTR(birth_date, 6, 2)
    , SUBSTR(birth_date, 3, 2)) as username
    , first_name
    , last_name
    , birth_date
FROM employees
;






