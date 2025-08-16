<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/14/2025
  Time: 11:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%
    String username = (String) session.getAttribute("user");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%--<html>--%>
<%--<head><title>Dashboard</title></head>--%>
<%--<body>--%>
<%--<h2>Welcome, <%= username %>!</h2>--%>
<%--<a href="index.jsp">Logout</a>--%>
<%--</body>--%>
<%--</html>--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
    <title>Document</title>
</head>
<body>
</body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Bookstore Billing Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <!-- User Info (right side) -->
        <div class="d-flex align-items-center ms-auto">
                <span class="me-2 position-relative">
                    <i class="bi bi-bell fs-5"></i>
                    <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
                </span>
            <span class="d-flex align-items-center">
                    <span class="rounded-circle bg-info text-white fw-bold d-flex justify-content-center align-items-center" style="width: 40px; height: 40px;">AU</span>
                    <span class="ms-2 text-white fw-semibold"><%= username %></span>
                </span>
        </div>
        <div class="d-flex flex-column flex-shrink-0 p-3 bg-primary text-white vh-100" style="width: 250px; position: fixed; top: 0; left: 0; z-index: 1030;">
            <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
                <span class="fs-4"><i class="bi bi-book"></i> Bookstore Billing</span>
            </a>
            <hr>
            <ul class="nav nav-pills flex-column mb-auto">
                <li>
                    <a href="#customerMenu" data-bs-toggle="collapse" class="nav-link text-white d-flex align-items-center">
                        <i class="bi bi-person"></i>
                        <span class="ms-2">Customer</span>
                        <i class="bi bi-caret-down ms-auto"></i>
                    </a>
                    <div class="collapse" id="customerMenu">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ms-4">
                            <li><a href="addcustomer.jsp" class="nav-link text-white"><i class="bi bi-person-plus"></i> Add Customer</a></li>
                            <li><a href="#" class="nav-link text-white"><i class="bi bi-pencil-square"></i> Edit Customer</a></li>
                            <li><a href="#" class="nav-link text-white"><i class="bi bi-person-x"></i> Delete Customer</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a href="#itemsMenu" data-bs-toggle="collapse" class="nav-link text-white d-flex align-items-center">
                        <i class="bi bi-box"></i>
                        <span class="ms-2">Items</span>
                        <i class="bi bi-caret-down ms-auto"></i>
                    </a>
                    <div class="collapse" id="itemsMenu">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ms-4">
                            <li><a href="#" class="nav-link text-white"><i class="bi bi-plus-square"></i> Add Item</a></li>
                            <li><a href="#" class="nav-link text-white"><i class="bi bi-pencil"></i> Edit Item</a></li>
                            <li><a href="#" class="nav-link text-white"><i class="bi bi-trash"></i> Delete Item</a></li>
                        </ul>
                    </div>
                </li>
                <li>
                    <a href="#" class="nav-link text-white d-flex align-items-center">
                        <i class="bi bi-person-badge"></i>
                        <span class="ms-2">Display Account Details</span>
                    </a>
                </li>
                <li>
                    <a href="#" class="nav-link text-white d-flex align-items-center">
                        <i class="bi bi-printer"></i>
                        <span class="ms-2">Calculate & Print Bills</span>
                    </a>
                </li>
                <li>
                    <a href="#" class="nav-link text-white d-flex align-items-center">
                        <i class="bi bi-question-circle"></i>
                        <span class="ms-2">Help</span>
                    </a>
                </li>
                <li>
                    <a href="index.jsp" class="nav-link text-danger d-flex align-items-center">
                        <i class="bi bi-box-arrow-right"></i>
                        <span class="ms-2">Exit System</span>
                    </a>
                </li>
            </ul>
        </div>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <style>
            body {
                margin-left: 250px;
            }
            @media (max-width: 991.98px) {
                .vh-100 {
                    height: auto !important;
                }
                body {
                    margin-left: 0;
                }
            }
        </style>
    </div>
</nav>

<div class="container-fluid mt-4"></div>
<div class="row g-3">
    <!-- Total Customers -->
    <div class="col-md-3">
        <div class="card border-primary h-100">
            <div class="card-body">
                <h6 class="card-subtitle mb-2 text-muted">Total Customers</h6>
                <h3>N/A</h3>
                <span class="text-secondary">Loading...</span>
                <div class="mt-2 text-success small">+12.5% from last month</div>
                <span class="position-absolute top-0 end-0 m-3"><i class="bi bi-people fs-4"></i></span>
            </div>
        </div>
    </div>
    <!-- Today's Sales -->
    <div class="col-md-3">
        <div class="card border-success h-100">
            <div class="card-body">
                <h6 class="card-subtitle mb-2 text-muted">Today's Sales</h6>
                <h3>Rs. <span class="text-danger">&lt;!DOCTYPE html&gt; ...</span></h3>
                <div class="mt-2 text-success small">+8.3% from yesterday</div>
                <span class="position-absolute top-0 end-0 m-3"><i class="bi bi-currency-rupee fs-4"></i></span>
            </div>
        </div>
    </div>
    <!-- Inventory Items -->
    <div class="col-md-3">
        <div class="card border-danger h-100">
            <div class="card-body">
                <h6 class="card-subtitle mb-2 text-muted">Inventory Items</h6>
                <div class="text-danger">&lt;!DOCTYPE html&gt; ...</div>
                <div class="mt-2 text-danger small">-3.2% from last week</div>
                <span class="position-absolute top-0 end-0 m-3"><i class="bi bi-box-seam fs-4"></i></span>
            </div>
        </div>
    </div>
    <!-- Pending Orders -->
    <div class="col-md-3">
        <div class="card border-warning h-100">
            <div class="card-body">
                <h6 class="card-subtitle mb-2 text-muted">Pending Orders</h6>
                <h3>24</h3>
                <div class="mt-2 text-success small">-5.6% from yesterday</div>
                <span class="position-absolute top-0 end-0 m-3"><i class="bi bi-lock fs-4"></i></span>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="mt-4">
    <h6 class="fw-bold">Quick Actions</h6>
    <div class="row g-3">
        <div class="col-md-4">
            <a href="#customerMenu" class="text-decoration-none">
                <div class="card h-100">
                    <div class="card-body d-flex align-items-center">
                        <i class="bi bi-person-plus fs-2 text-primary me-3"></i>
                        <div>
                            <div class="fw-bold">Add New Customer</div>
                            <div class="text-muted small">Register a new customer in the system</div>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="#" class="text-decoration-none">
                <div class="card h-100">
                    <div class="card-body d-flex align-items-center">
                        <i class="bi bi-calculator fs-2 text-success me-3"></i>
                        <div>
                            <div class="fw-bold">Calculate Bill</div>
                            <div class="text-muted small">Generate billing details and print invoice</div>
                        </div>
                    </div>
                </div>
            </a>
        </div>
        <div class="col-md-4">
            <a href="#itemsMenu" class="text-decoration-none">
                <div class="card h-100">
                    <div class="card-body d-flex align-items-center">
                        <i class="bi bi-box-seam fs-2 text-info me-3"></i>
                        <div>
                            <div class="fw-bold">Manage Inventory</div>
                            <div class="text-muted small">Add, update or delete item records</div>
                        </div>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Recent Activity -->
<div class="mt-4">
    <h6 class="fw-bold">Recent Activity</h6>
    <div class="card">
        <ul class="list-group list-group-flush">
            <li class="list-group-item d-flex align-items-center">
                <i class="bi bi-person-plus text-primary me-2"></i>
                <div>
                    <div class="fw-bold">New customer registered</div>
                    <div class="text-muted small">John Doe was added to the system</div>
                </div>
                <span class="ms-auto text-muted small">10 min ago</span>
            </li>
            <li class="list-group-item d-flex align-items-center">
                <i class="bi bi-currency-rupee text-success me-2"></i>
                <div>
                    <div class="fw-bold">Order completed</div>
                    <div class="text-muted small">Invoice #INV-2023-1245 for ₹2,450</div>
                </div>
                <span class="ms-auto text-muted small">1 hour ago</span>
            </li>
            <li class="list-group-item d-flex align-items-center">
                <i class="bi bi-exclamation-triangle text-warning me-2"></i>
                <div>
                    <div class="fw-bold">Low stock alert</div>
                    <div class="text-muted small">"Advanced Mathematics" is running low (3 remaining)</div>
                </div>
                <span class="ms-auto text-muted small">3 hours ago</span>
            </li>
        </ul>
    </div>
</div>
</div>

</body>
</html>
