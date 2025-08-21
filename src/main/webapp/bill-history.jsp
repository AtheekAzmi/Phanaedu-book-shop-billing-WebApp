<%@ page import="java.util.List" %>
<%@ page import="model.Bill" %>
<%@ page import="model.Customer" %>
<%@ page import="dao.BillDAO" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%
    CustomerDAO customerDAO = new CustomerDAO();
    BillDAO billDAO = new BillDAO();
    List<Customer> customers = customerDAO.getAllCustomers();
    NumberFormat nf = NumberFormat.getNumberInstance(new Locale("en", "LK"));
    nf.setMinimumFractionDigits(2);
    nf.setMaximumFractionDigits(2);
%>
<!doctype html>
<html class="bg-gray-100">
<head>
    <meta charset="utf-8" />
    <title>Bill History</title>
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
                <i class="fa-solid fa-file-invoice-dollar text-primary"></i>
                Bill History
            </h2>
        </div>
        <div class="mt-4 flex md:mt-0 md:ml-4">
            <a href="dashboard.jsp"
               class="ml-3 inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
                <i class="fa-solid fa-gauge mr-2"></i> Dashboard
            </a>
        </div>
    </div>
    <!-- Bill History Table -->
    <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200 bg-white rounded-lg shadow">
            <thead class="bg-primary text-white">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-user"></i> Customer Name</th>
                    <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-phone"></i> Contact Number</th>
                    <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-money-bill-wave"></i> Total Amount</th>
                    <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-eye"></i> Action</th>
                </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <% for (Customer customer : customers) {
                List<Bill> bills = billDAO.getBillsByCustomer(customer.getCustomer_id());
                double totalAmount = 0.0;
                if (bills != null && !bills.isEmpty()) {
                    for (Bill bill : bills) {
                        totalAmount += bill.getTotalAmount();
                    }
                }
                if (bills != null && !bills.isEmpty()) { %>
                <tr>
                    <td class="px-6 py-4"><%= customer.getFull_name() %></td>
                    <td class="px-6 py-4"><%= customer.getContact_no() %></td>
                    <td class="px-6 py-4 text-green-600 font-bold">LKR <%= nf.format(totalAmount) %></td>
                    <td class="px-6 py-4">
                        <a href="bill-customer-history.jsp?customerId=<%= customer.getCustomer_id() %>"
                           class="inline-flex items-center px-3 py-1 rounded bg-secondary text-white hover:bg-secondary/90">
                            <i class="fa-solid fa-eye mr-1"></i> View
                        </a>
                    </td>
                </tr>
            <% } else { %>
                <tr class="bg-gray-50">
                    <td class="px-6 py-4"><%= customer.getFull_name() %></td>
                    <td class="px-6 py-4"><%= customer.getContact_no() %></td>
                    <td class="px-6 py-4 text-gray-400" colspan="2">
                        <i class="fa-solid fa-file-circle-xmark mr-2"></i> No bill
                    </td>
                </tr>
            <% } } %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
