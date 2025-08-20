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
    <div style="text-align:center; margin-bottom:20px;">
        <button type="button" onclick="window.location.href='dashboard.jsp'">Back to Dashboard</button>
    </div>
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
    java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance(new java.util.Locale("en", "LK"));
    nf.setMinimumFractionDigits(2);
    nf.setMaximumFractionDigits(2);
%>
<h2>Bill Created Successfully!</h2>
<% if (bill != null) { %>
<div id="printableBill">
    <h3>Bill Summary</h3>
    <table>
        <tr><th>Bill No</th><td><%= bill.getBillId() %></td></tr>
        <tr><th>Customer</th><td><%= customer != null ? customer.getFull_name() : "N/A" %></td></tr>
        <tr><th>User</th><td><%= user != null ? user.getFullName() : "N/A" %></td></tr>
        <tr><th>Date</th><td><%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></td></tr>
        <tr><th>Total Amount</th><td><%= "LKR " + nf.format(bill.getTotalAmount()) %></td></tr>
        <tr><th>Payment Method</th><td><%= bill.getPaymentMethod() %></td></tr>
    </table>
    <h3>Bill Items</h3>
    <table>
        <thead>
        <tr>
            <th>Item Image</th>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Unit Price</th>
            <th>Total</th>
        </tr>
        </thead>
        <tbody>
        <%
            ItemDAO itemDAO = new ItemDAO();
            double grossTotal = 0.0;
            for (BillItem item : bill.getItems()) {
                Items book = itemDAO.getItemById(item.getItemId());
                grossTotal += item.getTotalPrice();
        %>
        <tr>
            <td>
                <% if (book != null && book.getItemImage() != null) { %>
                    <img src="ItemImageServlet?item_id=<%= book.getItem_id() %>" alt="Item Image" class="bill-item-image" style="width:60px;height:60px;object-fit:cover;" />
                <% } else { %>
                    <span>No Image</span>
                <% } %>
            </td>
            <td><%= book != null ? book.getItem_name() : "N/A" %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= "LKR " + nf.format(item.getUnitPrice()) %></td>
            <td><%= "LKR " + nf.format(item.getTotalPrice()) %></td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <div style="text-align:right; width:80%; margin:10px auto; font-weight:bold; font-size:1.1em;">
        Gross Total: LKR <%= nf.format(grossTotal) %>
    </div>
</div>
<div style="text-align:center; margin-top:20px;">
    <button onclick="printBill()">Print Bill</button>
    <a href="billForm.jsp">Create Another Bill</a>
    <a href="dashboard.jsp" style="margin-left:20px;">Go to Dashboard</a>
    <button type="button" onclick="window.location.href='dashboard.jsp'" style="margin-left:20px;">Back to Dashboard</button>
</div>
<script>
function printBill() {
    var printContents = document.getElementById('printableBill').innerHTML;
    var originalContents = document.body.innerHTML;
    document.body.innerHTML = printContents;
    window.print();
    document.body.innerHTML = originalContents;
}
</script>
<style>
@media print {
    body * { visibility: hidden; }
    #printableBill, #printableBill * { visibility: visible; }
    #printableBill { position: absolute; left: 0; top: 0; width: 100%; }
    button, a { display: none !important; }
    .bill-item-image { width: 100px !important; height: 100px !important; object-fit: cover !important; }
}
</style>
<% } else { %>
    <h3 style="color:red; text-align:center;">No bill data found.</h3>
<% } %>
</body>
</html>
