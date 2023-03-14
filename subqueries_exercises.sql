use employees;

/* 
1. Find all the current employees with the same hire date as employee 101010 using a subquery.
*/

select e.first_name, e.last_name, e.hire_date
from employees as e
join dept_emp as de on e.emp_no = de.emp_no
	and to_date > now()
where hire_date = 
	(select hire_date
    from employees
    where emp_no = 101010
    )
;

select *
from employees
where emp_no = 101010
;

/* 
2. Find all the titles ever held by all current employees with the first name Aamod.
titles
current employees
first name = aamod
*/

select distinct(titles.title)
from titles
join employees on titles.emp_no = employees.emp_no
where first_name in
	(
    select first_name
    from employees
    join dept_emp on employees.emp_no = dept_emp.emp_no
	and first_name = 'aamod'
	and to_date > now()
    )
;



/* 
3. How many people in the employees table are no longer working for the company? 
Give the answer in a comment in your code.
*/
-- A. 59,900

select count(*)
from employees
where emp_no not in
	(
    select employees.emp_no
	from employees
	join dept_emp on employees.emp_no = dept_emp.emp_no
	and dept_emp.to_date > now()
    ) 
;


/* 
4. Find all the current department managers that are female. List their names in a comment in your code.
*/
-- A. Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil
select first_name, last_name
from employees
where emp_no in
	(
    select emp_no
    from dept_manager
    where to_date > now()
		and gender = "f"
	)
;



/* #5
Find all the employees who currently have a higher salary than the companies overall, historical average salary.
*/

select concat(employees.first_name, ' ', employees.last_name) as employee
	, salaries.salary as salary
from employees
join salaries on employees.emp_no = salaries.emp_no
	and salaries.to_date > now()
where salaries.salary >
	(
    select avg(salary)
    from salaries
    )
ORDER BY salaries.salary
;

select avg(salary)
from salaries
;

/* #6
How many current salaries are within 1 standard deviation of the current highest salary? 
(Hint: you can use a built in function to calculate the standard deviation.) 
What percentage of all salaries is this?

Hint You will likely use multiple subqueries in a variety of ways

Hint It's a good practice to write out all of the small queries that you can. 
Add a comment above the query showing the number of rows returned. 
You will use this number (or the query that produced it) in other, larger queries.
*/

select count(*)
from salaries
where salary >
	(
    select max(salary)
    from salaries
    where to_date > now()) - 
		(
        select round(std(salary), 0)
        from salaries
        where to_date > now())
        and to_date > now()
;

select (100*(100* (select count(*)
from salaries
where salary >
    (
    select max(salary)
    from salaries
    where to_date > now()
    ) - 
    (
		select round(std(salary),0) 
		from salaries
		where to_date > now())
		and to_date > now()
	) /
			count(emp_no)))
			from salaries
			where to_date > now()
;



/* BONUS 1
Find all the department names that currently have female managers.
*/



/* BONUS 2
Find the first and last name of the employee with the highest salary.
*/



/* BONUS 3
Find the department name that the employee with the highest salary works in.
*/



/* BONUS 4
Who is the highest paid employee within each department.
*/









