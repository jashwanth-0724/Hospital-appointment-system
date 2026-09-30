package com.hospital.controller;
import com.hospital.dao.AppointmentDAO;
import javax.servlet.ServletException; import javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest; import javax.servlet.http.HttpServletResponse; import javax.servlet.http.HttpSession; import java.io.IOException;

@WebServlet("/appointment/updateStatus")
public class UpdateStatusServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        String role = (String) session.getAttribute("role");
        if ("PATIENT".equals(role)) {
            // patient can only cancel
            String status = request.getParameter("status");
            if (!"CANCELLED".equals(status)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Patients can only cancel appointments");
                return;
            }
        }
        
        int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
        String status = request.getParameter("status");
        
        appointmentDAO.updateStatus(appointmentId, status);
        
        String referer = request.getHeader("Referer");
        response.sendRedirect(referer != null ? referer : request.getContextPath() + "/");
    }
}
