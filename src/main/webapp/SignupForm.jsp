<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | Chapter-11 Admin Portal</title>
    <link href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/authentication.css">
    <style>
        body {
            background: radial-gradient(circle at top, rgba(125, 60, 0, 0.4) 0%, rgba(0, 0, 0, 0.9) 100%),
                        url('${pageContext.request.contextPath}/IMG/admin_bg.jpg');
            min-height: 100vh;
        }
        .glass-card {
            max-width: 450px;
            margin: 20px auto;
        }
    </style>
</head>
<body>

    <div class="login-wrapper py-4">
        <div class="glass-card">
            <div class="icon-header">
                <div class="fingerprint-box">
                    <img src="${pageContext.request.contextPath}/IMG/finger.png" alt="Registration" id="finger-img">
                </div>
            </div>

            <div class="text-center mb-4">
                <h1 class="admin-title">Create Account</h1>
                <p class="admin-subtitle">Register to Chapter-11 Portal</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2" style="font-size: 0.8rem; border-radius: 10px;">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/signup" method="POST">
                
                <div class="form-group mb-3">
                    <label class="form-label-custom">Full Name</label>
                    <div class="input-container">
                        <span class="input-icon">👤</span>
                        <input type="text" name="name" class="form-control-custom" placeholder="Your Full Name" required>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <label class="form-label-custom">Email Address</label>
                    <div class="input-container">
                        <span class="input-icon">@</span>
                        <input type="email" name="email" class="form-control-custom" placeholder="admin@chapter11.com" required>
                    </div>
                </div>

                <div class="form-group mb-3">
                    <label class="form-label-custom">Password</label>
                    <div class="input-container">
                        <span class="input-icon">🔒</span>
                        <input type="password" name="password" class="form-control-custom" placeholder="Min. 8 characters" required>
                    </div>
                </div>

                <div class="form-group mb-4">
                    <label class="form-label-custom">Confirm Password</label>
                    <div class="input-container">
                        <span class="input-icon">🛡️</span>
                        <input type="password" name="confirmPassword" class="form-control-custom" placeholder="Repeat your password" required>
                    </div>
                </div>

                <button type="submit" style="background: none; border: none; width: 100%; padding: 0;">
                    <div class="btn-signin">Sign Up</div>
                </button>

                <div class="text-center mt-4 support-text">
                    Already have an account? <a href="${pageContext.request.contextPath}/login" class="support-link">Sign In</a>
                </div>
            </form>
        </div>
        
        <div class="footer-copyright pb-4">
            Crafted with excellence © 2026
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>