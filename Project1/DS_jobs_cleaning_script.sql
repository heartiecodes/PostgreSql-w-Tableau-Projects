-- Creating table --

CREATE TABLE ds_jobs_raw (
    index_col INT,
    job_title TEXT,
    salary_estimate TEXT,
    job_description TEXT,
    rating NUMERIC,
    company_name TEXT,
    location_val TEXT,
    headquarters TEXT,
    size_val TEXT,
    founded INT,
    type_of_ownership TEXT,
    industry TEXT,
    sector TEXT,
    revenue TEXT,
    competitors TEXT
);


-- Checking the table of the imported CSV files --
SELECT * FROM ds_jobs_raw LIMIT 10;




CREATE TABLE ds_jobs_cleaned AS
WITH base_cleaning AS (
    SELECT 
        -- 1. Clean Company Name (Removes the rating suffix)
        CASE 
            WHEN rating < 0 THEN company_name 
            ELSE SPLIT_PART(company_name, E'\n', 1) 
        END AS company_name,
        
        -- 2. Extract City and State
        SPLIT_PART(location_val, ', ', 1) as job_city,
        SPLIT_PART(location_val, ', ', 2) as job_state,

        -- 3. Advanced Salary Cleaning using Regex
        -- This strips everything except numbers and the dash
        REGEXP_REPLACE(salary_estimate, '[^0-9-]', '', 'g') as salary_numbers,

        -- Pass through other columns
        job_title, job_description, rating, size_val, founded, 
        type_of_ownership, industry, sector, revenue, competitors
    FROM ds_jobs_raw
    WHERE salary_estimate != '-1' 
),
split_salary AS (
    SELECT 
        *,
        -- Split the cleaned string into min and max parts
        SPLIT_PART(salary_numbers, '-', 1) as min_s,
        SPLIT_PART(salary_numbers, '-', 2) as max_s
    FROM base_cleaning
)
SELECT 
    job_title,
    company_name,
    job_city,
    job_state,
    
    -- Convert to Integers and handle single-value salaries
    CAST(min_s AS INT) AS min_salary_k,
    CASE 
        WHEN max_s = '' THEN CAST(min_s AS INT) 
        ELSE CAST(max_s AS INT) 
    END AS max_salary_k,
    
    -- Calculate Average
    CASE 
        WHEN max_s = '' THEN CAST(min_s AS INT)
        ELSE (CAST(min_s AS INT) + CAST(max_s AS INT)) / 2 
    END AS avg_salary_k,

    rating,
    CASE WHEN founded < 0 THEN NULL ELSE 2024 - founded END AS company_age,
    
    -- Skill tags (The "Portfolio Gold")
    CASE WHEN job_description ILIKE '%python%' THEN 1 ELSE 0 END AS python_yn,
    CASE WHEN job_description ILIKE '%sql%' THEN 1 ELSE 0 END AS sql_yn,
    CASE WHEN job_description ILIKE '%excel%' THEN 1 ELSE 0 END AS excel_yn,
    CASE WHEN job_description ILIKE '%tableau%' THEN 1 ELSE 0 END AS tableau_yn,

    industry,
    sector,
    revenue
FROM split_salary;






-- View cleaned table--
SELECT * FROM ds_jobs_cleaned;