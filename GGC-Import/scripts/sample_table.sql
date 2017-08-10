drop table if exists basic;
create table basic (	
	id    bigint,
	name 	text,
	age		Int,
	createdDate TIMESTAMP,
	lastmodifiedDate TIMESTAMP
) distributed by (id);		
 
INSERT INTO basic(id, name, age, createdDate, lastmodifiedDate)  VALUES (1, 'John',  20, to_timestamp(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH:MI'), to_timestamp(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH:MI'));
INSERT INTO basic(id, name, age, createdDate, lastmodifiedDate)  VALUES (2, 'Alex',  21, to_timestamp(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH:MI'), to_timestamp(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH:MI'));
INSERT INTO basic(id, name, age, createdDate, lastmodifiedDate)  VALUES (3, 'Abc',  25, to_timestamp(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH:MI'), to_timestamp(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH:MI'));
INSERT INTO basic(id, name, age, createdDate, lastmodifiedDate)  VALUES (4, 'Zam',  44, to_timestamp(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH:MI'), to_timestamp(CURRENT_TIMESTAMP, 'YYYY/MM/DD HH:MI'));

DROP VIEW basicview;
CREATE VIEW basicview AS SELECT id, name, age, to_timestamp(createdDate, 'YYYY/MM/DD HH:MI') createdDate, to_timestamp(lastmodifiedDate, 'YYYY/MM/DD HH:MI') lastmodifiedDate from basic WHERE createdDate > now() - interval '8 hours';





