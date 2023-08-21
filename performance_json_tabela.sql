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