<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="dao.CustomerDAO,dao.ItemDAO,dao.BillDAO,java.util.List,model.Customer,model.Items,model.Bill" %>
<%
    // Basic metrics (safe read only)
    CustomerDAO cDao = new CustomerDAO();
    ItemDAO iDao = new ItemDAO();
    BillDAO bDao = new BillDAO();
    int customerCount = cDao.getAllCustomers().size();
    int itemCount = iDao.getAllItems().size();
    int billCount = bDao.getAllBills().size();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Help & Documentation | Pahana-Edu Billing</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    <style>
        body { background: #f5f7fa; }
        .toc a { text-decoration: none; }
        .anchor-offset { scroll-margin-top: 90px; }
        pre,code { background:#1e293b; color:#f1f5f9; padding:.25rem .5rem; border-radius:.35rem; }
        .badge-soft { background:#eef2f7; color:#334155; }
    </style>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary shadow-sm sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand fw-semibold" href="dashboard.jsp"><i class="bi bi-book-half me-2"></i>Pahana-Edu Billing Help</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navHelp" aria-controls="navHelp" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navHelp">
            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 small">
                <li class="nav-item"><a class="nav-link" href="#overview">Overview</a></li>
                <li class="nav-item"><a class="nav-link" href="#navigation">Navigation</a></li>
                <li class="nav-item"><a class="nav-link" href="#customers">Customers</a></li>
                <li class="nav-item"><a class="nav-link" href="#items">Items</a></li>
                <li class="nav-item"><a class="nav-link" href="#billing">Billing</a></li>
                <li class="nav-item"><a class="nav-link" href="#security">Security</a></li>
                <li class="nav-item"><a class="nav-link" href="#faq">FAQ</a></li>
                <li class="nav-item"><a class="nav-link" href="#troubleshooting">Troubleshooting</a></li>
            </ul>
        </div>
    </div>
</nav>

<header class="bg-white border-bottom py-4 mb-4 shadow-sm">
    <div class="container">
        <h1 class="h3 mb-2">System Help & Documentation</h1>
        <p class="text-muted mb-0 small">Current Data Snapshot: <span class="badge bg-success-subtle text-success-emphasis">Customers: <%= customerCount %></span> <span class="badge bg-info-subtle text-info-emphasis ms-1">Items: <%= itemCount %></span> <span class="badge bg-warning-subtle text-warning-emphasis ms-1">Bills: <%= billCount %></span></p>
    </div>
</header>

<main class="container pb-5">
    <div class="row g-4">
        <aside class="col-lg-3">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-primary text-white py-2"><strong>Quick TOC</strong></div>
                <div class="card-body small toc">
                    <ol class="ps-3 mb-0">
                        <li><a href="#overview">Overview</a></li>
                        <li><a href="#navigation">Navigation Layout</a></li>
                        <li><a href="#customers">Customer Management</a></li>
                        <li><a href="#items">Inventory Management</a></li>
                        <li><a href="#billing">Billing & Invoicing</a></li>
                        <li><a href="#reports">Metrics & Insights</a></li>
                        <li><a href="#security">Security & Access</a></li>
                        <li><a href="#faq">FAQ</a></li>
                        <li><a href="#troubleshooting">Troubleshooting</a></li>
                        <li><a href="#shortcuts">Tips / Shortcuts</a></li>
                        <li><a href="#support">Support</a></li>
                    </ol>
                </div>
            </div>
            <div class="card border-0 shadow-sm">
                <div class="card-header py-2 bg-secondary text-white"><strong>At a Glance</strong></div>
                <div class="card-body small lh-sm">
                    <div><i class="bi bi-check2-circle text-success"></i> Add / edit / delete customers</div>
                    <div><i class="bi bi-check2-circle text-success"></i> Manage item stock & pricing</div>
                    <div><i class="bi bi-check2-circle text-success"></i> Real-time bill creation</div>
                    <div><i class="bi bi-check2-circle text-success"></i> Low stock awareness</div>
                    <div><i class="bi bi-check2-circle text-success"></i> Inventory valuation</div>
                </div>
            </div>
        </aside>
        <section class="col-lg-9">
            <article id="overview" class="anchor-offset mb-5">
                <h2 class="h5">1. Overview</h2>
                <p class="text-muted small">The Pahana-Edu Bookstore Billing System streamlines customer registration, inventory control, and billing workflow for a small-to-medium educational bookstore. It combines a Bootstrap UI with servlet/JSP back end and a relational database (MySQL assumed) via DAO layer.</p>
                <ul class="small">
                    <li><strong>Tech Stack:</strong> JSP, Servlets, JDBC, Bootstrap 5</li>
                    <li><strong>Data Access:</strong> DAO pattern (<code>CustomerDAO</code>, <code>ItemDAO</code>, <code>BillDAO</code>)</li>
                    <li><strong>Key Entities:</strong> Customer, Items, Bill, BillItem, User</li>
                    <li><strong>Session:</strong> Simple login storing <code>user</code> in session scope</li>
                </ul>
            </article>

            <article id="navigation" class="anchor-offset mb-5">
                <h2 class="h5">2. Navigation Layout</h2>
                <p class="small text-muted">Persistent sidebar (desktop) or off-canvas (mobile) gives fast access:</p>
                <table class="table table-sm table-bordered small">
                    <thead class="table-light"><tr><th>Menu</th><th>Purpose</th></tr></thead>
                    <tbody>
                        <tr><td>Customer</td><td>Add and view customer records</td></tr>
                        <tr><td>Items</td><td>Create, edit, delete inventory items</td></tr>
                        <tr><td>Calculate & Print Bills</td><td>Compose new bill with dynamic pricing</td></tr>
                        <tr><td>Bill History</td><td>Review past billing entries</td></tr>
                        <tr><td>Help</td><td>Open this documentation</td></tr>
                        <tr><td>Exit System</td><td>Return to landing / login</td></tr>
                    </tbody>
                </table>
            </article>

            <article id="customers" class="anchor-offset mb-5">
                <h2 class="h5">3. Customer Management</h2>
                <ul class="small">
                    <li><strong>Add Customer:</strong> From Dashboard Quick Actions or sidebar. Validates required fields.</li>
                    <li><strong>Account Number Format:</strong> <code>ACC###</code> (enforced by pattern in form).</li>
                    <li><strong>Editing:</strong> Initiated from customer list or detail view.</li>
                    <li><strong>Units Consumed:</strong> Increments automatically when bills referencing the customer are created.</li>
                </ul>
                <p class="small text-muted mb-1">Data Integrity Rules:</p>
                <ul class="small">
                    <li>No duplicate primary keys (DB level)</li>
                    <li>Deletion blocked if foreign key constraints exist (bills referencing customer) unless cascade configured</li>
                </ul>
            </article>

            <article id="items" class="anchor-offset mb-5">
                <h2 class="h5">4. Inventory Management</h2>
                <ul class="small">
                    <li><strong>Add / Edit Items:</strong> Specify name, description, price, non-negative stock, and image.</li>
                    <li><strong>Stock Validation:</strong> Negative values rejected (server + client).</li>
                    <li><strong>Deletion:</strong> Fails gracefully if item referenced by a bill (constraint).</li>
                    <li><strong>Low Stock:</strong> Dashboard highlights items below threshold (default 10).</li>
                </ul>
            </article>

            <article id="billing" class="anchor-offset mb-5">
                <h2 class="h5">5. Billing & Invoicing</h2>
                <ul class="small">
                    <li><strong>Create Bill:</strong> Choose customer, payment method, add items dynamically.</li>
                    <li><strong>Real-Time Price:</strong> Unit price fetched via AJAX endpoint by item id.</li>
                    <li><strong>Stock Enforcement:</strong> Zero or insufficient stock blocked both client + server.</li>
                    <li><strong>Total Recalculation:</strong> Server recomputes to prevent tampering.</li>
                    <li><strong>Post-Save Effects:</strong> Stock decremented; customer unit consumption increments.</li>
                </ul>
            </article>

            <article id="reports" class="anchor-offset mb-5">
                <h2 class="h5">6. Metrics & Insights</h2>
                <p class="small text-muted">Dashboard aggregates basic operational KPIs:</p>
                <ul class="small">
                    <li>Total customers, total inventory quantity</li>
                    <li>Inventory valuation (sum price × stock)</li>
                    <li>Low stock items list</li>
                    <li>Highest moving item(s) based on bill item quantities</li>
                </ul>
            </article>

            <article id="security" class="anchor-offset mb-5">
                <h2 class="h5">7. Security & Access</h2>
                <ul class="small">
                    <li><strong>Session Gate:</strong> Dashboard & core pages redirect if session <code>user</code> missing.</li>
                    <li><strong>Input Validation:</strong> Non-negative numeric fields, pattern checks, server revalidation.</li>
                    <li><strong>Avoid XSS:</strong> Escape user-originated text before display if extended (current code shows raw values; future improvement).</li>
                    <li><strong>DB Credentials:</strong> Managed in <code>DBConnection</code>; rotate safely.</li>
                </ul>
            </article>

            <article id="faq" class="anchor-offset mb-5">
                <h2 class="h5">8. Frequently Asked Questions</h2>
                <div class="accordion" id="faqAcc">
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="q1"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#a1">Why can't I delete an item?</button></h2>
                        <div id="a1" class="accordion-collapse collapse" data-bs-parent="#faqAcc"><div class="accordion-body small">Likely referenced in existing bills. Remove or archive related bills (or enable ON DELETE CASCADE) first.</div></div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="q2"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#a2">Stock not reducing?</button></h2>
                        <div id="a2" class="accordion-collapse collapse" data-bs-parent="#faqAcc"><div class="accordion-body small">Ensure bill saved successfully; server decrements after bill insert commit.</div></div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="q3"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#a3">Wrong totals on bill?</button></h2>
                        <div id="a3" class="accordion-collapse collapse" data-bs-parent="#faqAcc"><div class="accordion-body small">Client shows dynamic estimation; server recomputes—refresh success page if mismatch suspected.</div></div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header" id="q4"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#a4">How to flag low stock?</button></h2>
                        <div id="a4" class="accordion-collapse collapse" data-bs-parent="#faqAcc"><div class="accordion-body small">Threshold currently hard-coded (10) in dashboard logic; adjust there for custom value.</div></div>
                    </div>
                </div>
            </article>

            <article id="troubleshooting" class="anchor-offset mb-5">
                <h2 class="h5">9. Troubleshooting</h2>
                <table class="table table-sm table-bordered small align-middle">
                    <thead class="table-light"><tr><th>Issue</th><th>Cause</th><th>Resolution</th></tr></thead>
                    <tbody>
                        <tr><td>Login loops to login.jsp</td><td>Session expired / user attr missing</td><td>Re-authenticate; ensure LoginServlet sets session attribute</td></tr>
                        <tr><td>Cannot add customer</td><td>Duplicate account number or DB error</td><td>Check pattern (ACC###) & uniqueness</td></tr>
                        <tr><td>Bill save failure</td><td>Out-of-stock item or DB constraint</td><td>Remove offending line; restock item</td></tr>
                        <tr><td>Image not showing</td><td>ItemImageServlet or binary null</td><td>Re-upload via edit item form</td></tr>
                        <tr><td>Delete blocked</td><td>Foreign key reference</td><td>Switch to soft delete or remove dependencies</td></tr>
                    </tbody>
                </table>
            </article>

            <article id="shortcuts" class="anchor-offset mb-5">
                <h2 class="h5">10. Tips & Shortcuts</h2>
                <ul class="small">
                    <li><strong>CTRL + F</strong> to search this page for a topic.</li>
                    <li>Use browser tab duplication to compare inventory before and after bill creation.</li>
                    <li>Batch add customers first, then create bills—reduces context switching.</li>
                    <li>Use descriptive item names for clearer bill auditing.</li>
                </ul>
            </article>

            <article id="support" class="anchor-offset mb-5">
                <h2 class="h5">11. Support & Contact</h2>
                <p class="small">For maintenance or enhancements:</p>
                <ul class="small">
                    <li>Email (example): <code>support@pahana-edu.local</code></li>
                    <li>Provide steps, screenshot, and timestamp when reporting issues.</li>
                    <li>Log SQL exceptions centrally (future improvement).</li>
                </ul>
                <a href="dashboard.jsp" class="btn btn-sm btn-outline-primary"><i class="bi bi-arrow-left"></i> Back to Dashboard</a>
            </article>
            <hr/>
            <p class="small text-muted">&copy; <%= java.time.Year.now() %> Pahana-Edu Bookstore Billing System. All rights reserved.</p>
        </section>
    </div>
</main>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"></script>
<script>document.querySelectorAll('a[href^="#"]').forEach(a=>a.addEventListener('click',e=>{const id=a.getAttribute('href').substring(1);const el=document.getElementById(id);if(el){}}));</script>
</body>
</html>
