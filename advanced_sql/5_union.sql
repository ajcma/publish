-- Get jobs and companies from January

SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    january_jobs

-- now lets union it with february


SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    february_jobs


-- Repeat that for all the months

SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    january_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    february_jobs

UNION

SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    march_jobs


-- Now with UNION ALL which returns all even with duplicates


SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    january_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    february_jobs

UNION ALL

SELECT
    job_title_short,
    company_id,
    job_location
FROM   
    march_jobs


