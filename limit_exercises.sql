-- # LIMIT

show databases;
use employees;
select database();

/* #2 
MySQL provides a way to return only unique results from our queries with the keyword DISTINCT. 
For example, to find all the unique titles within the company, we could run the following query:
List the first 10 distinct last name sorted in descending order.

*/

SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10
;

/* #3
Find all previous or current employees hired in the 90s and born on Christmas. 
Find the first 5 employees hired in the 90's by sorting by hire date and limiting your results to the first 5 records. 
Write a comment in your code that lists the five names of the employees returned.
*/
-- A. Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

SELECT *
FROM employees
WHERE hire_date LIKE "199%"
	AND birth_date LIKE "%12-25"
ORDER BY hire_date
LIMIT 5
;

/*
Try to think of your results as batches, sets, or pages. The first five results are your first page. 
The five after that would be your second page, etc. Update the query to find the tenth page of results.
LIMIT and OFFSET can be used to create multiple pages of data. 
What is the relationship between OFFSET (number of results to skip), LIMIT (number of results per page), 
and the page number?
*/

SELECT *
FROM employees
WHERE hire_date LIKE "199%"
	AND birth_date LIKE "%12-25"
ORDER BY hire_date
LIMIT 5 offset 45
;

/* With OFFSET, we are able to "skip" a specified number of results (LIMIT's) which in turn, skips the correlating
pages. These all work hand in hand. If there are 5 results or LIMITS per page and we OFFSET or skipped to results after
50, then we skipped 10 pages of results. 

*/









