SELECT * 
FROM employees

/*
 * Q1 a)
 */

SELECT 
E.first_name,
E.last_name,
T.name
FROM employees AS E
INNER JOIN teams AS T ON E.team_id = t.id; 

/*
 * Q1 b)
 */


SELECT
E.first_name,
E.last_name,
T.name,
E.pension_enrol 
FROM employees AS E
INNER JOIN teams AS T ON E.team_id = T.id
WHERE e.pension_enrol IS TRUE ;

/*
 * Q1 c)
 */


SELECT
E.first_name,
E.last_name,
T.name,
t.charge_cost AS charge_cost_over_80
FROM employees AS E
INNER JOIN teams AS T ON E.team_id = T.id
WHERE (CAST(T.charge_cost AS Integer)) >80
ORDER BY (T.charge_cost, T.name, E.last_name) ;

/*
 * Q2 a)
 */

-- I have 2 options as I'm unsure of the wording of the quesion
-- this was my initial answer
SELECT 
E.first_name,
E.last_name,
T.name AS team_name,
pd.local_account_no ,
pd.local_sort_code 
FROM employees AS E
LEFT JOIN pay_details AS pd ON E.id = pd.id
INNER JOIN teams AS T ON E.team_id = T.id 
ORDER BY (E.last_name) ;

-- however when i re-read the quesion I realised it said "all employee details" - so that's what I've done here
SELECT * FROM employees  AS E
LEFT JOIN pay_details AS pd ON E.id = pd.id
-- INNER JOIN teams AS T ON E.team_id = T.id 
ORDER BY (E.last_name) ;

/*
 * Q2 b)
 */

-- i aslo inadvertantly answwer this quesion in my first version, so here's the answer again.
SELECT 
E.first_name,
E.last_name,
T.name AS team_name,
pd.local_account_no ,
pd.local_sort_code 
FROM employees AS E
LEFT JOIN pay_details AS pd ON E.id = pd.id
INNER JOIN teams AS T ON E.team_id = T.id 
ORDER BY (E.last_name) ;

-- here's the alternative version for this question
SELECT * FROM employees  AS E
LEFT JOIN pay_details AS pd ON E.id = pd.id
INNER JOIN teams AS T ON E.team_id = T.id 
ORDER BY (E.last_name) ;

/*
 * Q3 a)
 */

SELECT
T.name AS team_name,
E.id ,
E.first_name,
E.last_name
FROM employees AS E
LEFT JOIN pay_details AS pd ON E.id = pd.id
INNER JOIN teams AS T ON E.team_id = T.id 
ORDER BY (T."name" ,E.last_name) ;

/*
 * Q3 b)
 */

SELECT
count(E.id) AS number_of_employees,
T.name AS team_name
FROM employees AS E
INNER JOIN teams AS T ON E.team_id = T.id 
GROUP BY t.name;

/*
 * Q3 c)
 */

SELECT
count(E.id) AS number_of_employees,
T.name AS team_name
FROM employees AS E
LEFT JOIN teams AS T ON E.team_id = T.id 
GROUP BY t.name
ORDER BY (number_of_employees) ;

/*
 * Q4 a)
 */

SELECT
count(E.id) AS number_of_employees,
T.name,
t.id
FROM employees AS E
LEFT JOIN teams AS T ON E.team_id = T.id 
GROUP BY t.name, t.id
ORDER BY t.name, t.id, number_of_employees ;

/*
 * Q4 b)
 */

SELECT
CAST(T.charge_cost AS Integer) * count(E.id) AS total_day_charge,
t.name,
t.id
FROM employees AS E
LEFT JOIN teams AS T ON E.team_id = T.id 
GROUP BY t.name, t.id
ORDER BY total_day_charge DESC ;

/*
 * Q4 c)
 */

SELECT
Cast(T.charge_cost AS integer)*count(E.id) AS total_day_charge,
T."name",
T.id
FROM employees AS E
LEFT JOIN teams AS T ON E.team_id  = T.id
GROUP BY T."name", T.id 
HAVING (Cast(T.charge_cost AS integer)*count(E.id)) > 5000;

-- Extension
-- Q5 a)

-- working out
SELECT * FROM employees_committees ;
SELECT * FROM committees  ;

-- more working out
SELECT
count(*) AS number_of_employees 
FROM employees AS E
INNER JOIN employees_committees AS EC ON E.id = EC.committee_id  
INNER JOIN committees AS CS ON EC.committee_id = CS.id 
WHERE EC.committee_id >= 1
-- GROUP BY (CS."name", EC.committee_id )
-- ORDER BY number_of_employees , CS."name";

-- some more working out
SELECT 
count(employee_id) AS number_of_employees
FROM employees_committees ;

-- THE ANSWER!!!!!
SELECT 
count(DISTINCT (employee_id)) AS number_of_employees
FROM employees_committees ;


-- working out or something
SELECT
count(E.id) AS number_of_employees,
CS."name" 
FROM employees AS E
INNER JOIN employees_committees AS EC ON E.id = EC.committee_id  
INNER JOIN committees AS CS ON EC.committee_id = CS.id 
GROUP BY (CS."name", EC.committee_id )
ORDER BY number_of_employees , CS."name";


-- JUST SOME WORKINGS

SELECT
count(E.id) AS number_of_employees
FROM employees AS E;


SELECT
	count(E.id) * CAST(T.charge_cost AS INTEGER) AS total_day_charge,
	T.name,
	T.id
FROM employees AS E 
LEFT JOIN teams AS T ON E.team_id = T.id
GROUP BY T.name, T.id;


SELECT
	count(E.id) AS employees_count,
	count(E.id) * CAST(T.charge_cost AS INTEGER) AS total_day_charge,
	T.charge_cost, 
	T.name,
	T.id
FROM employees AS E 
LEFT JOIN teams AS T ON E.team_id = T.id
GROUP BY T.name, T.id, T.charge_cost ;

SELECT
count(E.id) AS number_of_employees
E.id 
FROM employees AS E
INNER JOIN employees_committees AS EC ON E.id = EC.committee_id  
INNER JOIN committees AS CS ON EC.committee_id = CS.id 
GROUP BY (E.id ,number_of_employees)
ORDER BY E.id ,number_of_employees;




