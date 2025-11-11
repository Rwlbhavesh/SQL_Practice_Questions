use project_medical_data_histroy;
show tables;
select * from patients;

-- Q.1  Show first name, last name, and gender of patients who's gender is 'M'
select first_name , last_name , gender from patients where gender = "M" ;
select count(*)  from patients where gender = "M";
-- Total Male Patients 2468.


-- Q.2 Show first name and last name of patients who does not have allergies.
select * from patients;
select first_name , last_name from patients where allergies is null;
select count(*) from patients where allergies is null ;
-- Total not allergies 2059.


-- Q.3 Show first name of patients that start with the letter 'C'
select first_name from patients where first_name like "C%";
select count(*) from patients where first_name like "C%";
-- Total 302 Patients first_name Start with "C"


-- Q.4 Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
select * from patients ;
select first_name , last_name , weight from patients where weight between 100 and 120 order by weight desc;
select count(*) from patients where weight between 100 and 120;
-- Total patients 952 weight between 100 and 120


-- Q.5 Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
update patients set allergies = "NKA" where allergies is null;
select * from patients;


-- Q.6 Show first name and last name concatenated into one column to show their full name.
select concat(first_name,' ',last_name) as full_name from patients ;


-- Q.7. Show first name, last name, and the full province name of each patient.
select * from patients;
select * from province_names;
select first_name , last_name , province_names.province_name from patients INNER JOIN province_names on patients.province_id = province_names.province_id;


-- Q.8 Show how many patients have a birth_date with 2010 as the birth year.
select * from patients where birth_date = 2010;
select count(*) from patients where birth_date = 2010;
-- Total Patients 55 birth in 2010


-- Q.9 Show the first_name, last_name, and height of the patient with the greatest height.
select * from patients where height in (select max(height) from patients);
-- recheck 
select max(height) from patients;


-- Q.10 Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000
select * from patients where patient_id in (1,45,534,1000);


-- Q.11 Show the total number of admissions
select count(*) from admissions;
-- Total admissions 4579


-- Q.12 Show all the columns from admissions where the patient was admitted and discharged on the same day.
select * from admissions where admission_date = discharge_date;
select count(*) from admissions where admission_date = discharge_date;
-- Total patients 452 in same day admission and discharge 


-- Q.13 . Show the total number of admissions for patient_id 579.
select * from admissions where patient_id = 579;


-- Q.14 . Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
select * from patients where province_id = 'NS';
select count(*) from patients where province_id = 'NS';
-- Total patients is 60


-- Q.15 Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70
select first_name,last_name,birth_date , height , weight from patients where height > 160 and weight >70 order by height desc;
select count(*) from patients where height > 160 and weight >70;
-- Total Patients is 2091


-- Q.16 Show unique birth years from patients and order them by ascending.
select DISTINCT year(birth_date) as birth_year from patients order by birth_year asc;


-- Q.17 Show unique first names from the patients table which only occurs once in the list.
select DISTINCT first_name as unique_name from patients group by unique_name;


-- Q.18 Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id , first_name from patients where first_name like "s%s" and length(first_name) >= 6;


-- Q.19 Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.   Primary diagnosis is stored in the admissions table.
select * from patients ;
select * from admissions;
select first_name,last_name, ad.diagnosis from patients
inner join admissions as ad on patients.patient_id = ad.patient_id
where ad.diagnosis = 'dementia';


-- Q.20 Display every patient's first_name. Order the list by the length of each name and then by alphbetically.
select first_name from patients order by length(first_name),first_name asc;


-- Q.21 Show the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.
select  sum(case when gender = "M" then 1 else 0 end ) as Male , 
		sum(case when gender = "F" then 1 else 0 end ) as female 
        from patients; 
        
        
-- Q.22 Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
select * from admissions;
select patient_id , diagnosis , count(patient_id) from admissions group by  patient_id , diagnosis having count(patient_id) > 1; 


-- Q.23 Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
select count(*) as Total_Patients , city from patients group by city order by Total_Patients desc;


-- Q.24 Show first name, last name and role of every person that is either patient or doctor.    The roles are either "Patient" or "Doctor"
SELECT first_name, last_name, 'Patient' AS role FROM patients
UNION ALL
SELECT first_name, last_name, 'Doctor' AS role FROM doctors;


-- Q.25 Show all allergies ordered by popularity. Remove NULL values from query.
select * from patients;
select DISTINCT allergies from patients order by allergies asc;
-- NULL value Replace by "NKA"


-- Q.26 Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name , last_name , birth_date from patients order by birth_date asc;


-- Q.27 We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. 
-- Separate the last_name and first_name with a comma. Order the list by the first_name in decending order.ALTER
select concat(lower(first_name),',',upper(last_name)) as Full_Name from patients order by first_name desc;


-- Q.28 Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select * from patients;
select DISTINCT province_id , sum(height) as Total_Height from patients group BY province_id having sum(height)>=7000;


-- Q.29  Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select last_name , max(weight) , min(weight) from patients where last_name = 'maroni';


-- Q.30 Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select * from admissions;
SELECT 
    DAY(admission_date) AS day_of_month,
    COUNT(*) AS total_admissions
	FROM admissions
	GROUP BY DAY(admission_date)
	ORDER BY total_admissions DESC;


-- Q.31 Show all of the patients grouped into weight groups. Show the total amount of patients in each weight group. 
-- Order the list by the weight group decending. e.g. if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
SELECT (FLOOR(weight / 10) * 10) AS weight_group,COUNT(*) AS total_patients
FROM patients GROUP BY weight_group ORDER BY weight_group DESC;



-- Q.32 Show patient_id, weight, height, isObese from the patients table. Display isObese as a boolean 0 or 1. 
-- Obese is defined as weight(kg)/(height(m). Weight is in units kg. Height is in units cm.

SELECT patient_id,weight,height,
    CASE 
	WHEN (weight / POWER(height / 100, 2)) >= 30 THEN 1 
	ELSE 0 
    END AS isObese
    FROM 
    patients;
    
								-- ALL QUESTIONS ARE COMPLETED BY ME -- 
 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                               