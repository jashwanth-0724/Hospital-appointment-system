<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Appointment System | Modern Healthcare</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm fixed-top">
        <div class="container">
            <a class="navbar-brand text-primary fw-bold" href="${pageContext.request.contextPath}/">
                <i class="fas fa-heartbeat me-2"></i>CarePlus
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <% if(session.getAttribute("user") != null) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/<%= session.getAttribute("role").toString().toLowerCase() %>/dashboard">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">Logout</a>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/login">Login</a>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-primary rounded-pill px-4 ms-2" href="${pageContext.request.contextPath}/register">Register Patient</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <header class="hero-section text-center text-md-start">
        <div class="container h-100">
            <div class="row h-100 align-items-center">
                <div class="col-md-6">
                    <h1 class="display-4 fw-bold text-dark mb-4">Your Health, <br><span class="text-primary">Our Priority.</span></h1>
                    <p class="lead text-muted mb-5">Book appointments with top doctors instantly. Experience seamless healthcare management with CarePlus.</p>
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-primary btn-lg rounded-pill px-5 py-3 me-3 mb-3 shadow">Get Started</a>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-secondary btn-lg rounded-pill px-5 py-3 mb-3">Book Appointment</a>
                </div>
                <div class="col-md-6 d-none d-md-block">
                    <!-- Hero Illustration / CSS Styling -->
                    <div class="hero-image-placeholder rounded-4 shadow-lg">
                        <div class="glass-card text-center p-4">
                            <i class="fas fa-user-md fa-4x text-primary mb-3"></i>
                            <h4>Top Specialists</h4>
                            <p class="text-muted small">24/7 Availability</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Services Section -->
    <section class="py-5 bg-light">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold">Our Core Departments</h2>
                <p class="text-muted">Comprehensive care for you and your family.</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card service-card h-100 border-0 shadow-sm text-center p-4">
                        <div class="icon-wrapper bg-primary bg-opacity-10 text-primary mb-3 mx-auto">
                            <i class="fas fa-heart fa-2x"></i>
                        </div>
                        <h4 class="card-title">Cardiology</h4>
                        <p class="card-text text-muted">Advanced heart care and treatments by renowned cardiologists.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card service-card h-100 border-0 shadow-sm text-center p-4">
                        <div class="icon-wrapper bg-info bg-opacity-10 text-info mb-3 mx-auto">
                            <i class="fas fa-brain fa-2x"></i>
                        </div>
                        <h4 class="card-title">Neurology</h4>
                        <p class="card-text text-muted">Comprehensive neurological care and diagnostics.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card service-card h-100 border-0 shadow-sm text-center p-4">
                        <div class="icon-wrapper bg-success bg-opacity-10 text-success mb-3 mx-auto">
                            <i class="fas fa-baby fa-2x"></i>
                        </div>
                        <h4 class="card-title">Pediatrics</h4>
                        <p class="card-text text-muted">Friendly and expert medical care for infants and children.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4 mt-auto">
        <div class="container text-center">
            <p class="mb-0">&copy; 2026 CarePlus Hospital Appointment System. Academic Project.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
