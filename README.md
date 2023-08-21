# Performance de JSON indexado
 Testes de performance em buscas de JSON indexados

O postgresql quando faz pesquisas do tipo JSON dá a entender que é ineficaz e até uma pratica que deve ser evitada,
porém adicionar um index especializado para identificar qual deve ser o campo chave do JSON torna o banco muito eficaz para relizar consultas.
O index padrão não resolve este problema, deve-se atentar a este detalhe , que mesmo o JSON possuíndo uma estrutura flexivel para ser armazenada padroniza-la e identar corretamente com um index traz a possibilidade de realizar buscas de forma eficaz.

Praticas como TIPOS compostos para estruturar o JSON resolvem grandes problemas de padronização.

RESULTADOS : 

--Index Btree com especialização para o JSON , identificando a coluna JSON mais o atributo do JSON que deverá ser indexado
SELECT * FROM gin_indexes  WHERE json_btree->>'id' ='1';
/* Result: "1 rows returned (execution time: 0 ms; total time: 47 ms)" */

--Index do tipo GIN com especificação JSON mas sem identificação de colunas
SELECT * FROM gin_indexes  WHERE json_gin->>'id' ='1';
/* Result: "1 rows returned (execution time: 3.140 sec; total time: 3.156 sec)" */

--Index do tipo Btree padrão , apenas especificando a coluna que vai receber o index
SELECT * FROM gin_indexes  WHERE json_btree_padrao->>'id' ='1';
/* Result: "1 rows returned (execution time: 3.078 sec; total time: 3.094 sec)" */

--Coluna sem index.
SELECT * FROM gin_indexes  WHERE json_vazio->>'id' ='1';
/* Result: "1 rows returned (execution time: 3.250 sec; total time: 3.281 sec)" */

