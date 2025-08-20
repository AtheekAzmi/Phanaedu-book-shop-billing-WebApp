<%@ page import="model.Bill,model.BillItem,model.Customer,model.Items,dao.BillDAO,dao.CustomerDAO,dao.ItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    int customerId = Integer.parseInt(request.getParameter("customerId"));
    CustomerDAO customerDAO = new CustomerDAO();
    BillDAO billDAO = new BillDAO();
    ItemDAO itemDAO = new ItemDAO();
    Customer customer = customerDAO.getCustomerById(customerId);
    List<Bill> bills = billDAO.getBillsByCustomer(customerId);
    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("en", "LK"));
    nf.setMinimumFractionDigits(2);
    nf.setMaximumFractionDigits(2);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Bill History</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
    <div style="text-align:center; margin-bottom:20px;">
        <button type="button" onclick="window.location.href='bill-history.jsp'">Back to Bill History</button>
        <button type="button" onclick="window.location.href='dashboard.jsp'">Go to Dashboard</button>
    </div>
    <h2>Bill History for <%= customer.getFull_name() %></h2>
    <div id="printableBill">
    <% if (bills != null && !bills.isEmpty()) { %>
        <% for (Bill bill : bills) { %>
            <h3>Bill No: <%= bill.getBillId() %> | Date: <%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></h3>
            <table border="1" cellpadding="8" cellspacing="0" style="margin-bottom:10px;">
                <tr><th>Total Amount</th><td>LKR <%= nf.format(bill.getTotalAmount()) %></td></tr>
                <tr><th>Payment Method</th><td><%= bill.getPaymentMethod() %></td></tr>
            </table>
            <table border="1" cellpadding="8" cellspacing="0" style="margin-bottom:30px;">
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
                        <td><%= "LKR " + nf.format(item.getUnitPrice()) %></td>
                        <td><%= "LKR " + nf.format(item.getTotalPrice()) %></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } %>
    <% } else { %>
        <h3>No bills found for this customer.</h3>
    <% } %>
    </div>
    <div style="text-align:center; margin-top:20px;">
        <button onclick="printBill()">Print Bill History</button>
        <button type="button" onclick="window.location.href='bill-history.jsp'">Back to Bill History</button>
        <button type="button" onclick="window.location.href='dashboard.jsp'">Go to Dashboard</button>
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
    }
    </style>
</body>
</html>
