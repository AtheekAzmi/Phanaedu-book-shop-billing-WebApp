<%--
  Created by IntelliJ IDEA.
  User: Atheek Azmi
  Date: 8/20/2025
  Time: 12:10 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.*,dao.CustomerDAO,model.Customer,dao.ItemDAO,model.Items" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Create Bill</title>
    <style>
        table { border-collapse: collapse; width: 80%; margin: 20px auto; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: center; }
        button { margin: 5px; padding: 5px 10px; }
        .modal { display:none; position:fixed; z-index:1000; left:0; top:0; width:100%; height:100%; overflow:auto; background:rgba(0,0,0,0.4); }
        .modal-content { background:#fff; margin:10% auto; padding:20px; border:1px solid #888; width:300px; }
    </style>
    <script>
        function addRow() {
            let table = document.getElementById("itemsTable").getElementsByTagName('tbody')[0];
            let row = table.insertRow();

            let itemCell = row.insertCell(0);
            let qtyCell = row.insertCell(1);
            let priceCell = row.insertCell(2);
            let totalCell = row.insertCell(3);
            let actionCell = row.insertCell(4);

            itemCell.innerHTML = document.getElementById("itemTemplate").innerHTML;
            qtyCell.innerHTML = "<input type='number' name='quantity' value='1' min='1' oninput='updateRowTotal(this)'/>";
            priceCell.innerHTML = "<input type='number' name='unitPrice' value='0' step='0.01' readonly/>";
            totalCell.innerHTML = "<input type='text' name='rowTotal' value='0' readonly/>";
            actionCell.innerHTML = "<button type='button' onclick='removeRow(this)'>Remove</button>";

            // Add event listener for item selection
            let itemSelect = itemCell.querySelector("select[name='itemId']");
            itemSelect.addEventListener('change', function() {
                fetchUnitPriceAndUpdateRow(itemSelect);
            });
            // Trigger price fetch for initial selection
            fetchUnitPriceAndUpdateRow(itemSelect);
        }

        function fetchUnitPriceAndUpdateRow(itemSelect) {
            let row = itemSelect.parentNode.parentNode;
            let itemId = itemSelect.value;
            let priceInput = row.querySelector("input[name='unitPrice']");
            if (!itemId) {
                priceInput.value = 0;
                updateRowTotal(priceInput);
                return;
            }
            // AJAX request to get price
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    try {
                        var resp = JSON.parse(xhr.responseText);
                        priceInput.value = resp.price;
                        updateRowTotal(priceInput);
                    } catch (e) {
                        priceInput.value = 0;
                        updateRowTotal(priceInput);
                    }
                }
            };
            xhr.open('GET', 'getItemPrice?itemId=' + encodeURIComponent(itemId), true);
            xhr.send();
        }

        function removeRow(btn) {
            let row = btn.parentNode.parentNode;
            row.parentNode.removeChild(row);
            updateTotal();
        }

        function updateRowTotal(input) {
            let row = input.parentNode.parentNode;
            let qty = row.querySelector("input[name='quantity']").value;
            let price = row.querySelector("input[name='unitPrice']").value;
            let total = qty * price;
            row.querySelector("input[name='rowTotal']").value = total.toFixed(2);
            updateTotal();
        }

        function updateTotal() {
            let totals = document.getElementsByName("rowTotal");
            let sum = 0;
            for (let i = 0; i < totals.length; i++) {
                sum += parseFloat(totals[i].value || 0);
            }
            document.getElementById("totalAmount").value = sum.toFixed(2);
        }

        function showCustomerModal() {
            document.getElementById('customerModal').style.display = 'block';
        }

        function closeCustomerModal() {
            document.getElementById('customerModal').style.display = 'none';
        }

        function addCustomerAJAX() {
            var name = document.getElementById('newCustomerName').value;
            var contact = document.getElementById('newCustomerContact').value;
            var account = document.getElementById('newCustomerAccount').value;
            var address = document.getElementById('newCustomerAddress').value;
            var unit = document.getElementById('newCustomerUnit').value;
            if (!name || !account) { alert('Name and Account Number are required'); return; }
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    try {
                        var resp = JSON.parse(xhr.responseText);
                        if (resp.success) {
                            var select = document.getElementsByName('customerId')[0];
                            var opt = document.createElement('option');
                            opt.value = resp.id;
                            opt.text = resp.name;
                            select.appendChild(opt);
                            select.value = resp.id;
                            closeCustomerModal();
                        } else {
                            alert('Failed to add customer');
                        }
                    } catch (e) { alert('Error adding customer'); }
                }
            };
            xhr.open('POST', 'AddCustomerServlet', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.send('name=' + encodeURIComponent(name) + '&contact=' + encodeURIComponent(contact) + '&account=' + encodeURIComponent(account) + '&address=' + encodeURIComponent(address) + '&unit=' + encodeURIComponent(unit));
        }

        function resetForm() {
            let table = document.getElementById("itemsTable").getElementsByTagName('tbody')[0];
            // Remove all rows except the first
            while (table.rows.length > 1) {
                table.deleteRow(1);
            }
            // Reset first row inputs
            let firstRow = table.rows[0];
            if (firstRow) {
                firstRow.querySelector("select[name='itemId']").selectedIndex = 0;
                firstRow.querySelector("input[name='quantity']").value = 1;
                firstRow.querySelector("input[name='unitPrice']").value = 0;
                firstRow.querySelector("input[name='rowTotal']").value = 0;
            }
            updateTotal();
        }

        // Hook to prevent selecting disabled (safety for some browsers) and enforce stock when changing existing rows
        function enforceStock(select){
          const opt = select.selectedOptions[0];
          if(!opt) return;
          const stock = parseInt(opt.getAttribute('data-stock')||'0');
          if(stock===0){ toast('Item out of stock','error'); select.value=''; }
        }
        // Update existing rows after page load (if any pre-rendered)
        window.addEventListener('DOMContentLoaded',()=>{
          document.querySelectorAll('select[name=itemId]').forEach(s=>{s.addEventListener('change',()=>enforceStock(s)); enforceStock(s);});
        });
    </script>
</head>
<body>
<div style="text-align:center; margin-bottom:20px;">
    <button type="button" onclick="window.location.href='dashboard.jsp'">Back to Dashboard</button>
</div>
<h2 align="center">Create New Bill</h2>
<form action="addBill" method="post">
    <table>
        <tr>
            <td>Customer:</td>
            <td>
                <select name="customerId" required>
                    <%
                        CustomerDAO customerDAO = new CustomerDAO();
                        List<Customer> customers = customerDAO.getAllCustomers();
                        for(Customer c : customers){
                    %>
                    <option value="<%= c.getCustomer_id() %>"><%= c.getFull_name() %></option>
                    <% } %>
                </select>
                <button type="button" onclick="showCustomerModal()">Add New Customer</button>
            </td>
        </tr>
        <tr>
            <td>User ID:</td>
            <td><input type="number" name="userId" required/></td>
        </tr>
        <tr>
            <td>Payment Method:</td>
            <td>
                <select name="paymentMethod" required>
                    <option value="Cash">Cash</option>
                    <option value="Card">Card</option>
                    <option value="Online">Online</option>
                </select>
            </td>
        </tr>
    </table>

    <h3 align="center">Bill Items</h3>
    <table id="itemsTable">
        <thead>
        <tr>
            <th>Item</th>
            <th>Quantity</th>
            <th>Unit Price</th>
            <th>Total</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody></tbody>
    </table>
    <div style="text-align: center;">
        <button type="button" onclick="addRow()">+ Add Item</button>
    </div>

    <table align="center">
        <tr>
            <td>Total Amount:</td>
            <td><input type="text" id="totalAmount" name="totalAmount" readonly/></td>
        </tr>
    </table>
    <div style="text-align: center;">
        <button type="submit">Save Bill</button>
    </div>
</form>

<!-- Hidden item dropdown template -->
<div id="itemTemplate" style="display:none;">
    <select name="itemId" class="border-gray-300 rounded-lg shadow-sm focus:ring-blue-500 focus:border-blue-500">
        <%
            ItemDAO itemDAO = new ItemDAO();
            List<Items> items = itemDAO.getAllItems();
            for(Items i : items){
                int stk = i.getStock_quantity();
                String label = i.getItem_name() + (stk==0 ? " (Out of Stock)" : "");
        %>
        <option value="<%= i.getItem_id() %>" data-stock="<%= stk %>" <%= stk==0?"disabled class='text-gray-400'": "" %>><%= label %></option>
        <% } %>
    </select>
</div>

<!-- Customer Modal -->
<div id="customerModal" class="modal">
    <div class="modal-content">
        <span style="float:right;cursor:pointer;" onclick="closeCustomerModal()">&times;</span>
        <h3>Add New Customer</h3>
        <label>Account Number:</label><br>
        <input type="text" id="newCustomerAccount" required><br>
        <label>Name:</label><br>
        <input type="text" id="newCustomerName" required><br>
        <label>Address:</label><br>
        <input type="text" id="newCustomerAddress"><br>
        <label>Contact:</label><br>
        <input type="text" id="newCustomerContact"><br>
        <label>Unit Consumed:</label><br>
        <input type="number" id="newCustomerUnit" value="0"><br><br>
        <button type="button" onclick="addCustomerAJAX()">Add Customer</button>
    </div>
</div>

<div style="text-align:center; margin-bottom:20px;">
    <button type="button" onclick="window.location.href='dashboard.jsp'">Back to Dashboard</button>
    <button type="button" onclick="resetForm()">Reset</button>
</div>

<% if (request.getAttribute("billError") != null) { %>
<script>window.addEventListener('DOMContentLoaded',function(){toast('<%= request.getAttribute("billError") %>','error');});</script>
<% } %>
</body>
</html>