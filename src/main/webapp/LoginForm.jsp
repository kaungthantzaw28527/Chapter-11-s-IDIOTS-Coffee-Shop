<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chapter-11 Admin Portal</title>
    <link href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/authentication.css">
    <style>
	    body{
		    background: radial-gradient(circle at top, rgba(125, 60, 0, 0.4) 0%, rgba(0, 0, 0, 0.9) 100%),
		                url('${pageContext.request.contextPath}/IMG/admin_bg.jpg');
	    }
    </style>
</head>
<body>

    <div class="login-wrapper">
        <div class="glass-card">
            <div class="icon-header">
                <div class="fingerprint-box">
                    <img src="${pageContext.request.contextPath}/IMG/finger.png" alt="Fingerprint" id="finger-img">
                </div>
            </div>

            <div class="text-center mb-4">
                <h1 class="admin-title">Admin Portal</h1>
                <p class="admin-subtitle">Welcome to your premium workspace</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger py-2" style="font-size: 0.8rem; border-radius: 10px;">
                    ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="POST">
                
                <div class="form-group mb-3">
                    <label class="form-label-custom">Username or Email</label>
                    <div class="input-container">
                        <span class="input-icon">@</span>
                        <input type="text" name="username" class="form-control-custom" placeholder="admin@company.com" required>
                    </div>
                </div>

                <div class="form-group mb-4">
                    <label class="form-label-custom">Password</label>
                    <div class="input-container">
                        <span class="input-icon">🔒</span>
                        <input type="password" name="password" class="form-control-custom" placeholder="Enter your password" required>
                    </div>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4 options-text">
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="remember">
                        <label class="form-check-label" for="remember">Remember me</label>
                    </div>
                    <a href="#" class="forgot-link">Forgot password?</a>
                </div>

                <button type="submit" style="background: none; border: none; width: 100%; padding: 0;">
                    <div class="btn-signin">Sign In</div>
                </button>

                <div class="text-center mt-4 support-text">
                    Don’t you have an account? <a href="${pageContext.request.contextPath}/signup" class="support-link">Register</a>
                </div>
            </form>
        </div>
        
        <div class="footer-copyright">
            Crafted with excellence © 2026
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>