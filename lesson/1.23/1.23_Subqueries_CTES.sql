-- Subquery
SELECT * 
FROM (
    SELECT * 
    FROM data_jobs.job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)
LIMIT 10;

-- CTE

WITH valid_salaries AS (
    SELECT * 
    FROM data_jobs.job_postings_fact
    WHERE salary_year_avg IS NOT NULL
        OR salary_hour_avg IS NOT NULL
)

SELECT * 
FROM valid_salaries
LIMIT 10;


-- Subquery in 'SELECT'
-- show each jobs salary next to the over all market median:

SELECT 
    job_title_short,
    salary_year_avg,
    (
        SELECT MEDIAN( salary_year_avg)
        FROM data_jobs.job_postings_fact
    ) AS market_median_salary
FROM data_jobs.job_postings_fact
WHERE salary_year_avg IS NOT NULL
LIMIT 10;



-- Subquery in 'FROM'
-- stage only jobs that are remote before aggregating to determine the remote median salary per jobs

SELECT 
    job_title_short,
    MEDIAN (salary_year_avg) AS median_salery,
    (
        SELECT MEDIAN( salary_year_avg)
        FROM data_jobs.job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary
FROM (
    SELECT
        job_title_short,
        salary_year_avg
    FROM data_jobs.job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs
WHERE salary_year_avg IS NOT NULL
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Subquery in 'HAVING'
-- keep only job title whose median salary is above the overall median

SELECT 
    job_title_short,
    MEDIAN (salary_year_avg) AS median_salery,
    (
        SELECT MEDIAN( salary_year_avg)
        FROM data_jobs.job_postings_fact
        WHERE job_work_from_home = TRUE
    ) AS market_remote_median_salary
FROM (
    SELECT
        job_title_short,
        salary_year_avg
    FROM data_jobs.job_postings_fact
    WHERE job_work_from_home = TRUE
) AS clean_jobs
WHERE salary_year_avg IS NOT NULL
GROUP BY 1
HAVING MEDIAN(salary_year_avg) > (
    SELECT MEDIAN( salary_year_avg)
    FROM data_jobs.job_postings_fact
    WHERE job_work_from_home = TRUE
)
ORDER BY 2 DESC
LIMIT 10;

-- CTE Example
-- compare how much more ( or less ) renote roles pay compared to onsite roles for each job title.
-- Use CTE to calculate the median salary by title and work arrangement, the compare the medians.

WITH title_median AS (
    SELECT 
        job_title_short,
        job_work_from_home,
        MEDIAN(salary_year_avg):: INT AS median_salary
    FROM data_jobs.job_postings_fact
    WHERE job_country = 'United States'
    GROUP BY 1, 2
)
SELECT
    r.job_title_short,
    r.median_salary AS remote_median_salry,
    o.median_salary AS onsite_median_salary,
    (r.median_salary - o.median_salary) AS remote_premium
FROM title_median AS r
INNER JOIN title_median AS o
    ON r.job_title_short = o.job_title_short
WHERE r.job_work_from_home = TRUE
    AND o.job_work_from_home = FALSE
ORDER BY remote_premium DESC;


-- Subquery Final example 

SELECT *
FROM range(3) AS src(key);

SELECT * 
FROM range(2) AS tgt(key);

SELECT *
FROM range(3) AS src(key)
WHERE EXISTS(
    SELECT 1
    FROM range(2) AS tgt(key)
    WHERE tgt.key = src.key
);

SELECT *
FROM range(3) AS src(key)
WHERE NOT EXISTS(
    SELECT 1
    FROM range(2) AS tgt(key)
    WHERE tgt.key = src.key
);

-- identify the job posting that have no associated skills before loading them into a data mart 
SELECT *
FROM job_postings_fact AS tgt
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS src
    WHERE tgt.job_id = src.job_id
)
ORDER BY job_id DESC;

SELECT *
FROM job_postings_fact AS tgt
WHERE EXISTS (
    SELECT 1
    FROM skills_job_dim AS src
    WHERE tgt.job_id = src.job_id
)
ORDER BY job_id DESC;