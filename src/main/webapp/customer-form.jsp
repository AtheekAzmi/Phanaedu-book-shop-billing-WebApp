<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Customer" %>
<html>
<head><title>Edit Customer</title></head>
<body>
<h2>Edit Customer</h2>

<%
    Customer customer = (Customer) request.getAttribute("customer");
    if (customer != null) {
%>
<form method="post" action="customers">
    <input type="hidden" name="accountNumber" value="<%=customer.getAccount_number()%>"/>

    <label>Name:</label>
    <input type="text" name="name" value="<%=customer.getFull_name()%>"/><br/>

    <label>Address:</label>
    <input type="text" name="address" value="<%=customer.getAddress()%>"/><br/>

    <label>Telephone:</label>
    <input type="text" name="telephone" value="<%=customer.getContact_no()%>"/><br/>

    <label>Units Consumed:</label>
    <input type="number" name="unitsConsumed" value="<%=customer.getUnit_consumed()%>"/><br/>

    <input type="submit" value="Update Customer"/>
</form>
<% } %>

</body>
</html>
