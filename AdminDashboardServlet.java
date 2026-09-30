package com.hospital.controller;
import com.hospital.dao.AppointmentDAO; import com.hospital.model.Appointment; import com.hospital.model.User;
import javax.servlet.ServletException; import javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest; import javax.servlet.http.HttpServletResponse; import javax.servlet.http.HttpSession; import java.io.IOException; import java.util.List;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || !"ADMIN".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        List<Appointment> appointments = appointmentDAO.getAllAppointments();
        int totalAppts = appointmentDAO.getTotalAppointments();
        
        request.setAttribute("appointments", appointments);
        request.setAttribute("totalAppointments", totalAppts);
        request.getRequestDispatcher("/admin_dashboard.jsp").forward(request, response);
    }
}
