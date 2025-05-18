create database hospital;
use hospital;
-- Write an SQL query to find the total number of patients across all hospitals. 
select sum(Patients_Count) as total_patients from hospital_data;
 -- Retrieve the average count of doctors available in each hospital.-- 
 select avg(Doctors_Count) as Avrage_docter from hospital_data;
 -- Find the top 3 hospital departments that have the highest number of patients. 
SELECT Department, sum(Patients_Count) as no_paitent
FROM hospital_data
GROUP BY Department
ORDER BY no_paitent DESC
LIMIT 3; 
-- TOP 3 DEPARTMENT USE RANK
WITH Ranked_Departments AS (
    SELECT 
        Department,
        SUM(Patients_Count) AS Total_Patients,
        RANK() OVER (ORDER BY SUM(Patients_Count) DESC) AS dept_rank
    FROM hospital_data
    GROUP BY Department
)
SELECT Department, Total_Patients, dept_rank
FROM Ranked_Departments
WHERE dept_rank <= 3;

-- dentify the hospital that recorded the highest medical expenses. 
-- for sinal expenses-- 
SELECT 
    ï»¿Hospital_Name, MAX(Medical_Expenses)
FROM
    hospital_data
GROUP BY ï»¿Hospital_Name
ORDER BY MAX(Medical_Expenses) DESC;

-- over all
SELECT ï»¿Hospital_Name, SUM(Medical_Expenses) AS Total_Expenses
FROM hospital_data
GROUP BY ï»¿Hospital_Name
ORDER BY Total_Expenses DESC
LIMIT 1;

-- Calculate the average medical expenses per day for each hospital. 
select ï»¿Hospital_Name, avg(Medical_Expenses) as avrage_daily_exp
from hospital_data
group by ï»¿Hospital_Name
order by avrage_daily_exp desc limit 5 ;

-- Find the patient with the longest stay by calculating the difference between 
-- Discharge Date and Admission Date. 

SELECT *,
       Discharge_Date - Admission_Date AS Stay_Duration
FROM hospital_data
ORDER BY Stay_Duration DESC
LIMIT 1;

-- Count the total number of patients treated in each city. --
select Location, sum(Patients_Count) as total_patient
from hospital_data
group by Location
order by total_patient desc;

-- Calculate the average number of days patients spend in each department. 

 SELECT Department,
       round(avg(Discharge_Date - Admission_Date),0) AS Avg_Stay_Duration
FROM hospital_data
group by Department
ORDER BY Avg_Stay_Duration DESC
LIMIT 5;


-- Find the department with the least number of patients. 
select Department , min(Patients_Count) as no_patient
from hospital_data
group by Department
order by no_patient ASC LIMIT 1;


-- Group the data by month and calculate the total medical expenses for each month. 
SELECT 
    FORMAT(Admission_Date, 'MM/DD/yyyy') AS DAYS,
    SUM(Medical_Expenses) AS Monthly_Expenses
FROM hospital_data
GROUP BY FORMAT(Admission_Date, 'MM/DD/yyyy')
ORDER BY MIN(Admission_Date);





