-- find the top 10 companies for posting jobs
-- they most have > 3000 postings
-- limit this only to us jobs

SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM 
    job_postings_fact AS jpf
LEFT JOIN 
    company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY 1
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC;

--  you can use the "EXPLAIN" or "EXPLAIN ANALYZE to explain the code structure

EXPLAIN
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM 
    job_postings_fact AS jpf
LEFT JOIN 
    company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY 1
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC;

EXPLAIN ANALYZE
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS posting_count
FROM 
    job_postings_fact AS jpf
LEFT JOIN 
    company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE jpf.job_country = 'United States'
GROUP BY 1
HAVING COUNT(jpf.job_id) > 3000
ORDER BY posting_count DESC;