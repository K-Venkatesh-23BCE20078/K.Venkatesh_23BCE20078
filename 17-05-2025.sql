show databases;
create dAtABAse vIT_bHOPAL;
show tables from mysql;
drop database vit_bhopal;
use mysql;
create table it(
s_id int,
s_name varchar(40),
s_rank int,
s_pen int
);
drop table it;
insert into it values(101,'adhi',89,16),(102,'ali',80,17),(103,'hlo',90,16),
(104,'ho',99,16),(105,'gani',70,17),(106,'koi',90,19),(107,'kalo',85,16),(108,'kani',91,16),(109,'rani',70,19);

create table mech(
s_id int,
s_name varchar(40),
s_mark int,
s_age int
);
drop table mech;
insert into mech values(101,'adhi',89,16),(102,'ali',80,17),(103,'hlo',90,16),
(104,'ho',99,16),(105,'gani',70,17),(106,'koi',90,19),(107,'kalo',85,16),(108,'kani',91,16),(109,'rani',70,19);

create table cse(
s_id int,
s_name varchar(40),
s_mark int,
s_age int
);
drop table cse;
insert into cse values(101,'adhi',89,16),(102,'ali',80,17),(103,'hlo',90,16),
(104,'ho',99,16),(105,'gani',70,17),(106,'koi',90,19),(107,'kalo',85,16),(108,'kani',91,16),(109,'rani',70,19);

select * from cse;

alter table cse add(
	s_address varchar(200)
);
alter table cse add(
	s_merit varchar(10),
    s_class varchar(10)
);
alter table cse drop column s_class;
alter table cse add(
	s_country varchar(100) default 'India'
);

update cse set s_mark = 100 where s_id=101;

update cse set s_mark = s_mark+50;