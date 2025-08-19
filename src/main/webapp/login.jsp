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
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 h-screen flex items-center justify-center">
<div class="bg-white p-8 rounded-lg shadow-lg w-96">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-8">Login</h2>
    <form action="login" method="post" class="space-y-6">
        <div>
            <label class="block text-gray-700 text-sm font-bold mb-2">Username:</label>
            <input type="text" name="username" required
                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div>
            <label class="block text-gray-700 text-sm font-bold mb-2">Password:</label>
            <input type="password" id="password" name="password" required
                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            <button type="button" onclick="togglePassword()" style="background:none;border:none;cursor:pointer;">
                <span id="eyeIcon">&#128065;</span>
            </button>
            <script>
                function togglePassword() {
                    var pwd = document.getElementById('password');
                    var eye = document.getElementById('eyeIcon');
                    if (pwd.type === 'password') {
                        pwd.type = 'text';
                        eye.textContent = '🙈';
                    } else {
                        pwd.type = 'password';
                        eye.textContent = '👁️';
                    }
                }
            </script>
        </div>
        <button type="submit"
                class="w-full bg-blue-500 text-white font-bold py-2 px-4 rounded-md hover:bg-blue-600 transition duration-300">
            Login
        </button>
    </form>
    <% if (request.getAttribute("error") != null) { %>
    <p class="mt-4 text-red-500 text-center"><%= request.getAttribute("error") %>
    </p>
    <% } %>
</div>
</body>
</html>

