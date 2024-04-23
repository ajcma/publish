
-- Que the dataset
SELECT *
FROM job_postings_fact
LIMIT 10;



-- Just to extract the month of January
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 1
LIMIT 10;

-- Now just create a table to put into the sql_course database


-- January
CREATE TABLE january_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


SELECT job_posted_date
FROM march_jobs;

-- Now looking at CASE Expressions

SELECT  
    job_title_short,
    job_location
FROM job_postings_fact;

/*

Label new column called location_cateogry as follow:
-'Anywhere' jobs as 'Romote'
-'New York, NY' jobs as 'Local'
-Otherwise 'Onsite'
*/

SELECT  
    job_title_short,
    job_location,
    CASE    
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact;

-- now lets count them

SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE    
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
GROUP BY location_category;

-- let further refine the search to just 'Data Analyst'

SELECT 
    COUNT(job_id) AS number_of_jobs,
    CASE    
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY location_category;