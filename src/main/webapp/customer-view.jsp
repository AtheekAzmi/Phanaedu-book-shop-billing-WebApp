<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/18/2025
  Time: 6:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Customer" %>
<html>
<head><title>Customer Details</title></head>
<body>
<%
  Customer customer = (Customer) request.getAttribute("customer");
%>
<h2>Customer Details</h2>
<table border="1" cellpadding="8">
  <tr><th>ID</th><td><%= customer.getCustomer_id() %></td></tr>
  <tr><th>Account Number</th><td><%= customer.getAccount_number() %></td></tr>
  <tr><th>Full Name</th><td><%= customer.getFull_name() %></td></tr>
  <tr><th>Address</th><td><%= customer.getAddress() %></td></tr>
  <tr><th>Contact No</th><td><%= customer.getContact_no() %></td></tr>
  <tr><th>Units Consumed</th><td><%= customer.getUnit_consumed() %></td></tr>
</table>
<br/>
<a href="listCustomers">Back to List</a> |
<a href="editCustomer?id=<%= customer.getCustomer_id() %>">Edit</a>
</body>
</html>


