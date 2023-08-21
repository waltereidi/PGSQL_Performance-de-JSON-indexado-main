
CREATE OR REPLACE PROCEDURE popular_teste_p() AS
	
	$body$
	DECLARE 
	iCount INTEGER :=0 ; 

	BEGIN 
		WHILE iCount < 1000000
		LOOP 
			INSERT INTO gin_indexes(json_btree , json_gin , json_vazio , json_btree_padrao )
			SELECT (SELECT row_to_json(j1)FROM ( SELECT  iCount AS id, random()::text AS descricao  , random()::text AS descricao2 , random()::text AS descricao3  ) AS j1),
			(SELECT row_to_json(j2)FROM ( SELECT  iCount AS id, random()::text AS descricao  , random()::text AS descricao2 , random()::text AS descricao3  ) AS j2),
			(SELECT row_to_json(j3)FROM ( SELECT  iCount AS id, random()::text AS descricao  , random()::text AS descricao2 , random()::text AS descricao3  ) AS j3), 
			(SELECT row_to_json(j4)FROM ( SELECT  iCount AS id, random()::text AS descricao  , random()::text AS descricao2 , random()::text AS descricao3  ) AS j4); 
			iCount := iCount + 1 ; 

		END LOOP;


	END; 
	$body$
	LANGUAGE plpgsql ; 

CREATE OR REPLACE PROCEDURE buscabtreepadrao_p() AS
	
	$body$
	DECLARE 
	iCount INTEGER := 0 ;
	rRecord RECORD ; 
	iTotalEncontrados INTEGER := 0 ; 
	BEGIN 

		WHILE iCount< 100 
		LOOP
			SELECT * FROM gin_indexes INTO rRecord WHERE json_btree_padrao->>'id' = iCount::text ; 

			IF rRecord.id IS NOT NULL THEN 
			iTotalEncontrados := iTotalEncontrados+1; 
			END IF; 
			iCount := iCount+1;

		
		END LOOP;

	END; 
	$body$
LANGUAGE plpgsql ; 
CREATE OR REPLACE PROCEDURE buscabtreeespecializado_p() AS
	
	$body$
	DECLARE 
	iCount INTEGER := 0 ;
	rRecord RECORD ; 
	iTotalEncontrados INTEGER := 0 ; 
	BEGIN 

		WHILE iCount< 100 
		LOOP
			SELECT * FROM gin_indexes INTO rRecord WHERE json_btree->>'id' = iCount::text ; 

			IF rRecord.id IS NOT NULL THEN 
			iTotalEncontrados := iTotalEncontrados+1; 
			END IF; 
			iCount := iCount+1;

		
		END LOOP;

	END; 
	$body$
LANGUAGE plpgsql ; 
CREATE OR REPLACE PROCEDURE buscagin_p() AS
	
	$body$
	DECLARE 
	iCount INTEGER := 0 ;
	rRecord RECORD ; 
	iTotalEncontrados INTEGER := 0 ; 
	BEGIN 

		WHILE iCount< 100 
		LOOP
			SELECT * FROM gin_indexes INTO rRecord WHERE json_gin->>'id' = iCount::text ; 

			IF rRecord.id IS NOT NULL THEN 
			iTotalEncontrados := iTotalEncontrados+1; 
			END IF; 
			iCount := iCount+1;

		
		END LOOP;

	END; 
	$body$
LANGUAGE plpgsql ; 
CREATE OR REPLACE PROCEDURE buscasemindex_p() AS
	
	$body$
	DECLARE 
	iCount INTEGER := 0 ;
	rRecord RECORD ; 
	iTotalEncontrados INTEGER := 0 ; 
	BEGIN 

		WHILE iCount< 100 
		LOOP
			SELECT * FROM gin_indexes INTO rRecord WHERE json_vazio->>'id' = iCount::text ; 

			IF rRecord.id IS NOT NULL THEN 
			iTotalEncontrados := iTotalEncontrados+1; 
			END IF; 
			iCount := iCount+1;

		
		END LOOP;

	END; 
	$body$
LANGUAGE plpgsql ; 
