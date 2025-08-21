<%@ page import="model.Bill,model.BillItem,model.Customer,model.Items,dao.BillDAO,dao.CustomerDAO,dao.ItemDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<% int customerId = Integer.parseInt(request.getParameter("customerId"));
   CustomerDAO customerDAO = new CustomerDAO();
   BillDAO billDAO = new BillDAO();
   ItemDAO itemDAO = new ItemDAO();
   Customer customer = customerDAO.getCustomerById(customerId);
   List<Bill> bills = billDAO.getBillsByCustomer(customerId);
   NumberFormat nf = NumberFormat.getNumberInstance(new Locale("en", "LK"));
   nf.setMinimumFractionDigits(2);
   nf.setMaximumFractionDigits(2);
%>
<!doctype html>
<html class="bg-gray-100">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Customer Bill History</title>
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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"/>
</head>
<body class="bg-gray-100">
<div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
  <!-- Header -->
  <div class="md:flex md:items-center md:justify-between mb-8">
    <div class="flex-1 min-w-0">
      <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate flex items-center gap-2">
        <i class="fa-solid fa-file-invoice-dollar text-primary"></i>
        Customer Bill History
      </h2>
      <div class="mt-1 flex flex-col sm:flex-row sm:flex-wrap sm:mt-0 sm:space-x-6">
        <div class="mt-2 flex items-center text-sm text-gray-500">
          <i class="fa-solid fa-user"></i>
          <span class="ml-2">Customer: <%= customer.getFull_name() %></span>
        </div>
      </div>
    </div>
    <div class="mt-4 flex md:mt-0 md:ml-4">
      <a href="bill-history.jsp"
         class="ml-3 inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
        <i class="fa-solid fa-arrow-left mr-2"></i> Back
      </a>
      <a href="dashboard.jsp"
         class="ml-3 inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
        <i class="fa-solid fa-gauge mr-2"></i> Dashboard
      </a>
    </div>
  </div>
  <!-- Customer Details Card -->
  <div class="bg-white rounded-lg shadow p-6 mb-8 max-w-xl mx-auto">
    <div class="flex items-center gap-4 mb-4">
      <i class="fa-solid fa-id-card text-primary text-2xl"></i>
      <span class="font-semibold text-lg">Account Number:</span>
      <span class="ml-2 text-gray-700"><%= customer.getAccount_number() %></span>
    </div>
    <div class="flex items-center gap-4 mb-2">
      <i class="fa-solid fa-user text-secondary"></i>
      <span class="font-semibold">Full Name:</span>
      <span class="ml-2 text-gray-700"><%= customer.getFull_name() %></span>
    </div>
    <div class="flex items-center gap-4 mb-2">
      <i class="fa-solid fa-location-dot text-accent"></i>
      <span class="font-semibold">Address:</span>
      <span class="ml-2 text-gray-700"><%= customer.getAddress() %></span>
    </div>
    <div class="flex items-center gap-4">
      <i class="fa-solid fa-phone text-primary"></i>
      <span class="font-semibold">Contact Number:</span>
      <span class="ml-2 text-gray-700"><%= customer.getContact_no() %></span>
    </div>
  </div>
  <!-- Bill History Table -->
  <div id="printableBill">
    <% if (bills != null && !bills.isEmpty()) { %>
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200 bg-white rounded-lg shadow">
          <thead class="bg-primary text-white">
            <tr>
              <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-hashtag"></i> Bill No</th>
              <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-calendar-days"></i> Date</th>
              <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-money-bill-wave"></i> Total Amount</th>
              <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-credit-card"></i> Payment Method</th>
              <th class="px-6 py-3 text-left text-xs font-medium uppercase tracking-wider"><i class="fa-solid fa-list"></i> Items</th>
            </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
            <% for (Bill bill : bills) { %>
              <tr>
                <td class="px-6 py-4 whitespace-nowrap font-semibold text-primary"><%= bill.getBillId() %></td>
                <td class="px-6 py-4 whitespace-nowrap"><%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></td>
                <td class="px-6 py-4 whitespace-nowrap text-green-600 font-bold">LKR <%= nf.format(bill.getTotalAmount()) %></td>
                <td class="px-6 py-4 whitespace-nowrap"><%= bill.getPaymentMethod() %></td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <table class="min-w-full text-xs">
                    <thead>
                      <tr>
                        <th class="px-2 py-1">Image</th>
                        <th class="px-2 py-1">Name</th>
                        <th class="px-2 py-1">Qty</th>
                        <th class="px-2 py-1">Unit Price</th>
                        <th class="px-2 py-1">Total</th>
                      </tr>
                    </thead>
                    <tbody>
                      <% for (BillItem item : bill.getItems()) {
                        Items book = itemDAO.getItemById(item.getItemId()); %>
                        <tr>
                          <td class="px-2 py-1">
                            <% if (book != null && book.getItemImage() != null) { %>
                              <img src="ItemImageServlet?item_id=<%= book.getItem_id() %>" alt="Item Image" class="w-10 h-10 object-cover rounded" />
                            <% } else { %>
                              <span class="text-gray-400"><i class="fa-solid fa-image"></i> No Image</span>
                            <% } %>
                          </td>
                          <td class="px-2 py-1"><%= book != null ? book.getItem_name() : "N/A" %></td>
                          <td class="px-2 py-1"><%= item.getQuantity() %></td>
                          <td class="px-2 py-1">LKR <%= nf.format(item.getUnitPrice()) %></td>
                          <td class="px-2 py-1">LKR <%= nf.format(item.getTotalPrice()) %></td>
                        </tr>
                      <% } %>
                    </tbody>
                  </table>
                </td>
              </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    <% } else { %>
      <div class="bg-white rounded-lg shadow-sm p-6 text-center flex flex-col items-center">
        <i class="fa-solid fa-file-circle-xmark text-4xl text-gray-400 mb-2"></i>
        <h3 class="text-lg font-medium text-gray-700">No bills found for this customer.</h3>
      </div>
    <% } %>
  </div>
  <!-- Print Button -->
  <div class="mt-6 text-center">
    <button onclick="printBill()" class="inline-flex items-center px-5 py-2 rounded-full bg-primary text-white font-semibold shadow-lg hover:scale-105 transition transform">
      <i class="fa-solid fa-print mr-2"></i> Print Bill History
    </button>
  </div>
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
