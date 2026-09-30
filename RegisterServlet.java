package com.hospital.controller;
import com.hospital.dao.PatientDAO; import com.hospital.model.Patient;
import javax.servlet.ServletException; import javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet; import javax.servlet.http.HttpServletRequest; import javax.servlet.http.HttpServletResponse; import java.io.IOException; import java.sql.Date; import java.security.MessageDigest; import java.security.NoSuchAlgorithmException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private PatientDAO patientDAO = new PatientDAO();
    
    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] encodedhash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : encodedhash) {
                String hex = Integer.toHexString(0xff & b);
                if(hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) { throw new RuntimeException(e); }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Patient p = new Patient();
        p.setFirstName(request.getParameter("firstName"));
        p.setLastName(request.getParameter("lastName"));
        p.setEmail(request.getParameter("email"));
        p.setPasswordHash(hashPassword(request.getParameter("password")));
        p.setPhone(request.getParameter("phone"));
        p.setDateOfBirth(Date.valueOf(request.getParameter("dateOfBirth")));
        p.setGender(request.getParameter("gender"));
        p.setAddress(request.getParameter("address"));
        
        if (patientDAO.registerPatient(p)) {
            response.sendRedirect("login?registered=true");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Email might already exist.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
