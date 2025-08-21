<%@ page import="model.Bill,model.BillItem,model.Customer,model.User,model.Items,dao.CustomerDAO,dao.UserDAO,dao.ItemDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bill Summary</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col items-center py-8">

<%
    Bill bill = (Bill) request.getAttribute("bill");
    Customer customer = null;
    User user = null;
    if (bill != null) {
        CustomerDAO customerDAO = new CustomerDAO();
        customer = customerDAO.getCustomerById(bill.getCustomerId());
        UserDAO userDAO = new UserDAO();
        user = userDAO.getUserById(bill.getUserId());
    }
    java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance(new java.util.Locale("en", "LK"));
    nf.setMinimumFractionDigits(2);
    nf.setMaximumFractionDigits(2);
%>

<div class="w-full max-w-4xl bg-white shadow-lg rounded-lg p-8">
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold text-gray-800 flex items-center gap-2">
            <!-- Receipt Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 14h6m2 4H7a2 2 0 01-2-2V6a2 2 0 012-2h3.5a2 2 0 001.7-.9l.6-.8a2 2 0 011.6-.8H17a2 2 0 012 2v14a2 2 0 01-2 2z" />
            </svg>
            Bill Summary
        </h2>
        <a href="dashboard.jsp" class="text-sm text-gray-500 hover:text-blue-600 flex items-center gap-1">
            <!-- Home Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l9-9 9 9M4 10v10a1 1 0 001 1h14a1 1 0 001-1V10" />
            </svg>
            Back to Dashboard
        </a>
    </div>

    <% if (bill != null) { %>
    <!-- Bill Details -->
    <div id="printableBill" class="space-y-6">
        <div class="grid grid-cols-2 gap-4">
            <div class="bg-gray-50 p-4 rounded-md">
                <p class="text-sm text-gray-500">Bill No</p>
                <p class="font-semibold"><%= bill.getBillId() %></p>
            </div>
            <div class="bg-gray-50 p-4 rounded-md">
                <p class="text-sm text-gray-500">Customer</p>
                <p class="font-semibold"><%= customer != null ? customer.getFull_name() : "N/A" %></p>
            </div>
            <div class="bg-gray-50 p-4 rounded-md">
                <p class="text-sm text-gray-500">User</p>
                <p class="font-semibold"><%= user != null ? user.getFullName() : "N/A" %></p>
            </div>
            <div class="bg-gray-50 p-4 rounded-md">
                <p class="text-sm text-gray-500">Date</p>
                <p class="font-semibold"><%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></p>
            </div>
            <div class="bg-gray-50 p-4 rounded-md">
                <p class="text-sm text-gray-500">Payment Method</p>
                <p class="font-semibold"><%= bill.getPaymentMethod() %></p>
            </div>
            <div class="bg-gray-50 p-4 rounded-md">
                <p class="text-sm text-gray-500">Total Amount</p>
                <p class="font-semibold text-green-600">LKR <%= nf.format(bill.getTotalAmount()) %></p>
            </div>
        </div>

        <!-- Bill Items -->
        <h3 class="text-lg font-semibold mt-6 flex items-center gap-2">
            <!-- Shopping Cart Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-blue-600" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13l-1.6 8h13.2M7 13l-2-8H1" />
            </svg>
            Bill Items
        </h3>
        <div class="overflow-x-auto">
            <table class="min-w-full border border-gray-200 rounded-md overflow-hidden">
                <thead class="bg-gray-100 text-gray-600 text-sm">
                <tr>
                    <th class="px-4 py-2 border">Image</th>
                    <th class="px-4 py-2 border">Item Name</th>
                    <th class="px-4 py-2 border">Qty</th>
                    <th class="px-4 py-2 border">Unit Price</th>
                    <th class="px-4 py-2 border">Total</th>
                </tr>
                </thead>
                <tbody class="text-sm text-gray-700">
                <%
                    ItemDAO itemDAO = new ItemDAO();
                    double grossTotal = 0.0;
                    for (BillItem item : bill.getItems()) {
                        Items book = itemDAO.getItemById(item.getItemId());
                        grossTotal += item.getTotalPrice();
                %>
                <tr class="hover:bg-gray-50">
                    <td class="px-4 py-2 border">
                        <% if (book != null && book.getItemImage() != null) { %>
                        <img src="ItemImageServlet?item_id=<%= book.getItem_id() %>"
                             class="w-14 h-14 object-cover rounded-md border" />
                        <% } else { %>
                        <span class="text-gray-400">No Image</span>
                        <% } %>
                    </td>
                    <td class="px-4 py-2 border"><%= book != null ? book.getItem_name() : "N/A" %></td>
                    <td class="px-4 py-2 border"><%= item.getQuantity() %></td>
                    <td class="px-4 py-2 border">LKR <%= nf.format(item.getUnitPrice()) %></td>
                    <td class="px-4 py-2 border font-medium">LKR <%= nf.format(item.getTotalPrice()) %></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <div class="flex justify-end font-bold text-lg text-gray-800 mt-4">
            Gross Total: <span class="ml-2 text-green-600">LKR <%= nf.format(grossTotal) %></span>
        </div>
    </div>

    <!-- Actions -->
    <div class="flex justify-center gap-4 mt-8">
        <button onclick="printBill()"
                class="flex items-center gap-2 bg-blue-600 text-white px-4 py-2 rounded-lg shadow hover:bg-blue-700 transition">
            <!-- Print Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 9V2h12v7m-6 4h6m-6 4h6M6 9h12v13H6z" />
            </svg>
            Print Bill
        </button>
        <a href="billForm.jsp"
           class="flex items-center gap-2 bg-green-600 text-white px-4 py-2 rounded-lg shadow hover:bg-green-700 transition">
            <!-- Plus Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
            </svg>
            New Bill
        </a>
        <a href="dashboard.jsp"
           class="flex items-center gap-2 bg-gray-600 text-white px-4 py-2 rounded-lg shadow hover:bg-gray-700 transition">
            <!-- Dashboard Icon -->
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12h18M3 6h18M3 18h18" />
            </svg>
            Dashboard
        </a>
    </div>

    <% } else { %>
    <p class="text-center text-red-500 font-semibold">No bill data found.</p>
    <% } %>
</div>

<script>
    function printBill() {
        var printContents = document.getElementById('printableBill').innerHTML;
        var originalContents = document.body.innerHTML;
        document.body.innerHTML = printContents;
        window.print();
        document.body.innerHTML = originalContents;
    }
</script>

</body>
</html>
