<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Customer" %>
<html>
<head><title>Customer Account Details</title></head>
<body>
<h2>Customer Account Details</h2>

<table border="1">
  <tr>
    <th>ID</th><th>Account</th><th>Name</th><th>Address</th><th>Contact</th><th>Units</th><th>Actions</th>
  </tr>
  <%
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
    if (customers != null) {
      for (Customer c : customers) {
  %>
  <tr>
    <td><%= c.getCustomer_id() %></td>
    <td><%= c.getAccount_number() %></td>
    <td><%= c.getFull_name() %></td>
    <td><%= c.getAddress() %></td>
    <td><%= c.getContact_no() %></td>
    <td><%= c.getUnit_consumed() %></td>
  </tr>
  <% } } %>
</table>

<a href="dashboard.jsp">Dashboard</a>

</body>
</html>
