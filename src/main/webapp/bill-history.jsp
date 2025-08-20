<%@ page import="java.util.List" %>
<%@ page import="model.Bill" %>
<%@ page import="model.Customer" %>
<%@ page import="dao.BillDAO" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    CustomerDAO customerDAO = new CustomerDAO();
    BillDAO billDAO = new BillDAO();
    List<Customer> customers = customerDAO.getAllCustomers();
    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("en", "LK"));
    nf.setMinimumFractionDigits(2);
    nf.setMaximumFractionDigits(2);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Bill History</title>
    <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
    <h2>Bill History</h2>
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
            <tr>
                <th>Customer Name</th>
                <th>Contact Number</th>
                <th>Total Amount</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
        <% for (Customer customer : customers) {
            List<Bill> bills = billDAO.getBillsByCustomer(customer.getCustomer_id());
            double totalAmount = 0.0;
            if (bills != null && !bills.isEmpty()) {
                for (Bill bill : bills) {
                    totalAmount += bill.getTotalAmount();
                }
            }
            if (bills != null && !bills.isEmpty()) { %>
            <tr>
                <td><%= customer.getFull_name() %></td>
                <td><%= customer.getContact_no() %></td>
                <td>LKR <%= nf.format(totalAmount) %></td>
                <td><a href="bill-customer-history.jsp?customerId=<%= customer.getCustomer_id() %>">View</a></td>
            </tr>
        <% } else { %>
            <tr>
                <td><%= customer.getFull_name() %></td>
                <td><%= customer.getContact_no() %></td>
                <td colspan="2">No bill</td>
            </tr>
        <% } } %>
        </tbody>
    </table>
<br>
    <button type="button" onclick="window.location.href='dashboard.jsp'">Back to Dashboard</button>
</body>
</html>
