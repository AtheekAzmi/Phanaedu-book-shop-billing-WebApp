package servlet;

import dao.ItemDAO;
import model.Items;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/getItemPrice")
public class GetItemPriceServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String itemIdStr = request.getParameter("itemId");
        double price = 0.0;
        if (itemIdStr != null) {
            try {
                int itemId = Integer.parseInt(itemIdStr);
                ItemDAO itemDAO = new ItemDAO();
                Items item = itemDAO.getItemById(itemId);
                if (item != null) {
                    price = item.getPrice();
                }
            } catch (NumberFormatException e) {
                // Invalid itemId, price remains 0.0
            }
        }
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"price\":" + price + "}");
        out.flush();
    }
}

