package servlet;

import dao.BillDAO;
import model.Bill;
import model.BillItem;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addBill")
public class AddBillServlet extends HttpServlet {
    private BillDAO billDAO;

    @Override
    public void init() {
        billDAO = new BillDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int customerId = Integer.parseInt(request.getParameter("customerId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

        // Collect bill items
        String[] itemIds = request.getParameterValues("itemId");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unitPrice");

        List<BillItem> billItems = new ArrayList<>();
        if (itemIds != null) {
            for (int i = 0; i < itemIds.length; i++) {
                int itemId = Integer.parseInt(itemIds[i]);
                int qty = Integer.parseInt(quantities[i]);
                double unitPrice = Double.parseDouble(unitPrices[i]);
                double totalPrice = qty * unitPrice;

                billItems.add(new BillItem(0, 0, itemId, qty, unitPrice, totalPrice));
            }
        }

        Bill bill = new Bill(0, customerId, userId, null, totalAmount, billItems);

        boolean success = billDAO.addBill(bill);

        if (success) {
            request.setAttribute("bill", bill);
            request.getRequestDispatcher("billSuccess.jsp").forward(request, response);
        } else {
            response.sendRedirect("billError.jsp");
        }
    }
}
