SELECT
    table_name, 
    column_name, 
    data_type
FROM information_schema.columns
WHERE table_name = 'job_postings_fact';

-- CASTING ( change a data type using cast function)
SELECT CAST(123 AS VARCHAR); 

SELECT CAST('123' AS INTEGER); 

SELECT 
    CAST(job_id AS VARCHAR) || '-' || CAST(company_id AS VARCHAR) AS ID, -- more unique identifier
    CAST(job_work_from_home AS INTEGER) AS job_work_from_home, -- From boolean to integer
    CAST(job_posted_date AS date) AS job_posted_date, -- From Timestamp to date only 
    CAST(salary_year_avg AS DECIMAL(10, 0)) AS salary_year_avg -- from double to no decimal place
FROM 
    job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;

--  OR 

SELECT 
    job_id::VARCHAR || '-' || company_id::VARCHAR AS ID, -- more unique identifier
    job_work_from_home::INTEGER AS job_work_from_home, -- From boolean to integer
    job_posted_date::date AS job_posted_date, -- From Timestamp to date only 
    salary_year_avg::DECIMAL(10, 0) AS salary_year_avg -- from double to no decimal place
FROM 
    job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;


