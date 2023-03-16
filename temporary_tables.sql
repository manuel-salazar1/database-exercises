/*
1.
Using the example from the lesson, 
create a temporary table called employees_with_departments that contains 
first_name, 
last_name, 
and dept_name for employees currently with that department. 
Be absolutely sure to create this table on your own database. 
If you see "Access denied for user ...", it means that the query was 
attempting to write a new table to a database that you can only read.
*/

show databases;
use pagel_2180;
show tables;
use employees;

create temporary table pagel_2180.employees_with_departments as
select employees.emp_no, first_name, last_name, dept_no, dept_name
from employees
join dept_emp on employees.emp_no = dept_emp.emp_no
	and dept_emp.to_date > now()
join departments using (dept_no)
;

select *
from employees_with_departments
;

/*
A.
Add a column named full_name to this table. It should be a VARCHAR 
whose length is the sum of the lengths of the first name and last name columns.
*/

alter table employees_with_departments
add full_name varchar(40)
;


/*
B.
Update the table so that the full_name column contains the correct data.
*/

update employees_with_departments
set full_name = concat(first_name, ' ', last_name)
;
select *
from employees_with_departments;



/*
C.
Remove the first_name and last_name columns from the table.
*/

alter table employees_with_departments
drop column first_name
;
alter table employees_with_departments
drop column last_name
;

select *
from employees_with_departments
;


/*
D.
What is another way you could have ended up with this same table?
*/

-- Yes, create temp table with the information we need to begin with

/*
2.
Create a temporary table based on the payment table from the sakila database.
Write the SQL necessary to transform the amount column such that it is 
stored as an integer representing the number of cents of the payment. 
For example, 1.99 should become 199.

*/

use sakila;
show tables;

select *
from payment
;

create temporary table pagel_2180.sakila_payment as
select amount * 100 as amount_in_pennies
from payment
;



use pagel_2180;
select *
from sakila_payment;

alter table sakila_payment
modify amount_in_pennies int not null;

select *
from sakila_payment;

/*
select amount * 100 as amount_in_pennies
from sakila.payment;
*/


/*
3.
Find out how the current average pay in each department compares to the overall 
current pay for everyone at the company. For this comparison, you will calculate the z-score for each salary. 
In terms of salary, what is the best department right now to work for? The worst?
*/

use employees;
select *
from employees;

select avg(salary), std(salary)
from employees.salaries
where to_date > now()
;

create temporary table overall_aggregates as
(
	select avg(salary) as avg_salary, std(salary) as std_salary
	from employees.salaries
	where to_date > now()
)
;

drop table if exists overall_aggregates;

select *
from overall_aggregates
;

use employees;
use pagel_2180;


create temporary table pagel_2180.current_info
select dept_name, avg(salary) as department_current_average
from employees.salaries
join employees.dept_emp using(emp_no)
join employees.departments using(dept_no)
where employees.dept_emp.to_date > now()
	and employees.salaries.to_date > now()
group by dept_name
;

select * 
from current_info;

alter table current_info
add overall_avg float(10,2)
;

alter table current_info
add overall_std float(10,2)
;

update current_info
set overall_avg = (select avg_salary from overall_aggregates)
;

update current_info
set overall_std = (select std_salary from overall_aggregates)
;

alter table current_info
add zscore float(10,2)
;

update current_info
set zscore = (department_current_average - overall_avg) / overall_std
;

select *
from current_info
order by zscore desc
;









