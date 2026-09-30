# Hospital Appointment System

## 1. Project Overview
The Hospital Appointment System is a robust web-based healthcare management application. It bridges the gap between patients, doctors, and hospital administrators by streamlining the appointment scheduling process and offering an intuitive, responsive user interface.

## 2. Problem Statement
Many healthcare facilities rely on manual or fragmented systems for scheduling appointments. This leads to double-bookings, inefficiency, long patient wait times, and a lack of data-driven insights.

## 3. Objectives
- Provide a centralized platform for appointment booking.
- Prevent double-booking conflicts via robust backend logic.
- Deliver a modern, responsive, and accessible UI/UX.
- Offer analytical insights into hospital operations.
- Ensure strict role-based data isolation.

## 4. Features
- Secure Authentication (SHA-256 password hashing)
- Role-based Dashboards
- Dynamic Appointment Booking & Slot Availability
- Automated Double-booking Prevention
- Real-time Analytics with Chart.js
- Modern CSS3/Bootstrap UI

## 5. User Roles
- **Patient**: Registers, logs in, books appointments, views history, and can cancel pending appointments.
- **Doctor**: Logs in, views upcoming schedule, and manages appointment statuses (e.g., marks as Completed or Cancelled).
- **Admin**: Oversees the entire hospital, views analytical charts, and manages all appointments across departments.

## 6. Patient Workflow
1. Registers via the Patient Registration form.
2. Logs in to access the Patient Dashboard.
3. Clicks "Book Appointment" and selects a Department and Doctor.
4. Chooses a valid Date and Time.
5. Submits booking (backend validates availability).
6. Views confirmed appointment in the dashboard.

## 7. Doctor Workflow
1. Logs in with Doctor credentials.
2. Views the Doctor Dashboard.
3. Accesses the daily/upcoming schedule.
4. Marks appointments as Completed after consultation.

## 8. Admin Workflow
1. Logs in with Admin credentials.
2. Views the Admin Dashboard.
3. Analyzes hospital performance via Chart.js graphs (appointments by department, status distribution).
4. Monitors all patient-doctor interactions.

## 9. System Architecture
- **Presentation Layer**: HTML5, CSS3, Bootstrap 5, JavaScript (ES6).
- **Controller Layer**: Java Servlets handling HTTP Requests/Responses.
- **Data Access Layer**: DAOs (Data Access Objects) utilizing JDBC.
- **Database Layer**: MySQL relational database.

## 10. Technology Stack
- **Frontend**: HTML, CSS, JavaScript, Bootstrap, Chart.js
- **Backend**: Java 11, Servlets, JSP
- **Database**: MySQL 8.0, JDBC
- **Build Tool**: Maven

## 11. Project Structure
```text
hospital-appointment-system/
├── pom.xml
├── database/
│   └── hospital_setup.sql
├── src/main/java/com/hospital/
│   ├── controller/  (Servlets)
│   ├── dao/         (Data Access Objects)
│   ├── model/       (Entities)
│   └── util/        (DBConnection)
├── src/main/webapp/
│   ├── css/style.css
│   ├── js/main.js
│   ├── index.jsp, login.jsp, register.jsp
│   ├── patient_dashboard.jsp, doctor_dashboard.jsp, admin_dashboard.jsp
│   └── WEB-INF/web.xml
└── supporting_experiments/
    ├── xml/          (XML, DTD, XSD)
    ├── node_express/ (Node.js, Express, REST CRUD, JWT)
    └── react_app/    (React TODO components)
```

## 12. Database Design
- `users`: Core table containing authentication and roles.
- `patients`: Contains demographic data, linked to users.
- `doctors`: Contains specialization data, linked to users and departments.
- `departments`: Categorizes doctors.
- `doctor_schedules`: Manages availability slots.
- `appointments`: Tracks bookings, links patients to doctors.

## 13. Database Setup
Execute the `database/hospital_setup.sql` script in MySQL to create the `hospital_db` database, tables, and default seed data (including admin, doctors, and test patients).

## 14. Authentication & Session Management
- Passwords are one-way hashed using SHA-256 before database insertion.
- `HttpSession` tracks the logged-in user and their role.
- Secure routes redirect unauthenticated access attempts back to the login page.

## 15. Double-Booking Prevention
The system validates appointment availability twice:
1. **Frontend**: Validates input formats and minimum dates.
2. **Backend**: The `AppointmentDAO` performs an atomic SQL `SELECT COUNT` transaction to ensure no overlapping `CONFIRMED` or `PENDING` appointment exists for the requested doctor and time slot before inserting.

## 16. Lab Experiment Mapping

| Experiment | Technology | Actual Implementation | Core / Supporting |
| :--- | :--- | :--- | :--- |
| Exp 1 | CSS3 / Responsive | `style.css` (Flexbox, custom properties, glassmorphism) | Core |
| Exp 2 | Bootstrap | Grid, Navbar, Cards, Forms across all JSPs | Core |
| Exp 3 | JS Validation | `main.js` Bootstrap validation API interception | Core |
| Exp 4 | ES6 / Async | `fetch()` API used in `main.js` for Chart data | Core |
| Exp 5 | Java + DB + JDBC | Complete DAO layer implementation | Core |
| Exp 6 | XML + DTD + XSD | `supporting_experiments/xml/` config files | Supporting |
| Exp 7 | Java Servlets | `LoginServlet`, `BookAppointmentServlet`, etc. | Core |
| Exp 8 | Session Tracking | `HttpSession` handling in all Servlets | Core |
| Exp 9 | Node.js | `supporting_experiments/node_express/server.js` | Supporting |
| Exp 10 | Express REST CRUD | `supporting_experiments/node_express/server.js` | Supporting |
| Exp 11 | JWT | `supporting_experiments/node_express/server.js` | Supporting |
| Exp 12 | React | `supporting_experiments/react_app/index.html` | Supporting |
| Exp 13 | Chart.js | Admin dashboard canvas rendering in `main.js` | Core |
| Exp 14 | React TODO | `supporting_experiments/react_app/index.html` | Supporting |

## 17. Security and Data Isolation
- Patients can only view and cancel their own appointments.
- Doctors only see their respective patients and schedules.
- Direct URL manipulation is intercepted by checking `session.getAttribute("role")` inside every Servlet `doGet`/`doPost`.
- No sensitive keys or plaintext passwords exist in the repository.

## 18. Healthcare Data Scope
*Disclaimer*: This application is designed solely for academic and administrative scheduling purposes. It does not provide medical diagnoses, treatment plans, or automated health advice.