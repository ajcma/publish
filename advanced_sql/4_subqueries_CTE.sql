

-- CREATING a temporary result set in another query to only select data from that table


SELECT *    
FROM  ( -- SubQuery starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1 
) AS january_jobs;
--SubQuery ends here

WITH january_jobs as ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) -- CTE definition ends here

SELECT *
from january_jobs;


-- Get a list of companys that don't require a degree

SELECT  
    company_id,
    job_no_degree_mention
FROM
    job_postings_fact
WHERE   
    job_no_degree_mention = true


-- Now lets make it into a subquery

SELECT
    company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN ( 
    SELECT  
        company_id
    FROM
        job_postings_fact
    WHERE   
        job_no_degree_mention = true
    ORDER BY
        company_id
)

-- Now lets look at this example
-- Using CTE or common table expression

/* 
Find the companies that have the most job openings.
- Get the total number of job postings per company id (job_posting_fact)
- Return the total number of jobs with the company name (company_dim)
*/


-- core statement inside the CTE
SELECT 
    company_id,
    COUNT(*)
FROM
    job_postings_fact
GROUP BY
    company_id

-- now the complete 


WITH company_job_count AS (
SELECT 
    company_id,
    COUNT(*)
FROM
    job_postings_fact
GROUP BY
    company_id
)

SELECT *
FROM company_job_count

-- Now lets include a CASE statement looking at the locations

SELECT
    job_title_short,
    job_location,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;


-- Now we can count and group them by different jobs
SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
GROUP BY
    location_category;

-- Further refining to just Data Analyst

SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE 
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category;


-- Now lets do a join

WITH company_job_count AS (
    SELECT 
        company_id,
        COUNT(*) AS total_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
)

SELECT company_dim.name AS company_name,
company_job_count.total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id
ORDER BY
    total_jobs DESC