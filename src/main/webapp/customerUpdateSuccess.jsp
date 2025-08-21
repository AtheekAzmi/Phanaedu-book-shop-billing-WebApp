<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/16/2025
  Time: 11:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Customer Added</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#ff6d4d',
                        secondary: '#309afc',
                        accent: '#27f4ff'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center p-4">
<div class="bg-white rounded-xl shadow-lg p-8 max-w-md w-full transform transition-all duration-300 hover:shadow-xl">
    <div class="text-center">
        <div class="mb-6 inline-block animate-bounce">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-16 w-16 text-primary" fill="none" viewBox="0 0 24 24"
                 stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                      d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
        </div>
        <h2 class="text-2xl font-bold text-gray-800 mb-6">Customer has been successfully updated!</h2>
        <div class="space-y-4 sm:space-y-0 sm:space-x-4">
            <a href="customer-add.jsp"
               class="inline-block px-6 py-3 bg-secondary text-white rounded-lg transition-all duration-300 hover:bg-opacity-90 hover:transform hover:scale-105">Add
                Another Customer</a>
            <a href="dashboard.jsp"
               class="inline-block px-6 py-3 mt-5px bg-accent text-gray-800 rounded-lg transition-all duration-300 hover:bg-opacity-90 hover:transform hover:scale-105">Go
                to Dashboard</a>
        </div>
    </div>
</div>
</body>
</html>