<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL Tag Library များ ထည့်သွင်းခြင်း (ဒါမှ c:choose အလုပ်လုပ်မှာပါ) --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chapter-11's IDIOTS</title>
    <link href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-nav sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#">
                <i class="bi bi-cup-hot me-2"></i>Chapter-11's IDIOTS
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    
                    <c:choose>
                        <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin-home">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-menu">Menu</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-events">Events</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/our-journey">Our Journey</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menu">Menu</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/event">Events</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/our-journey">Our Journey</a></li>
                        </c:otherwise>
                    </c:choose>                    
                    
                    <li class="nav-item dropdown ms-lg-3 admin-section">
                        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <div class="admin-profile-circle">
                                <i class="bi bi-person-fill"></i>
                            </div>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end shadow-lg border-0" aria-labelledby="adminDropdown">
                            <c:choose>
                                <c:when test="${empty sessionScope.userRole}">
                                    <li><h6 class="dropdown-header text-uppercase small fw-bold text-muted">Guest Access</h6></li>
                                    <li><a class="dropdown-item py-2 text-primary fw-bold" href="${pageContext.request.contextPath}/login"><i class="bi bi-box-arrow-in-right me-2"></i>Login Required</a></li>
                                </c:when>

                                <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                                    <li><h6 class="dropdown-header text-uppercase small fw-bold">Admin Control</h6></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin-settings"><i class="bi bi-gear-fill me-2"></i>Settings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a></li>
                                </c:when>

                                <c:otherwise>
                                    <li><h6 class="dropdown-header text-uppercase small fw-bold">User Control</h6></li>
                                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/user-settings"><i class="bi bi-gear-fill me-2"></i>Settings</a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item py-2 text-danger" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right me-2"></i>Sign Out</a></li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="main-block">
        <div class="container hero-content text-center text-white d-flex flex-column justify-content-center align-items-center">
            <h1 class="display-3 fw-bold">Welcome to Chapter-11's IDIOTS</h1>
            <p class="fs-4">Where Coffee Meets Literature</p>
            
            <%-- 🎯 ပြင်ဆင်ရန်- Explore Menu ခလုတ်ကိုလည်း 'ADMIN' (စာလုံးအကြီး) ဖြင့် ပြောင်းလဲတိုက်စစ်ခြင်း --%>
            <c:choose>
                <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin-menu" class="btn btn-explore mt-3">Explore Menu</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/menu" class="btn btn-explore mt-3">Explore Menu</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="main-secblock py-5">
        <div class="container text-center">
            <h2 class="section-title">Our Story in Every Cup</h2>
            <p class="section-subtitle mb-5">A unique blend of artisan coffee, delicious food, and literary inspiration. Your perfect escape awaits.</p>
            
            <div class="row g-4 mb-5">
                <div class="col-md-4">
                    <div class="card story-card border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/IMG/premium_coffee.jpeg" class="card-img-top" alt="Premium Coffee">
                        <div class="card-body text-start">
                            <h5 class="card-title fw-bold">Premium Coffee</h5>
                            <p class="card-text">Handcrafted beverages made from the finest beans, roasted to perfection.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card story-card border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/IMG/curated_library.jpeg" class="card-img-top" alt="Curated Library">
                        <div class="card-body text-start">
                            <h5 class="card-title fw-bold">Curated Library</h5>
                            <p class="card-text">Thousands of books across genres, perfect for your reading pleasure.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card story-card border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/IMG/cozy_atmosphere.jpeg" class="card-img-top" alt="Cozy Atmosphere">
                        <div class="card-body text-start">
                            <h5 class="card-title fw-bold">Cozy Atmosphere</h5>
                            <p class="card-text">Warm, inviting spaces designed for comfort and creativity.</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="stats-banner p-5 text-white shadow-lg mt-5">
                <div class="row">
                    <div class="col-md-4 stat-item">
                        <h2 class="fw-bold display-5">500+</h2>
                        <p class="mb-0 text-warning">Happy Customers Daily</p>
                    </div>
                    <div class="col-md-4 stat-item">
                        <h2 class="fw-bold display-5">${totalBooks}+</h2>
                        <p class="mb-0 text-warning">Books in Library</p>
                    </div>
                    <div class="col-md-4">
                        <h2 class="fw-bold display-5">${totalMenu}+</h2>
                        <p class="mb-0 text-warning">Menu Items</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="main-thirdblock">
        <div class="container text-center">
            <h2 class="section-title mb-5">What Makes Us Special</h2>
            
            <div class="row g-4 mb-5 justify-content-center">
                <div class="col-6 col-md-3">
                    <div class="service-card p-4 shadow-sm h-100">
                        <div class="icon-circle mb-3"><i class="bi bi-cup-hot"></i></div>
                        <h6 class="fw-bold">Artisan Brews</h6>
                        <p class="small text-muted">Expert baristas crafting perfect cups</p>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="service-card p-4 shadow-sm h-100">
                        <div class="icon-circle mb-3"><i class="bi bi-book"></i></div>
                        <h6 class="fw-bold">Reading Haven</h6>
                        <p class="small text-muted">Quiet corners for book lovers</p>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="service-card p-4 shadow-sm h-100">
                        <div class="icon-circle mb-3"><i class="bi bi-wifi"></i></div>
                        <h6 class="fw-bold">Free WiFi</h6>
                        <p class="small text-muted">Stay connected while you relax</p>
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="service-card p-4 shadow-sm h-100">
                        <div class="icon-circle mb-3"><i class="bi bi-people"></i></div>
                        <h6 class="fw-bold">Community</h6>
                        <p class="small text-muted">Regular events and gatherings</p>
                    </div>
                </div>
            </div>

            <div class="hours-container p-5 shadow-sm text-start bg-white mt-5">
                <div class="row align-items-center">
                    <div class="col-md-6 pe-md-5">
                        <h3 class="section-title fs-2 mb-4">Opening Hours</h3>
                        <div class="d-flex justify-content-between border-bottom py-2">
                            <span class="fw-bold">Monday - Friday</span>
                            <span>7:00 AM - 10:00 PM</span>
                        </div>
                        <div class="d-flex justify-content-between border-bottom py-2">
                            <span class="fw-bold">Saturday</span>
                            <span>8:00 AM - 11:00 PM</span>
                        </div>
                        <div class="d-flex justify-content-between py-2">
                            <span class="fw-bold">Sunday</span>
                            <span>8:00 AM - 9:00 PM</span>
                        </div>
                    </div>
                    <div class="col-md-6 mt-4 mt-md-0">
                        <img src="${pageContext.request.contextPath}/IMG/cafe_hours.jpeg" class="img-fluid rounded-4 shadow" alt="Cafe Hours">
                    </div>
                </div>
            </div>
        </div>
     </div>
    <div class="main-Fourthblock py-5">
        <div class="container">
            <div class="visit-banner p-5 text-center text-white mb-5 shadow">
                <h2 class="section-title text-white mb-2">Visit Us Today</h2>
                <p class="mb-4">123 Literary Lane, Book District, City 12345</p>
                <div class="d-flex justify-content-center gap-3">
                    <a href="#" class="btn btn-light rounded-pill px-4">
                        <i class="bi bi-telephone-fill me-2"></i>Call Us
                    </a>
                    <a href="#" class="btn btn-warning-custom rounded-pill px-4 text-white">
                        <i class="bi bi-geo-alt-fill me-2"></i>Get Directions
                    </a>
                </div>
            </div>

            <div class="row g-3">
                <div class="col-6 col-md-3">
                    <div class="gallery-item shadow-sm">
                        <img src="${pageContext.request.contextPath}/IMG/mainfourthP1.jpeg" class="img-fluid rounded-3" alt="Coffee Pour">
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="gallery-item shadow-sm">
                        <img src="${pageContext.request.contextPath}/IMG/mainfourthP2.jpeg" class="img-fluid rounded-3" alt="Coffee Beans">
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="gallery-item shadow-sm">
                        <img src="${pageContext.request.contextPath}/IMG/mainfourthP3.jpeg" class="img-fluid rounded-3" alt="Bean Texture">
                    </div>
                </div>
                <div class="col-6 col-md-3">
                    <div class="gallery-item shadow-sm">
                        <img src="${pageContext.request.contextPath}/IMG/mainfourthP4.jpeg" class="img-fluid rounded-3" alt="Cafe Interior">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer class="main-lastblock pt-5 pb-3">
        <div class="container text-white">
            <div class="row g-4">
                <div class="col-md-3">
                    <h4 class="fw-bold mb-3">Chapter-11's IDIOTS</h4>
                    <p class="small opacity-75">Where Coffee Meets Literature</p>
                </div>
                
                <div class="col-md-3">
                    <h5 class="fw-bold mb-3">Quick Links</h5>
                    <ul class="list-unstyled footer-links">
                        <c:choose>
                            <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                                <li><a href="${pageContext.request.contextPath}/admin-home">Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin-menu">Menu</a></li>
                                <li><a href="${pageContext.request.contextPath}/admin-events">Events</a></li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/menu">Menu</a></li>
                                <li><a href="${pageContext.request.contextPath}/event">Events</a></li>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>

                <div class="col-md-3">
                    <h5 class="fw-bold mb-3">Contact</h5>
                    <ul class="list-unstyled small opacity-75">
                        <li class="mb-2">123 Literary Lane</li>
                        <li class="mb-2">Book District, City 12345</li>
                        <li class="mb-2">Phone: (+95) 9978407566</li>
                        <li>Email: kaunglinux.dev@gmail.com</li>
                    </ul>
                </div>

                <div class="col-md-3">
                    <h5 class="fw-bold mb-3">Hours</h5>
                    <ul class="list-unstyled small opacity-75">
                        <li class="mb-2">Mon-Fri: 7AM - 10PM</li>
                        <li class="mb-2">Saturday: 8AM - 11PM</li>
                        <li>Sunday: 8AM - 9PM</li>
                    </ul>
                </div>
            </div>

            <hr class="mt-5 mb-4 opacity-25">
            
            <div class="text-center small opacity-75">
                <p>&copy; 2026 Chapter-11's IDIOTS. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>