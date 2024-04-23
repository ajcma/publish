/* 
Find job postings from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan-Mar)
- Gets job postings with an average yearly salary > $70,000
*/


-- lets first get the entire quarter of data

SELECT *
FROM january_jobs
UNION ALL
SELECT *
FROM february_jobs
UNION ALL
SELECT *
FROM march_jobs


-- now lets create a CTE

SELECT *
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_jobs_postings

-- Now lets define the 4 main columns b/c there is to many


SELECT 
    quarter1_jobs_postings.job_title_short,
    quarter1_jobs_postings.job_location,
    quarter1_jobs_postings.job_via,
    quarter1_jobs_postings.job_posted_date::date
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_jobs_postings



-- Lets further refine the data. 

SELECT 
    quarter1_jobs_postings.job_title_short,
    quarter1_jobs_postings.job_location,
    quarter1_jobs_postings.job_via,
    quarter1_jobs_postings.job_posted_date::date,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_jobs_postings
WHERE 
    quarter1_jobs_postings.salary_year_avg > 70000 AND
    quarter1_jobs_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_jobs_postings.salary_year_avg DESC

-- Optional to remove the extra fluff

SELECT 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::date,
    salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_jobs_postings
WHERE 
    salary_year_avg > 70000 AND
    job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC