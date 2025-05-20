
create database fore;
use fore;
create table catogery(
	c_id int primary key,
    name varchar(50),
    category varchar(50)
);
insert into catogery values (101,'furniture','abcdef'),(102,'electronics','abs');
select * from catogery;
drop table catogery;

create table products (
	p_id int primary key,
    name varchar(50),
    color varchar(10),
    c_id int,
    nu int not null,
    foreign key products(c_id) references catogery(c_id) on update cascade
);
drop table products;
select * from products;
insert into products values (1,'wood', 'brown', 101,1001),(2,'nail','silver', 101,1002),(3,'disk','black',102,1003),(4,'moniter','balck',102,1004);
delete from catogery where c_id = 102;
delete from products where c_id = 101;

update catogery set c_id = 107 where c_id = 101;

create table constraints(
	id int primary key,
    def varchar(20),
    uni int unique,
    nu int not null,
    foreign key (nu) references products(nu)
);
drop table constraints;

insert into constraints values (1,'hari',101,1001),(2,'ali',102,1002),(3,'gani',103,1003);
alter table constraints add unique(nu);
alter table constraints add constraint hello unique (def,nu);
desc constraints;
alter table constraints drop index nu;

ALTER TABLE constraints ADD FOREIGN KEY (nu) REFERENCES products(nu);

alter table constraints drop primary key;
alter table constraints add constraint hello primary key(id,def);
alter table constraints add primary key(id);

create table t1(
	id int primary key,
    def varchar(20),
    uni int unique,
    nu int not null,
    check (nu<1005)
);
alter table t1 add check (nu<1005);
insert into t1 values (1,'hari',101,1001),(2,'ali',102,1002),(3,'gani',103,1003);
alter table t1 add (
	c1 varchar(10) default 'name'
);
alter table t1 drop column c1;
select * from t1;

