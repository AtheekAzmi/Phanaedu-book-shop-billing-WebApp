<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/14/2025
  Time: 11:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Login - Pahana Edu</title>
</head>
<body>
<h2>Login</h2>
<form action="login" method="post">
    <label>Username:</label> <input type="text" name="username" required><br>
    <label>Password:</label> <input type="password" name="password" required><br><br>

    <button type="submit">Login</button>

</form>
<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>
</body>
</html>

