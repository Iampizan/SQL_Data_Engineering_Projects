-- left join
SELECT 
    jpf.*,
    cd.*
FROM 
    job_postings_fact AS jpf
LEFT JOIN 
    company_dim AS cd
ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT 
    jpf.job_title_short,
    jpf.job_id,
    cd.name AS company_name,
    cd.company_id
FROM 
    job_postings_fact AS jpf
LEFT JOIN 
    company_dim AS cd
ON jpf.company_id = cd.company_id
LIMIT 10;

SELECT 
    COUNT(*)
FROM 
    job_postings_fact;

-- right join 

SELECT 
    jpf.job_title_short,
    jpf.job_id,
    cd.name AS company_name,
    cd.company_id
FROM 
    job_postings_fact AS jpf
RIGHT JOIN 
    company_dim AS cd
ON jpf.company_id = cd.company_id
LIMIT 10;

-- Inner join

SELECT 
    jpf.job_title_short,
    jpf.job_id,
    cd.name AS company_name,
    cd.company_id
FROM 
    job_postings_fact AS jpf
INNER JOIN 
    company_dim AS cd
ON jpf.company_id = cd.company_id
LIMIT 10;

        -- OR

SELECT 
    jpf.job_title_short,
    jpf.job_id,
    cd.name AS company_name,
    cd.company_id
FROM 
    job_postings_fact AS jpf
JOIN 
    company_dim AS cd
ON jpf.company_id = cd.company_id
LIMIT 10;


-- Full join

SELECT 
    jpf.job_title_short,
    jpf.job_id,
    cd.name AS company_name,
    cd.company_id
FROM 
    job_postings_fact AS jpf
FULL JOIN 
    company_dim AS cd
ON jpf.company_id = cd.company_id;
