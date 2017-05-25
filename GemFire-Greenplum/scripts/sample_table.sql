drop table if exists basic;
create table basic (	
	id    bigint,
	col1 	text,
	col2	Int,
	col3    Varchar
) distributed by (id);		
 

INSERT INTO basic(id, col1, col2, col3)  VALUES (1, 'TEXT_1',  10, 'ABC');
INSERT INTO basic(id, col1, col2, col3)  VALUES (2, 'TEXT_2',  20, 'ABCD');
INSERT INTO basic(id, col1, col2, col3)  VALUES (4, 'TEXT_3',  30, 'ABCDE');
INSERT INTO basic(id, col1, col2, col3)  VALUES (5, 'TEXT_4',  40, 'ABCDEF');
INSERT INTO basic(id, col1, col2, col3)  VALUES (6, 'TEXT_5',  50, 'ABCDEFG');




