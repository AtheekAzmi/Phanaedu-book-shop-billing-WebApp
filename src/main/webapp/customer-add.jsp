<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer" %>
<html>
<head>
    <title>Customer Form</title>
</head>
<body>
<%
    Customer customer = (Customer) request.getAttribute("customer");
    boolean isEdit = (customer != null);
%>
<h2><%= isEdit ? "Edit Customer" : "Add Customer" %></h2>
<form action="CustomerServlet" method="get">
    <input type="hidden" name="action" value="<%= isEdit ? "UPDATE" : "INSERT" %>"/>
    <% if (isEdit) { %>
    <input type="hidden" name="customer_id" value="<%= customer.getCustomer_id() %>"/>
    <% } %>
    Account Number: <input type="text" name="account_number" value="<%= isEdit ? customer.getAccount_number() : "" %>" required/><br/>
    Full Name: <input type="text" name="full_name" value="<%= isEdit ? customer.getFull_name() : "" %>" required/><br/>
    Address: <input type="text" name="address" value="<%= isEdit ? customer.getAddress() : "" %>" required/><br/>
    Contact No: <input type="text" name="contact_no" value="<%= isEdit ? customer.getContact_no() : "" %>" required/><br/>
    Units Consumed: <input type="number" name="unit_consumed" value="<%= isEdit ? customer.getUnit_consumed() : "" %>" required/><br/>
    <input type="submit" value="<%= isEdit ? "Update" : "Save" %>"/>
</form>
<a href="customer-list.jsp">Back to List</a>
</body>
</html>
