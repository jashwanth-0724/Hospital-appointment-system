package com.hospital.controller;
import com.hospital.dao.AppointmentDAO; import com.hospital.dao.DoctorDAO; import com.hospital.dao.DepartmentDAO; import com.hospital.model.Appointment; import com.hospital.model.Doctor; import com.hospital.model.Patient; import com.hospital.dao.PatientDAO; import com.hospital.model.User;
import javax.servlet.ServletException; import javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest; import javax.servlet.http.HttpServletResponse; import javax.servlet.http.HttpSession; import java.io.IOException; import java.sql.Date; import java.sql.Time; import java.util.List;

@WebServlet("/patient/book")
public class BookAppointmentServlet extends HttpServlet {
    private DoctorDAO doctorDAO = new DoctorDAO();
    private DepartmentDAO departmentDAO = new DepartmentDAO();
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private PatientDAO patientDAO = new PatientDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"PATIENT".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        request.setAttribute("doctors", doctorDAO.getAllDoctors());
        request.setAttribute("departments", departmentDAO.getAllDepartments());
        request.getRequestDispatcher("/book_appointment.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"PATIENT".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        Patient patient = patientDAO.getPatientByUserId(user.getId());
        
        int doctorId = Integer.parseInt(request.getParameter("doctorId"));
        Date apptDate = Date.valueOf(request.getParameter("appointmentDate"));
        Time apptTime = Time.valueOf(request.getParameter("appointmentTime") + ":00");
        String reason = request.getParameter("reason");
        
        Appointment appt = new Appointment();
        appt.setPatientId(patient.getPatientId());
        appt.setDoctorId(doctorId);
        appt.setAppointmentDate(apptDate);
        appt.setAppointmentTime(apptTime);
        appt.setReason(reason);
        
        if (appointmentDAO.bookAppointment(appt)) {
            response.sendRedirect(request.getContextPath() + "/patient/dashboard?booked=true");
        } else {
            request.setAttribute("errorMessage", "Slot not available. Double booking prevented.");
            doGet(request, response);
        }
    }
}
