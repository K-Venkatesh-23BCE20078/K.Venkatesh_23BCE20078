# delete , drop and truncate
show databases;
create database vit;
use vit;
show tables from vit;
drop table it;
desc cse;
alter table cse drop column s_country;

CREATE TABLE Worker (
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	FIRST_NAME CHAR(25),
	LAST_NAME CHAR(25),
	SALARY INT(15),
	JOINING_DATE DATETIME,
	DEPARTMENT CHAR(25)
);
use vit;
INSERT INTO Worker 
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'Monika', 'Arora', 100000, '14-02-20 09.00.00', 'HR'),
		(002, 'Niharika', 'Verma', 80000, '14-06-11 09.00.00', 'Admin'),
		(003, 'Vishal', 'Singhal', 300000, '14-02-20 09.00.00', 'HR'),
		(004, 'Amitabh', 'Singh', 500000, '14-02-20 09.00.00', 'Admin'),
		(005, 'Vivek', 'Bhati', 500000, '14-06-11 09.00.00', 'Admin'),
		(006, 'Vipul', 'Diwan', 200000, '14-06-11 09.00.00', 'Account'),
		(007, 'Satish', 'Kumar', 75000, '14-01-20 09.00.00', 'Account'),
		(008, 'Geetika', 'Chauhan', 90000, '14-04-11 09.00.00', 'Admin');
select * from worker;
show tables from vit;
delete from worker;
delete from worker where department = 'account';

truncate table worker;

use vit;
create table cse2(
	s_id int,
	name varchar(50)
);
start transaction;
insert into cse2 values (101,'jaya');
savepoint a11;
insert into cse2 values (102,'ali');
savepoint a22;
delete from cse2 where s_id = 101;
select * from cse2;
commit;
rollback to a11;

# operator logical and operator
select * from worker;
select first_name, department from worker where salary > 300000;
select worker_id, department from worker where salary < 150000;
select first_name, salary from worker where department = 'hr';
select first_name,worker_id from worker where salary >= 300000;
select first_name, department from worker where salary <= 150000;

select first_name from worker where salary>200000 and department='hr';
SELECT * FROM Worker WHERE SALARY < 200000 AND (DEPARTMENT ='HR' OR DEPARTMENT = 'Admin');
select * from worker where salary < 300000 and salary > 100000 and (department='Admin' or department='Account');

select * from worker where department in ('Admin','Accounts');
select * from worker where salary < 500000 and department in ('Admin','Accounts');
select * from worker where salary < 500000 and department not in ('hr');
select * from worker where worker_id % 2 =0 and department in ('hr','admin') order by salary desc limit 1;
