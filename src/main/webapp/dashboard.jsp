<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/14/2025
  Time: 11:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%
    String username = (String) session.getAttribute("user");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head><title>Dashboard</title></head>
<body>
<h2>Welcome, <%= username %>!</h2>
<a href="index.jsp">Logout</a>
</body>
</html>

