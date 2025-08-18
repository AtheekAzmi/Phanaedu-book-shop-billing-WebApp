<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/16/2025
  Time: 11:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Customer" %>
<html>
<head>
    <title>Customer Added</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body class="bg-gradient-to-br from-[#27f4ff] to-white min-h-screen flex items-center justify-center">
<%
    Customer customer = (Customer) request.getAttribute("customer");
    String customerName = customer != null ? customer.getFull_name() : "Customer";
%>
<div class="bg-white p-8 rounded-lg shadow-lg text-center space-y-6 max-w-md w-full mx-4">
    <div class="text-[#ff6d4d] animate-bounce">
        <i class="ph-fill ph-check-circle text-6xl"></i>
    </div>
    <h2 class="text-2xl font-bold text-gray-800"><%= customerName %> has been successfully added!</h2>
    <div class="flex justify-center space-x-4">
        <a href="customer-add.jsp"
           class="group px-6 py-3 bg-[#309afc] text-white rounded-full font-medium transition-all duration-200 hover:bg-[#27f4ff] flex items-center space-x-2">
            <i class="ph-fill ph-plus-circle"></i>
            <span>Add Another Customer</span>
        </a>
        <a href="dashboard.jsp"
           class="group px-6 py-3 bg-[#ff6d4d] text-white rounded-full font-medium transition-all duration-200 hover:bg-[#27f4ff] flex items-center space-x-2">
            <i class="ph-fill ph-gauge"></i>
            <span>Go to Dashboard</span>
        </a>
    </div>
</div>
</body>
</html>
