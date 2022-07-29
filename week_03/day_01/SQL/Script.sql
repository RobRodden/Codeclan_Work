?*
* this IS a multiline
* COMMENT
*/


-- This is an inline comment

-- Get me a table of all the animals information

-- SELECT = columns to select
--FROM = TABLE / ENTITIY TO SELECT FROM 
-- ; = END OF QUERY

SELECT *
FROM animals
WHERE id = 2

-- Taks: Get me a table of information about Ernest the Snake

SELECT *
FROM animals
WHERE "name" = 'ernest' AND species = 'snake'

little note, becuase we're filtering on a pk (primary key), we should only expect 1 row

SELECT *
FROM animals

