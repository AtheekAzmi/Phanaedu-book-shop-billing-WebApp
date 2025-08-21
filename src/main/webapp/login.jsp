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
    <script src="https://unpkg.com/feather-icons"></script>
</head>
<style>
    img{
        display: block;
        margin: 0 auto;
    /*    center the image*/
        margin-bottom: 20px;
    }

    h2{
        color: #ff6d4d;
    }

    h2 > span{
        color: #3e79fb;
    }
</style>
<body class="bg-gray-100 h-screen flex items-center justify-center">
<div class="bg-white p-8 rounded-2xl shadow-2xl w-full max-w-md">
    <!-- Logo / Title -->
<%--    center the logo--%>
        <img src="assets/Phana.png" alt="Pahana Edu Logo" width="100" >
    <h2 class="text-3xl font-extrabold text-center text-gray-800 mb-8 flex items-center justify-center gap-2">
        <span class="text-blue-600">Pahana</span> Edu Login
    </h2>

    <!-- Login Form -->
    <form action="login" method="post" class="space-y-6">

        <!-- Username -->
        <div>
            <label class="block text-gray-700 text-sm font-semibold mb-2">Username</label>
            <div class="flex items-center border border-gray-300 rounded-lg px-3 py-2 focus-within:ring-2 focus-within:ring-blue-500">
                <i data-feather="user" class="w-5 h-5 text-gray-500"></i>
                <input type="text" name="username" required
                       class="ml-2 w-full outline-none border-none bg-transparent"
                       placeholder="Enter your username">
            </div>
        </div>

        <!-- Password -->
        <div>
            <label class="block text-gray-700 text-sm font-semibold mb-2">Password</label>
            <div class="flex items-center border border-gray-300 rounded-lg px-3 py-2 focus-within:ring-2 focus-within:ring-blue-500">
                <i data-feather="lock" class="w-5 h-5 text-gray-500"></i>
                <input type="password" id="password" name="password" required
                       class="ml-2 w-full outline-none border-none bg-transparent"
                       placeholder="Enter your password">
                <button type="button" onclick="togglePassword()" class="ml-2 focus:outline-none">
                    <i id="eyeIcon" data-feather="eye" class="w-5 h-5 text-gray-500"></i>
                </button>
            </div>
        </div>

        <!-- Submit Button -->
        <button type="submit"
                class="w-full bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 rounded-lg transition duration-300 flex items-center justify-center gap-2">
            <i data-feather="log-in" class="w-5 h-5"></i> Login
        </button>
    </form>

    <!-- Error Message -->
    <% if (request.getAttribute("error") != null) { %>
    <p class="mt-4 text-red-500 text-center font-medium">
        <i data-feather="alert-circle" class="inline w-4 h-4"></i>
        <%= request.getAttribute("error") %>
    </p>
    <% } %>
</div>

<script>
    function togglePassword() {
        var pwd = document.getElementById('password');
        var eye = document.getElementById('eyeIcon');
        if (pwd.type === 'password') {
            pwd.type = 'text';
            eye.setAttribute("data-feather", "eye-off");
        } else {
            pwd.type = 'password';
            eye.setAttribute("data-feather", "eye");
        }
        feather.replace(); // re-render icons
    }
    feather.replace(); // render all icons on page load
</script>
</body>
</html>

