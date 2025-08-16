<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/16/2025
  Time: 9:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Edit Customer</title>
</head>
<body>
<h2>Edit Customer</h2>
<form action="editCustomer" method="post">
    <input type="hidden" name="account_number" value="${customer.account_number}" />

    Name: <input type="text" name="full_name" value="${customer.full_name}" required /><br>
    Address: <input type="text" name="address" value="${customer.address}" required /><br>
    Telephone: <input type="text" name="contact_no" value="${customer.contact_no}" required /><br>
    Units Consumed: <input type="number" name="unit_consumed" value="${customer.unit_consumed}" required /><br>

    <input type="submit" value="Update Customer" />
</form>
</body>
</html>
