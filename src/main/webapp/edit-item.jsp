<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    model.Items item = (model.Items) request.getAttribute("item");
%>
<!doctype html>
<html class="bg-neutralSoft">
<head>
    <title>Edit Item</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        brand: {
                            DEFAULT: '#0f172a',
                            accent: '#06b6d4',
                            gradientFrom: '#7c3aed',
                            gradientTo: '#06b6d4'
                        },
                        neutralSoft: '#f8fafc',
                        primary: '#ff6d4d',
                        secondary: '#309afc',
                        accent: '#27f4ff'
                    },
                    boxShadow: {
                        'soft-lg': '0 10px 30px rgba(2,6,23,0.14)'
                    },
                    animation: {
                        'fade-in': 'fadeIn 0.45s ease-in-out',
                        'float-up': 'floatUp 0.45s cubic-bezier(.2,.8,.2,1)'
                    },
                    keyframes: {
                        fadeIn: {'0%': {opacity: '0'}, '100%': {opacity: '1'}},
                        floatUp: {'0%': {transform: 'translateY(8px)', opacity: '0'}, '100%': {transform: 'translateY(0)', opacity: '1'}}
                    }
                }
            }
        }
    </script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .field-wrap { position: relative; }
        .floating-label {
            position: absolute;
            left: 16px;
            top: 14px;
            pointer-events: none;
            transition: all .18s ease;
            font-size: .95rem;
            color: rgba(15,23,42,0.55);
        }
        input:focus + .floating-label,
        input:not(:placeholder-shown) + .floating-label {
            transform: translateY(-28px) scale(.92);
            color: #7c3aed;
        }
    </style>
</head>
<body class="bg-neutralSoft min-h-screen flex items-center justify-center">
    <div class="max-w-lg w-full mx-auto bg-white rounded-2xl shadow-soft-lg p-8 animate-fade-in">
        <div class="flex items-center gap-3 mb-6">
            <div class="p-3 rounded-full bg-gradient-to-tr from-brand.gradientFrom to-brand.gradientTo text-white">
                <i class="fa-solid fa-box-open fa-lg"></i>
            </div>
            <h2 class="text-2xl font-bold text-brand">Edit Item</h2>
        </div>
        <% if (item.getItem_id() > 0) { %>
        <div class="mb-6 flex flex-col items-center">
            <img src="ItemImageServlet?item_id=<%= item.getItem_id() %>" alt="Current Photo" class="w-32 h-32 object-cover rounded-xl border border-gray-200 shadow mb-2" />
            <span class="text-xs text-gray-500">Current Photo</span>
        </div>
        <% } %>
        <form method="post" action="editItem" enctype="multipart/form-data" class="space-y-6">
            <input type="hidden" name="item_id" value="<%= item.getItem_id() %>">
            <div class="field-wrap">
                <input type="text" id="item_name" name="item_name" value="<%= item.getItem_name() %>" required placeholder=" " class="block w-full px-4 py-3 rounded-lg border border-gray-300 focus:border-brand.gradientFrom focus:ring-2 focus:ring-brand.gradientFrom bg-neutralSoft text-brand shadow-sm" />
                <span class="floating-label">Item Name</span>
            </div>
            <div class="field-wrap">
                <input type="text" id="description" name="description" value="<%= item.getDescription() %>" required placeholder=" " class="block w-full px-4 py-3 rounded-lg border border-gray-300 focus:border-brand.gradientFrom focus:ring-2 focus:ring-brand.gradientFrom bg-neutralSoft text-brand shadow-sm" />
                <span class="floating-label">Description</span>
            </div>
            <div class="field-wrap">
                <input type="number" step="0.01" id="price" name="price" value="<%= item.getPrice() %>" required placeholder=" " class="block w-full px-4 py-3 rounded-lg border border-gray-300 focus:border-brand.gradientFrom focus:ring-2 focus:ring-brand.gradientFrom bg-neutralSoft text-brand shadow-sm" />
                <span class="floating-label">Price</span>
            </div>
            <div class="field-wrap">
                <input type="number" id="stock_quantity" name="stock_quantity" value="<%= item.getStock_quantity() %>" required placeholder=" " class="block w-full px-4 py-3 rounded-lg border border-gray-300 focus:border-brand.gradientFrom focus:ring-2 focus:ring-brand.gradientFrom bg-neutralSoft text-brand shadow-sm" />
                <span class="floating-label">Stock Quantity</span>
            </div>
            <div class="field-wrap">
                <input type="file" id="photo" name="photo" accept="image/*" class="block w-full px-4 py-3 rounded-lg border border-gray-300 bg-neutralSoft text-brand shadow-sm" />
                <span class="floating-label">Change Photo</span>
                <span class="text-xs text-gray-400 block mt-1">Leave blank to keep current photo.</span>
            </div>
            <button type="submit" class="w-full py-3 rounded-lg bg-primary text-white font-bold shadow hover:scale-[1.03] transition">Update Item</button>
        </form>
        <% if (request.getAttribute("message") != null) { %>
        <div class="mt-6 px-4 py-3 rounded-lg bg-green-50 border border-green-100 text-green-700 flex items-center gap-2 animate-fade-in">
            <i class="fa-solid fa-circle-check"></i>
            <span><%= request.getAttribute("message") %></span>
        </div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="mt-6 px-4 py-3 rounded-lg bg-red-50 border border-red-100 text-red-700 flex items-center gap-2 animate-fade-in">
            <i class="fa-solid fa-circle-exclamation"></i>
            <span><%= request.getAttribute("error") %></span>
        </div>
        <% } %>
        <div class="mt-8 flex justify-between">
            <a href="item-list.jsp" class="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-secondary text-white font-medium shadow hover:bg-secondary/90 transition">
                <i class="fa-solid fa-list"></i> Item List
            </a>
            <a href="dashboard.jsp" class="inline-flex items-center gap-2 px-4 py-2 rounded-lg bg-secondary text-white font-medium shadow hover:bg-brand.accent/90 transition">
                <i class="fa-solid fa-gauge"></i> Dashboard
            </a>
        </div>
    </div>
</body>
</html>
