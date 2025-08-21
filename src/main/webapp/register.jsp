<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Registration</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Heroicons -->
    <script src="https://unpkg.com/feather-icons"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen">
<div class="bg-white shadow-xl rounded-2xl w-full max-w-md p-8">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">👤 Pahana Book Store User Registration</h2>

    <form method="post" action="register" class="space-y-5">

        <!-- Username -->
        <div>
            <label for="username" class="block text-gray-700 font-medium">Username</label>
            <div class="flex items-center border border-gray-300 rounded-lg px-3 py-2 mt-1 focus-within:ring-2 focus-within:ring-indigo-500">
                <i data-feather="user" class="w-5 h-5 text-gray-500"></i>
                <input type="text" id="username" name="username" required
                       class="ml-2 w-full outline-none border-none bg-transparent" placeholder="Enter username">
            </div>
        </div>

        <!-- Password -->
        <div>
            <label for="password" class="block text-gray-700 font-medium">Password</label>
            <div class="flex items-center border border-gray-300 rounded-lg px-3 py-2 mt-1 focus-within:ring-2 focus-within:ring-indigo-500">
                <i data-feather="lock" class="w-5 h-5 text-gray-500"></i>
                <input type="password" id="password" name="password" required
                       class="ml-2 w-full outline-none border-none bg-transparent" placeholder="Enter password">
                <button type="button" onclick="togglePassword()" class="focus:outline-none">
                    <i id="eyeIcon" data-feather="eye" class="w-5 h-5 text-gray-500"></i>
                </button>
            </div>
        </div>

        <!-- Full Name -->
        <div>
            <label for="fullName" class="block text-gray-700 font-medium">Full Name</label>
            <div class="flex items-center border border-gray-300 rounded-lg px-3 py-2 mt-1 focus-within:ring-2 focus-within:ring-indigo-500">
                <i data-feather="edit-2" class="w-5 h-5 text-gray-500"></i>
                <input type="text" id="fullName" name="fullName" required
                       class="ml-2 w-full outline-none border-none bg-transparent" placeholder="Enter full name">
            </div>
        </div>

        <!-- Submit Button -->
        <div>
            <button type="submit"
                    class="w-full bg-indigo-600 hover:bg-indigo-700 text-white font-semibold py-2 rounded-lg transition duration-300">
                Register
            </button>
        </div>
    </form>

    <!-- Messages -->
    <div class="mt-4">
        <% if (request.getAttribute("message") != null) { %>
        <p class="text-green-600 text-sm font-medium text-center"><%= request.getAttribute("message") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <p class="text-red-600 text-sm font-medium text-center"><%= request.getAttribute("error") %></p>
        <% } %>
    </div>
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
    feather.replace();
</script>
</body>
</html>
