-- ======================================
-- SQL Tutorial Script 
-- Author: Atharva Kale
-- Purpose: Practice and reference SQL concepts
-- ======================================

-- ========================
-- DATABASE & BASIC TABLES
-- ========================
-- Use the 'college' database (make sure it exists)
create database college;
USE college;

-- Creating a simple 'student' table
CREATE TABLE student (
    roll_no INT,
    name VARCHAR(30),
    age INT
);

-- Inserting sample data into 'student'
INSERT INTO student VALUES
(101, "a", 24),
(102, "b", 25);

SELECT * FROM student;

-- ========================
-- DATABASE COMMANDS
-- ========================
CREATE DATABASE IF NOT EXISTS student;
CREATE DATABASE IF NOT EXISTS insta;

DROP DATABASE IF EXISTS student;
DROP DATABASE IF EXISTS insta;

SHOW DATABASES;

USE college;
SHOW TABLES;

-- ========================
-- INSTA DATABASE TABLES
-- ========================
USE insta;

-- Create 'user' table
CREATE TABLE user (
    id INT PRIMARY KEY,
    age INT,
    name VARCHAR(10) NOT NULL,
    email VARCHAR(20) UNIQUE,
    followers INT DEFAULT 0,
    following INT,
    CONSTRAINT age_check CHECK(age >= 13)
);

-- Create 'post' table
CREATE TABLE post (
    id INT PRIMARY KEY,
    content VARCHAR(100),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

-- Insert into 'user' table
INSERT INTO user (id, age, name, email, followers, following) VALUES
(1, 14, "adam", "adam@yahoo.in", 123, 24),
(2, 15, "bob", "bob123@gmail.com", 123, 35),
(3, 16, "case", "caeit@gmail.com", 200, 5),
(4, 17, "john", "john2004@gmail.com", 13, 30);

-- Attempting duplicate ID would give error (commented out)
-- INSERT INTO user (id, age, name) VALUES (2, 20, "random");

-- Select queries
SELECT id, age FROM user;
SELECT * FROM user;
SELECT DISTINCT age FROM user;

-- Insert into 'post'
INSERT INTO post (id, content, user_id) VALUES
(1, "hello world", 3),
(2, "byebyebye", 2),
(3, "foolforyou", 3);

SELECT * FROM post;

-- ========================
-- FILTERING AND CONDITIONS
-- ========================
SELECT * FROM user WHERE followers >= 200;

SELECT name, age, followers FROM user
WHERE age > 15 AND followers > 100;

SELECT name, age, followers FROM user
WHERE age > 15 OR followers > 200;

SELECT name, age, followers FROM user
WHERE age BETWEEN 15 AND 17;

SELECT name, age, followers FROM user
WHERE email IN ("adam@yahoo.in", "caeit@gmail.com");

SELECT name, age, followers FROM user
WHERE email NOT IN ("adam@yahoo.in", "caeit@gmail.com");

-- ========================
-- LIMIT & ORDER BY
-- ========================
SELECT * FROM user LIMIT 2;

SELECT * FROM user ORDER BY age DESC;

-- ========================
-- AGGREGATE FUNCTIONS
-- ========================
SELECT MAX(age) FROM user;
SELECT COUNT(age) FROM user WHERE age >= 15;
SELECT MIN(age) FROM user;
SELECT AVG(age) FROM user;
SELECT SUM(followers) FROM user;

-- GROUP BY & HAVING
SELECT age, MAX(followers) FROM user GROUP BY age;

SELECT age, MAX(followers) FROM user
GROUP BY age
HAVING MAX(followers) >= 100;

SELECT age, MAX(followers) FROM user
WHERE age > 14
GROUP BY age
HAVING MAX(followers) >= 100
ORDER BY age DESC;

-- ========================
-- UPDATE & DELETE
-- ========================
UPDATE user SET followers = 600 WHERE age = 16;

-- If MySQL throws error due to safe updates, run:
-- SET sql_safe_updates = 0;

DELETE FROM user WHERE age = 14;

-- ========================
-- ALTER TABLE OPERATIONS
-- ========================
ALTER TABLE user ADD COLUMN city VARCHAR(20) DEFAULT "mumbai";

ALTER TABLE user DROP age;

ALTER TABLE user RENAME TO instauser;
ALTER TABLE instauser RENAME TO user;

ALTER TABLE user CHANGE COLUMN followers subs INT DEFAULT 0;
ALTER TABLE user MODIFY subs INT DEFAULT 5;

-- Insert after schema change
INSERT INTO user (id, name, email, following) VALUES
(5, "jim", "jim@hotmail.com", 100);

-- DROP & TRUNCATE
DROP TABLE post;
TRUNCATE TABLE user;

-- ========================
-- PRACTICE QUESTIONS
-- ========================

-- Q1: College Teacher Table
CREATE DATABASE mycollege;
USE mycollege;

CREATE TABLE Teacher (
    id INT,
    name VARCHAR(20),
    subject VARCHAR(10),
    salary INT
);

INSERT INTO Teacher VALUES
(23, "ajay", "math", 50000),
(47, "bharat", "english", 60000),
(18, "chetan", "chemistry", 45000),
(23, "divya", "physics", 75000); -- duplicate id for testing

SELECT * FROM Teacher;

-- Salary queries
SELECT * FROM Teacher WHERE salary >= 55000;

-- Rename salary column to ctc
ALTER TABLE Teacher CHANGE COLUMN salary ctc INT DEFAULT 50000;

-- Apply 25% hike
UPDATE Teacher SET ctc = ctc + (ctc * 0.25);

ALTER TABLE Teacher ADD COLUMN city VARCHAR(20) DEFAULT "Gurgaon";

ALTER TABLE Teacher DROP ctc;

-- Q2: Student Table for Practice
CREATE TABLE student (
    roll_no INT,
    name VARCHAR(20),
    city VARCHAR(10),
    marks INT
);

INSERT INTO student (roll_no, name, city, marks) VALUES
(110, "adam", "Delhi", 76),
(108, "bob", "Mumbai", 65),
(124, "casey", "Pune", 94),
(112, "duke", "Pune", 80);

SELECT name, marks FROM student WHERE marks > 75;

SELECT DISTINCT city FROM student;

-- Max marks per city
SELECT city, MAX(marks) FROM student GROUP BY city;

-- Average marks
SELECT AVG(marks) FROM student;

-- Add Grade Column
ALTER TABLE student ADD COLUMN grade VARCHAR(2);

UPDATE student SET grade = "O" WHERE marks >= 80;
UPDATE student SET grade = "A" WHERE marks BETWEEN 70 AND 80;
UPDATE student SET grade = "B" WHERE marks BETWEEN 60 AND 70;

SELECT * FROM student;

-- ========================
-- END OF SCRIPT
-- ========================
