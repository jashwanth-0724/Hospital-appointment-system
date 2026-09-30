package com.hospital.controller;
import com.hospital.dao.AppointmentDAO; import com.hospital.dao.DoctorDAO; import com.hospital.model.Appointment; import com.hospital.model.Doctor; import com.hospital.model.User;
import javax.servlet.ServletException; import javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest; import javax.servlet.http.HttpServletResponse; import javax.servlet.http.HttpSession; import java.io.IOException; import java.util.List;

@WebServlet("/doctor/dashboard")
public class DoctorDashboardServlet extends HttpServlet {
    private DoctorDAO doctorDAO = new DoctorDAO();
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"DOCTOR".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        User user = (User) session.getAttribute("user");
        Doctor doctor = doctorDAO.getDoctorByUserId(user.getId());
        if (doctor != null) {
            List<Appointment> appointments = appointmentDAO.getAppointmentsByDoctor(doctor.getDoctorId());
            request.setAttribute("doctor", doctor);
            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("/doctor_dashboard.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }
}
