-- Hospital Appointment System Database Setup

CREATE DATABASE IF NOT EXISTS hospital_db;
USE hospital_db;

-- 1. Departments Table
CREATE TABLE IF NOT EXISTS departments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Users Table (Base table for authentication & role management)
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('PATIENT', 'DOCTOR', 'ADMIN') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Patients Table (Linked to users)
CREATE TABLE IF NOT EXISTS patients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    address TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 4. Doctors Table (Linked to users & departments)
CREATE TABLE IF NOT EXISTS doctors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL UNIQUE,
    department_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    experience_years INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(id)
);

-- 5. Doctor Availability (Schedule)
CREATE TABLE IF NOT EXISTS doctor_schedules (
    id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    slot_duration_minutes INT DEFAULT 30,
    FOREIGN KEY (doctor_id) REFERENCES doctors(id) ON DELETE CASCADE,
    UNIQUE KEY doctor_day_schedule (doctor_id, day_of_week)
);

-- 6. Appointments Table
CREATE TABLE IF NOT EXISTS appointments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('PENDING', 'CONFIRMED', 'COMPLETED', 'CANCELLED', 'REJECTED') DEFAULT 'PENDING',
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(id),
    UNIQUE KEY prevent_double_booking (doctor_id, appointment_date, appointment_time)
);

-- Insert Default Data
-- Default Admin (Password: admin123 -> Hash it in application or use simple text for demo? Let's use simple hash or just handle it. We will use a basic SHA-256 hash or plain for simplicity. Let's assume plain for this demo if we don't have hashing, or just insert it via application logic. Actually, we should insert via SQL)
INSERT INTO users (email, password_hash, role) VALUES ('admin@hospital.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN'); -- password 'admin123' (SHA-256)

INSERT INTO departments (name, description) VALUES 
('Cardiology', 'Heart and cardiovascular diseases'),
('Neurology', 'Brain and nervous system'),
('Pediatrics', 'Children and infant care'),
('Orthopedics', 'Bones and muscles'),
('General Medicine', 'General health and wellness');

-- Doctor 1
INSERT INTO users (email, password_hash, role) VALUES ('dr.smith@hospital.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'DOCTOR');
SET @doc1_user_id = LAST_INSERT_ID();
INSERT INTO doctors (user_id, department_id, first_name, last_name, phone, specialization, experience_years) 
VALUES (@doc1_user_id, 1, 'John', 'Smith', '1234567890', 'Cardiologist', 15);
SET @doc1_id = LAST_INSERT_ID();

INSERT INTO doctor_schedules (doctor_id, day_of_week, start_time, end_time) VALUES
(@doc1_id, 'Monday', '09:00:00', '13:00:00'),
(@doc1_id, 'Wednesday', '09:00:00', '13:00:00'),
(@doc1_id, 'Friday', '14:00:00', '18:00:00');

-- Doctor 2
INSERT INTO users (email, password_hash, role) VALUES ('dr.jones@hospital.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'DOCTOR');
SET @doc2_user_id = LAST_INSERT_ID();
INSERT INTO doctors (user_id, department_id, first_name, last_name, phone, specialization, experience_years) 
VALUES (@doc2_user_id, 2, 'Sarah', 'Jones', '0987654321', 'Neurologist', 10);
SET @doc2_id = LAST_INSERT_ID();

INSERT INTO doctor_schedules (doctor_id, day_of_week, start_time, end_time) VALUES
(@doc2_id, 'Tuesday', '10:00:00', '16:00:00'),
(@doc2_id, 'Thursday', '10:00:00', '16:00:00');

-- Patient 1
INSERT INTO users (email, password_hash, role) VALUES ('patient1@gmail.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'PATIENT');
SET @pat1_user_id = LAST_INSERT_ID();
INSERT INTO patients (user_id, first_name, last_name, phone, date_of_birth, gender, address) 
VALUES (@pat1_user_id, 'Alice', 'Williams', '5551234567', '1990-05-15', 'Female', '123 Main St');
SET @pat1_id = LAST_INSERT_ID();

-- Insert an appointment for testing
INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, reason)
VALUES (@pat1_id, @doc1_id, CURDATE() + INTERVAL 1 DAY, '10:00:00', 'CONFIRMED', 'Routine Checkup');
