SELECT * FROM gin_indexes  WHERE json_gin->>'id' ='1';

SELECT * FROM gin_indexes  WHERE json_btree_padrao->>'id' ='1';

SELECT * FROM gin_indexes  WHERE json_vazio->>'id' ='1';

SELECT * FROM gin_indexes  WHERE json_btree->>'id' ='1';