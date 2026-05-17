<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Account Settings - Chapter-11's IDIOTS</title>
    <link href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Account_settings.css">
</head>
<body class="settings-page">

    <nav class="navbar navbar-expand-lg navbar-dark custom-nav sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/admin-home">
                <i class="bi bi-cup-hot me-2"></i>Chapter-11's IDIOTS
            </a>
            <div class="ms-auto">
                <a href="${pageContext.request.contextPath}/admin-home" class="btn btn-outline-light btn-sm rounded-pill px-3">
                    <i class="bi bi-arrow-left me-1"></i> Back to Home
                </a>
            </div>
        </div>
    </nav>

    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <h2 class="settings-title text-center mb-4">Account Management</h2>
                
                <%-- 🎯 စနစ်မှ ပြန်ပြသမည့် Error သို့မဟုတ် Success Message များ (Dismissible Cross Button ဖြည့်ထားသည်) --%>
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show rounded-pill px-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> ${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <% session.removeAttribute("errorMessage"); %>
                    </div>
                </c:if>
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show rounded-pill px-4" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i> ${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        <% session.removeAttribute("successMessage"); %>
                    </div>
                </c:if>
                
                <div class="card settings-card border-0 shadow-sm mb-4">
                    <div class="card-body p-4">
                        <h5 class="card-subtitle fw-bold mb-4">
                            <i class="bi bi-envelope-at-fill me-2"></i>Email Address
                        </h5>
                        <form action="${pageContext.request.contextPath}/updateEmail" method="POST">
                            <div class="mb-3">
                                <label class="form-label small fw-bold text-muted">Current Email</label>
                                <input type="email" class="form-control readonly-field" 
                                       value="${not empty sessionScope.email ? sessionScope.email : 'user@gmail.com'}" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">New Email</label>
                                <input type="email" name="newEmail" class="form-control" placeholder="Enter new email address" required>
                            </div>
                            <button type="submit" class="btn btn-save w-100 rounded-pill py-2">Update Email</button>
                        </form>
                    </div>
                </div>

                <div class="card settings-card border-0 shadow-sm">
                    <div class="card-body p-4">
                        <h5 class="card-subtitle fw-bold mb-4">
                            <i class="bi bi-shield-lock-fill me-2"></i>Security Password
                        </h5>
                        <form action="${pageContext.request.contextPath}/updatePassword" method="POST">
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Current Password</label>
                                <input type="password" name="currentPassword" class="form-control" placeholder="Enter current password" required>
                            </div>
                            <hr class="my-4 opacity-10">
                            <div class="mb-3">
                                <label class="form-label small fw-bold">New Password</label>
                                <input type="password" name="newPassword" class="form-control" placeholder="Minimum 8 characters" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label small fw-bold">Confirm New Password</label>
                                <input type="password" name="confirmPassword" class="form-control" placeholder="Re-type new password" required>
                            </div>
                            <button type="submit" class="btn btn-save w-100 rounded-pill py-2">Update Password</button>
                        </form>
                    </div>
                </div>

                <div class="text-center mt-4 text-muted small">
                    <i class="bi bi-info-circle me-1"></i> Security changes may require you to log in again.
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>