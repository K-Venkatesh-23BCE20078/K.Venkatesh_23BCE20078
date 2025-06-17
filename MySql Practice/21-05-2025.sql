show databases;
show tables from vit;
use vit;
select * from worker;

select * from worker where salary between 75000 and 100000;
select * from worker where salary not between 75000 and 100000;
# 'between' key has included both boiundary values
select * from worker where salary between 75000 and 100000 and department not in ('account','hr');

select min(salary) from worker;
select max(salary) from worker;
select count(salary) from worker;
select avg(salary) from worker;
select sum(salary) from worker;

select distinct department from worker;

create table w2 like worker;
insert into w2 select * from worker;
select department from worker
union
select department from w2;

select department from worker
union all
select department from w2;

select department from worker
where salary>100000
union all
select department from w2
where worker_id between 5 and 8;

SELECT first_name,salary,
CASE
    WHEN salary > 3000000 THEN 'rich people'
    when salary between 100000 and 300000 then 'middle layer'
    WHEN Salary between 10000 and 100000 then 'poor people'
    ELSE 'no data'
END 
AS status
FROM worker;

select * from worker where salary < 200000 order by salary desc;
select * from worker order by first_name asc, last_name desc;

select * from worker where first_name like '%a%';
select * from worker where first_name like '%a_';
select * from worker where first_name like 'ai%';
select * from worker where first_name like '%h_l';
select * from worker where first_name like '[a-z]%';

create view admin_team as select * from worker where department = 'admin' and salary<200000;
create view hr_team as select * from worker where department = 'hr' and salary<200000;
create view account_team as select * from worker where department = 'account' and salary<200000;
select * from admin_team;

drop view admin_team;

create or replace view admin_team_re as select * from worker where department = 'admin' and salary<200000;
select * from admin_team_re