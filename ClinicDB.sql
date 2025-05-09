-- Drop tables if they exist to reset the schema
DROP TABLE IF EXISTS Doctor_Patient, Billing, Prescriptions, Appointments, Medical_Records,
Patients, Doctors, Insurance, Departments;

-- Departments table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- Insurance table
CREATE TABLE Insurance (
    insurance_id INT PRIMARY KEY,
    provider_name VARCHAR(100) NOT NULL,
    policy_number VARCHAR(50) UNIQUE NOT NULL,
    coverage_details TEXT
);

-- Patients table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR(10),
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    address TEXT,
    insurance_id INT,
    FOREIGN KEY (insurance_id) REFERENCES Insurance(insurance_id)
);

-- Doctors table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Appointments table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status VARCHAR(20) DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);


-- Users Table
CREATE TABLE Users (
    User_ID INT PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100),
    Created_At TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Roles Table
CREATE TABLE Roles (
    Role_ID INT PRIMARY KEY AUTO_INCREMENT,
    Role_Name VARCHAR(50) UNIQUE NOT NULL
);

-- UserRoles Table (Many-to-Many between Users and Roles)
CREATE TABLE UserRoles (
    User_ID INT,
    Role_ID INT,
    PRIMARY KEY (User_ID, Role_ID),
    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE,
    FOREIGN KEY (Role_ID) REFERENCES Roles(Role_ID) ON DELETE CASCADE
);

-- Doctor_Patient Table (Many-to-Many between Doctors and Patients)
CREATE TABLE Doctor_Patient (
    Doctor_ID INT,
    Patient_ID INT,
    Relationship_Started DATE,
    PRIMARY KEY (Doctor_ID, Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);



-- Prescriptions table (1-1 with Appointments)
CREATE TABLE Prescriptions (
    prescription_id INT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    medication_details TEXT NOT NULL,
    dosage VARCHAR(50),
    instructions TEXT,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Billing table (1-1 with Appointments)
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'Unpaid',
    payment_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Medical Records (1-M with Patients)
CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    record_date DATE NOT NULL,
    description TEXT,
    attachments TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Many-to-Many relationship between Doctors and Patients
CREATE TABLE Doctor_Patient (
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    PRIMARY KEY (doctor_id, patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
);

-- Departments
INSERT INTO Departments VALUES
(1, 'Cardiology', '1st Floor'),
(2, 'Pediatrics', '2nd Floor'),
(3, 'Dermatology', '3rd Floor'),
(4, 'Neurology', '4th Floor'),
(5, 'Orthopedics', '5th Floor'),
(6, 'Gynecology', '6th Floor'),
(7, 'Oncology', '7th Floor'),
(8, 'Radiology', '8th Floor'),
(9, 'ENT', '9th Floor'),
(10, 'Urology', '10th Floor');


-- Insurance
INSERT INTO Insurance VALUES
(1, 'MediCare', 'MC123456', 'General and specialist consultations'),
(2, 'HealthPlus', 'HP789012', 'Diagnostics and medication'),
(3, 'PrimeHealth', 'PH112233', 'Full coverage including surgery'),
(4, 'SureHealth', 'SH445566', 'Basic care and emergencies'),
(5, 'SafeLife', 'SL778899', 'Dental and vision included'),
(6, 'CareNow', 'CN111222', '24/7 urgent care'),
(7, 'SecurePlan', 'SP333444', 'Wellness and screenings'),
(8, 'TotalCare', 'TC555666', 'Maternity and child care'),
(9, 'FastHealth', 'FH777888', 'In-network doctors only'),
(10, 'GlobalMed', 'GM999000', 'International coverage');


-- Patients
INSERT INTO Patients VALUES
(101, 'John Doe', '1985-06-15', 'Male', '1234567890', 'john@example.com', '123 Elm St.', 1),
(102, 'Jane Smith', '1990-09-22', 'Female', '0987654321', 'jane@example.com', '456 Oak Ave.', 2),
(103, 'Michael Johnson', '1978-01-10', 'Male', '1112223333', 'mj@example.com', '789 Maple Rd.', 3),
(104, 'Emily Davis', '1992-03-08', 'Female', '4445556666', 'emilyd@example.com', '101 Pine Blvd.', 4),
(105, 'Chris Lee', '1987-11-19', 'Male', '7778889999', 'chrisl@example.com', '202 Birch Way', 5),
(106, 'Laura Kim', '1995-07-12', 'Female', '5556667777', 'laurak@example.com', '303 Spruce Ln.', 6),
(107, 'Daniel Garcia', '1983-05-21', 'Male', '2223334444', 'danielg@example.com', '404 Walnut Dr.', 7),
(108, 'Sophia Turner', '1999-08-30', 'Female', '6667778888', 'sophiat@example.com', '505 Cedar St.', 8),
(109, 'Mark Allen', '1975-12-17', 'Male', '9990001111', 'marka@example.com', '606 Chestnut Ct.', 9),
(110, 'Olivia Scott', '1989-10-05', 'Female', '3334445555', 'olivias@example.com', '707 Redwood Ter.', 10);


-- Doctors
INSERT INTO Doctors VALUES
(201, 'Dr. Alice Brown', 'Cardiologist', '5551000001', 'alice.b@clinic.com', 1),
(202, 'Dr. Tom Lee', 'Pediatrician', '5551000002', 'tom.lee@clinic.com', 2),
(203, 'Dr. Karen White', 'Dermatologist', '5551000003', 'karen.w@clinic.com', 3),
(204, 'Dr. David King', 'Neurologist', '5551000004', 'david.k@clinic.com', 4),
(205, 'Dr. Nina Moore', 'Orthopedic', '5551000005', 'nina.m@clinic.com', 5),
(206, 'Dr. James Young', 'Gynecologist', '5551000006', 'james.y@clinic.com', 6),
(207, 'Dr. Angela Perez', 'Oncologist', '5551000007', 'angela.p@clinic.com', 7),
(208, 'Dr. Frank Zhou', 'Radiologist', '5551000008', 'frank.z@clinic.com', 8),
(209, 'Dr. Megan Hall', 'ENT Specialist', '5551000009', 'megan.h@clinic.com', 9),
(210, 'Dr. Steve Adams', 'Urologist', '5551000010', 'steve.a@clinic.com', 10);


-- Appointments
INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, appointment_time, status, notes) VALUES
(301, 101, 201, '2025-05-10', '10:00:00', 'Scheduled', 'Initial consultation'),
(302, 102, 202, '2025-05-11', '09:00:00', 'Scheduled', 'Routine check-up');



-- Prescriptions
INSERT INTO Prescriptions (prescription_id, appointment_id, medication_details, dosage, instructions) VALUES
(401, 301, 'Atenolol', '50mg', 'Take once daily after breakfast'),
(402, 302, 'Ibuprofen', '200mg', 'Take as needed for pain');


-- Billing
INSERT INTO Billing VALUES
(501, 301, 100.00, 'Paid','2024-06-01'),
(502, 302, 120.00, 'Paid', '2024-06-02'),
(503, 303, 90.00, 'Unpaid', '2024-06-03'),
(504, 304, 150.00, 'Paid', '2024-06-04'),
(505, 305, 200.00, 'Unpaid', '2024-06-05'),
(506, 306, 80.00, 'Paid', '2024-06-06'),
(507, 307, 250.00, 'Paid', '2024-06-07'),
(508, 308, 130.00, 'Unpaid', '2024-06-08'),
(509, 309, 110.00, 'Paid', '2024-06-09'),
(510, 310, 160.00, 'Paid', '2024-06-10');


-- Medical Records
INSERT INTO Medical_Records (record_id, patient_id, record_date, description, attachments) VALUES
(601, 101, '2025-04-20', 'ECG report shows mild abnormalities', NULL),
(602, 102, '2025-04-22', 'Annual physical examination - all normal', NULL);



-- Doctor_Patient relationship
INSERT INTO Doctor_Patient VALUES
(201, 101),
(202, 102),
(203, 103),
(204, 104),
(205, 105),
(206, 106),
(207, 107),
(208, 108),
(209, 109),
(210, 110);



-- Creating Test Users with Roles and Permissions
-- Admin user
CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123';

-- Doctor user
CREATE USER 'doctor_user'@'localhost' IDENTIFIED BY 'DoctorPass123';

-- Receptionist user
CREATE USER 'receptionist_user'@'localhost' IDENTIFIED BY 'ReceptionistPass123';

-- Accountant user
CREATE USER 'accountant_user'@'localhost' IDENTIFIED BY 'AccountantPass123';


-- Granting Privileges to Users
-- Grant admin full access
GRANT ALL PRIVILEGES ON ClinicDB.* TO 'admin_user'@'localhost' WITH GRANT OPTION;

-- Doctor: appointments + prescriptions
GRANT SELECT, INSERT ON ClinicDB.Appointments TO 'doctor_user'@'localhost';
GRANT SELECT, INSERT ON ClinicDB.Prescriptions TO 'doctor_user'@'localhost';

-- Receptionist: manage patients and appointments
GRANT SELECT, INSERT, UPDATE, DELETE ON ClinicDB.Patients TO 'receptionist_user'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON ClinicDB.Appointments TO 'receptionist_user'@'localhost';

-- Accountant: billing only
GRANT SELECT, UPDATE ON ClinicDB.Billing TO 'accountant_user'@'localhost';

FLUSH PRIVILEGES;



-- STORED PROCEDURES

-- Adding a New Appointment
DELIMITER $$

CREATE PROCEDURE AddAppointment (
    IN p_patient_id INT,
    IN p_doctor_id INT,
    IN p_date DATE,
    IN p_time TIME,
    IN p_notes TEXT
)
BEGIN
    INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, notes)
    VALUES (p_patient_id, p_doctor_id, p_date, p_time, p_notes);
END $$

DELIMITER ;

-- Creating a Billing Record for an Appointment
DELIMITER $$

CREATE PROCEDURE CreateBill (
    IN p_appointment_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    INSERT INTO Billing (appointment_id, amount, payment_status)
    VALUES (p_appointment_id, p_amount, 'Unpaid');
END $$

DELIMITER ;


-- Adding a Prescription to an Appointment
DELIMITER $$

CREATE PROCEDURE AddPrescription (
    IN p_appointment_id INT,
    IN p_med_details TEXT,
    IN p_dosage VARCHAR(50),
    IN p_instructions TEXT
)
BEGIN
    INSERT INTO Prescriptions (appointment_id, medication_details, dosage, instructions)
    VALUES (p_appointment_id, p_med_details, p_dosage, p_instructions);
END $$

DELIMITER ;

-- Views

-- View Upcoming Appointments by Doctor
CREATE VIEW View_Doctor_Appointments AS
SELECT
    a.appointment_id,
    d.full_name AS doctor,
    p.full_name AS patient,
    a.appointment_date,
    a.appointment_time,
    a.status
FROM Appointments a
JOIN Doctors d ON a.doctor_id = d.doctor_id
JOIN Patients p ON a.patient_id = p.patient_id
WHERE a.appointment_date >= CURDATE()
ORDER BY a.appointment_date, a.appointment_time;

-- View Billing Summary
CREATE VIEW View_Billing_Summary AS
SELECT
    b.bill_id,
    p.full_name AS patient,
    a.appointment_date,
    b.amount,
    b.payment_status,
    b.payment_date
FROM Billing b
JOIN Appointments a ON b.appointment_id = a.appointment_id
JOIN Patients p ON a.patient_id = p.patient_id;

-- View Patient Medical History
CREATE VIEW View_Patient_History AS
SELECT
    p.full_name,
    m.record_date,
    m.description,
    m.attachments
FROM Medical_Records m
JOIN Patients p ON m.patient_id = p.patient_id
ORDER BY m.record_date DESC;

