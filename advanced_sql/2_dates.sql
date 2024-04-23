-- Query entire dataset

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AS job_posted_date
FROM   
    job_postings_fact
LIMIT 100;

-- Convert the time stamp to just date and remove the time

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date:: DATE AS date
FROM   
    job_postings_fact
LIMIT 100;

-- Converting the time zone

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time
FROM   
    job_postings_fact
LIMIT 100;


-- Extract to get a field

SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
    EXTRACT(MONTH FROM job_posted_date) AS date_month,
    EXTRACT(YEAR FROM job_posted_date) AS date_year
FROM   
    job_postings_fact
LIMIT 100;

-- Say you want to see trends from month to month

SELECT  
    job_id,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
LIMIT 100;

-- Say you want to see trends from month to month and now count the job_id

SELECT  
    COUNT(job_id),
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
GROUP BY 
    month
LIMIT 100;

-- Say you want to see trends from month to month and now count the job_id
-- Now only specify Data Analyst roles

SELECT  
    COUNT(job_id),
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    month
LIMIT 100;

-- Say you want to see trends from month to month and now count the job_id
-- Now only specify Data Analyst roles, also order by count and rename count column

SELECT  
    COUNT(job_id) AS job_posted_count,
    EXTRACT(MONTH FROM job_posted_date) AS month
FROM job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    month
ORDER BY
    job_posted_count DESC
LIMIT 100;