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
    </script>
</head>
<body>
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
            </td>
        </tr>
        <tr>
            <td>User ID:</td>
            <td><input type="number" name="userId" required/></td>
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
    <select name="itemId">
        <%
            ItemDAO itemDAO = new ItemDAO();
            List<Items> items = itemDAO.getAllItems();
            for(Items i : items){
        %>
        <option value="<%= i.getItem_id() %>"><%= i.getItem_name() %></option>
        <% } %>
    </select>
</div>
</body>
</html>
