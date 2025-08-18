<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Customer" %>
<html>
<head><title>Customer List</title></head>
<body>
<h2>Customer List</h2>
<a href="customer-add.jsp">Add New Customer</a>
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
    <td>
      <a href="viewCustomer?id=<%= c.getCustomer_id() %>">View</a> |
      <a href="editCustomer?id=<%= c.getCustomer_id() %>">Edit</a> |
      <a href="deleteCustomer?id=<%= c.getCustomer_id() %>" onclick="return confirm('Delete?')">Delete</a>
    </td>
  </tr>
  <% } } %>
</table>
</body>
</html>
