/*
 Exercise goals
 Use CASE statements or IF() function to explore information in the employees database
 */
 use employees;
 show tables;
 
 /*
 1. Write a query that returns all employees, 
 their department number, 
 their start date, 
 their end date, 
 and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
 
 */
 
 select concat(employees.first_name, ' ', employees.last_name) as employee_name
	, dept_emp.dept_no as dept_no
    , dept_emp.from_date as start_date
    , dept_emp.to_date as end_date
    , case 
			when to_date > now() then '1'
			else 0
		end as is_current_employee
 from employees
 join dept_emp using(emp_no)
 ;
 
 
select 
	emp_no
    , concat(first_name, ' ', last_name) as full_name
    , dept_no
    , hire_date
    , to_date
    , if(to_date > now(), 1, 0) as is_current_employee
from employees
join dept_emp using(emp_no)
;
 
 /*
 2. Write a query that returns all employee names (previous and current), 
 and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
 */
 
 select *
 from employees
 ;
 
 select concat(first_name, ' ', last_name) as employee_name,
	case
		when substr(last_name, 1,1) <='h'  then "A-H"
        when substr(last_name, 1,1) <="q" then "I-Q"
        when substr(last_name, 1,1) <="z" then "R-Z"
	end as alpha_group
from employees
;
 
 select *, substr(last_name, 1,1)
 from employees
 ;
 
 /*
 3. How many employees (current or previous) were born in each decade?
 */
 
 -- I did it the hard/long way ):
 select
			case
				when substr(birth_date, 1,4) <1960 then "1950's"
				when substr(birth_date, 1,4) <1970 then "1960's"
				when substr(birth_date, 1,4) <1980 then "1970's"
				when substr(birth_date, 1,4) <1990 then "1980's"
				when substr(birth_date, 1,4) <2000 then "1990's"
				when substr(birth_date, 1,4) <2010 then "2000's"
				when substr(birth_date, 1,4) <2020 then "2010's"
	end as decade_born
    , count(*)
from employees
group by decade_born
 ;
 
 -- easier/smarter way to do it than above
select
	case
		when birth_date like "195%" then '50s'
        else '60s'
	end as birth_decade
    , count(*)
from employees
group by birth_decade
;

 
 /*
 4. What is the current average salary for each of the following department groups: 
 R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?
 */
 
 select 
	case
		when dept_name in ('research', 'development') then "R&D"
        when dept_name in ('sales', 'marketing') then "Sales & Marketing"
        when dept_name in ('production', 'quality management') then "Prod & QM"
        when dept_name in ('finance', 'human resources') then "Finance & HR"
        else "Customer Service"
	end as department_groups
        , round(avg(salary), 2) as average_salary
 from salaries
 join dept_emp on salaries.emp_no = dept_emp.emp_no
		and dept_emp.to_date > now()
 join departments using(dept_no)
 where salaries.to_date > now() 	
 group by department_groups
 ;

 
 

 
 
 