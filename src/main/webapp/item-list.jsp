<%@ page import="java.util.List" %>
<%@ page import="model.Items" %>
<%@ page import="dao.ItemDAO" %>
<!doctype html>
<html class="bg-gray-100">
<head>
    <meta charset="utf-8" />
    <title>Item List</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#ff6d4d',
                        secondary: '#309afc',
                        accent: '#00888f'
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-gray-100">
<div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
    <!-- Page header -->
    <div class="md:flex md:items-center md:justify-between mb-8">
        <div class="flex-1 min-w-0">
            <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
                Item List
            </h2>
            <div class="mt-1 flex flex-col sm:flex-row sm:flex-wrap sm:mt-0 sm:space-x-6">
                <div class="mt-2 flex items-center text-sm text-gray-500">
                    Total Items: <strong class="ml-2 text-slate-700">
                        <% List<Items> items = new ItemDAO().getAllItems(); int total = items != null ? items.size() : 0; %>
                        <%= total %>
                    </strong>
                </div>
            </div>
        </div>
        <div class="mt-4 flex md:mt-0 md:ml-4">
            <a href="add-item.jsp"
               class="ml-3 inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
                Add New Item
            </a>
            <a href="dashboard.jsp"
               class="ml-3 inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
                Dashboard
            </a>
        </div>
    </div>
    <!-- Status messages -->
    <div class="mb-6 grid grid-cols-1 gap-3">
        <% if (request.getAttribute("message") != null) { %>
        <div class="px-4 py-3 rounded-lg bg-green-50 border border-green-100 text-green-700">
            <div class="flex items-start gap-3">
                <svg class="w-5 h-5 text-green-500 animate-pulse" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M20 6L9 17l-5-5"/>
                </svg>
                <div><%= request.getAttribute("message") %></div>
            </div>
        </div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="px-4 py-3 rounded-lg bg-red-50 border border-red-100 text-red-700">
            <div class="flex items-start gap-3">
                <svg class="w-5 h-5 text-red-500 animate-pulse" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M12 9v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
                </svg>
                <div><%= request.getAttribute("error") %></div>
            </div>
        </div>
        <% } %>
    </div>
    <!-- Item List Table -->
    <div class="flex flex-col">
        <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
            <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
                <div class="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">No.</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Price</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Stock</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Photo</th>
                            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <%
                            if (items != null) {
                                int idx = 1;
                                for (Items item : items) {
                        %>
                        <tr class="hover:bg-primary/10 transition">
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600"><%= idx++ %></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600"><%= item.getItem_id() %></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-semibold text-gray-900 flex items-center gap-3">
                                <div class="p-2 rounded-md bg-primary/10 text-primary w-8 h-8 flex items-center justify-center">
                                    <svg class="w-4 h-4 animate-pulse-slow" viewBox="0 0 24 24" fill="currentColor"><circle cx="12" cy="12" r="6"/></svg>
                                </div>
                                <span><%= item.getItem_name() %></span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= item.getDescription() %></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700">$<%= item.getPrice() %></td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm">
                                <span class="inline-flex items-center px-3 py-1 rounded-full bg-accent/10 text-accent text-xs font-medium">
                                    <svg class="w-3 h-3 mr-2" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                        <path d="M12 6v6l4 2"/>
                                    </svg>
                                    <%= item.getStock_quantity() %> units
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm">
                                <img src="ItemImageServlet?item_id=<%= item.getItem_id() %>" alt="Item Photo" class="w-16 h-16 object-cover rounded-lg border border-gray-200 shadow cursor-pointer" onclick="showImageModal('ItemImageServlet?item_id=<%= item.getItem_id() %>')" />
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium flex items-center justify-end gap-3">
                                <a href="viewItem?item_id=<%= item.getItem_id() %>" class="text-secondary hover:underline">View</a>
                                <a href="editItem?item_id=<%= item.getItem_id() %>" class="text-primary hover:underline">Edit</a>
                                <form action="deleteItem" method="post" style="display:inline;">
                                    <input type="hidden" name="item_id" value="<%= item.getItem_id() %>">
                                    <button type="submit" class="text-red-500 hover:underline" onclick="return confirm('Are you sure you want to delete this item?');">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <%    }
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- Footer Actions -->
    <div class="px-6 py-4 border-t border-gray-200 flex items-center justify-between">
        <div class="text-sm text-gray-500">Showing <strong class="text-gray-700"><%= total %></strong> items</div>
        <div class="flex items-center gap-3">
            <button class="px-3 py-1 rounded-md text-sm bg-secondary/10 text-secondary hover:bg-secondary/20 transition inline-flex items-center gap-2">
                <svg class="w-4 h-4" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M3 12h18M3 6h18M3 18h18"/></svg>
                Export
            </button>
            <a href="add-item.jsp" class="px-3 py-1 rounded-md bg-primary text-white text-sm hover:bg-primary/90 transition">New Item</a>
        </div>
    </div>
    <!-- small helper note -->
    <footer class="mt-6 text-sm text-gray-400">
        Tip: Use the action links to manage items. Colors: primary (#ff6d4d), secondary (#309afc), accent (#27f4ff).
    </footer>
</div>
<!-- Image Modal -->
<div id="imageModal" class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-60 hidden" onclick="hideImageModal()">
    <div class="relative bg-white rounded-xl shadow-lg p-4 max-w-md w-full flex flex-col items-center" onclick="event.stopPropagation()">
        <button class="absolute top-2 right-2 text-gray-500 hover:text-red-500 text-xl" onclick="hideImageModal()" aria-label="Close">&times;</button>
        <img id="modalImage" src="" alt="Book Image" class="max-h-[60vh] w-auto rounded-lg border border-gray-200 shadow" />
    </div>
</div>
<script>
function showImageModal(src) {
    document.getElementById('modalImage').src = src;
    document.getElementById('imageModal').classList.remove('hidden');
    document.body.classList.add('overflow-hidden');
}
function hideImageModal() {
    document.getElementById('imageModal').classList.add('hidden');
    document.getElementById('modalImage').src = '';
    document.body.classList.remove('overflow-hidden');
}
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') hideImageModal();
});
</script>
</body>
</html>