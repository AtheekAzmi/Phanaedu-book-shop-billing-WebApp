<%@ page import="model.Bill" %>
<%@ page import="model.BillItem" %>
<%@ page import="model.Customer" %>
<%@ page import="dao.BillDAO" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="dao.ItemDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.Items" %>
<%
    int billId = Integer.parseInt(request.getParameter("billId"));
    BillDAO billDAO = new BillDAO();
    CustomerDAO customerDAO = new CustomerDAO();
    ItemDAO itemDAO = new ItemDAO();
    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("en", "LK"));
    nf.setMinimumFractionDigits(2);
    nf.setMaximumFractionDigits(2);
    Bill bill = billDAO.getBillById(billId);
    Customer customer = (bill != null) ? customerDAO.getCustomerById(bill.getCustomerId()) : null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill Details</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
    <div style="text-align:center; margin-bottom:20px;">
        <button type="button" onclick="window.location.href='dashboard.jsp'">Back to Dashboard</button>
    </div>
    <h2>Bill Details</h2>
    <% if (bill != null && customer != null) { %>
    <table border="1" cellpadding="8" cellspacing="0">
        <tr><th>Customer Name</th><td><%= customer.getFull_name() %></td></tr>
        <tr><th>Contact Number</th><td><%= customer.getContact_no() %></td></tr>
        <tr><th>Address</th><td><%= customer.getAddress() %></td></tr>
        <tr><th>Account Number</th><td><%= customer.getAccount_number() %></td></tr>
        <tr><th>Total Amount</th><td>LKR <%= nf.format(bill.getTotalAmount()) %></td></tr>
        <tr><th>Payment Method</th><td><%= bill.getPaymentMethod() %></td></tr>
    </table>
    <h3>Bill Items</h3>
    <div id="printableBill">
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
            <tr>
                <th>Item Image</th>
                <th>Item Name</th>
                <th>Quantity</th>
            </tr>
        </thead>
        <tbody>
        <% for (BillItem item : bill.getItems()) {
            Items book = itemDAO.getItemById(item.getItemId()); %>
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
            </tr>
        <% } %>
        </tbody>
    </table>
    </div>
    <div style="text-align:center; margin-top:20px;">
        <button onclick="printBill()">Print Bill</button>
        <a href="bill-history.jsp" style="margin-left:20px;">Back to Bill History</a>
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
    <p>Bill not found.</p>
    <% } %>
</body>
</html>
