<%@ page import="model.Bill,model.BillItem,model.Customer,model.User,model.Items,dao.CustomerDAO,dao.UserDAO,dao.ItemDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bill Summary</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        h2, h3 { text-align: center; }
    </style>
</head>
<body>
<%
    Bill bill = (Bill) request.getAttribute("bill");
    Customer customer = null;
    User user = null;
    if (bill != null) {
        CustomerDAO customerDAO = new CustomerDAO();
        customer = customerDAO.getCustomerById(bill.getCustomerId());
        UserDAO userDAO = new UserDAO();
        user = userDAO.getUserById(bill.getUserId());
    }
%>
<h2>Bill Created Successfully!</h2>
<% if (bill != null) { %>
    <h3>Bill Summary</h3>
    <table>
        <tr><th>Bill No</th><td><%= bill.getBillId() %></td></tr>
        <tr><th>Customer</th><td><%= customer != null ? customer.getFull_name() : "N/A" %></td></tr>
        <tr><th>User</th><td><%= user != null ? user.getFullName() : "N/A" %></td></tr>
        <tr><th>Date</th><td><%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></td></tr>
        <tr><th>Total Amount</th><td><%= bill.getTotalAmount() %></td></tr>
    </table>
    <h3>Bill Items</h3>
    <table>
        <thead>
        <tr>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Unit Price</th>
            <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <%
            ItemDAO itemDAO = new ItemDAO();
            for (BillItem item : bill.getItems()) {
                Items book = itemDAO.getItemById(item.getItemId());
        %>
        <tr>
            <td><%= book != null ? book.getItem_name() : "N/A" %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= item.getUnitPrice() %></td>
            <td><%= item.getTotalPrice() %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
<% } else { %>
    <h3 style="color:red; text-align:center;">No bill data found.</h3>
<% } %>
<div style="text-align:center; margin-top:20px;">
    <a href="billForm.jsp">Create Another Bill</a>
    <a href="dashboard.jsp" style="margin-left:20px;">Go to Dashboard</a>
</div>
</body>
</html>
