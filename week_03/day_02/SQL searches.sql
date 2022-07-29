-- find the number of employees within each department of the corporation

SELECT 
(count(id)),
department 
FROM employees 
--  we cam now remove WHERE department = 'Legal'
GROUP BY department -- anything IN the GROUP BY can be IN the SELECT 
ORDER BY count(id); 

SELECT 
(count(id)) AS num_employees,
department 
FROM employees 
--  we cam now remove WHERE department = 'Legal'
GROUP BY department -- anything IN the GROUP BY can be IN the SELECT 
ORDER BY count(id); 

-- How many employees are there in each country?
SELECT count(id) AS num_employees,
country , department 
FROM employees
GROUP BY country , department ;

SELECT count(id) AS num_employees,
country , department 
FROM employees
GROUP BY country , department
ORDER BY country ;

-- how many employees in each department
SELECT 
count(id),
fte_hours 
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.5
GROUP BY fte_hours ;

SELECT 
count(id),
fte_hours 
FROM employees
WHERE fte_hours = 0.25 OR fte_hours = 0.5
GROUP BY fte_hours ;

SELECT 
count(id),
fte_hours 
FROM employees
WHERE fte_hours IN (0.25, 0.5)
GROUP BY fte_hours ;

-- see how NULL affects counts
-- gotcha counts can exist without a group by if no other column is present
SELECT  
count(id),
count(first_name),
count(*)  -- BIGGGGGG GOTCHA
FROM employees  ;

-- Find the longest serving employee in each department
-- maybe a date column
-- employee in each department (GROUP BY)

SELECT *
FROM employees 

SELECT start_date , department 
FROM employees 
GROUP BY start_date ,department 

-- aggregate functions are count(), sum, avg, min, max
-- NOW() gives todays date and time (for the server) 

SELECT now() -min(start_date), department 
FROM employees 
GROUP BY department 

SELECT now() -min(start_date), department, first_name ,last_name  
FROM employees 
GROUP BY department , first_name , last_name 

SELECT now() -min(start_date) AS time_served, department, first_name ,last_name  
FROM employees 
GROUP BY department , first_name , last_name 
ORDER BY time_served

-- ORDER OF EXECUTION
-- 1 FROM 
-- 2 WHERE 
-- 3 GROUP BY 
-- 4 HAVING 
-- 5 SELECT 

SELECT now() -min(start_date) AS time_served,
department, 
first_name ,
last_name  ,
EXTRACT (DAY FROM NOW () -MIN(start_date))
FROM employees 
GROUP BY department , first_name , last_name 
ORDER BY time_served DESC NULLS LAST 

SELECT now() -min(start_date) AS time_served,
department, 
first_name ,
last_name  ,
EXTRACT (DAY FROM NOW () -MIN(start_date)) / 365
FROM employees 
GROUP BY department , first_name , last_name 
ORDER BY time_served DESC NULLS LAST 

SELECT now() -min(start_date) AS time_served,
department, 
first_name ,
last_name  ,
 round(EXTRACT (DAY FROM NOW () -MIN(start_date)) / 365)
FROM employees 
GROUP BY department , first_name , last_name 
ORDER BY time_served DESC NULLS LAST ;

SELECT 
department, 
first_name ,
last_name  ,
 round(EXTRACT (DAY FROM NOW () -MIN(start_date)) / 365) AS time_served
FROM employees 
GROUP BY department , first_name , last_name 
ORDER BY department, time_served DESC NULLS LAST ;

SELECT 
department, 
first_name ,
last_name  ,
 round(EXTRACT (DAY FROM NOW () -MIN(start_date)) / 365) AS time_served
FROM employees 
GROUP BY department , first_name , last_name 
ORDER BY department, time_served DESC NULLS LAST 
LIMIT 1;

-- 1. "How many employees in each department are enrolled in the pension scheme?"

--2. "Perform a breakdown by country of the number of employees that do not have a stored first name."

SELECT 
count(pension_enrol) AS staff_pension_enroll,
department 
FROM employees 
WHERE pension_enrol = TRUE
GROUP BY department  

SELECT 
count(pension_enrol) AS staff_pension_enroll,
department 
FROM employees 
WHERE pension_enrol IS TRUE
GROUP BY department  

SELECT 
count(last_name) AS count_emp_that_do_not_f_name,
country
FROM employees
WHERE first_name IS NULL
GROUP BY country
ORDER BY country ASC ;

-- show those departments in which at least 40 employees work either 0.25 or 0.5 fte hours
-- where clause for group is called HAVING 
SELECT count(id),
department 
FROM employees
WHERE fte_hours BETWEEN 0.25 AND 0.50
GROUP BY department 
HAVING count(id) >= 40 -- ONLY works WITH AGGREGATEs

-- show any countries  in which the minimum salary is less than 21,000 dollars

SELECT * FROM employees 
WHERE pension_enrol IS TRUE 
AND salary <21000;

SELECT country , salary  FROM employees 
WHERE pension_enrol IS TRUE 
AND salary <21000;

SELECT country , min(salary)  FROM employees 
WHERE pension_enrol IS TRUE 
GROUP BY country
HAVING  min(salary) <21000;


SELECT country , min(salary),department  FROM employees 
WHERE pension_enrol IS TRUE 
GROUP BY country ,department 
HAVING  min(salary) <21000;

SELECT country , min(salary),department  FROM employees 
WHERE pension_enrol IS TRUE 
GROUP BY country ,department -- ONLY have TO be COLUMNS NOT AGGREGATE 
HAVING  min(salary) <21000
ORDER BY min(salary), country , department ;

SELECT count(id), min(salary),department  FROM employees 
WHERE pension_enrol IS TRUE 
GROUP BY department -- ONLY have TO be COLUMNS NOT AGGREGATE 
HAVING  min(salary) <21000
ORDER BY min(salary), department ;

-- "Show any departments in which the earliest start date amongst grade 1 employees is prior to 1991"

SELECT 
department, min(start_date)  AS earliest_st_date
FROM employees 
WHERE grade = 1 
GROUP BY department 
HAVING  min(start_date) < '1991-01-01' 

SELECT * FROM employees 
WHERE country = 'Japan'
AND salary > avg(salary) -- will not work

SELECT avg(salary) FROM employees 

SELECT * FROM employees 
WHERE country = 'Japan'
AND salary > (SELECT avg(salary) FROM employees );

SELECT avg(salary) FROM employees
WHERE department = 'Legal'

SELECT * FROM employees 
WHERE department  = 'Legal'
AND salary < (SELECT avg(salary) FROM employees
WHERE department = 'Legal');

SELECT count(id) , country, salary 
FROM employees 
WHERE department = 'Legal'
AND salary < (SELECT avg(salary) FROM employees 
				WHERE department = 'Legal')
GROUP BY country , salary
ORDER BY salary, country  -- gotcha ORDER BY COLUMNS IS IMPORT 



-- if you see more than i PK in a table  it generally denotes one to many join table 
