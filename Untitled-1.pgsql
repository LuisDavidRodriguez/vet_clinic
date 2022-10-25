-- CREATE INDEX animals_id_desc ON join_visits(animals_id DESC);
-- explain analyze SELECT COUNT(*) FROM join_visits where animals_id = 4;

-- CREATE INDEX vets_id_desc ON join_visits(vets_id DESC);
-- explain analyze SELECT * FROM join_visits where vets_id = 2;

-- CREATE INDEX owners_email_desec ON owners(email DESC);
-- explain analyze SELECT * FROM owners where email = 'owner_18327@mail.com';
-- DROP INDEX owners_email_desec;