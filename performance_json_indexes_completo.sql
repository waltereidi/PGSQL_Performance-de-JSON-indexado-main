CREATE EXTENSION btree_gin;
CREATE EXTENSION jsquery;

CREATE SEQUENCE IF NOT EXISTS gin_indexes_seq; 

CREATE TABLE IF NOT EXISTS gin_indexes(
	id BIGINT DEFAULT nextval('gin_indexes_seq'::regclass) , 
	json_btree JSONB , 
	json_gin JSONB , 
	json_vazio JSONB ,
	json_btree_padrao JSONB , 
	CONSTRAINT gin_indexes_pkey PRIMARY KEY (id) 

	);
CREATE INDEX IF NOT EXISTS json_btree ON gin_indexes USING btree((json_btree ->> 'id' )) ;
CREATE INDEX IF NOT EXISTS json_gin ON gin_indexes USING gin( json_gin jsonb_path_ops ); 
CREATE INDEX IF NOT EXISTS json_btree_padrao ON gin_indexes USING btree(json_btree_padrao); 


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
