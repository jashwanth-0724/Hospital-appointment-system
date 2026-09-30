<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hospital.model.Appointment" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Dashboard - CarePlus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
    <div class="dashboard-wrapper">
        <nav class="sidebar shadow-sm">
            <div class="px-4 mb-4">
                <h5 class="fw-bold text-primary"><i class="fas fa-shield-alt me-2"></i>Admin Panel</h5>
            </div>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link active" href="#"><i class="fas fa-chart-pie me-2"></i> Overview</a></li>
                <li class="nav-item mt-auto"><a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt me-2"></i> Logout</a></li>
            </ul>
        </nav>
        
        <main class="main-content">
            <h2 class="fw-bold mb-4">Hospital Overview</h2>
            
            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="card border-0 shadow-sm rounded-4 bg-primary text-white">
                        <div class="card-body p-4">
                            <h6 class="text-white-50">Total Appointments</h6>
                            <h2 class="fw-bold mb-0">${totalAppointments}</h2>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Experiment 13: Chart.js / Dynamic Data -->
            <div class="row g-4 mb-4">
                <div class="col-md-8">
                    <div class="card border-0 shadow-sm rounded-4 h-100">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4">Appointments by Department</h5>
                            <canvas id="analyticsChart" height="100"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card border-0 shadow-sm rounded-4 h-100">
                        <div class="card-body p-4">
                            <h5 class="fw-bold mb-4">Status Distribution</h5>
                            <canvas id="statusChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card border-0 shadow-sm rounded-4">
                <div class="card-body p-4">
                    <h5 class="card-title fw-bold mb-4">Recent Appointments (All)</h5>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Patient</th>
                                    <th>Doctor</th>
                                    <th>Department</th>
                                    <th>Date</th>
                                    <th>Time</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% 
                                   List<Appointment> appts = (List<Appointment>) request.getAttribute("appointments");
                                   if(appts != null && !appts.isEmpty()) {
                                       for(Appointment a : appts) { 
                                %>
                                <tr>
                                    <td><%= a.getPatientName() %></td>
                                    <td><%= a.getDoctorName() %></td>
                                    <td><%= a.getDepartmentName() %></td>
                                    <td><%= a.getAppointmentDate() %></td>
                                    <td><%= a.getAppointmentTime() %></td>
                                    <td><span class="status-badge status-<%= a.getStatus() %>"><%= a.getStatus() %></span></td>
                                </tr>
                                <% } } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
    
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
