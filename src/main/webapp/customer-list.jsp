<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List, model.Customer" %>
<!doctype html>
<html class="bg-gray-100">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width,initial-scale=1"/>
  <title>Customer List</title>

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
</head>
<body class="bg-gray-100">
<%
  List<Customer> customers = (List<Customer>) request.getAttribute("customers");
  int total = (customers == null) ? 0 : customers.size();
%>

<div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
  <!-- Page header -->
  <div class="md:flex md:items-center md:justify-between mb-8">
    <div class="flex-1 min-w-0">
      <h2 class="text-2xl font-bold leading-7 text-gray-900 sm:text-3xl sm:truncate">
        Customer List
      </h2>
      <div class="mt-1 flex flex-col sm:flex-row sm:flex-wrap sm:mt-0 sm:space-x-6">
        <div class="mt-2 flex items-center text-sm text-gray-500">
          Total Customers: <%= total %>
        </div>
      </div>
    </div>
    <div class="mt-4 flex md:mt-0 md:ml-4">
      <a href="customer-add.jsp"
         class="ml-3 inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-primary hover:bg-primary/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
        Add Customer
      </a>
      <a href="dashboard.jsp"
         class="ml-3 inline-flex items-center px-4 py-2 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-primary">
        Dashboard
      </a>
    </div>
  </div>

  <!-- Customer List Table -->
  <div class="flex flex-col">
    <div class="-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8">
      <div class="py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8">
        <div class="shadow overflow-hidden border-b border-gray-200 sm:rounded-lg">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>

              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
                  data-increment="${counter}">
                No.
              </th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              ID
              </th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Account
              </th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Name
              </th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Address
              </th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Contact
              </th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                Units
              </th>
              <th scope="col" class="px-6 py-3 text-center text-xs font-medium text-gray-500 uppercase tracking-wider">
                Actions
              </th>
            </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <%
              if (customers != null) {
                int counter = 1;
                for (Customer c : customers) {
            %>
            <tr class="hover:bg-gray-50">
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= counter++ %>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"><%= c.getCustomer_id() %>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= c.getAccount_number() %>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900"><%= c.getFull_name() %>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= c.getAddress() %>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"><%= c.getContact_no() %>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                        <%= c.getUnit_consumed() %> units
                                    </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                <a href="viewCustomer?id=<%= c.getCustomer_id() %>" class="text-secondary hover:text-secondary/80 mr-4">View</a>
                <a href="editCustomer?id=<%= c.getCustomer_id() %>"
                   class="text-primary hover:text-primary/80 mr-4">Edit</a>
                <a href="deleteCustomer?id=<%= c.getCustomer_id() %>" onclick="return confirm('Delete this customer?')"
                   class="text-red-600 hover:text-red-900">Delete</a>
              </td>
            </tr>
            <% }
            } %>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>

</body>
</html>
