<%@ page import="model.Bill" %>
<%@ page import="model.BillItem" %>
<%@ page import="model.Customer" %>
<%@ page import="dao.BillDAO" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="dao.ItemDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="model.Items" %>
<%
    int billId = Integer.parseInt(request.getParameter("billId"));
    BillDAO billDAO = new BillDAO();
    CustomerDAO customerDAO = new CustomerDAO();
    ItemDAO itemDAO = new ItemDAO();
    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("en", "LK"));
    nf.setMinimumFractionDigits(2);
    nf.setMaximumFractionDigits(2);
    Bill bill = billDAO.getBillById(billId);
    Customer customer = (bill != null) ? customerDAO.getCustomerById(bill.getCustomerId()) : null;
%>
<!doctype html>
<html class="bg-gray-100">
<head>
    <meta charset="utf-8" />
    <title>Bill Details</title>
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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100">
<div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
    <!-- Header -->
    <div class="md:flex md:items-center md:justify-between mb-8">
        <div class="flex-1 min-w-0">
            <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate flex items-center gap-2">
                <i class="fa-solid fa-file-invoice text-primary"></i>
                Bill Details
            </h2>
        </div>
        <div class="mt-4 flex md:mt-0 md:ml-4">
            <a href="dashboard.jsp"
               class="ml-3 inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
                <i class="fa-solid fa-gauge mr-2"></i> Dashboard
            </a>
            <a href="bill-history.jsp"
               class="ml-3 inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
                <i class="fa-solid fa-clock-rotate-left mr-2"></i> Bill History
            </a>
        </div>
    </div>
    <% if (bill != null && customer != null) { %>
    <!-- Customer & Bill Info Card -->
    <div class="bg-white rounded-lg shadow p-6 mb-8 max-w-xl mx-auto">
        <div class="flex items-center gap-4 mb-2">
            <i class="fa-solid fa-user text-secondary"></i>
            <span class="font-semibold">Customer Name:</span>
            <span class="ml-2 text-gray-700"><%= customer.getFull_name() %></span>
        </div>
        <div class="flex items-center gap-4 mb-2">
            <i class="fa-solid fa-phone text-primary"></i>
            <span class="font-semibold">Contact Number:</span>
            <span class="ml-2 text-gray-700"><%= customer.getContact_no() %></span>
        </div>
        <div class="flex items-center gap-4 mb-2">
            <i class="fa-solid fa-location-dot text-accent"></i>
            <span class="font-semibold">Address:</span>
            <span class="ml-2 text-gray-700"><%= customer.getAddress() %></span>
        </div>
        <div class="flex items-center gap-4 mb-2">
            <i class="fa-solid fa-id-card text-primary"></i>
            <span class="font-semibold">Account Number:</span>
            <span class="ml-2 text-gray-700"><%= customer.getAccount_number() %></span>
        </div>
        <div class="flex items-center gap-4 mb-2">
            <i class="fa-solid fa-money-bill-wave text-green-600"></i>
            <span class="font-semibold">Total Amount:</span>
            <span class="ml-2 text-green-700 font-bold">LKR <%= nf.format(bill.getTotalAmount()) %></span>
        </div>
        <div class="flex items-center gap-4 mb-2">
            <i class="fa-solid fa-credit-card text-secondary"></i>
            <span class="font-semibold">Payment Method:</span>
            <span class="ml-2 text-gray-700"><%= bill.getPaymentMethod() %></span>
        </div>
    </div>
    <!-- Bill Items Table -->
    <h3 class="text-lg font-bold mb-4 flex items-center gap-2"><i class="fa-solid fa-list text-primary"></i> Bill Items</h3>
    <div id="printableBill" class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200 bg-white rounded-lg shadow">
            <thead class="bg-primary text-white">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-image"></i> Item Image</th>
                    <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-book"></i> Item Name</th>
                    <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-sort-numeric-up"></i> Quantity</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <% for (BillItem item : bill.getItems()) {
                Items book = itemDAO.getItemById(item.getItemId()); %>
                <tr>
                    <td class="px-6 py-4">
                        <% if (book != null && book.getItemImage() != null) { %>
                            <img src="ItemImageServlet?item_id=<%= book.getItem_id() %>" alt="Item Image" class="w-16 h-16 object-cover rounded" />
                        <% } else { %>
                            <span class="text-gray-400"><i class="fa-solid fa-image"></i> No Image</span>
                        <% } %>
                    </td>
                    <td class="px-6 py-4"><%= book != null ? book.getItem_name() : "N/A" %></td>
                    <td class="px-6 py-4"><%= item.getQuantity() %></td>
                </tr>
            <% } %>
            </tbody>
        </table>
    </div>
    <!-- Print Button -->
    <div class="mt-6 text-center">
        <button onclick="printBill()" class="inline-flex items-center px-5 py-2 rounded-full bg-primary text-white font-semibold shadow-lg hover:scale-105 transition transform">
            <i class="fa-solid fa-print mr-2"></i> Print Bill
        </button>
    </div>
    <% } else { %>
    <div class="bg-white rounded-lg shadow-sm p-6 text-center flex flex-col items-center">
        <i class="fa-solid fa-file-circle-xmark text-4xl text-gray-400 mb-2"></i>
        <h3 class="text-lg font-medium text-gray-700">Bill not found.</h3>
    </div>
    <% } %>
</div>
<script>
function printBill() {
    var printContents = document.getElementById('printableBill').innerHTML;
    var originalContents = document.body.innerHTML;
    document.body.innerHTML = '<div>' + printContents + '</div>';
    window.print();
    document.body.innerHTML = originalContents;
    location.reload();
}
</script>
</body>
</html>
