-- # LIKE \ NOT LIKE
-- to find things that aren't an exact match, we can use LIKE
-- with it's associated wildcard % (i.e. LIKE "%bowl", LIKE "bowl%", LIKE "%bowl%"
-- NOT LIKE "%bowl%" will return all items that do not have bowl. 

-- # IN
-- will select multiple values in our conditional statement from one column_name
-- FORMAT: WHERE [column_name] IN ([value1], [value2], [value3])

# NULL \ NOT NULL
-- this allows to filter on our NULL values
-- NULL will be our value in the conditional statement
-- FORMAT: WHERE [column_name] IS [NOT] NULL

# chaining WHERE clauses
-- we can chain our conditional statement in the WHERE CLAUSE
-- to check for more than one condition
-- using AND / OR
-- FORMAT: WHERE [column_name] operatior [value1]
-- 			AND/OR [column_name] operator [value2]

-- have to write the complete conditional statement twice

show databases;
use employees;
select database();

/* #1
Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
What is the employee number of the top three results?
*/

SELECT emp_no, first_name
FROM employees
WHERE first_name IN ("Irena", "Vidya", "Maya")
LIMIT 3
;

/* #2
Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
What is the employee number of the top three results? Does it match the previous question?
*/

SELECT emp_no, first_name
FROM employees
WHERE first_name = "Irena" 
	OR first_name = "Vidya" 
    OR first_name = "Maya"
LIMIT 3
;

/* #3
Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
What is the employee number of the top three results.
*/

SELECT *
FROM employees
WHERE gender = "M"
	AND (
    first_name = "Irena"
	OR first_name = "Vidya"
    OR first_name = "Maya"
 )
LIMIT 3
;

-- #4 Find all unique last names that start with 'E'.

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "E%"
;


-- #5 Find all unique last names that start or end with 'E'.

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "E%"
	OR last_name LIKE "%E"
;

-- #6 Find all unique last names that end with E, but does not start with E?

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%E"
	AND last_name NOT LIKE "E%"
;

-- #7 Find all unique last names that start and end with 'E'.

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "E%" -- where last_name like "e%e" shorter way to write
	AND last_name LIKE "%E"
;

-- #8 Find all current or previous employees hired in the 90s. Enter a comment with top three employee numbers.

SELECT emp_no, first_name, last_name
FROM employees
WHERE hire_date LIKE "199%"
LIMIT 3
;

-- #9 Find all current or previous employees born on Christmas. Enter a comment with top three employee numbers.

SELECT emp_no, first_name, last_name, birth_date
FROM employees
WHERE birth_date LIKE "%12-25"
LIMIT 3
;

/* #10 
Find all current or previous employees hired in the 90s and born on Christmas. 
Enter a comment with top three employee numbers.
*/

SELECT *
FROM employees
WHERE hire_date LIKE "199%"
	AND birth_date LIKE "%12-25"
LIMIT 3
;

-- #11 Find all unique last names that have a 'q' in their last name.

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%q%"
;

-- #12 Find all unique last names that have a 'q' in their last name but not 'qu'.

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "%q%"
	AND last_name NOT LIKE "%qu%"
;





