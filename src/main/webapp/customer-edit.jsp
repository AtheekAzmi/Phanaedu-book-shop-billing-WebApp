<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/18/2025
  Time: 6:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Customer" %>
<html>
<head><title>Edit Customer</title></head>
<body>
<%
  Customer customer = (Customer) request.getAttribute("customer");
%>
<h2>Edit Customer</h2>
<form action="updateCustomer" method="post">
  <input type="hidden" name="customer_id" value="<%= customer.getCustomer_id() %>"/>
  Account Number: <input type="text" name="account_number" value="<%= customer.getAccount_number() %>" required/><br/>
  Full Name: <input type="text" name="full_name" value="<%= customer.getFull_name() %>" required/><br/>
  Address: <input type="text" name="address" value="<%= customer.getAddress() %>" required/><br/>
  Contact No: <input type="text" name="contact_no" value="<%= customer.getContact_no() %>" required/><br/>
  Units Consumed: <input type="number" name="unit_consumed" value="<%= customer.getUnit_consumed() %>" required/><br/>
  <input type="submit" value="Update"/>
</form>
<a href="listCustomers">Back to List</a>
</body>
</html>


