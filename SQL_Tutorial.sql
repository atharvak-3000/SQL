use college;
create table student(
	roll_no INT,
    name varchar(30),
    age int
);

insert into student
values
(101,"a",24),
(102,"b",25);

select * from student;

create database if not exists student;
create database if not exists insta;

drop database if exists student;

drop database if exists insta;

show databases;
use college;
show tables;

-- table queries --
-- create table-- 
use insta;
create table user(
	id int primary key,
    age int,
    name varchar(10) not null,
    email varchar(20) unique,
    followers int default 0,
    following int ,
    constraint age_check check(age>=13)
);

create table post(
	id int primary key,
    content varchar(100),
    user_id int,
    foreign key (user_id) references user(id)
);


insert into user
(id,age,name,email,followers,following)
values
(1,14,"adam","adam@yahoo.in",123,24),
(2,15,"bob","bob123@gmail.com",123,35),
(3,16,"case","caeit@gmail.com",200,5),
(4,17,"john","john2004@gmail.com",13,30);


-- insert into user
-- (id,age,name)
-- values
-- (2,20,"random"); gives error as we are trying to duplicate value for id

-- select -- 
select id,age from user;
select * from user;
-- unique data
select distinct age from user;

-- entering data into post table
insert into post
(id,content,user_id)
values
(1,"hello world",3),
(2,"byebyebye",2),
(3,"foolforyou",3);

select * from post;

use insta;
select *
from user
where followers >=200;

-- operators
select name,age,followers
from user
where age>15 AND followers>100;

select name,age,followers
from user
where age>15 OR followers>200;

select name,age,followers
from user
where age between 15 and 17;


select name,age,followers
from user
where email in ("adam@yahoo.in","caeit@gmail.com");

select name,age,followers
from user
where email  not in ("adam@yahoo.in","caeit@gmail.com");

-- Limit
select * from user
limit 2;

-- order by
select  * from user
order by age desc;

-- aggreagate functions
select max(age)
from user;

select count(age)
from user
where age>=15;

select min(age)
from user;

select avg(age)
from user;

select sum(followers)
from user;

-- Group By
select age,max(followers)
from user
group by age;

-- having clause
select age,max(followers)
from user
group by age
having max(followers)>=100;

-- general order
select age,max(followers)
from user
where age>14
group by age
having max(followers)>=100
order by age desc;

-- Table Queries
-- UPDATE(rows)
update user
set followers = 600
where age = 16;
-- if there is an error try this
set sql_safe_updates = 0;

select * from user;

-- DELETE existing rows
delete from user
where age = 14;
select * from user;


-- Alter(change the schema(columns))
-- Add column
alter table user 
add column city varchar(20) default "mumbai";
select * from user; 

-- Drop column
alter table user
drop age;
select * from user;

-- rename table
alter table user
rename to instauser;
select * from instauser;

alter table instauser
rename to user;
select * from user;

-- rename columns
Alter table user
change column followers subs int default 0;
select * from user;

-- modify column
alter table user
modify subs int default 5;
select * from user;
-- inserting new data
insert into user
(id,name,email,following)
values 
(5,"jim","jim@hotmail.com",100);
select * from user;

-- truncate
drop table post;
truncate table user;
select * from user;

-- Practice qs
-- Create a database for your college 
-- create a table named teacher to store(id,anme,subject,salary)
create database mycollege;
use mycollege;
create table Teacher(
	id int,
    name varchar(20),
    subject varchar(10),
    salary int
); 
insert into Teacher
(id,name,subject,salary)
values
(23,"ajay","math",50000),
(47,"bharat","english",60000),
(18,"chetan","chemistry",45000),
(23,"divya","physics",75000);

select * from Teacher;

-- salary > 55k
select * from Teacher
where salary>=55000;

-- rename salary column to ctc
alter table Teacher
change column salary ctc int default 50000;

-- update salary as everyone got increment of 25 %
update Teacher
set ctc = ctc + (ctc*0.25);
select * from Teacher;

-- add new column for teachers city (default Gurgaon)
alter table Teacher
add column city varchar(20) default "Gurgaon"; 
select * from Teacher;

-- delete the salary column
alter table Teacher
Drop ctc;
select * from Teacher;


-- practice q 2
--  create a table to store student info(rool_no,name,city,marks)
create table student(
	roll_no int,
    name varchar(20),
    city varchar(10),
    marks int
);

insert into student
(roll_no,name,city,marks)
values
(110,"adam","Delhi",76),
(108,"bob","Mumbai",65),
(124,"casey","Pune",94),
(112,"duke","Pune",80);

-- all student marks > 75
select name,marks 
from student
where marks>75;

-- name of all cities where students are from
select distinct city
from student;

select city 
from student
group by city;

-- max marks of students from each city
select city,max(marks)
from student
group by city;

-- avg of the class
select avg(marks)
from student;

-- new column grade 
-- marks > 80 , grade=O
-- marks70=80 , grade = A
-- marks 60-70, grade = begin
alter table student
add column grade varchar(2);
update student
set grade = "O"
where marks>=80;
update student
set grade = "A"
where marks between 70 and 80;
update student
set grade = "B"
where marks between 60 and 70;
select * from student

