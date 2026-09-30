package com.hospital.controller;
import com.hospital.dao.AppointmentDAO; import com.google.gson.Gson; import com.hospital.model.Appointment;
import javax.servlet.ServletException; import javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest; import javax.servlet.http.HttpServletResponse; import java.io.IOException; import java.util.List; import java.util.Map; import java.util.HashMap; import java.util.stream.Collectors;

@WebServlet("/api/analytics/appointments")
public class AnalyticsServlet extends HttpServlet {
    private AppointmentDAO appointmentDAO = new AppointmentDAO();
    private Gson gson = new Gson();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Appointment> allAppts = appointmentDAO.getAllAppointments();
        
        Map<String, Long> byDepartment = allAppts.stream()
            .collect(Collectors.groupingBy(Appointment::getDepartmentName, Collectors.counting()));
            
        Map<String, Long> byStatus = allAppts.stream()
            .collect(Collectors.groupingBy(Appointment::getStatus, Collectors.counting()));
            
        Map<String, Object> result = new HashMap<>();
        result.put("byDepartment", byDepartment);
        result.put("byStatus", byStatus);
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(result));
    }
}
