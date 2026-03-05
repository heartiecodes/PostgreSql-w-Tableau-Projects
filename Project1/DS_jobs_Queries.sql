-- Find out which job titles actually pay the highest. --

SELECT 
    job_title, 
    ROUND(AVG(avg_salary_k), 2) as avg_salary_thousand_usd,
    COUNT(*) as job_count
FROM ds_jobs_cleaned
GROUP BY job_title
HAVING COUNT(*) > 5
ORDER BY avg_salary_thousand_usd DESC;




-- Prove which skills (Python, SQL, etc.) are most requested by employers.--
SELECT 
    ROUND(AVG(python_yn) * 100, 2) as python_pct,
    ROUND(AVG(sql_yn) * 100, 2) as sql_pct,
    ROUND(AVG(excel_yn) * 100, 2) as excel_pct,
    ROUND(AVG(tableau_yn) * 100, 2) as tableau_pct
FROM ds_jobs_cleaned;



-- Find out which states have the most jobs and the best pay. --
SELECT 
    job_state, 
    COUNT(*) as number_of_jobs,
    ROUND(AVG(avg_salary_k), 2) as avg_salary_k
FROM ds_jobs_cleaned
WHERE job_state IS NOT NULL AND job_state != ''
GROUP BY job_state
ORDER BY number_of_jobs DESC
LIMIT 10;





-- checks if highly-rated companies (4 stars and up) pay more than lower-rated companies. --
SELECT 
    CASE 
        WHEN rating >= 4.0 THEN 'High Rating (4.0 - 5.0)'
        WHEN rating >= 3.0 THEN 'Medium Rating (3.0 - 3.9)'
        ELSE 'Low/No Rating'
    END AS company_tier,
    COUNT(*) AS number_of_jobs,
    ROUND(AVG(avg_salary_k), 2) AS avg_salary_k
FROM ds_jobs_cleaned
WHERE rating > 0 -- Exclude rows where rating is -1 (unknown)
GROUP BY 1
ORDER BY avg_salary_k DESC;




-- Salary difference between jobs that require Python versus those that only require Excel. --
SELECT 
    CASE 
        WHEN python_yn = 1 AND excel_yn = 0 THEN 'Python, No Excel'
        WHEN python_yn = 0 AND excel_yn = 1 THEN 'Excel, No Python'
        WHEN python_yn = 1 AND excel_yn = 1 THEN 'Both Skills'
        ELSE 'Neither'
    END AS skill_set,
    COUNT(*) AS job_count,
    ROUND(AVG(avg_salary_k), 2) AS avg_salary_k
FROM ds_jobs_cleaned
GROUP BY 1
ORDER BY avg_salary_k DESC;



-- Identify which industries (like Finance, Health Care, or Tech) are hiring the most and paying the best. --
SELECT 
    industry, 
    COUNT(*) as job_count,
    ROUND(AVG(avg_salary_k), 2) as avg_salary
FROM ds_jobs_cleaned
WHERE industry != '-1' -- Filter out unknown industries
GROUP BY industry
HAVING COUNT(*) > 5 -- Only show industries with enough data to be significant
ORDER BY avg_salary DESC;



-- Company Age vs. Innovation Do older, established companies pay better than young startups? --
SELECT 
    CASE 
        WHEN company_age < 10 THEN 'Startup (<10 yrs)'
        WHEN company_age BETWEEN 10 AND 30 THEN 'Established (10-30 yrs)'
        WHEN company_age > 30 THEN 'Legacy (>30 yrs)'
        ELSE 'Unknown'
    END AS company_type,
    COUNT(*) AS job_count,
    ROUND(AVG(avg_salary_k), 2) AS avg_salary_k
FROM ds_jobs_cleaned
WHERE company_age IS NOT NULL
GROUP BY 1
ORDER BY avg_salary_k DESC;