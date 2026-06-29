CREATE DATABASE hospital_db;
USE hospital_db;
CREATE TABLE Patients (
    patient_id    INT AUTO_INCREMENT PRIMARY KEY,
    full_name     VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender        ENUM('Male', 'Female', 'Other') NOT NULL,
    blood_type    VARCHAR(5),
    phone         VARCHAR(15),
    address       VARCHAR(255),
    registered_on DATE DEFAULT (CURRENT_DATE)
);
CREATE TABLE Doctors (
    doctor_id        INT AUTO_INCREMENT PRIMARY KEY,
    full_name        VARCHAR(100) NOT NULL,
    specialization   VARCHAR(100) NOT NULL,
    department       VARCHAR(100) NOT NULL,
    phone            VARCHAR(15),
    email            VARCHAR(100) UNIQUE,
    joining_date     DATE,
    experience_years INT
);
CREATE TABLE Appointments (
    appointment_id   INT AUTO_INCREMENT PRIMARY KEY,
    patient_id       INT NOT NULL,
    doctor_id        INT NOT NULL,
    appointment_date DATE NOT NULL,
    status           ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    reason           VARCHAR(255),
    notes            TEXT,

    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id)  REFERENCES Doctors(doctor_id)
);
CREATE TABLE Medicines (
    medicine_id      INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id   INT NOT NULL,
    medicine_name    VARCHAR(100) NOT NULL,
    dosage           VARCHAR(50),
    duration_days    INT,
    prescribed_on    DATE DEFAULT (CURRENT_DATE),

    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

INSERT INTO Patients (full_name, date_of_birth, gender, blood_type, phone, address)
VALUES
('Aisha Mehta',    '1990-03-15', 'Female', 'A+',  '9876543210', 'Chennai'),
('Ravi Kumar',     '1985-07-22', 'Male',   'B+',  '9845123456', 'Mumbai'),
('Priya Nair',     '2000-11-05', 'Female', 'O+',  '9712345678', 'Delhi'),
('Arjun Singh',    '1978-01-30', 'Male',   'AB-', '9654321987', 'Bangalore'),
('Fatima Shaikh',  '1995-06-18', 'Female', 'B-',  '9788654321', 'Hyderabad');
SELECT * FROM Patients;
INSERT INTO Doctors (full_name, specialization, department, phone, email, joining_date, experience_years)
VALUES
('Dr. Sneha Rao',      'Cardiology',     'Heart Care',    '9801234567', 'sneha.rao@hospital.com',      '2010-06-01', 14),
('Dr. Arjun Mehta',   'Neurology',      'Brain & Spine', '9812345678', 'arjun.mehta@hospital.com',    '2015-03-15', 9),
('Dr. Priya Iyer',    'Pediatrics',     'Child Care',    '9823456789', 'priya.iyer@hospital.com',     '2018-07-20', 6),
('Dr. Rahul Verma',   'Orthopedics',    'Bone & Joint',  '9834567890', 'rahul.verma@hospital.com',    '2012-11-10', 12),
('Dr. Fatima Khan',   'Dermatology',    'Skin Care',     '9845678901', 'fatima.khan@hospital.com',    '2017-02-28', 7);
INSERT INTO Appointments (patient_id, doctor_id, appointment_date, status, reason)
VALUES
(1,  2,  '2024-01-10', 'Completed',  'Severe headache'),
(2,  1,  '2024-01-12', 'Completed',  'Chest pain'),
(3,  3,  '2024-01-15', 'Completed',  'Child fever'),
(4,  4,  '2024-01-15', 'Cancelled',  'Knee pain'),
(5,  5,  '2024-01-18', 'Completed',  'Skin rash'),
(1,  1,  '2024-02-05', 'Completed',  'Follow-up checkup'),
(2,  3,  '2024-02-10', 'Scheduled',  'Breathing issue'),
(3,  2,  '2024-02-14', 'Completed',  'Migraine'),
(1,  4,  '2024-03-01', 'Completed',  'Back pain');
SELECT 
    a.appointment_id,
    p.full_name AS patient,
    d.full_name AS doctor,
    a.appointment_date,
    a.status
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors  d ON a.doctor_id  = d.doctor_id;
INSERT INTO Medicines (appointment_id, medicine_name, dosage, duration_days)
VALUES
(1,  'Paracetamol',   '500mg twice daily',      5),
(1,  'Ibuprofen',     '400mg after meals',       3),
(2,  'Aspirin',       '75mg once daily',         30),
(2,  'Atorvastatin',  '10mg at night',           90),
(3,  'Amoxicillin',   '250mg three times daily', 7),
(4,  'Diclofenac',    '50mg twice daily',        5),
(5,  'Clotrimazole',  'Apply twice daily',       14),
(6,  'Metoprolol',    '25mg twice daily',        60),
(7,  'Salbutamol',    '2 puffs when needed',     30),
(8,  'Sumatriptan',   '50mg at onset',           3);

