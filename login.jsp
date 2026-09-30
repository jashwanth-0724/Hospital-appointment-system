<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login - CarePlus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="bg-light auth-bg">
    <div class="container h-100">
        <div class="row h-100 justify-content-center align-items-center">
            <div class="col-md-5">
                <div class="card border-0 shadow-lg rounded-4 overflow-hidden">
                    <div class="card-body p-5">
                        <div class="text-center mb-4">
                            <h2 class="fw-bold text-primary">Welcome Back</h2>
                            <p class="text-muted">Login to manage your appointments</p>
                        </div>
                        
                        <% if(request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= request.getAttribute("errorMessage") %>
                            </div>
                        <% } %>
                        <% if(request.getParameter("registered") != null) { %>
                            <div class="alert alert-success" role="alert">
                                Registration successful! Please login.
                            </div>
                        <% } %>

                        <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm" novalidate>
                            <div class="mb-3">
                                <label class="form-label text-muted small fw-bold">Email Address</label>
                                <input type="email" class="form-control form-control-lg bg-light border-0" name="email" id="email" required>
                                <div class="invalid-feedback">Please enter a valid email.</div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label text-muted small fw-bold">Password</label>
                                <input type="password" class="form-control form-control-lg bg-light border-0" name="password" id="password" required minlength="6">
                                <div class="invalid-feedback">Password must be at least 6 characters.</div>
                            </div>
                            <button type="submit" class="btn btn-primary btn-lg w-100 rounded-pill shadow-sm mb-3">Login</button>
                            <div class="text-center">
                                <span class="text-muted">Don't have an account?</span> <a href="${pageContext.request.contextPath}/register" class="text-decoration-none fw-bold">Register Here</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>
