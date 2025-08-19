<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/18/2025
  Time: 6:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.Customer" %>
<%
  Customer customer = (Customer) request.getAttribute("customer");
%>
<!doctype html>
<html>
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Customer Details</title>

  <!-- Tailwind CDN with custom colors -->
  <script>
    window.tailwind = {
      config: {
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
    }
  </script>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://unpkg.com/lucide@latest/dist/umd/lucide.js"></script>
  <!-- Production version -->
  <script src="https://unpkg.com/lucide@latest"></script>
</head>
<style>
  .Customer-Details{
    color: #ff6d4d;
  }

  .edit-bttun{
    background-color: #ff6d4d;
    color: white;
  }

  .cus-f-name{
    color: #309afc;
  }
</style>
<body class="min-h-screen bg-gradient-to-br from-secondary/5 via-accent/5 to-primary/5 flex items-center justify-center p-6">
<div class="max-w-3xl w-full">
  <!-- Header -->
  <header class="rounded-xl overflow-hidden shadow-lg mb-6 bg-white">
    <div class="bg-gradient-to-r from-primary/10 via-secondary/10 to-accent/10 p-8">
      <div class="flex items-center gap-6">
        <!-- circular icon -->
        <div class="w-16 h-16 rounded-full bg-primary text-white flex items-center justify-center ring-4 ring-primary/20 shadow-lg"
             aria-hidden="true">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor"
               stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
               class="lucide lucide-user-icon">
            <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"/>
            <circle cx="12" cy="7" r="4"/>
          </svg>
        </div>

        <div>
          <h1 class="Customer-Details text-3xl font-bold mb-1 bg-gradient-to-r from-primary to-secondary bg-clip-text ">Customer Details</h1>
          <p class="text-gray-700">Account overview for <span class="cus-f-name font-medium text-secondary"><%= customer.getFull_name() %></span></p>
        </div>

        <div class="ml-auto">
                <span class="inline-flex items-center gap-2 bg-white px-4 py-2 rounded-lg shadow-sm border border-gray-100">
                    <svg class="w-5 h-5 text-secondary" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5" d="M12 8v4l3 3"/>
                    </svg>
                    <span class="text-gray-500">ID:</span>
                    <span class="font-bold text-primary"><%= customer.getCustomer_id() %></span>
                </span>
        </div>
      </div>
    </div>

    <div class="p-4 flex gap-3 justify-end bg-gradient-to-r from-white to-gray-50">
      <a href="listCustomers"
         class="px-5 py-2.5 rounded-lg text-sm font-medium border-2 border-secondary text-secondary bg-secondary/10 hover:bg-secondary/20 transition-all">
        ← Back to List
      </a>
      <a href="editCustomer?id=<%= customer.getCustomer_id() %>"
         class="edit-bttun px-5 py-2.5 rounded-lg text-sm font-medium bg-primary text-white shadow-sm hover:bg-primary/90 transition-all">
        Edit Details
      </a>
    </div>
  </header>

  <!-- Card with details -->
  <main class="bg-white rounded-xl shadow-lg p-8 border-l-4 border-accent relative overflow-hidden">
    <div class="absolute top-0 right-0 w-40 h-40 bg-accent/5 rounded-full -mr-20 -mt-20"></div>
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-8 relative">
      <div class="p-4 rounded-lg bg-gray-50/50">
        <div class="text-xs font-medium text-gray-500 uppercase tracking-wider mb-2">Account Number</div>
        <div class="text-xl font-bold text-primary"><%= customer.getAccount_number() %>
        </div>
      </div>

      <div class="p-4 rounded-lg bg-gray-50/50">
        <div class="text-xs font-medium text-gray-500 uppercase tracking-wider mb-2">Full Name</div>
        <div class="text-xl font-bold text-gray-900"><%= customer.getFull_name() %>
        </div>
      </div>

      <div class="p-4 rounded-lg bg-gray-50/50">
        <div class="text-xs font-medium text-gray-500 uppercase tracking-wider mb-2">Contact No</div>
        <div class="text-xl font-bold text-gray-900"><%= customer.getContact_no() %>
        </div>
      </div>

      <div class="p-4 rounded-lg bg-gray-50/50">
        <div class="text-xs font-medium text-gray-500 uppercase tracking-wider mb-2">Units Consumed</div>
        <div class="flex items-center gap-4">
          <div class="text-xl font-bold text-secondary"><%= customer.getUnit_consumed() %>
          </div>
          <div class="flex-1">
            <div class="h-4 rounded-full bg-gray-100 overflow-hidden shadow-inner">
              <div class="h-4 bg-gradient-to-r from-secondary to-accent shadow-lg transition-all"
                   style="width: calc(<%= customer.getUnit_consumed() %> * 0.8% )"></div>
            </div>
          </div>
        </div>
      </div>

      <div class="sm:col-span-2 p-4 rounded-lg bg-gray-50/50">
        <div class="text-xs font-medium text-gray-500 uppercase tracking-wider mb-2">Address</div>
        <div class="text-lg text-gray-700"><%= customer.getAddress() %>
        </div>
      </div>
    </div>

    <hr class="my-8 border-gray-100"/>

    <div class="flex flex-col sm:flex-row items-center justify-between gap-4">
      <div class="text-sm text-gray-500">Last updated: <span
              class="text-gray-900 font-semibold"><%= new java.util.Date() %></span></div>
      <div class="flex gap-3">
        <a href="listCustomers"
           class="px-5 py-2.5 rounded-lg border-2 border-secondary text-secondary hover:bg-secondary/10 transition-all text-sm font-medium">View
          All Records</a>
        <a href="editCustomer?id=<%= customer.getCustomer_id() %>"
           class="edit-bttun px-5 py-2.5 rounded-lg bg-secondary text-white hover:bg-secondary/90 transition-all text-sm font-medium shadow-lg shadow-secondary/20">Edit
          Customer</a>
      </div>
    </div>
  </main>

  <!-- small footer -->
  <footer class="text-center text-sm text-gray-500 mt-6 flex items-center justify-center gap-3">
    Powered by PhanaEdu
    <div class="flex items-center gap-2">
      <span class="inline-block w-3 h-3 bg-primary rounded-full shadow-lg shadow-primary/30"></span>
      <span class="inline-block w-3 h-3 bg-secondary rounded-full shadow-lg shadow-secondary/30"></span>
      <span class="inline-block w-3 h-3 bg-accent rounded-full shadow-lg shadow-accent/30"></span>
    </div>
  </footer>
</div>
</body>
</html>


