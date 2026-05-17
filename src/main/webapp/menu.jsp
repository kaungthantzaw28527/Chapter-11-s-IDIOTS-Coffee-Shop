<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- JSTL Standard Tag Library အား ထည့်သွင်းခြင်း --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chapter-11's IDIOTS</title>
    <link href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
    <style>
        .admin-item-actions {
            display: flex;
            gap: 5px;
        }
        .btn-action-sm {
            padding: 2px 6px;
            font-size: 0.8rem;
            border-radius: 4px;
        }
    </style>
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
                            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/admin-menu">Menu</a></li>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin-events">Events</a></li>                     
                    		<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/our-journey">Our Journey</a></li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/home">Home</a></li>
                            <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/menu">Menu</a></li>
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

    <div class="menu-block py-5">
        <div class="container text-center">
            <h1 class="menu-main-title">Our Menu</h1>
            <p class="menu-subtitle mb-5">Explore our diverse selection of quality food and beverages</p>

            <div class="category-wrapper mb-5">
                <div class="category-bar shadow-sm nav nav-pills" id="pills-tab" role="tablist">
                    <c:forEach var="cat" items="${categories}" varStatus="status">
                        <button class="cat-item ${status.first ? 'active' : ''}" 
                                id="pills-id-${cat.categoryId}-tab" 
                                data-bs-toggle="pill" 
                                data-bs-target="#pills-id-${cat.categoryId}" 
                                type="button" 
                                role="tab">
                            <c:choose>
                                <c:when test="${cat.categoryId == 1}"><i class="bi bi-cup-hot me-2"></i></c:when>
                                <c:when test="${cat.categoryId == 2}"><i class="bi bi-egg-fried me-2"></i></c:when>
                                <c:when test="${cat.categoryId == 3}"><i class="bi bi-bowl-hot me-2"></i></c:when>
                                <c:when test="${cat.categoryId == 4}"><i class="bi bi-glass-gin me-2"></i></c:when>
                                <c:when test="${cat.categoryId == 5}"><i class="bi bi-apple me-2"></i></c:when>
                                <c:otherwise><i class="bi bi-tag me-2"></i></c:otherwise>
                            </c:choose>
                            ${cat.categoryName}
                        </button>
                    </c:forEach>
                </div>
            </div>

            <div class="tab-content" id="pills-tabContent">
                <c:forEach var="cat" items="${categories}" varStatus="status">
                    
                    <div class="tab-pane fade ${status.first ? 'show active' : ''}" id="pills-id-${cat.categoryId}" role="tabpanel">
                        
                        <div class="banner-section mb-5">
                            <c:choose>
                                <%-- Category 1: Coffee --%>
                                <c:when test="${cat.categoryId == 1}">
                                    <img src="${pageContext.request.contextPath}/IMG/menu-set-p.jpeg" alt="Coffee Menu">
                                </c:when>
                                <%-- Category 2: Breakfast / Food --%>
                                <c:when test="${cat.categoryId == 2}">
                                    <img src="${pageContext.request.contextPath}/IMG/menu-set-p2.jpeg" alt="Breakfast Menu">
                                </c:when>
                                <%-- Category 3: Main Dish / Noodles --%>
                                <c:when test="${cat.categoryId == 3}">
                                    <img src="${pageContext.request.contextPath}/IMG/menu-set-p3.jpeg" alt="Main Dish Menu">
                                </c:when>
                                <%-- Category 4: Drinks / Juice --%>
                                <c:when test="${cat.categoryId == 4}">
                                    <img src="${pageContext.request.contextPath}/IMG/menu-set-p4.jpeg" alt="Drinks Menu">
                                </c:when>
                                <%-- Category 5: Desserts --%>
                                <c:when test="${cat.categoryId == 5}">
                                    <img src="${pageContext.request.contextPath}/IMG/menu-set-p5.jpeg" alt="Desserts Menu">
                                </c:when>
                                <%-- အခြား Category များရှိလာပါက သုံးမည့် Default ပုံ --%>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/IMG/menu-set-p6.jpeg" alt="${cat.categoryName}">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="text-start menu-content-width mb-4">
                            <h2 class="category-heading">${cat.categoryName} Menu</h2>
                        </div>
                        
                        <div class="row g-4 text-start menu-content-width">
                            <c:forEach var="item" items="${menuItems}">
                                <c:if test="${item.categoryId == cat.categoryId}">
                                    <div class="col-md-4">
                                        <div class="menu-card d-flex align-items-center p-3 position-relative">
                                            <div class="menu-item-img me-3">
                                                <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.name}">
                                            </div>
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-center">
                                                    <h5 class="mb-0">${item.name}</h5>
                                                    <span class="price">$${item.price}</span>
                                                </div>
                                                <p class="desc text-muted mb-2 small">${item.description}</p>
                                                
                                                <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                                                    <div class="d-flex justify-content-between align-items-center">
                                                        <div class="admin-item-actions">
                                                            <button class="btn btn-outline-primary btn-action-sm" 
                                                                    onclick="openEditModal('${item.id}', '${item.name}', '${item.price}', '${item.categoryId}', '${item.description}')">
                                                                <i class="bi bi-pencil"></i>
                                                            </button>
                                                            <button class="btn btn-outline-danger btn-action-sm delete-trigger-btn" 
                                                                    data-href="${pageContext.request.contextPath}/DeleteMenuItem_controller?id=${item.id}">
                                                                <i class="bi bi-trash"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    
                </c:forEach>
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
                                <%-- 🎯 ပြင်ဆင်ရန်- Footer က Quick Links ထဲမှာလည်း /admin-menu သို့ ပြောင်းလဲခြင်း --%>
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
                        <li class="mb-2">Phone: (+95) 9978407566</li>
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

    <%-- Admin Control Modal များနှင့် Script များ အပြောင်းအလဲမရှိ ဆက်လက်တည်ရှိပါသည် --%>
    <c:if test="${sessionScope.userRole eq 'ADMIN'}">
        <div class="admin-controls-wrapper">
            <div class="dropup">
                <button class="btn btn-admin-main shadow-lg" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="bi bi-tools me-2"></i>Admin Tool
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow admin-dropdown-menu">
                    <li>
                        <a class="dropdown-item py-2" href="#" data-bs-toggle="modal" data-bs-target="#addItemModal">
                            <i class="bi bi-plus-circle-fill text-success me-2"></i>Add New Item
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="modal fade" id="addItemModal" tabindex="-1" aria-labelledby="addItemModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content shadow-lg">
                    <div class="modal-header">
                        <h5 class="modal-title text-white" id="addItemModalLabel">
                            <i class="bi bi-plus-circle me-2"></i>Add New Menu Item
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4">
                        <form action="${pageContext.request.contextPath}/AddMenuItem_controller" method="POST" enctype="multipart/form-data">
                            <div class="mb-3 text-start">
                                <label class="form-label">Item Name</label>
                                <input type="text" class="form-control" name="name" placeholder="e.g., Espresso" required>
                            </div>
                            <div class="row">
                                <div class="col-6 mb-3 text-start">
                                    <label class="form-label">Price ($)</label>
                                    <input type="number" step="0.01" class="form-control" name="price" placeholder="0.00" required>
                                </div>
                                <div class="col-6 mb-3 text-start">
                                    <label class="form-label">Category</label>
                                    <select class="form-select" name="category_id" required>
                                        <option value="" selected disabled>Select...</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.categoryId}">${cat.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3 text-start">
                                <label class="form-label">Select Image</label>
                                <input type="file" class="form-control" name="image_file" accept="image/*" required>
                            </div>
                            <div class="mb-4 text-start">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" name="description" rows="3" placeholder="Describe the item..."></textarea>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-save shadow-sm">Save Item</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="editItemModal" tabindex="-1" aria-labelledby="editItemModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content shadow-lg">
                    <div class="modal-header" style="background-color: #b35900;">
                        <h5 class="modal-title text-white" id="editItemModalLabel">
                            <i class="bi bi-pencil-square me-2"></i>Edit Menu Item
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body p-4" style="background-color: #ffcc99;">
                        <form action="${pageContext.request.contextPath}/UpdateMenuItem_controller" method="POST" enctype="multipart/form-data">
                            <input type="hidden" id="edit_id" name="id">
                            <div class="mb-3 text-start">
                                <label class="form-label">Item Name</label>
                                <input type="text" class="form-control" id="edit_name" name="name" required>
                            </div>
                            <div class="row">
                                <div class="col-6 mb-3 text-start">
                                    <label class="form-label">Price ($)</label>
                                    <input type="number" step="0.01" class="form-control" id="edit_price" name="price" required>
                                </div>
                                <div class="col-6 mb-3 text-start">
                                    <label class="form-label">Category</label>
                                    <select class="form-select" id="edit_category" name="category_id" required>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.categoryId}">${cat.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="mb-3 text-start">
                                <label class="form-label">Update Image (Optional)</label>
                                <input type="file" class="form-control" name="image_file" accept="image/*">
                                <small class="text-muted">ပုံအသစ်မရွေးရင် အဟောင်းအတိုင်းပဲ ရှိနေပါမယ်</small>
                            </div>
                            <div class="mb-4 text-start">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" id="edit_description" name="description" rows="3"></textarea>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn text-white shadow-sm" style="background-color: #b35900;">Update Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-sm" style="max-width: 320px;">
                <div class="modal-content border-0 p-4 shadow" style="border-radius: 16px; background-color: #ffffff;">
                    <div class="modal-body text-center p-0">
                        <div class="d-inline-flex align-items-center justify-content-center mb-3" 
                             style="width: 64px; height: 64px; background-color: #fce8e6; border-radius: 50%;">
                            <i class="bi bi-exclamation-triangle-fill text-danger" style="font-size: 2rem;"></i>
                        </div>
                        <h4 class="fw-bold mb-2" style="color: #212529; font-family: sans-serif;">Are you sure?</h4>
                        <p class="text-muted small mb-4">Do you really want to delete this item? This action cannot be undone.</p>
                        <div class="d-flex gap-2 justify-content-center">
                            <button type="button" class="btn border-0 py-2 px-4 fw-bold" data-bs-dismiss="modal"
                                    style="background-color: #f7f1eb; color: #5c3a21; border-radius: 8px; font-size: 0.95rem; flex: 1;">
                                Cancel
                            </button>
                            <a id="confirmDeleteBtn" href="#" class="btn text-white py-2 px-4 fw-bold border-0 d-flex align-items-center justify-content-center"
                               style="background-color: #dc3545; border-radius: 8px; font-size: 0.95rem; flex: 1; text-decoration: none;">
                                Sure
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

    <script>
        function openEditModal(id, name, price, categoryId, description) {
            if(document.getElementById('edit_id')) {
                document.getElementById('edit_id').value = id;
                document.getElementById('edit_name').value = name;
                document.getElementById('edit_price').value = price;
                document.getElementById('edit_category').value = categoryId;
                document.getElementById('edit_description').value = description;
                
                var editModal = new bootstrap.Modal(document.getElementById('editItemModal'));
                editModal.show();
            }
        }

        document.addEventListener("DOMContentLoaded", function() {
            const deleteButtons = document.querySelectorAll('.delete-trigger-btn');
            const confirmDeleteBtn = document.getElementById('confirmDeleteBtn');
            const deleteModalElement = document.getElementById('deleteConfirmModal');

            if (deleteButtons.length > 0 && confirmDeleteBtn && deleteModalElement) {
                const deleteModal = new bootstrap.Modal(deleteModalElement);
                deleteButtons.forEach(button => {
                    button.addEventListener('click', function() {
                        const deleteUrl = this.getAttribute('data-href');
                        confirmDeleteBtn.setAttribute('href', deleteUrl);
                        deleteModal.show();
                    });
                });
            }
        });
    </script>
</body>
</html>