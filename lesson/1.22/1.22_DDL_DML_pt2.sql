-- .read 'lesson\1.22\1.22_DDL_DML_pt2.sql'
-- CTAS
CREATE OR REPLACE TABLE staging.job_postings_flat AS 
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id;


SELECT COUNT(*) 
FROM staging.job_postings_flat
LIMIT 10;

-- VIEW
CREATE OR REPLACE VIEW staging.prirority_jobs_flat_view AS  
SELECT 
    jpf.* 
FROM staging.job_postings_flat AS jpf
JOIN staging.prirority_roles AS r
    ON jpf.job_title_short = r.role_name
WHERE r.prirority_lvl =  1;

SELECT
    job_title_short,
    COUNT(*) AS job_count
FROM staging.prirority_jobs_flat_view
GROUP BY job_title_short
ORDER BY job_count DESC;


-- TEMP TABLE
CREATE TEMPORARY TABLE senior_jobs_flat_temps AS 
SELECT * 
FROM staging.prirority_jobs_flat_view
WHERE job_title_short = 'Senior Data Engineer';

SELECT
    job_title_short,
    COUNT(*) AS job_count
FROM senior_jobs_flat_temps
GROUP BY job_title_short
ORDER BY job_count DESC;

SELECT COUNT(*) FROM staging.prirority_jobs_flat_view;
SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM senior_jobs_flat_temps;

-- DELETE

DELETE FROM staging.job_postings_fact
WHERE job_posted_date < '2024-01-01';

SELECT COUNT(*) FROM staging.prirority_jobs_flat_view;
SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM senior_jobs_flat_temps;

-- TRUNCATE 

TRUNCATE TABLE staging.job_postings_flat;

INSERT INTO staging.job_postings_flat
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name AS company_name
FROM data_jobs.job_postings_fact AS jpf
LEFT JOIN data_jobs.company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE job_posted_date >= '2024-01-01';


SELECT COUNT(*) FROM staging.prirority_jobs_flat_view;
SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM senior_jobs_flat_temps;
