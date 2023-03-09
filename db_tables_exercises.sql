-- List all the databases
show databases;
-- Write the SQL code necessary to use the albums_db database
use albums_db;
-- Show the currently selected database
select database();
-- List all the tables in the database
show tables;
-- Write the SQL code to switch the employees database
use employees_db;
-- Show the currently selected database
select database();
-- List all the tables in the database
show tables;
-- Explore the employees table. 
show create table employees;

-- We typically won't always want to know how the table was created.

show databases;
use employees_db;
show databases;
use employees;
show tables;
/* 11
Q) Which table(s) do you think contain a numeric type column?
A) All of them. departments, dept_emp, dept_manager, employees, salaries, titles

Corrected - dept_emp, dept_manager, employees, salaries, titles
*/

/* 12
Q) Which table(s) do you think contain a string type column?
A) All of them. department, dept_emp, dept_manager, employees, salaries, titles

Corrected - department, dept_emp, dept_manager, employees, titles
*/

/* 13
Q) Which table(s) do you think contain a date type column?
A) empoyees, dept_emp, dept_manager, salaries, & titles
*/

/* 14
Q) What is the relationship between the employees and the departments tables?
A) The dept_emp table links the 2 together 

Corrected - 
*/ 

show create table departments;
show create table employees;
show create table dept_emp;
-- #15 solution below
show create table dept_manager;
/* Question 15
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
show create table salaries;
show create table titles;

