## 📌 Project Overview
The goal of this project is to clean and analyze a dataset, which contains more than 670 Data Science job postings. The raw data was extremely unstructured that it contained unorganized pay scales, company rating in the form of names and long format job descriptions. I translated this into a structured format with the help of  **PostgreSQL** in order to obtain data about the trends of salaries, industry demand and necessary technical skills.

---

## 🔗 Quick Links
* **[Live Tableau Dashboard](https://public.tableau.com/views/TableauwithPostgreSQLDataCleaningAnalysis/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**
* **[SQL Cleaning Script](./CleaningPipeline.sql)**

---

## 🛠️ Tools & Methods
* **Database:** PostgreSQL (pgAdmin 4)
* **Visualization:** Tableau
* **Language:** SQL
* **Methods:** CTEs, Regular Expressions (Regex), Feature Engineering, Data Type Casting.

---

## 🚀 The Analysis Pipeline

### 🗄️ Project 1: PostgreSQL — Data Science Job Market Cleaning & Analysis
The cleaning involved a number of complicated SQL functions to transform the raw `Uncleaned_DS_jobs.csv` into a high-integrity analytical dataset.

**Key Data Cleaning Steps:**
* **Salary Parsing:** `REGEXP_REPLACE` was used to remove non-numbers and separate the salary ranges into min, max, and avg integer columns.
* **Company Cleanup:** Removed inconsistent names and spaces in naming conventions where ratings were embedded into company names (e.g., `Healthfirst\n3.1`).
* **Location Splitting:** Uniformed locations by splitting the data into distinct **City** and **State** columns.
* **Feature Engineering:** Boolean flags (0/1) for major skills (Python, SQL, Excel, Tableau) were created by searching the text in the Job Description with `ILIKE` patterns.

**Key Insights from the Analysis**
* **Python is Non-Negotiable:** Our text-mining approach revealed that 73.07% of all postings explicitly mention Python, and it is the dominant technical requirement in the market that is prevailing in the market.
* **Close attachment to SQL:** SQL, which came immediately after Python, was mentioned in 52.98% of job descriptions, showing that the "Modern Data Stack" remains primarily focused on database management.
* **The Geographic Payroll Peak:** California and New York will have the most number of jobs, but Washington DC is the highest paying with an average wage of 139k, possibly because of its specialty jobs in the public sector and jobs related to high security analytics.
* **High-Value Industries:** The Research and development ($136k) and Aerospace and Defense industries (132k) represent the best paying sectors, and their data science jobs are doing better than the traditional technology and finance sectors.
* **Rating vs. Salary (The Myth):** QL correlation queries and Tableau scatter plots have verified that there exists no zero level statistical correlation between Glassdoor rating of a company and salary that a company is offering. The better-paid positions are equally likely to be available in "average-rated" firms.
* **The "Specialist" Premium:** Occupations with specialized knowledge such as Tableau or AWS and Python were associated with a rise in salary by about 10-15 percent in comparison to generalist advertisements.


### 📊 Project 1: Tableau — Data Science Job Market Visualization & Insights

After cleaning the data in PostgreSQL, I utilized Tableau to translate the results into an interactive visual narrative to establish market trends.

Key Business Insights:

* **The Python Premium:** Python is the most critical technical requirement, appearing in 73.07% of all job postings, followed by SQL (52.98%).
* **High Paying Industries:** The Research & Development ($136k) and Aerospace & Defense ($132k) sectors offer the highest average compensation.
* *Geographic Hubs:** California and New York earn the most jobs in total, but Washington DC will pay the highest on average salary of $139k.
* *The Culture Paradox:** The results of the analysis indicate that there is zero correlation between the rating of a company and the salary, i.e., the positions with high salary are offered in both highly rated and average-rated company.

**Note on Data Discrepancy:** There is a slight numerical difference between the results of the raw SQL queries and the Tableau dashboard. This is due to the filtering of -1 values (placeholders for missing data) during the Tableau visualization phase to ensure that null values did not skew the final averages and insights. 

### 📂 Project Files
* **Uncleaned_DS_jobs.csv:** Source raw data.
* **CleaningPipeline.sql:** Complete PostgreSQL script of the cleaning pipeline.
* **DS_job_queries.sql:** Queries applied to establish business insights.
* **Cleaned_DS_Jobs.csv:** Finished data, ready for analysis.
* **[Tableau Dashboard](https://public.tableau.com/views/TableauwithPostgreSQLDataCleaningAnalysis/Dashboard1?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**
