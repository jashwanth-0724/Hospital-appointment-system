package com.hospital.controller;
import com.hospital.dao.AppointmentDAO; import com.hospital.dao.PatientDAO; import com.hospital.model.Appointment; import com.hospital.model.Patient; import com.hospital.model.User;
import javax.servlet.ServletException; import javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest; import javax.servlet.http.HttpServletResponse; import javax.servlet.http.HttpSession; import java.io.IOException; import java.util.List;

@WebServlet("/patient/dashboard")
public class PatientDashboardServlet extends HttpServlet {
    private PatientDAO patientDAO = new PatientDAO();
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"PATIENT".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("user");
        Patient patient = patientDAO.getPatientByUserId(user.getId());
        if (patient != null) {
            List<Appointment> appointments = appointmentDAO.getAppointmentsByPatient(patient.getPatientId());
            request.setAttribute("patient", patient);
            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("/patient_dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
