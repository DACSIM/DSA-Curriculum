CREATE TABLE myownschema.dsa_names (
    group_name VARCHAR(20),
    member_name VARCHAR(50)
);

-- Insert Group Members in a single query for each group
INSERT INTO myownschema.dsa_names (group_name, member_name) VALUES
('Group 1', 'Jaslene'),
('Group 1', 'Eugene'),
('Group 1', 'Shaun Tan'),
('Group 1', 'Harshini'),
('Group 1', 'Christopher'),
('Group 1', 'Elizabeth'),
('Group 2', 'Astrid'),
('Group 2', 'Elly'),
('Group 2', 'Ching Xi'),
('Group 2', 'Ajath'),
('Group 2', 'Ziyan'),
('Group 2', 'Syaziah'),
('Group 3', 'Shaniah'),
('Group 3', 'Shawn Kiswoto'),
('Group 3', 'Hwei Xin'),
('Group 3', 'Timothy'),
('Group 3', 'Jeriel'),
('Group 4', 'Elbert'),
('Group 4', 'Cheryl'),
('Group 4', 'Reina'),
('Group 4', 'Spencer'),
('Group 4', 'Guan Wei'),
('Group 5', 'Joline'),
('Group 5', 'Charmaine'),
('Group 5', 'Michelle'),
('Group 5', 'Yuxiang'),
('Group 5', 'Enriq'),
('Group 6', 'Tisya'),
('Group 6', 'Ephraim'),
('Group 6', 'Ignatius'),
('Group 6', 'Chloe'),
('Group 6', 'Parth');


SELECT 
    *,
    ROW_NUMBER() OVER(ORDER BY member_name) AS ranking
FROM myownschema.dsa_names

SELECT 
    *,
    ROW_NUMBER() OVER(PARTITION BY group_name ORDER BY member_name) AS ranking
FROM myownschema.dsa_names