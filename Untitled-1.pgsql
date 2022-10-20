/*What specialty should Maisy Smith consider getting?
 Look for the species she gets the most.*/

SELECT
COUNT(*), S.name
FROM join_visits visit
LEFT JOIN animals A ON visit.animals_id=A.id
LEFT JOIN join_specializations JS ON visit.vets_id=JS.vets_id
LEFT JOIN vets V ON visit.vets_id=V.id
LEFT JOIN species S ON A.species_id = S.id
WHERE V.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY count DESC LIMIT 1
;