

-- business query----> 1. Which doctor sees the most patients?
SELECT 
    d.full_name        AS doctor_name,
    d.department,
    COUNT(a.appointment_id) AS total_appointments
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id, d.full_name, d.department
ORDER BY total_appointments DESC
LIMIT 5;
-- Q2: Which department has the highest appointments?
SELECT 
    d.department,
    COUNT(a.appointment_id) AS total_appointments
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
GROUP BY d.department
ORDER BY total_appointments DESC;
-- Q3: How many appointments happen each day?
SELECT 
    appointment_date,
    COUNT(appointment_id) AS total_appointments
FROM Appointments
GROUP BY appointment_date
ORDER BY appointment_date ASC;
-- Q4: Who are the Top 10 Oldest Patients?
SELECT 
    full_name,
    date_of_birth,
    TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) AS age
FROM Patients
ORDER BY date_of_birth ASC
LIMIT 10;
-- Q5: Which Patients Have Multiple Visits?
SELECT 
    p.full_name,
    COUNT(a.appointment_id) AS total_visits,
    CASE 
        WHEN COUNT(a.appointment_id) >= 5 THEN 'Frequent'
        WHEN COUNT(a.appointment_id) >= 3 THEN 'Regular'
        ELSE 'Occasional'
    END AS visit_category
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
GROUP BY p.patient_id, p.full_name
HAVING total_visits > 1
ORDER BY total_visits DESC;
-- Q6:  Which doctor prescribes the most medicines?
SELECT 
    d.full_name AS doctor_name,
    d.department,
    m.medicine_name,
    COUNT(m.medicine_id) AS times_prescribed
FROM Medicines m
JOIN Appointments a ON m.appointment_id = a.appointment_id
JOIN Doctors      d ON a.doctor_id      = d.doctor_id
GROUP BY d.doctor_id, d.full_name, d.department, m.medicine_name
ORDER BY doctor_name, times_prescribed DESC;
CREATE VIEW appointment_summary AS
SELECT 
    a.appointment_id,
    p.full_name          AS patient_name,
    d.full_name          AS doctor_name,
    d.department,
    a.appointment_date,
    a.status,
    a.reason
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors  d ON a.doctor_id  = d.doctor_id;
-- Simple select
SELECT * FROM appointment_summary;

-- Filter by department
SELECT * FROM appointment_summary
WHERE department = 'Heart Care';

-- Filter by status
SELECT * FROM appointment_summary
WHERE status = 'Completed';

-- Filter by patient
SELECT * FROM appointment_summary
WHERE patient_name = 'Aisha Mehta';
-- Create the index
CREATE INDEX idx_appointment_date 
ON Appointments(appointment_date);

EXPLAIN SELECT * FROM Appointments 
WHERE appointment_date = '2024-01-10';
-- Create the index
SHOW INDEXES FROM Appointments;