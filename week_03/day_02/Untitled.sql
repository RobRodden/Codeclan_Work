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

SELECT FROM