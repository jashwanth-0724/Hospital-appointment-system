<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Appointment" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Patient Dashboard - CarePlus</title>
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
                <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/patient/dashboard"><i class="fas fa-home me-2"></i> Dashboard</a></li>
                <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/patient/book"><i class="fas fa-calendar-plus me-2"></i> Book Appointment</a></li>
                <li class="nav-item mt-auto"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
            </ul>
        </nav>
        
        <main class="main-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold">Welcome, ${patient.firstName}</h2>
                <a href="${pageContext.request.contextPath}/patient/book" class="btn btn-primary rounded-pill shadow-sm"><i class="fas fa-plus me-2"></i>New Appointment</a>
            </div>
            
            <% if(request.getParameter("booked") != null) { %>
                <div class="alert alert-success border-0 shadow-sm rounded-3"><i class="fas fa-check-circle me-2"></i>Appointment booked successfully!</div>
            <% } %>

            <div class="card border-0 shadow-sm rounded-4">
                <div class="card-body p-4">
                    <h5 class="card-title fw-bold mb-4">My Appointments</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Doctor</th>
                                    <th>Department</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                   List<Appointment> appts = (List<Appointment>) request.getAttribute("appointments");
                                   if(appts != null && !appts.isEmpty()) {
                                       for(Appointment a : appts) { 
                                %>
                                <tr>
                                    <td class="fw-bold"><%= a.getDoctorName() %></td>
                                    <td><span class="badge bg-light text-dark border"><%= a.getDepartmentName() %></span></td>
                                    <td><%= a.getAppointmentDate() %></td>
                                    <td><%= a.getAppointmentTime() %></td>
                                    <td><span class="status-badge status-<%= a.getStatus() %>"><%= a.getStatus() %></span></td>
                                    <td>
                                        <% if("CONFIRMED".equals(a.getStatus()) || "PENDING".equals(a.getStatus())) { %>
                                            <form action="${pageContext.request.contextPath}/appointment/updateStatus" method="post" class="d-inline">
                                                <input type="hidden" name="appointmentId" value="<%= a.getId() %>">
                                                <input type="hidden" name="status" value="CANCELLED">
                                                <button type="submit" class="btn btn-sm btn-outline-danger rounded-pill px-3" onclick="return confirm('Cancel appointment?')">Cancel</button>
                                            </form>
                                        <% } else { %>
                                            <span class="text-muted small">-</span>
                                        <% } %>
                                    </td>
                                </tr>
                                <% } } else { %>
                                <tr><td colspan="6" class="text-center py-4 text-muted">No appointments found. Book one today!</td></tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
