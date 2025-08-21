package servlet;

import dao.ItemDAO;
import model.Items;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

@MultipartConfig
@WebServlet("/addItem")
public class AddItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("add-item.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("item_name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock_quantity");

        double price;
        int stock;
        try { price = Double.parseDouble(priceStr); } catch (Exception e){ price = -1; }
        try { stock = Integer.parseInt(stockStr); } catch (Exception e){ stock = -1; }

        if (price < 0 || stock < 0) {
            request.setAttribute("error", "Price and Stock must be non-negative.");
            request.setAttribute("item_name", name);
            request.setAttribute("description", description);
            request.setAttribute("price", priceStr);
            request.setAttribute("stock_quantity", stockStr);
            request.getRequestDispatcher("add-item.jsp").forward(request, response);
            return;
        }

        Part photoPart = request.getPart("photo");
        byte[] itemImage = null;
        if (photoPart != null && photoPart.getSize() > 0) {
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();
            try (java.io.InputStream is = photoPart.getInputStream()) {
                byte[] temp = new byte[4096];
                int read;
                while ((read = is.read(temp)) != -1) {
                    buffer.write(temp, 0, read);
                }
                itemImage = buffer.toByteArray();
            }
        }

        Items item = new Items(0, name, description, price, stock, null, itemImage);

        boolean success = new ItemDAO().addItem(item);
        if (success) {
            response.sendRedirect("item-list.jsp");
        } else {
            request.setAttribute("error", "Failed to add item.");
            request.setAttribute("item_name", name);
            request.setAttribute("description", description);
            request.setAttribute("price", priceStr);
            request.setAttribute("stock_quantity", stockStr);
            request.getRequestDispatcher("add-item.jsp").forward(request, response);
        }
    }
}
