/*Who owns the most animals?*/
/*First way*/
SELECT O.full_name, COUNT(*)
FROM owners O
JOIN animals A ON O.id = A.owner_id
GROUP BY O.full_name
ORDER BY count DESC LIMIT 1;
