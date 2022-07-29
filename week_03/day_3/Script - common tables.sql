/*
 * Advanced SQL Topics
 */

/*
 * create your own function
 * 
 * can help when performing the same / similar tasks often. (an answer to tediousness)
 * 
 * you may not be allowed to create function (depends on your DB permissions
 * 
 * omni user cannot create functions
 * 
 * functions are attached to databases
 * 
 */

-- 1. use the keyword TO CREATE [OR REPLACE] TO START defining your FUNCTION 
-- 2. give your function a name = percent_change
--3. specify the arguments of you function and their datatypes
-- 4. specify the DATATYPE of the RESULT 
-- 5. write the cod for the FUNCTION 
-- 6.
-- 7.
-- 8. call your function, jast as you would any other built in FUNCTION 

CREATE OR REPLACE FUNCTION -- IF there IS a FUNCTION IN the SYSTEM we're going TO UPDATE OR REPLACE It 
percent_change(new_value NUMERIC, old_value NUMERIC, decimals INT DEFAULT 2)
RETURNS NUMERIC AS 
    'SELECT ROUND(100 * (new_value - old_value) / old_value, decimals);'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

percent_change <- function(new_value, old_value, decimal = 2)

SELECT ROUND(100 * (new_value - old_value) / old_value, decimals) ;

SELECT 
percentage_change(50, 40),
percentage_change(100, 99, 4);


/*
 * legal salaries ARE increasing BY %1000 NEXT YEAR 
SHOW the PERCENT CHANGE FOR EACH employee's salary IN legal
 */

SELECT 
id,
first_name,
last_name,
salary,
salary + 1000 AS new_salary,
percent_change(salary +1000, salary, 2)
FROM employees 
WHERE department = 'Legal'
ORDER BY percent_change DESC NULLS LAST;

SELECT 
make_badge(first_name, last_name, department) AS badge
FROM employees ;

-- kind of need to know functions ahead of time


/*
 * Investigating Query Performance
 * maybe a queries taking a surprisingly long amount of time to run
 * 
 * interview question (how would i speed up a slow running query
 */

SELECT department 
FROM employees 
WHERE country IN ('Germany', 'France','Italy', 'Spain')
GROUP BY department 
ORDER BY avg(salary);

EXPLAIN ANALYZE 
SELECT department 
FROM employees 
WHERE country IN ('Germany', 'France','Italy', 'Spain')
GROUP BY department 
ORDER BY avg(salary);

-- how could we speed up this query

-- index column(s)!
-- what index columns do is behind the scenes they provide a quick lookup-y
-- way of finding rows using the index column

-- searching a phone book
-- 1. start at the start and go through each page until we find 'David Currie'
-- look at all the A's, all the B's, and a good chunk or the C's until we FOUND 
-- David C (sequential scan)
--[default behaviour]

-- 2. use and index. notice that the surname starts with a C 
-- go directly to C and look there
-- (index scan)

-- let's use employees indexec
-- this was created with employees and indexec by country



SELECT *
FROM employees_indexed ;

CREATE INDEX employees_indexed_country ON employees_indexed(country ASC NULLS LAST) ;

EXPLAIN ANALYZE 
SELECT department , avg(salary)
FROM employees_indexed 
WHERE country IN ('Germany', 'France','Italy', 'Spain')
GROUP BY department 
ORDER BY avg(salary);

-- drawbacks 
-- storage (less of an issue these days)
-- slows down other CRUD operations (insert, update, delete) since indexes need
-- to be updated

/*
 *  Common Table Expressions
 * 
 * we can create temporary table before the start of our query
 * and access them like tables in the database
 */
 
/*
 * find all the employees in the legal department who 
 * earn less than the mean salary of people in that same 
 * department
 */
SELECT 
FROM 
WHERE 
GROUP
HAVING 
ORDER 
LIMIT  

-- su;bqueries too

SELECT *
FROM employees 
WHERE department = 'Legal'

SELECT avg(salary) FROM employees WHERE department = 'Legal'

SELECT *
FROM employees 
WHERE department = 'Legal' AND salary < (

SELECT avg(salary) FROM employees WHERE department = 'Legal')

-- common tables allow you to specify this temp table created in out subquery as table in the database

WITH dep_average AS (
SELECT avg(salary) AS avg_salary
FROM employees 
WHERE department = 'Legal'
)
SELECT *
FROM employees 
WHERE department ='Legal' AND salary < (
SELECT avg_salary
FROM dep_average);

/*
* find ALL the employees IN legal who earn 
less than the mean slary AND WORK fewer than the mean fte hours
*/

SELECT *
FROM employees 
WHERE department = "Legal" AND salary <(
SELECT avg(salary)
FROM employees
WHERE department = 'Legal');

WITH dep_averages AS (
SELECT
avg(salary) AS avg_salary,
avg(fte_hours) AS avg_fte
FROM employees 
WHERE department = 'Legal'
)
SELECT *
FROM employees 
WHERE department = "Legal"



WITH dep_averages AS (SELECT)


SELECT *
FROM employees 
WHERE department = 'Legal' AND salary < (
	SELECT avg(salary)
	FROM employees
	WHERE department = 'Legal'
) AND fte_hours < (
	SELECT avg(fte_hours)
	FROM employees
	WHERE department = 'Legal');

-- common table solution
WITH dep_averages AS (
	SELECT
		avg(salary) AS avg_salary,
		avg(fte_hours) AS avg_fte
	FROM employees
	WHERE department = 'Legal'
	)
	SELECT *
	FROM employees
	WHERE department = 'Legal' AND salary < (
		SELECT avg_salary
		FROM dep_averages
	) AND fte_hours < (
		SELECT avg_fte
		FROM dep_averages
	);
	
/*
 *  get a table with each employee's 
 * first name
 * last name
 * department
 * country
 * salary
 * and a comparison of their salary vs that of the country they work in, 
 * and the department they work in
 */

/*
 * first | last | dep| country | salary | sal vs dep | sal vs country
 * 
 * employee salary / department avg
 * emp / country avg
 */

-- get the average salary for each dep 
-- get the avg salary for each country
-- using these avg values calculate each employee's ration (select)
-- some kind of joining operation

SELECT 
department ,
avg(salary) AS avg_salary
FROM employees 
GROUP BY department 

SELECT
country,
avg(salary) AS avg_salary_country
FROM employees 
GROUP BY country 


--
WITH dep_avgs AS (SELECT 
department ,
avg(salary) AS avg_salary
FROM employees 
GROUP BY department 
),
country_avg AS (
SELECT 
country,
avg(salary) AS avg_salary_country
FROM employees 
GROUP BY country 
)
SELECT 
e.first_name ,
e.last_name ,
e.department ,
e.country ,
e.salary,
dep_a.avg_salary,
c_a.avg_salary_country
FROM employees AS e
INNER JOIN dep_avgs AS dep_a
ON e.department  = dep_a.department
INNER JOIN country_avg AS c_a
ON e.country = c_a.country



WITH dep_avg AS (SELECT 
department ,
avg(salary) AS avg_salary
FROM employees 
GROUP BY department 
),
country_avg AS (
SELECT 
country,
avg(salary) AS avg_salary_country
FROM employees 
GROUP BY country 
)

SELECT 
first_name ,
last_name ,
department ,
e.country ,
e.salary
round(e.salary / dep_a.avg_salary_dept, 2)
round(e.salary / c_a.avg_salary_country, 2)
FROM employees AS e
INNER JOIN dep_avgs AS dep_a
ON e.department  = dep_a.department
INNER JOIN country_avgs AS c_a
ON e.country = c_a.country

/*
 *  Windows Functions
 */

/*
 * show for each employee their salary together with the minimum and 
 * maximum salaries of employees in their department
 */

-- window function : OVER 

SELECT *
FROM employees 
GROUP BY department ;

SELECT *, 
	min(salary) OVER (PARTITION BY department),
	max(salary) OVER (PARTITION BY department)
FROM employees ;


SELECT
	first_name ,
	last_name ,
	salary,
	department 
	min(salary) OVER (PARTITION BY department),
	max(salary) OVER (PARTITION BY department)
FROM employees ;

-- common tables

WITH dep_avgs AS (
	SELECT 
		department,
		min(salary) AS min_salary,
		max(salary) AS max_salary
	FROM employees 
	GROUP BY department 
	)
SELECT 
	e.first_name,
	e.last_name,
	e.salary,
	e.department,
	dep_a.min_salary,
	dep_a.max_salary
FROM employees AS e
INNER JOIN dep_avgs AS dep_a
ON e.department = dep_a.department;