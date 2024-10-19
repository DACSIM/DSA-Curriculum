-- Hey all these are some leetcode style questions that I got asked during my interviews with tech companies!
-- Give them a shot and let me know if you find them difficult! :)

--------------------------------------------------------------------------------------------------------------------------------------------------

-- Q1: To finish a class, students must pass four exams (exam ids: 1,2,3 and 4).
-- Given a table exam_scores containing the data about all of the exams that students took, form a new table to track the scores for each student.
-- Note: Students took each exam only once.



/* 
Create the schema to store all your leetcode question

Create the table exam_scores
    student_id
    student_name
    exam_id
    score
*/

INSERT INTO .... (student_id, student_name, exam_id, score)
VALUES 
    (100, 'Anna', 1, 71),
    (100, 'Anna', 2, 72),
    (100, 'Anna', 3, 73),
    (100, 'Anna', 4, 74),
    (101, 'Brian', 1, 65);



--------------------------------------------------------------------------------------------------------------------------------------------------

-- Q2: Given a table called user_experiences, write a query to determine the percentage of users that held the title of “Data Analyst” 
-- immediately before holding the title “Data Scientist”.

--Immediate is defined as the user holding no other titles between the “Data Analyst” and “Data Scientist” roles.

/* 
Create the table user_experiences
    id
    position_name
    start_date
    end_date
    user_id
*/

INSERT INTO myownschema.user_experiences (id, position_name, start_date, end_date, user_id)
VALUES
    (1, 'Data Analyst', '2019-01-01 00:00:00', '2019-12-01 00:00:00', 1),
    (2, 'Data Scientist', '2019-12-01 00:00:00', '2021-07-01 00:00:00', 1),
    (3, 'Business Analyst', '2019-12-01 00:00:00', '2020-05-01 00:00:00', 3),
    (4, 'Data Analyst', '2020-05-01 00:00:00', '2022-01-01 00:00:00', 3),
    (5, 'Data Scientist', '2022-02-01 00:00:00', NULL, 3),
    (6, 'Data Analyst', '2021-01-01 00:00:00', NULL, 4),
    (7, 'ML Engineer', '2019-01-01 00:00:00', '2020-06-01 00:00:00', 5),
    (8, 'Data Scientist', '2019-01-01 00:00:00', '2019-11-01 00:00:00', 6);




--------------------------------------------------------------------------------------------------------------------------------------------------

-- Q3: The schema below is for a retail online shopping company consisting of two tables, attribution and user_sessions.
-- The attribution table logs a session visit for each row.
-- If conversion is true, then the user converted to buying on that session.
-- The channel column represents which advertising platform the user was attributed to for that specific session.
-- Lastly the user_sessions table maps many to one session visits back to one user.
-- First touch attribution is defined as the channel with which the converted user was associated when they first discovered the website.
-- Calculate the first touch attribution for each user_id that converted. 

-- Create the attribution table
CREATE TABLE myownschema.attribution (
    session_id INTEGER,
    channel VARCHAR(255),
    conversion BOOLEAN
);

-- Create the user_sessions table
CREATE TABLE myownschema.user_sessions (
    session_id INTEGER,
    created_at TIMESTAMP,
    user_id INTEGER
);

-- Insert data into the attribution table
INSERT INTO myownschema.attribution (session_id, channel, conversion)
VALUES 
    (1, 'facebook', TRUE),
    (2, 'google', FALSE),
    (3, 'facebook', FALSE),
    (4, 'organic', TRUE),
    (5, 'email', TRUE);

-- Insert data into the user_sessions table
INSERT INTO myownschema.user_sessions (session_id, created_at, user_id)
VALUES 
    (1, '2024-10-01 10:00:00', 123),
    (2, '2024-10-01 11:00:00', 145),
    (3, '2024-10-02 09:30:00', 153),
    (4, '2024-10-02 10:30:00', 172),
    (5, '2024-10-02 11:00:00', 173);


SELECT *
FROM myownschema.attribution;

SELECT *
FROM myownschema.user_sessions;

