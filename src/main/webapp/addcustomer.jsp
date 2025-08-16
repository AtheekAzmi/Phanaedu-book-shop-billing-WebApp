<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/16/2025
  Time: 11:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Add Customer</title>
</head>
<body>
<h2>Add New Customer</h2>
<form action="addCustomer" method="post">
    <label>Account Number:</label>
    <input type="text" name="accountNumber" required><br><br>

    <label>Name:</label>
    <input type="text" name="name" required><br><br>

    <label>Address:</label>
    <input type="text" name="address"><br><br>

    <label>Telephone:</label>
    <input type="text" name="telephone"><br><br>

    <label>Units Consumed:</label>
    <input type="number" name="unitsConsumed" min="0" value="0"><br><br>

    <button type="submit">Add Customer</button>
</form>

<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
</body>
</html>

