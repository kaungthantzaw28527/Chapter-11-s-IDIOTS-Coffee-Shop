<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chapter-11's IDIOTS</title>
    <link href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Event.css">
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
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-home">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-menu">Menu</a></li>
                            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin-events">Events</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/our-journey">Our Journey</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/menu">Menu</a></li>
                            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/event">Events</a></li>
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

    <div class="EventsBody py-5">
        <div class="container text-center">
            <h1 class="events-main-title mb-2">Events</h1>
            <p class="events-subtitle mb-5">Join us for exciting gatherings and activities</p>

            <div class="text-start mb-4">
                <h3 class="event-category-title">Past Events</h3>
            </div>
            <div class="row g-4 mb-5">
                <c:forEach var="event" items="${pastList}">
                    <c:if test="${event.completed}">
                        <div class="col-md-4">
                            <div class="event-card past shadow-sm">
                                <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                                    <div class="admin-actions">
                                        <button class="btn btn-delete-sm" title="Delete Event" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal" onclick="prepareDelete(${event.eventId})">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </div>
                                </c:if>
                                <img src="${pageContext.request.contextPath}${event.imagePath}" class="event-img" alt="${event.title}">
                                <div class="event-info p-4 text-start">
                                    <p class="event-date">${event.eventDate}</p>
                                    <h5 class="event-name">${event.title}</h5>
                                    <p class="event-desc text-muted">${event.description}</p>
                                    <span class="badge-completed">Completed</span>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>

            <div class="text-start mb-4">
                <h3 class="event-category-title">Upcoming Events</h3>
            </div>
            <div class="row g-4">
                <c:forEach var="event" items="${upcomingList}">
                    <c:if test="${!event.completed}">
                        <div class="col-md-4">
                            <div class="event-card upcoming shadow-sm">
                                <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                                    <div class="admin-actions">
                                        <button class="btn btn-edit-sm" title="Edit Event" 
										        data-bs-toggle="modal" 
										        data-bs-target="#editEventModal" 
										        onclick="populateEditModal(this)"
										        data-id="${event.eventId}"
										        data-title="${event.title}"
										        data-date="${event.eventDate}"
										        data-location="${event.location}"
										        data-guests="${event.maxGuests}"
										        data-description="${event.description}"
										        data-completed="${event.completed}">
										    <i class="bi bi-pencil-square"></i>
										</button>
                                        <button class="btn btn-delete-sm" title="Delete Event" data-bs-toggle="modal" data-bs-target="#deleteConfirmModal" onclick="prepareDelete(${event.eventId})">
                                            <i class="bi bi-trash-fill"></i>
                                        </button>
                                    </div>
                                </c:if>
                                
                                <img src="${pageContext.request.contextPath}${event.imagePath}" class="event-img" alt="${event.title}">
                                <div class="event-info p-4 text-start">
                                    <p class="event-date">${event.eventDate}</p>
                                    <h5 class="event-name">${event.title}</h5>
                                    <p class="event-desc text-muted">${event.description}</p>
                                    
                                    <p class="small text-secondary mb-2">Available Seats: ${event.maxGuests - event.currentGuests} / ${event.maxGuests}</p>
                                    
                                    <c:choose>
                                        <c:when test="${event.currentGuests >= event.maxGuests}">
                                            <button class="btn btn-secondary w-100 disabled" style="background-color: #6c757d; border-color: #6c757d; cursor: not-allowed;" disabled>
                                                <i class="bi bi-x-circle me-1"></i> Unavailable (Full)
                                            </button>
                                        </c:when>
                                        
                                        <c:otherwise>
                                            <c:choose>
                                                <c:when test="${empty sessionScope.userRole}">
                                                    <a href="${pageContext.request.contextPath}/login" class="btn btn-register d-block text-center text-decoration-none">Register Now</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-register" 
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#registerModal" 
                                                            onclick="setRegistrationEvent('${event.eventId}', '${event.title}', '${event.eventDate}', '${event.location}', ${event.maxGuests}, ${event.currentGuests})">
                                                        Register Now
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </div>

    <div class="RegiForm">
        <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg">
                    <div class="modal-header border-0 pb-0">
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body px-4 pb-4">
                        <h3 class="modal-title mb-1" id="registerModalLabel">Register for Event</h3>
                        <p class="text-muted small mb-4">Complete the form below to secure your spot.</p>

                        <div class="event-summary-card p-3 mb-4">
                            <h6 class="event-title-sm mb-3" id="regEventTitle">Event Title</h6>
                            <div class="row g-2 small">
                                <div class="col-6"><i class="bi bi-calendar3 me-2"></i><span id="regEventDate">Date</span></div>
                                <div class="col-6"><i class="bi bi-geo-alt me-2"></i><span id="regEventLocation">Location</span></div>
                            </div>
                        </div>
                        
						<form id="eventForm" action="${pageContext.request.contextPath}/registerEvent" method="POST">
						    <input type="hidden" name="eventId" id="regEventId">
                            <input type="hidden" id="regAvailableSlots">
						
						    <div class="mb-3">
							    <label class="form-label small fw-bold">Full Name *</label>
							    <input type="text" name="fullName" class="form-control bg-light" placeholder="John Doe" required>
							</div>
							<div class="row mb-3">
							    <div class="col-md-6">
							        <label class="form-label small fw-bold">Email Address *</label>
							        <input type="email" name="email" class="form-control bg-light" placeholder="john@example.com" required>
							    </div>
							    <div class="col-md-6">
							        <label class="form-label small fw-bold">Phone Number</label>
							        <input type="tel" name="phone" class="form-control bg-light" placeholder="(555) 123-4567">
							    </div>
							</div>
							<div class="mb-3">
							    <label class="form-label small fw-bold">Number of Guests *</label>
							    <input type="number" name="guests" id="regGuestsInput" class="form-control bg-light" value="1" min="1" required>
							</div>
							<div class="mb-4">
							    <label class="form-label small fw-bold">Special Requests</label>
							    <textarea name="requests" class="form-control bg-light" rows="3" placeholder="Any allergies..."></textarea>
							</div>
							<div class="d-flex gap-3 mt-4">
							    <button type="button" class="btn btn-outline-warning w-100 rounded-pill text-dark" data-bs-dismiss="modal">Cancel</button>
							    <button type="submit" class="btn btn-register-complete w-100 rounded-pill text-white">Complete Registration</button>
							</div>
						</form>
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
                        <li>Phone: (+95) 9978407566</li>
                        <li>Email: kaunglinux.dev@gmail.com</li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5 class="fw-bold mb-3">Hours</h5>
                    <ul class="list-unstyled small opacity-75">
                        <li class="mb-2">Mon-Fri: 7AM - 10PM</li>
                        <li>Sat-Sun: 8AM - 11PM</li>
                    </ul>
                </div>
            </div>
            <hr class="mt-5 mb-4 opacity-25">
            <div class="text-center small opacity-75">
                <p>&copy; 2026 Chapter-11's IDIOTS. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <c:if test="${sessionScope.userRole eq 'ADMIN'}">
        <div class="admin-controls-wrapper">
            <div class="dropup">
                <button class="btn btn-admin-main shadow-lg" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-tools me-2"></i>Admin Tool
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow admin-dropdown-menu">
                    <li>
                        <a class="dropdown-item py-2" href="#" data-bs-toggle="modal" data-bs-target="#addEventModal">
                            <i class="bi bi-plus-circle-fill text-success me-2"></i>Add New Event
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item py-2" href="${pageContext.request.contextPath}/admin-registrations">
                            <i class="bi bi-people-fill text-primary me-2"></i>View Registrations
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="modal fade" id="addEventModal" tabindex="-1" aria-labelledby="addEventModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg custom-modal-style">
                    <div class="modal-header text-white p-4">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-calendar-plus fs-3 me-3"></i>
                            <div>
                                <h5 class="modal-title mb-0 fw-bold" id="addEventModalLabel">Add New Event</h5>
                                <small class="opacity-75">Create a new experience for customers</small>
                            </div>
                        </div>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4 bg-white">
                        <form id="addEventForm" action="admin-events" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="add">
                            <div class="mb-4">
                                <label class="form-label custom-label">Event Title</label>
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-soft-brown"><i class="bi bi-pencil-square"></i></span>
                                    <input type="text" name="title" class="form-control custom-input" placeholder="e.g. Weekend Latte Art" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-4">
                                    <label class="form-label custom-label">Date & Time</label>
                                    <input type="datetime-local" name="eventDate" class="form-control custom-input" required>
                                </div>
                                <div class="col-md-6 mb-4">
                                    <label class="form-label custom-label">Max Guests</label>
                                    <input type="number" name="maxGuests" class="form-control custom-input" value="50" min="1">
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label custom-label">Location</label>
                                <div class="input-group">
                                    <span class="input-group-text border-0 bg-soft-brown"><i class="bi bi-geo-alt-fill"></i></span>
                                    <input type="text" name="location" class="form-control custom-input" placeholder="Main Branch, Mandalay">
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label custom-label">Event Banner</label>
                                <input type="file" name="eventImage" class="form-control custom-input file-input" accept="image/*">
                            </div>
                            <div class="mb-4">
                                <label class="form-label custom-label">Description</label>
                                <textarea name="description" class="form-control custom-input" rows="4" placeholder="Briefly describe the event highlights..."></textarea>
                            </div>
                            <div class="d-flex gap-3 pt-2">
                                <button type="button" class="btn btn-cancel w-100 py-2 fw-bold" data-bs-dismiss="modal">Discard</button>
                                <button type="submit" class="btn btn-save w-100 py-2 fw-bold shadow-sm">Post Event</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="editEventModal" tabindex="-1" aria-labelledby="editEventModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content border-0 shadow-lg custom-modal-style">
                    <div class="modal-header text-white p-4" style="background-color: #5d2e00; border-bottom: none;">
                        <div class="header-content-wrapper d-flex align-items-center w-100">
                            <div class="edit-icon-container me-3">
                                <i class="bi bi-pencil-square fs-3"></i>
                            </div>
                            <div class="header-text-info">
                                <h5 class="modal-title mb-0 fw-bold" id="editEventModalLabel">Edit Event Details</h5>
                                <p class="mb-0 opacity-75 small">Update or complete your event information</p>
                            </div>
                            <button type="button" class="btn-close btn-close-white ms-auto" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                    </div>
                    <div class="modal-body p-4 bg-white">
                        <form id="editEventForm" action="admin-events" method="POST" enctype="multipart/form-data">
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="eventId" id="editEventId">
                            <div class="mb-4">
                                <label class="form-label fw-bold small text-uppercase" style="color: #5d2e00;">Event Title</label>
                                <div class="input-group custom-input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-pencil"></i></span>
                                    <input type="text" class="form-control bg-light border-start-0" name="title" id="editTitle" placeholder="Enter event title" required>
                                </div>
                            </div>
                            <div class="row mb-4">
                                <div class="col-md-7">
                                    <label class="form-label fw-bold small text-uppercase" style="color: #5d2e00;">Date & Time</label>
                                    <input type="datetime-local" class="form-control bg-light" name="eventDate" id="editDate" required>
                                </div>
                                <div class="col-md-5">
                                    <label class="form-label fw-bold small text-uppercase" style="color: #5d2e00;">Max Guests</label>
                                    <input type="number" class="form-control bg-light" name="maxGuests" id="editMaxGuests" placeholder="e.g. 50">
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-bold small text-uppercase" style="color: #5d2e00;">Location</label>
                                <div class="input-group custom-input-group">
                                    <span class="input-group-text bg-light border-end-0"><i class="bi bi-geo-alt-fill"></i></span>
                                    <input type="text" class="form-control bg-light border-start-0" name="location" id="editLocation" placeholder="Enter location">
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-bold small text-uppercase" style="color: #5d2e00;">Change Event Banner</label>
                                <input type="file" class="form-control bg-light" name="eventImage" id="editImage" accept="image/*">
                                <p class="text-muted mt-1 mb-0" style="font-size: 0.75rem;">Leave empty if you don't want to change the image.</p>
                            </div>
                            <div class="mb-4">
                                <label class="form-label fw-bold small text-uppercase" style="color: #5d2e00;">Description</label>
                                <textarea class="form-control bg-light" name="description" id="editDescription" rows="4" placeholder="Briefly describe the event..."></textarea>
                            </div>
                            <div class="status-box mb-4 p-3 rounded-3 d-flex justify-content-between align-items-center border border-dashed border-warning">
                                <div class="me-3">
                                    <span class="fw-bold d-block text-dark small">Event Progress</span>
                                    <p class="text-muted mb-0" style="font-size: 0.75rem;">Once completed, it will move to Past Events.</p>
                                </div>
                                <div class="form-check form-switch custom-switch-lg">
                                    <input class="form-check-input" type="checkbox" name="isCompleted" id="editIsCompleted">
                                    <label class="form-check-label fw-bold small ms-2 text-dark" for="editIsCompleted">Mark as Completed</label>
                                </div>
                            </div>
                            <div class="row g-3 pt-2">
                                <div class="col-6">
                                    <button type="button" class="btn w-100 py-2 fw-bold" data-bs-dismiss="modal" style="background-color: #f8f1ea; color: #5d2e00;">Cancel</button>
                                </div>
                                <div class="col-6">
                                    <button type="submit" class="btn w-100 py-2 fw-bold text-white shadow-sm" style="background-color: #5d2e00;">Save Changes</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-sm">
                <div class="modal-content border-0 shadow-lg" style="border-radius: 15px;">
                    <div class="modal-body p-4 text-center">
                        <div class="mb-3">
                            <i class="bi bi-exclamation-triangle-fill text-danger" style="font-size: 3rem;"></i>
                        </div>
                        <h5 class="fw-bold mb-2">Are you sure?</h5>
                        <p class="text-muted small mb-4">Do you really want to delete this event? This action cannot be undone.</p>
                        <div class="d-flex gap-2">
                            <button type="button" class="btn w-100 fw-bold" data-bs-dismiss="modal" style="background-color: #f8f1ea; color: #5d2e00;">Cancel</button>
                            <button type="button" class="btn btn-danger w-100 fw-bold shadow-sm" id="confirmDeleteBtn">Sure</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

    <c:if test="${not empty sessionScope.errorMessage}">
        <script>
            Swal.fire({ icon: 'error', title: 'Registration Over Limit!', text: '${sessionScope.errorMessage}', confirmButtonColor: '#5d2e00', background: '#ffffff', timer: 4500, timerProgressBar: true });
        </script>
        <c:remove var="errorMessage" scope="session" />
    </c:if>

    <c:if test="${not empty sessionScope.successMessage}">
        <script>
            Swal.fire({ icon: 'success', title: 'Success!', text: '${sessionScope.successMessage}', confirmButtonColor: '#5d2e00', background: '#ffffff', timer: 3500, timerProgressBar: true });
        </script>
        <c:remove var="successMessage" scope="session" />
    </c:if>

    <script>
        let eventIdToDelete = null;

        function populateEditModal(btn) {
            const id = btn.getAttribute('data-id');
            const title = btn.getAttribute('data-title');
            const date = btn.getAttribute('data-date');
            const location = btn.getAttribute('data-location');
            const guests = btn.getAttribute('data-guests');
            const description = btn.getAttribute('data-description');
            const isCompleted = btn.getAttribute('data-completed') === 'true';

            document.getElementById('editEventId').value = id; 
            document.getElementById('editTitle').value = title;
            document.getElementById('editLocation').value = location;
            document.getElementById('editMaxGuests').value = guests;
            document.getElementById('editDescription').value = description;
            document.getElementById('editIsCompleted').checked = isCompleted;

            if (date) {
                let formattedDate = date.substring(0, 16).replace(" ", "T");
                document.getElementById('editDate').value = formattedDate;
            }
        }

        function setRegistrationEvent(id, title, date, loc, maxGuests, currentGuests) {
            document.getElementById('regEventId').value = id;
            document.getElementById('regEventTitle').innerText = title;
            document.getElementById('regEventDate').innerText = date;
            document.getElementById('regEventLocation').innerText = loc;
            
            const available = maxGuests - currentGuests;
            document.getElementById('regAvailableSlots').value = available;
            
            document.getElementById('regGuestsInput').max = available;
        }

        function prepareDelete(id) {
            eventIdToDelete = id;
        }

        document.addEventListener('DOMContentLoaded', function() {
            const eventForm = document.getElementById('eventForm');
            if (eventForm) {
                eventForm.addEventListener('submit', function(e) {
                    const availableSlots = parseInt(document.getElementById('regAvailableSlots').value) || 0;
                    const requestedGuests = parseInt(document.getElementById('regGuestsInput').value) || 0;

                    if (requestedGuests > availableSlots) {
                        e.preventDefault(); 
                        
                        Swal.fire({
                            icon: 'error',
                            title: 'Registration Failed!',
                            text: 'တောင်းဆိုထားသော လူဦးရေသည် သတ်မှတ်ချက်ထက် ကျော်လွန်နေပါသည်။ လက်ရှိတွင် ' + availableSlots + ' ခုံသာ လွတ်ပါတော့သည်။',
                            confirmButtonColor: '#5d2e00',
                            background: '#ffffff'
                        });
                    }
                });
            }

            const confirmBtn = document.getElementById('confirmDeleteBtn');
            if (confirmBtn) {
                confirmBtn.addEventListener('click', function() {
                    if (eventIdToDelete) {
                        const form = document.createElement('form');
                        form.method = 'POST';
                        form.action = 'admin-events';

                        const actionInput = document.createElement('input');
                        actionInput.type = 'hidden';
                        actionInput.name = 'action';
                        actionInput.value = 'delete';

                        const idInput = document.createElement('input');
                        idInput.type = 'hidden';
                        idInput.name = 'eventId';
                        idInput.value = eventIdToDelete;

                        form.appendChild(actionInput);
                        form.appendChild(idInput);
                        document.body.appendChild(form);
                        form.submit();
                    }
                });
            }
        });
    </script>
</body>
</html>