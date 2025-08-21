package servlet;

import dao.BillDAO;
import model.Bill;
import model.BillItem;
import dao.ItemDAO; // added
import model.Items; // added
import dao.CustomerDAO; // may still be used for other actions

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addBill")
public class AddBillServlet extends HttpServlet {
    private BillDAO billDAO;
    private ItemDAO itemDAO; // added

    @Override
    public void init() {
        billDAO = new BillDAO();
        itemDAO = new ItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String[] itemIds = request.getParameterValues("itemId");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unitPrice");

        if (itemIds == null || itemIds.length == 0) {
            request.setAttribute("billError", "No items added to the bill.");
            request.getRequestDispatcher("billForm.jsp").forward(request, response);
            return;
        }

        List<BillItem> billItems = new ArrayList<>();
        double computedTotal = 0.0;

        for (int i = 0; i < itemIds.length; i++) {
            int itemId = Integer.parseInt(itemIds[i]);
            int qty = Integer.parseInt(quantities[i]);
            if (qty <= 0) {
                request.setAttribute("billError", "Invalid quantity for item ID " + itemId);
                request.getRequestDispatcher("billForm.jsp").forward(request, response);
                return;
            }
            Items item = itemDAO.getItemById(itemId);
            if (item == null) {
                request.setAttribute("billError", "Item not found: ID " + itemId);
                request.getRequestDispatcher("billForm.jsp").forward(request, response);
                return;
            }
            int stock = item.getStock_quantity();
            if (stock <= 0) {
                request.setAttribute("billError", "Item '" + item.getItem_name() + "' is out of stock.");
                request.getRequestDispatcher("billForm.jsp").forward(request, response);
                return;
            }
            if (qty > stock) {
                request.setAttribute("billError", "Not enough stock for '" + item.getItem_name() + "' (Available: " + stock + ")");
                request.getRequestDispatcher("billForm.jsp").forward(request, response);
                return;
            }
            // Trust server-side price if provided, else fall back to DB price
            double unitPrice;
            try {
                unitPrice = Double.parseDouble(unitPrices[i]);
                if (unitPrice <= 0) unitPrice = item.getPrice();
            } catch (Exception e) {
                unitPrice = item.getPrice();
            }
            double lineTotal = qty * unitPrice;
            computedTotal += lineTotal;
            billItems.add(new BillItem(0, 0, itemId, qty, unitPrice, lineTotal));
        }

        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String paymentMethod = request.getParameter("paymentMethod");

        // Replace any client total with server computed
        double totalAmount = computedTotal;

        java.util.Date billDate = new java.util.Date();
        Bill bill = new Bill(0, customerId, userId, billDate, totalAmount, billItems, paymentMethod);

        boolean success = billDAO.addBill(bill);

        if (success) {
            // Update stock after successful bill creation
            for (BillItem bi : billItems) {
                itemDAO.reduceStockAndIncrementSales(bi.getItemId(), bi.getQuantity());
            }
            // Removed unit_consumed increment (deprecated)
            request.setAttribute("bill", bill);
            request.getRequestDispatcher("billSuccess.jsp").forward(request, response);
        } else {
            request.setAttribute("billError", "Failed to save bill. Try again.");
            request.getRequestDispatcher("billForm.jsp").forward(request, response);
        }
    }
}
