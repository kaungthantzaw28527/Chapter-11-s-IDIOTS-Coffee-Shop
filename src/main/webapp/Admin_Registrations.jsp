<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Event Registrations</title>
    
    <link href="${pageContext.request.contextPath}/bootstrap/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Admin_Registrations.css">
    
    <!-- For Excel Export -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

    <style>
        .table-wrapper { overflow-x: auto; -webkit-overflow-scrolling: touch; background: white; border-radius: 8px; }
        .pagination .page-link { color: #7d3c00; border: 1px solid #E0D5CB; }
        .pagination .page-item.active .page-link { background-color: #7d3c00; border-color: #7d3c00; color: white; }
        .pagination .page-link:hover { background-color: #f8f1e7; color: #5d2e00; }
        .pagination-container { display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; margin-top: 20px; padding-bottom: 30px; }
        .text-brown { color: #7d3c00; }
        
        @media (max-width: 768px) {
            .controls-section { flex-direction: column; align-items: stretch !important; gap: 15px; }
            .search-box { width: 100% !important; }
            .filter-box { width: 100% !important; }
        }
    </style>
</head>
<body>

<!-- Navbar Section -->
<nav class="navbar navbar-expand-lg navbar-dark custom-nav sticky-top" style="background-color: #5d2e00;">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#">
            <i class="bi bi-cup-hot me-2"></i>Chapter-11's IDIOTS
        </a>
        <div class="ms-auto">
            <a href="admin-events" class="btn btn-outline-light rounded-pill px-4">
                <i class="bi bi-arrow-left me-1"></i> 
                <span class="d-none d-sm-inline">Back to Event Page</span>
                <span class="d-inline d-sm-none">Back</span>
            </a>
        </div>
    </div>
</nav>

<div class="admin-content container-fluid px-md-5 py-4">
    <header class="page-header mb-4">
        <h2 class="fw-bold">Event Registrations List</h2>
        <p class="text-muted">Manage registrations and export data for your future events</p>
    </header>

    <!-- Controls Section -->
    <div class="controls-section d-flex justify-content-between align-items-center mb-4 gap-3">
        <div class="d-flex gap-2 flex-grow-1">
            <!-- Search Box -->
            <div class="search-box" style="max-width: 400px; position: relative; flex: 1;">
                <i class="bi bi-search" style="position: absolute; left: 12px; top: 50%; transform: translateY(-50%); color: #7d3c00;"></i>
                <input type="text" id="adminSearch" class="form-control" placeholder="Search by name, email or phone..." style="padding-left: 35px; border-radius: 8px;">
            </div>
            
            <!-- Event Filter Dropdown -->
            <div class="filter-box" style="max-width: 250px;">
                <select id="eventFilter" class="form-select" style="border-radius: 8px;">
                    <option value="all">All Events</option>
                    <!-- JavaScript မှတဆင့် Unique Event Name များကို ဒီမှာထည့်ပေးပါမည် -->
                </select>
            </div>
        </div>

        <div class="export-buttons d-flex gap-2">
            <button class="btn btn-success btn-sm me-1" onclick="exportToExcel()">
			    <i class="bi bi-file-earmark-excel"></i> Excel
			</button>
        </div>
    </div>

    <!-- Table Section -->
    <div class="table-wrapper shadow-sm border">
        <table class="table table-hover mb-0">
            <thead class="table-light">
                <tr>
                    <th>No.</th>
                    <th>Full Name</th>
                    <th>Event Name</th>
                    <th>Email Address</th>
                    <th>Phone Number</th>
                    <th class="text-center">Guests</th>
                    <th>Special Requests</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody id="registrationTableBody">
                <c:forEach var="reg" items="${registrationList}" varStatus="status">
                    <tr class="reg-row" data-event="${reg.eventTitle}">
                        <td class="row-no">${status.count}</td>
                        <td><span class="fw-bold">${reg.fullName}</span></td>
                        <td><span class="badge bg-info text-dark event-name-tag">${reg.eventTitle}</span></td>
                        <td>${reg.email}</td>
                        <td>${reg.phone}</td>
                        <td class="text-center">${reg.numGuests}</td>
                        <td>
                            <small class="text-muted italic">
                                <c:choose>
                                    <c:when test="${empty reg.specialRequests}">-</c:when>
                                    <c:otherwise>${reg.specialRequests}</c:otherwise>
                                </c:choose>
                            </small>
                        </td>
                        <td>
                            <div class="d-flex justify-content-center gap-2">
								<button class="btn btn-sm btn-outline-primary" 
								        onclick="openEditModal('${reg.regId}', '${reg.fullName}', '${reg.email}', '${reg.phone}', '${reg.numGuests}', '${reg.maxGuests}', '${reg.totalBooked}')">
								    <i class="bi bi-pencil-square"></i>
								</button>
                                <button class="btn btn-sm btn-outline-danger" 
                                        onclick="openDeleteModal('${reg.regId}', '${reg.fullName}')">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty registrationList}">
                    <tr class="no-data">
                        <td colspan="8" class="text-center py-4 text-muted">No registrations found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>

    <!-- Pagination Section -->
    <div class="pagination-container">
        <div class="showing-text text-muted small" id="showingText">
            Showing 0 to 0 of ${registrationList.size()} entries
        </div>
        <nav>
            <ul class="pagination mb-0" id="paginationControls">
                <!-- JavaScript Generation -->
            </ul>
        </nav>
    </div>
</div>

<!-- [MODAL] Edit Registration Form -->
<div class="modal fade" id="editModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow">
            <form action="admin-registrations" method="POST">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="regId" id="editRegId">
                
                <div class="modal-header" style="background-color: #5d2e00; color: white;">
                    <h5 class="modal-title fw-bold">Edit Registration Info</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Full Name</label>
                        <input type="text" class="form-control" name="fullName" id="editName" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-bold">Email Address</label>
                        <input type="email" class="form-control" name="email" id="editEmail" required>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label small fw-bold">Phone Number</label>
                            <input type="text" class="form-control" name="phone" id="editPhone">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label small fw-bold">Guests</label>
                            <input type="number" class="form-control" name="numGuests" id="editGuests" min="1">
                        </div>
                    </div>
                </div>
                <div class="modal-footer border-0">
                    <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn text-white px-4" style="background-color: #5d2e00;">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- [MODAL] Delete Confirmation -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered modal-sm">
        <div class="modal-content border-0 shadow">
            <form action="admin-registrations" method="POST">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="regId" id="deleteRegId">
                <div class="modal-body text-center p-4">
                    <div class="mb-3"><i class="bi bi-exclamation-circle text-danger" style="font-size: 3rem;"></i></div>
                    <h5 class="fw-bold">Are you sure?</h5>
                    <p class="text-muted small">Delete <b id="deleteTargetName"></b>'s record?</p>
                    <div class="d-flex justify-content-center gap-2 mt-4">
                        <button type="button" class="btn btn-light" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    /**
     * Modal Functions
     * Edit ခလုတ်နှိပ်သည့်အခါ လက်ရှိဒေတာများအပြင် Event Limit (maxAllowed) နှင့် 
     * လက်ရှိ Register လုပ်ထားပြီးသမျှ စုစုပေါင်း (totalBooked) ကိုပါ လက်ခံတွက်ချက်ပေးသည်။
     */
    function openEditModal(id, name, email, phone, currentGuests, maxAllowed, totalBooked) {
        document.getElementById('editRegId').value = id;
        document.getElementById('editName').value = name;
        document.getElementById('editEmail').value = email;
        document.getElementById('editPhone').value = phone;
        
        const guestInput = document.getElementById('editGuests');
        const oldVal = parseInt(currentGuests);      // ပြင်ဆင်ခြင်းမပြုမီ ယခင်ကသွင်းထားသည့် လူဦးရေ
        const limit = parseInt(maxAllowed);         // Event မှ လက်ခံနိုင်သည့် အများဆုံး Limit
        const currentTotal = parseInt(totalBooked); // Event တစ်ခုလုံးတွင် လက်ရှိရှိနေသည့် စုစုပေါင်းလူဦးရေ
        
        guestInput.value = oldVal;
        
        // User က keyboard နဲ့ ရိုက်ထည့်ရင်လည်း Event Limit ကျော်မသွားအောင် စစ်ပေးခြင်း
        guestInput.oninput = function() {
            const newVal = parseInt(this.value) || 0;
            
            /**
             * Logic: (လက်ရှိစုစုပေါင်း - ငါအရင်သွင်းထားတာ) + ငါအခုအသစ်ပြင်လိုက်တာ <= Limit
             * ဤနည်းဖြင့် အခြားသူများ Register လုပ်ထားသည့် အရေအတွက်ကို မထိခိုက်စေဘဲ စစ်ဆေးနိုင်ပါမည်။
             */
            const otherGuests = currentTotal - oldVal;
            const projectedTotal = otherGuests + newVal;

            if (projectedTotal > limit) {
                const remainingSpace = limit - otherGuests;
                
                // Alert Box ဖြင့် အသေးစိတ် သတိပေးခြင်း
				alert("⚠️ Event Capacity Exceeded!\n\n" +
				      "Event Limit: " + limit + " guests\n" +
				      "Current registrations by others: " + otherGuests + " guests\n\n" +
				      "You can only register up to " + remainingSpace + " guests.");
                
                this.value = oldVal; // Limit ကျော်ပါက မူလအရေအတွက်အတိုင်း ပြန်ထားမည်
            } else if (newVal < 1) {
                this.value = 1; // အနည်းဆုံး ၁ ယောက်တော့ ရှိရမည်
            }
        };

        new bootstrap.Modal(document.getElementById('editModal')).show();
    }

    /**
     * Delete Modal ဖွင့်ခြင်း
     */
    function openDeleteModal(id, name) {
        document.getElementById('deleteRegId').value = id;
        document.getElementById('deleteTargetName').innerText = name;
        new bootstrap.Modal(document.getElementById('deleteModal')).show();
    }

    /**
     * Advanced Table Logic: Search, Filter, and Pagination
     */
    document.addEventListener("DOMContentLoaded", function() {
        const rowsPerPage = 10;
        const tableBody = document.getElementById("registrationTableBody");
        const allRows = Array.from(tableBody.querySelectorAll(".reg-row"));
        const paginationControls = document.getElementById("paginationControls");
        const showingText = document.getElementById("showingText");
        const searchInput = document.getElementById("adminSearch");
        const eventFilter = document.getElementById("eventFilter");

        let filteredRows = allRows;
        let currentPage = 1;

        // Initialize Event Filter Dropdown
        const uniqueEvents = [...new Set(allRows.map(row => row.getAttribute('data-event')))];
        uniqueEvents.forEach(event => {
            if(event) {
                const opt = document.createElement("option");
                opt.value = event;
                opt.innerText = event;
                eventFilter.appendChild(opt);
            }
        });

        // Filter နှင့် Search ပေါင်းစပ်လုပ်ဆောင်သည့် Function
        function applyFilters() {
            const searchQuery = (searchInput.value || "").toLowerCase().trim();
            const filterValue = eventFilter.value;

            filteredRows = allRows.filter(row => {
                const textMatch = row.innerText.toLowerCase().includes(searchQuery);
                const eventMatch = filterValue === "all" || row.getAttribute('data-event') === filterValue;
                return textMatch && eventMatch;
            });

            // No Data Message ပြသခြင်း
            const existingNoData = tableBody.querySelector(".no-data");
            if (filteredRows.length === 0) {
                if(!existingNoData) {
                    const tr = document.createElement("tr");
                    tr.className = "no-data";
                    tr.innerHTML = `<td colspan="8" class="text-center py-4 text-muted">No results found matching your criteria.</td>`;
                    tableBody.appendChild(tr);
                }
            } else if(existingNoData) {
                existingNoData.remove();
            }

            displayPage(1);
        }

        // Pagination Display Function
        function displayPage(page) {
            const totalItems = filteredRows.length;
            const totalPages = Math.ceil(totalItems / rowsPerPage);
            
            if (page < 1) page = 1;
            if (totalPages > 0 && page > totalPages) page = totalPages;
            
            currentPage = page;
            const start = (currentPage - 1) * rowsPerPage;
            const end = start + rowsPerPage;

            allRows.forEach(row => row.style.display = "none");
            
            if (totalItems > 0) {
                const pageRows = filteredRows.slice(start, end);
                pageRows.forEach((row, idx) => {
                    row.style.display = "";
                    const rowNoCell = row.querySelector(".row-no");
                    if (rowNoCell) rowNoCell.innerText = start + idx + 1;
                });
                updateText(start + 1, Math.min(end, totalItems), totalItems);
            } else {
                updateText(0, 0, 0);
            }

            updateControls(totalPages);
        }

        function updateText(start, end, total) {
            showingText.innerText = total === 0 ? "Showing 0 to 0 of 0 entries" : "Showing " + start + " to " + end + " of " + total + " entries";
        }

        function updateControls(totalPages) {
            paginationControls.innerHTML = "";
            const displayTotal = Math.max(totalPages, 1);

            addBtn("<i class='bi bi-chevron-left'></i>", currentPage > 1, () => displayPage(currentPage - 1));

            for (let i = 1; i <= displayTotal; i++) {
                (function(pageNum) {
                    addBtn(pageNum, true, () => displayPage(pageNum), pageNum === currentPage);
                })(i);
            }

            addBtn("<i class='bi bi-chevron-right'></i>", currentPage < totalPages, () => displayPage(currentPage + 1));
        }

        function addBtn(html, enabled, clickFn, active = false) {
            const li = document.createElement("li");
            li.className = "page-item" + (!enabled ? " disabled" : "") + (active ? " active" : "");
            const a = document.createElement("a");
            a.className = "page-link";
            a.innerHTML = html;
            a.href = "javascript:void(0)";
            if (enabled) {
                a.addEventListener("click", (e) => { e.preventDefault(); clickFn(); });
            }
            li.appendChild(a);
            paginationControls.appendChild(li);
        }

        searchInput.addEventListener("input", applyFilters);
        eventFilter.addEventListener("change", applyFilters);
        displayPage(1);
    });
    /**
     * Excel ထုတ်ရန် Function
     */
    function exportToExcel() {
        const table = document.getElementById("registrationTableBody");
        const visibleRows = Array.from(table.querySelectorAll("tr")).filter(row => row.style.display !== "none");
        
        // Header ပြင်ဆင်ခြင်း
        const data = [["No.", "Full Name", "Event Name", "Email Address", "Phone Number", "Guests", "Special Requests"]];
        
        // ဒေတာများ ထည့်သွင်းခြင်း
        visibleRows.forEach((row, index) => {
            const cells = row.querySelectorAll("td");
            data.push([
                index + 1,
                cells[1].innerText,
                cells[2].innerText,
                cells[3].innerText,
                cells[4].innerText,
                cells[5].innerText,
                cells[6].innerText
            ]);
        });

        const worksheet = XLSX.utils.aoa_to_sheet(data);
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, "Registrations");
        
        // File name ကို Filter အလိုက် သတ်မှတ်ခြင်း
        const eventName = document.getElementById("eventFilter").value;
        XLSX.writeFile(workbook, `Registrations_${eventName}.xlsx`);
    }

</script>
<script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
</body>
</html>