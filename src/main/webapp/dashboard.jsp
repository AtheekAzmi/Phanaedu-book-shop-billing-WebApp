<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/14/2025
  Time: 11:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.ItemDAO" %>
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
    <title>Pahana-Edu Dashboard</title>
</head>
<style>
    #sidebarMenu, .offcanvas-header {
        background-color: #ff6d4d;
    }
    img{
        background-color: aliceblue;
        padding: 5px;
        border-radius: 5px;
        margin: 0;
    }
    .exit1{
        background-color: #1b1919;
        color: rgb(250, 0, 0);
        border: none;
        border-radius: 5px;
        cursor: grab;
    }

    /* add animation when it's hover */
    .exit1:hover {
        background-color: #ff6d4d;
        transition: background-color 0.3s ease;
        color: white;
    }
    .exit2{
        background-color: #1b1919;
        color: rgb(250, 0, 0);
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
    }
    /* add animation when it's hover */
    .exit2:hover {
        background-color: #309afc;
        transition: background-color 0.3s ease;
        color: white;
    }
</style>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
            <a class="navbar-brand py-3 " href="#" style="font-size: 1.5rem;">Phana Edu Bookstore</a>
        </button>
        <!-- User Info (right side) -->
        <div class="d-flex align-items-center ms-auto">
                <span class="me-2 position-relative">
                    <i class="bi bi-bell fs-5"></i>
                    <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
                </span>
            <span class="d-flex align-items-center">
                    <span class="rounded-circle bg-info text-white fw-bold d-flex justify-content-center align-items-center" style="width: 40px; height: 40px;">AU</span>
                    <span class="ms-2 text-white fw-semibold">Admin User</span>
                </span>
        </div>
    </div>
</nav>

<!-- Responsive Sidebar -->
<nav id="sidebarMenu" class="d-lg-block d-none text-white vh-100 flex-shrink-0 p-3" style="width: 250px; position: fixed; top: 0; left: 0; z-index: 1030;">
    <img src="assets/Phana.png" width="150" class="m-0" alt="Phana Logo">
    <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <span class="fs-4"> Bookstore Billing</span>
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
                    <li><a href="customer-add.jsp" class="nav-link text-white"><i class="bi bi-person-plus"></i> Add Customer</a></li>
                    <li><a href="listCustomers" class="nav-link text-white"><i class="bi bi-person-lines-fill"></i> View Customer Details</a></li>
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
                    <li><a href="addItem" class="nav-link text-white"><i class="bi bi-plus-square"></i> Add Item</a></li>
                    <li><a href="item-list.jsp" class="nav-link text-white"><i class="bi bi-pencil"></i> Manage Items</a></li>
                </ul>
            </div>
        </li>
        <li>
            <a href="view-customer-list.jsp" class="nav-link text-white d-flex align-items-center">
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
            <a href="#" class="exit2 nav-link text-danger d-flex align-items-center">
                <i class="bi bi-box-arrow-right"></i>
                <span class="ms-2">Exit System</span>
            </a>
        </li>
    </ul>
</nav>
<!-- Sidebar Toggle Button for small screens -->
<button class="btn btn-primary d-lg-none position-fixed" type="button" style="top: 10px; left: 10px; z-index: 1040;" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSidebar" aria-controls="offcanvasSidebar">
    <i class="bi bi-list"></i>
</button>
<!-- Offcanvas Sidebar for small screens -->
<div class="offcanvas offcanvas-start bg-primary text-white" tabindex="-1" id="offcanvasSidebar" aria-labelledby="offcanvasSidebarLabel">
    <div class="offcanvas-header">
        <img src="assets/Phana.png" width="150" class="m-0" alt="Phana Logo">
        <h5 class="offcanvas-title ms-3" id="offcanvasSidebarLabel">Bookstore Billing</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body p-3">
        <ul class="nav nav-pills flex-column mb-auto">
            <li>
                <a href="#customerMenuMobile" data-bs-toggle="collapse" class="nav-link text-white d-flex align-items-center">
                    <i class="bi bi-person"></i>
                    <span class="ms-2">Customer</span>
                    <i class="bi bi-caret-down ms-auto"></i>
                </a>
                <div class="collapse" id="customerMenuMobile">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ms-4">
                        <li><a href="customer-add.jsp" class="nav-link text-white"><i class="bi bi-person-plus"></i> Add Customer</a></li>
                        <li><a href="listCustomers" class="nav-link text-white"><i class="bi bi-person-lines-fill"></i> View Customer Details</a></li>
                    </ul>
                </div>
            </li>
            <li>
                <a href="#itemsMenuMobile" data-bs-toggle="collapse" class="nav-link text-white d-flex align-items-center">
                    <i class="bi bi-box"></i>
                    <span class="ms-2">Items</span>
                    <i class="bi bi-caret-down ms-auto"></i>
                </a>
                <div class="collapse" id="itemsMenuMobile">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ms-4">
                        <<li><a href="addItem" class="nav-link text-white"><i class="bi bi-plus-square"></i> Add Item</a></li>
                        <li><a href="item-list.jsp" class="nav-link text-white"><i class="bi bi-pencil"></i> Manage Items</a></li>
                    </ul>
                </div>
            </li>
            <li>
                <a href="view-customer-list.jsp" class="nav-link text-white d-flex align-items-center">
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
                <a href="#" class="exit2 nav-link text-white d-flex align-items-center">
                    <i class="bi bi-question-circle"></i>
                    <span class="ms-2">Help</span>
                </a>
            </li>
            <li>
                <a href="#" class="exit1 nav-link d-flex align-items-center">
                    <i class="bi bi-box-arrow-right"></i>
                    <span class="ms-2">Exit System</span>
                </a>
            </li>
        </ul>
    </div>
</div>
<style>
    @media (max-width: 991.98px) {
        #sidebarMenu {
            display: none !important;
        }
    }
</style>
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

<div class="container-fluid mt-lg-4"></div>
<div class="row g-3 mx-xl-2">
    <!-- Total Customers -->
    <div class="col-md-3">
        <div class="card border-primary h-100">
            <div class="card-body">
                <h6 class="card-subtitle mb-2 text-muted">Total Customers</h6>
                <%
                    CustomerDAO customerDAO = new CustomerDAO();
                    List<Customer> customers = customerDAO.getAllCustomers();
                    int totalCustomers = customers.size();
                %>
                <h3><%= totalCustomers %>
                </h3>
                <span class="text-secondary">Current total customers</span>
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
                <%
                    ItemDAO itemDAO = new ItemDAO();
                    int totalStock = itemDAO.getTotalStockQuantity();
                %>
                <h3><%= totalStock %></h3>
                <span class="text-danger">Total stock quantity</span>
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
<div class="mt-4 mx-xl-2">
    <h6 class="fw-bold">Quick Actions</h6>
    <div class="row g-3">
        <div class="col-md-4">
            <a href="customer-add.jsp" class="text-decoration-none">
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
            <a href="item-list.jsp" class="text-decoration-none">
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
<div class="mt-4 mx-xl-2">
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
                <i class="bi bi-currency-dollar text-success me-2"></i>
                <div>
                    <div class="fw-bold">Order completed</div>
                    <div class="text-muted small">Invoice #INV-2023-1245 for $2,450</div>
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
