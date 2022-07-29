/*
*
*/

-- Your manager comes to you and says:

/*
 * i was talking with a collueage from greece last month and i can't remember their last name exaclty i think it begane with "mc" can you find them
 * 
 */

SELECT  *
FROM employees 
WHERE (country = 'Greece') AND (last_name LIKE 'Mc%');

/*
 * Wildcards
 * _ a single character
 * % matches zero or more characters
 */

SELECT *
FROM employees
WHERE last_name LIKE '%ere%';

-- can pop wildcards anywhere inside the pattern

-- Find all employees with last names containing the phrase 'ere'

SELECT *
FROM employees 
WHERE last_name LIKE '%ere%';

/*
 * Like is case sensitive (distinguishes between lowercase and uppercase)
 */

SELECT *
FROM employees 
WHERE last_name LIKE 'D%';
  -- can use ILike to be insensitive to upper / lowere case letters

SELECT *
FROM employees 
WHERE last_name ILIKE 'D%';

-- ~ to define a regex pattern match

--  find all employees for whom the secnond letter of their last name 
-- is 'r' or 's' and the third letter is 'a' or 'o'

SELECT *
FROM employees 
WHERE last_name ~ '^.[rs][ao]';


-- regex tweaks
/*
 * ~ ----define a regex
 * ~* ---- define a case-insensiteve regex
 * !~ ---- define a negative regex (case sensitive does not match)
 * !~* -- case insensitive does not match
 */

SELECT*
FROM employees
WHERE last_name !~ '^.[rs][ao]';

/*
 * is Null
 */

SELECT *
FROM employees 
WHERE email IS NULL;

-- little gotcha column IS NULL, not column = NULL, similar to is.na() iin R
