-- inner join implies at least a 1-1 or a 1- many

SELECT *
FROM animals
INNER JOIN ON animals.diet_id = diets.id

SELECT animals.*,
diets.*
FROM animals AS A
INNER JOIN ON diets AS A.diet.id = D.id

SELECT A.name, A.species,
D.diet_type
FROM Animals AS A
INNER JOIN diets AS D ON A.diet_id = D.id
WHERE A. age> 4

-- count the animals in the zoo group by diet type 

SELECT * FROM animals AS A
INNER JOIN diets AS D ON A.diet_id  = D.id ;

SELECT count(a.id), D.diet_type  
FROM animals AS A
INNER JOIN diets AS D ON A.diet_id  = D.id 
GROUP BY D.diet_type

-- MODIFY the above to return all Herbivores ONLY 

SELECT count(a.id), D.diet_type  
FROM animals AS A
INNER JOIN diets AS D ON A.diet_id  = D.id 
WHERE D.diet_type = 'herbivore'
GROUP BY D.diet_type

SELECT count(a.id), A.species ,D.diet_type  
FROM animals AS A
INNER JOIN diets AS D ON A.diet_id  = D.id 
WHERE D.diet_type = 'herbivore'
GROUP BY A.species ,D.diet_type

SELECT a.name,a.species, a.age, d.diet_type
FROM animals AS A
INNER JOIN diets AS D ON A.diet_id  = D.id 

SELECT 
a.name,
a.species, 
a.age, 
d.diet_type
FROM animals AS A
LEFT JOIN diets AS D ON A.diet_id  = D.id 

SELECT 
a.name,
a.species, 
a.age, 
d.diet_type
FROM animals AS A
RIGHT JOIN diets AS D ON A.diet_id  = D.id 

-- return how many animals follwo each diet type, including any diets which no animals FOLLOW

SELECT count(a.id), D.diet_type  
FROM animals AS A
RIGHT JOIN diets AS D ON A.diet_id  = D.id 
GROUP BY D.diet_type

SELECT count(a.id), D.diet_type  
FROM animals AS A
LEFT JOIN diets AS D ON A.diet_id  = D.id 
GROUP BY D.diet_type

-- Full JOIN brings back all records in both tables

SELECT a.name, a.species, a.age, D.diet_type  
FROM animals AS A
FULL JOIN diets AS D ON A.diet_id  = D.id 

-- get a rota for the keepers and the animals they look AFTER 
SELECT *
FROM animals AS A
INNER JOIN care_schedule AS cs ON a.id = cs.animal_id 
INNER JOIN keepers AS K ON k.id = cs.keeper_id 
ORDER BY a.name, cs.DAY

SELECT a."name" AS animal_name,
a.species,
cs."day",
k."name" AS keeper_name
FROM animals AS A
INNER JOIN care_schedule AS cs ON a.id = cs.animal_id 
INNER JOIN keepers AS K ON k.id = cs.keeper_id 
ORDER BY a.name, cs.DAY

-- for the above change to show me the keep for ernest the skanke

SELECT a.name AS animal_name,
a.species,
k."name" AS keeper_name
FROM animals AS A
INNER JOIN care_schedule AS cs ON a.id = cs.animal_id 
INNER JOIN keepers AS K ON k.id = cs.keeper_id 
WHERE species = 'Snake'
ORDER BY cs.DAY, a.name

SELECT a.name AS animal_name,
a.species,
k."name" AS keeper_name
FROM (animals AS A
INNER JOIN care_schedule AS cs ON a.id = cs.animal_id) 
INNER JOIN keepers AS K ON k.id = cs.keeper_id 
WHERE a.name LIKE '%rne%'
AND a.species IN ('Snake')
ORDER BY cs.DAY, a.name

-- Various animals feature on various tours around the zoo (this is another example of a many-to-many relationship).

-- Identify the join table linking the animals and tours table and reacquaint yourself with its contents.

-- Obtain a table showing animal name and species, the tour name on which they feature(d), 
-- along with the start date and end date (if stored) of their involvement. 
-- Order the table by tour name, and then by animal name.
-- [Harder] - can you limit the table to just those animals currently featuring on tours. Perhaps the NOW() function might help? Assume an animal with a start date in the past and either no stored end date or an end date in the future is currently active on a tour.

SELECT a.name AS animal_name,
a.species,
t.name AS tour_name,
AT.start_date,
AT.end_date
FROM animals AS A
INNER JOIN animals_tours AS AT ON a.id = AT.animal_id
INNER JOIN tours AS T ON T.id = AT.tour_id
ORDER BY tour_name, animal_name 

SELECT a."name" AS animal_name,
a.species,
t.name AS tour_name,
att.start_date,
att.end_date
FROM animals AS A
INNER JOIN animals_tours AS att ON a.id = att.animal_id
INNER JOIN tours AS T ON att.tour_id = T.id
WHERE att.start_date <= NOW()
AND (att.end_date >= NOW() -- evaluates AS 1 CONDITION because it's in IN brackets()
OR att.end_date IS NULL) 
ORDER BY t.name, a.name 

SELECT * FROM keepers 
INNER JOIN keepers AS managers ON keepers.manager_id = managers.id 

SELECT keepers.name AS keeper_name,
managers.name AS manager_name
FROM keepers 
INNER JOIN keepers AS managers ON keepers.manager_id = managers.id 

SELECT * FROM animals 
-- 100 where conditions
UNION -- eliminates duplicates
SELECT * FROM animals 


-- union all brings back duplicas
SELECT * FROM animals 
-- 100 where conditions
UNION ALL 
SELECT * FROM animals 

-- grafana powerful graphics package
-- data analytics and SSRS (SQL Studion Reporting Services)
