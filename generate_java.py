import os

base_dir = r"c:\Users\SUCHETHAN\Hospital_Appointment_System\Hospital-appointment-system\src\main\java\com\hospital"

models = {
    "User.java": """package com.hospital.model;
public class User {
    private int id; private String email; private String passwordHash; private String role;
    public User() {}
    public User(int id, String email, String passwordHash, String role) { this.id = id; this.email = email; this.passwordHash = passwordHash; this.role = role; }
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public String getEmail() { return email; } public void setEmail(String email) { this.email = email; }
    public String getPasswordHash() { return passwordHash; } public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }
    public String getRole() { return role; } public void setRole(String role) { this.role = role; }
}
""",
    "Patient.java": """package com.hospital.model;
import java.sql.Date;
public class Patient extends User {
    private int patientId; private String firstName; private String lastName; private String phone; private Date dateOfBirth; private String gender; private String address;
    public Patient() {}
    public int getPatientId() { return patientId; } public void setPatientId(int patientId) { this.patientId = patientId; }
    public String getFirstName() { return firstName; } public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; } public void setLastName(String lastName) { this.lastName = lastName; }
    public String getPhone() { return phone; } public void setPhone(String phone) { this.phone = phone; }
    public Date getDateOfBirth() { return dateOfBirth; } public void setDateOfBirth(Date dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    public String getGender() { return gender; } public void setGender(String gender) { this.gender = gender; }
    public String getAddress() { return address; } public void setAddress(String address) { this.address = address; }
}
""",
    "Department.java": """package com.hospital.model;
public class Department {
    private int id; private String name; private String description;
    public Department() {}
    public Department(int id, String name, String description) { this.id = id; this.name = name; this.description = description; }
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public String getName() { return name; } public void setName(String name) { this.name = name; }
    public String getDescription() { return description; } public void setDescription(String description) { this.description = description; }
}
""",
    "Doctor.java": """package com.hospital.model;
public class Doctor extends User {
    private int doctorId; private int departmentId; private String departmentName; private String firstName; private String lastName; private String phone; private String specialization; private int experienceYears;
    public Doctor() {}
    public int getDoctorId() { return doctorId; } public void setDoctorId(int doctorId) { this.doctorId = doctorId; }
    public int getDepartmentId() { return departmentId; } public void setDepartmentId(int departmentId) { this.departmentId = departmentId; }
    public String getDepartmentName() { return departmentName; } public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
    public String getFirstName() { return firstName; } public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; } public void setLastName(String lastName) { this.lastName = lastName; }
    public String getPhone() { return phone; } public void setPhone(String phone) { this.phone = phone; }
    public String getSpecialization() { return specialization; } public void setSpecialization(String specialization) { this.specialization = specialization; }
    public int getExperienceYears() { return experienceYears; } public void setExperienceYears(int experienceYears) { this.experienceYears = experienceYears; }
}
""",
    "Appointment.java": """package com.hospital.model;
import java.sql.Date; import java.sql.Time;
public class Appointment {
    private int id; private int patientId; private int doctorId; private String patientName; private String doctorName; private String departmentName; private Date appointmentDate; private Time appointmentTime; private String status; private String reason;
    public Appointment() {}
    public int getId() { return id; } public void setId(int id) { this.id = id; }
    public int getPatientId() { return patientId; } public void setPatientId(int patientId) { this.patientId = patientId; }
    public int getDoctorId() { return doctorId; } public void setDoctorId(int doctorId) { this.doctorId = doctorId; }
    public String getPatientName() { return patientName; } public void setPatientName(String patientName) { this.patientName = patientName; }
    public String getDoctorName() { return doctorName; } public void setDoctorName(String doctorName) { this.doctorName = doctorName; }
    public String getDepartmentName() { return departmentName; } public void setDepartmentName(String departmentName) { this.departmentName = departmentName; }
    public Date getAppointmentDate() { return appointmentDate; } public void setAppointmentDate(Date appointmentDate) { this.appointmentDate = appointmentDate; }
    public Time getAppointmentTime() { return appointmentTime; } public void setAppointmentTime(Time appointmentTime) { this.appointmentTime = appointmentTime; }
    public String getStatus() { return status; } public void setStatus(String status) { this.status = status; }
    public String getReason() { return reason; } public void setReason(String reason) { this.reason = reason; }
}
"""
}

daos = {
    "UserDAO.java": """package com.hospital.dao;
import com.hospital.model.User; import com.hospital.util.DBConnection; import java.sql.*;
public class UserDAO {
    public User login(String email, String passwordHash) {
        String query = "SELECT * FROM users WHERE email = ? AND password_hash = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email); stmt.setString(2, passwordHash);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("email"), rs.getString("password_hash"), rs.getString("role"));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
}
""",
    "PatientDAO.java": """package com.hospital.dao;
import com.hospital.model.Patient; import com.hospital.util.DBConnection; import java.sql.*;
public class PatientDAO {
    public Patient getPatientByUserId(int userId) {
        String query = "SELECT p.*, u.email, u.role FROM patients p JOIN users u ON p.user_id = u.id WHERE u.id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Patient p = new Patient();
                p.setId(rs.getInt("user_id")); p.setEmail(rs.getString("email")); p.setRole(rs.getString("role"));
                p.setPatientId(rs.getInt("id")); p.setFirstName(rs.getString("first_name")); p.setLastName(rs.getString("last_name"));
                p.setPhone(rs.getString("phone")); p.setDateOfBirth(rs.getDate("date_of_birth")); p.setGender(rs.getString("gender")); p.setAddress(rs.getString("address"));
                return p;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
    public boolean registerPatient(Patient patient) {
        String userQuery = "INSERT INTO users (email, password_hash, role) VALUES (?, ?, 'PATIENT')";
        String patientQuery = "INSERT INTO patients (user_id, first_name, last_name, phone, date_of_birth, gender, address) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement userStmt = conn.prepareStatement(userQuery, Statement.RETURN_GENERATED_KEYS)) {
                userStmt.setString(1, patient.getEmail()); userStmt.setString(2, patient.getPasswordHash());
                userStmt.executeUpdate();
                ResultSet rs = userStmt.getGeneratedKeys();
                if (rs.next()) {
                    int userId = rs.getInt(1);
                    try (PreparedStatement patStmt = conn.prepareStatement(patientQuery)) {
                        patStmt.setInt(1, userId); patStmt.setString(2, patient.getFirstName()); patStmt.setString(3, patient.getLastName());
                        patStmt.setString(4, patient.getPhone()); patStmt.setDate(5, patient.getDateOfBirth()); patStmt.setString(6, patient.getGender()); patStmt.setString(7, patient.getAddress());
                        patStmt.executeUpdate();
                    }
                }
                conn.commit();
                return true;
            } catch (SQLException e) { conn.rollback(); e.printStackTrace(); }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
}
""",
    "DoctorDAO.java": """package com.hospital.dao;
import com.hospital.model.Doctor; import com.hospital.util.DBConnection; import java.sql.*; import java.util.ArrayList; import java.util.List;
public class DoctorDAO {
    public Doctor getDoctorByUserId(int userId) {
        String query = "SELECT d.*, u.email, u.role, dep.name as department_name FROM doctors d JOIN users u ON d.user_id = u.id JOIN departments dep ON d.department_id = dep.id WHERE u.id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Doctor d = new Doctor();
                d.setId(rs.getInt("user_id")); d.setEmail(rs.getString("email")); d.setRole(rs.getString("role"));
                d.setDoctorId(rs.getInt("id")); d.setDepartmentId(rs.getInt("department_id")); d.setDepartmentName(rs.getString("department_name"));
                d.setFirstName(rs.getString("first_name")); d.setLastName(rs.getString("last_name")); d.setPhone(rs.getString("phone"));
                d.setSpecialization(rs.getString("specialization")); d.setExperienceYears(rs.getInt("experience_years"));
                return d;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }
    public List<Doctor> getAllDoctors() {
        List<Doctor> doctors = new ArrayList<>();
        String query = "SELECT d.*, u.email, u.role, dep.name as department_name FROM doctors d JOIN users u ON d.user_id = u.id JOIN departments dep ON d.department_id = dep.id";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Doctor d = new Doctor();
                d.setId(rs.getInt("user_id")); d.setEmail(rs.getString("email")); d.setRole(rs.getString("role"));
                d.setDoctorId(rs.getInt("id")); d.setDepartmentId(rs.getInt("department_id")); d.setDepartmentName(rs.getString("department_name"));
                d.setFirstName(rs.getString("first_name")); d.setLastName(rs.getString("last_name")); d.setPhone(rs.getString("phone"));
                d.setSpecialization(rs.getString("specialization")); d.setExperienceYears(rs.getInt("experience_years"));
                doctors.add(d);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return doctors;
    }
}
""",
    "AppointmentDAO.java": """package com.hospital.dao;
import com.hospital.model.Appointment; import com.hospital.util.DBConnection; import java.sql.*; import java.util.ArrayList; import java.util.List;
public class AppointmentDAO {
    public boolean bookAppointment(Appointment appt) {
        String query = "INSERT INTO appointments (patient_id, doctor_id, appointment_date, appointment_time, status, reason) VALUES (?, ?, ?, ?, 'CONFIRMED', ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, appt.getPatientId()); stmt.setInt(2, appt.getDoctorId());
            stmt.setDate(3, appt.getAppointmentDate()); stmt.setTime(4, appt.getAppointmentTime()); stmt.setString(5, appt.getReason());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
    public List<Appointment> getAppointmentsByPatient(int patientId) {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT a.*, d.first_name as d_fn, d.last_name as d_ln, dep.name as dep_name FROM appointments a JOIN doctors d ON a.doctor_id = d.id JOIN departments dep ON d.department_id = dep.id WHERE a.patient_id = ? ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, patientId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id")); a.setPatientId(rs.getInt("patient_id")); a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentDate(rs.getDate("appointment_date")); a.setAppointmentTime(rs.getTime("appointment_time"));
                a.setStatus(rs.getString("status")); a.setReason(rs.getString("reason"));
                a.setDoctorName("Dr. " + rs.getString("d_fn") + " " + rs.getString("d_ln")); a.setDepartmentName(rs.getString("dep_name"));
                list.add(a);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    public List<Appointment> getAppointmentsByDoctor(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT a.*, p.first_name as p_fn, p.last_name as p_ln FROM appointments a JOIN patients p ON a.patient_id = p.id WHERE a.doctor_id = ? ORDER BY a.appointment_date DESC, a.appointment_time DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id")); a.setPatientId(rs.getInt("patient_id")); a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentDate(rs.getDate("appointment_date")); a.setAppointmentTime(rs.getTime("appointment_time"));
                a.setStatus(rs.getString("status")); a.setReason(rs.getString("reason"));
                a.setPatientName(rs.getString("p_fn") + " " + rs.getString("p_ln"));
                list.add(a);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
    public boolean updateStatus(int appointmentId, String status) {
        String query = "UPDATE appointments SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, status); stmt.setInt(2, appointmentId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }
    public List<Appointment> getAllAppointments() {
        List<Appointment> list = new ArrayList<>();
        String query = "SELECT a.*, p.first_name as p_fn, p.last_name as p_ln, d.first_name as d_fn, d.last_name as d_ln, dep.name as dep_name FROM appointments a JOIN patients p ON a.patient_id = p.id JOIN doctors d ON a.doctor_id = d.id JOIN departments dep ON d.department_id = dep.id ORDER BY a.appointment_date DESC";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id")); a.setPatientId(rs.getInt("patient_id")); a.setDoctorId(rs.getInt("doctor_id"));
                a.setAppointmentDate(rs.getDate("appointment_date")); a.setAppointmentTime(rs.getTime("appointment_time"));
                a.setStatus(rs.getString("status")); a.setReason(rs.getString("reason"));
                a.setPatientName(rs.getString("p_fn") + " " + rs.getString("p_ln"));
                a.setDoctorName("Dr. " + rs.getString("d_fn") + " " + rs.getString("d_ln")); a.setDepartmentName(rs.getString("dep_name"));
                list.add(a);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
""",
    "DepartmentDAO.java": """package com.hospital.dao;
import com.hospital.model.Department; import com.hospital.util.DBConnection; import java.sql.*; import java.util.ArrayList; import java.util.List;
public class DepartmentDAO {
    public List<Department> getAllDepartments() {
        List<Department> list = new ArrayList<>();
        String query = "SELECT * FROM departments";
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) { list.add(new Department(rs.getInt("id"), rs.getString("name"), rs.getString("description"))); }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}
"""
}

def create_files(folder, files_dict):
    path = os.path.join(base_dir, folder)
    os.makedirs(path, exist_ok=True)
    for name, content in files_dict.items():
        with open(os.path.join(path, name), "w") as f:
            f.write(content)

create_files("model", models)
create_files("dao", daos)
print("Java models and DAOs created.")
