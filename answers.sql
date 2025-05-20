-- ============================
-- Clinic Booking System Schema
-- ============================

-- Drop existing tables to avoid errors during re-creation
DROP TABLE IF EXISTS Prescription_Medication;
DROP TABLE IF EXISTS Prescription;
DROP TABLE IF EXISTS Appointment;
DROP TABLE IF EXISTS Medication;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS Doctor;
DROP TABLE IF EXISTS Specialization;

-- ============================
-- Table: Specialization
-- One-to-One with Doctor
-- ============================
CREATE TABLE Specialization (
    id INT PRIMARY KEY AUTO_INCREMENT,        -- Unique ID for each specialization
    name VARCHAR(100) NOT NULL UNIQUE         -- Specialization name (e.g., Cardiology), must be unique
);

-- ============================
-- Table: Doctor
-- Each doctor has one specialization
-- ============================
CREATE TABLE Doctor (
    id INT PRIMARY KEY AUTO_INCREMENT,        -- Unique ID for each doctor
    name VARCHAR(100) NOT NULL,               -- Doctor's name
    email VARCHAR(100) NOT NULL UNIQUE,       -- Email must be unique
    phone VARCHAR(20) NOT NULL UNIQUE,        -- Phone number must be unique
    specialization_id INT NOT NULL UNIQUE,    -- Links to Specialization table (1-to-1)
    FOREIGN KEY (specialization_id) REFERENCES Specialization(id)
);

-- ============================
-- Table: Patient
-- Stores patient info
-- ============================
CREATE TABLE Patient (
    id INT PRIMARY KEY AUTO_INCREMENT,        -- Unique ID for each patient
    name VARCHAR(100) NOT NULL,               -- Patient's name
    email VARCHAR(100) NOT NULL UNIQUE,       -- Patient's email
    phone VARCHAR(20) NOT NULL UNIQUE,        -- Patient's phone number
    birth_date DATE NOT NULL                  -- Date of birth
);

-- ============================
-- Table: Appointment
-- Many-to-One: Patient -> Appointments
-- Many-to-One: Doctor -> Appointments
-- ============================
CREATE TABLE Appointment (
    id INT PRIMARY KEY AUTO_INCREMENT,        -- Unique ID for each appointment
    patient_id INT NOT NULL,                  -- Refers to the patient
    doctor_id INT NOT NULL,                   -- Refers to the doctor
    appointment_date DATETIME NOT NULL,       -- When the appointment is scheduled
    reason TEXT,                              -- Reason for visit
    FOREIGN KEY (patient_id) REFERENCES Patient(id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(id)
);

-- ============================
-- Table: Prescription
-- One-to-One with Appointment
-- ============================
CREATE TABLE Prescription (
    id INT PRIMARY KEY AUTO_INCREMENT,        -- Unique ID for each prescription
    appointment_id INT NOT NULL UNIQUE,       -- Refers to the appointment (1-to-1)
    notes TEXT,                               -- Doctor's notes or diagnosis
    FOREIGN KEY (appointment_id) REFERENCES Appointment(id)
);

-- ============================
-- Table: Medication
-- Stores available medications
-- ============================
CREATE TABLE Medication (
    id INT PRIMARY KEY AUTO_INCREMENT,        -- Unique ID for each medication
    name VARCHAR(100) NOT NULL UNIQUE,        -- Medication name
    description TEXT                          -- Optional description
);

-- ============================
-- Table: Prescription_Medication
-- Many-to-Many between Prescription and Medication
-- ============================
CREATE TABLE Prescription_Medication (
    prescription_id INT NOT NULL,             -- Refers to Prescription
    medication_id INT NOT NULL,               -- Refers to Medication
    dosage VARCHAR(100),                      -- Dosage instructions (e.g., "1 tablet twice daily")
    PRIMARY KEY (prescription_id, medication_id),
    FOREIGN KEY (prescription_id) REFERENCES Prescription(id),
    FOREIGN KEY (medication_id) REFERENCES Medication(id)
);

