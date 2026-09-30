<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Doctor" %>
<%@ page import="com.hospital.model.Department" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Book Appointment - CarePlus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="dashboard-wrapper">
        <nav class="sidebar shadow-sm">
            <div class="px-4 mb-4">
                <h5 class="fw-bold text-primary"><i class="fas fa-heartbeat me-2"></i>CarePlus</h5>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/patient/dashboard"><i class="fas fa-home me-2"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/patient/book"><i class="fas fa-calendar-plus me-2"></i> Book Appointment</a></li>
                <li class="nav-item mt-auto"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
            </ul>
        </nav>
        
        <main class="main-content">
            <h2 class="fw-bold mb-4">Book New Appointment</h2>
            
            <% if(request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("errorMessage") %></div>
            <% } %>

            <div class="card border-0 shadow-sm rounded-4">
                <div class="card-body p-4">
                    <form action="${pageContext.request.contextPath}/patient/book" method="post" id="bookForm" novalidate>
                        <div class="row g-4">
                            <div class="col-md-6">
                                <label class="form-label fw-bold text-muted small">Select Doctor</label>
                                <select class="form-select form-select-lg bg-light border-0" name="doctorId" required>
                                    <option value="">Choose a specialist...</option>
                                    <% 
                                       List<Doctor> docs = (List<Doctor>) request.getAttribute("doctors");
                                       if(docs != null) {
                                           for(Doctor d : docs) {
                                    %>
                                    <option value="<%= d.getDoctorId() %>">Dr. <%= d.getFirstName() %> <%= d.getLastName() %> (<%= d.getSpecialization() %> - <%= d.getDepartmentName() %>)</option>
                                    <% } } %>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold text-muted small">Date</label>
                                <input type="date" class="form-control form-control-lg bg-light border-0" name="appointmentDate" id="appointmentDate" required>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label fw-bold text-muted small">Time</label>
                                <input type="time" class="form-control form-control-lg bg-light border-0" name="appointmentTime" required>
                            </div>
                            <div class="col-md-12">
                                <label class="form-label fw-bold text-muted small">Reason for Visit</label>
                                <textarea class="form-control bg-light border-0" name="reason" rows="3" required></textarea>
                            </div>
                            <div class="col-12 text-end mt-4">
                                <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-light rounded-pill px-4 me-2">Cancel</a>
                                <button type="submit" class="btn btn-primary rounded-pill px-5 shadow-sm">Confirm Booking</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
