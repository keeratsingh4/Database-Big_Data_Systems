-- (1) Complex-type table creation
CREATE TABLE IF NOT EXISTS employees ( 
  emp_id STRING, 
  full_name STRING, 
  skills ARRAY<STRING> 
) 
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|' 
COLLECTION ITEMS TERMINATED BY ',';

-- (2) Staging table creation
CREATE TABLE IF NOT EXISTS employees_staging ( 
  emp_id STRING, 
  full_name STRING, 
  raw_projects STRING, 
  raw_skills STRING 
) 
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|';

-- (3) Insert raw data into staging table
INSERT INTO employees_staging VALUES 
('007', 'James Bond', 'DB/3:30,Oracle:25,SQL-2022:100', 'Java,C,C++'), 
('008', 'Harry Potter', 'DB/3:70,Oracle:75', ''), 
('010', 'Robin Banks', '', 'C,Rust'), 
('009', 'Robin Hood', '', ''), 
('011', 'Tony Stark', 'AI-Core:80,Weapons:20', 'Python,Scala');

-- (4) Create employee_projects table for storing individual project data
CREATE TABLE IF NOT EXISTS employee_projects (
  emp_id STRING,
  project_name STRING,
  project_score INT
);

-- (5) Insert exploded project data into employee_projects table
INSERT INTO employee_projects
SELECT
  emp_id,
  split(entry, ':')[0] AS project_name,
  CAST(split(entry, ':')[1] AS INT) AS project_score
FROM employees_staging
LATERAL VIEW explode(split(raw_projects, ',')) exploded_project AS entry;

-- (6) Insert parsed data into employees table
INSERT INTO employees 
SELECT 
  emp_id, 
  full_name, 
  split(raw_skills, ',') as skills 
FROM employees_staging;