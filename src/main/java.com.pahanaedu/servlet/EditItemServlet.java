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
import java.io.IOException;

@MultipartConfig
@WebServlet("/editItem")
public class EditItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        Items item = new ItemDAO().getItemById(itemId);
        request.setAttribute("item", item);
        request.getRequestDispatcher("edit-item.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        String name = request.getParameter("item_name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String stockStr = request.getParameter("stock_quantity");

        double price; int stock;
        try { price = Double.parseDouble(priceStr); } catch (Exception e){ price = -1; }
        try { stock = Integer.parseInt(stockStr); } catch (Exception e){ stock = -1; }

        Items existingItem = new ItemDAO().getItemById(itemId);
        if (price < 0 || stock < 0) {
            request.setAttribute("error", "Price and Stock must be non-negative.");
            // preserve previous (including image) so page can re-render
            if (existingItem != null) {
                existingItem.setItem_name(name);
                existingItem.setDescription(description);
                existingItem.setPrice(price < 0 ? 0 : price);
                existingItem.setStock_quantity(stock < 0 ? 0 : stock);
            }
            request.setAttribute("item", existingItem);
            request.getRequestDispatcher("edit-item.jsp").forward(request, response);
            return;
        }

        byte[] itemImage = null;
        Part photoPart = request.getPart("photo");
        if (photoPart != null && photoPart.getSize() > 0 && photoPart.getSubmittedFileName() != null && !photoPart.getSubmittedFileName().isEmpty()) {
            java.io.ByteArrayOutputStream buffer = new java.io.ByteArrayOutputStream();
            try (java.io.InputStream is = photoPart.getInputStream()) {
                byte[] temp = new byte[4096];
                int read;
                while ((read = is.read(temp)) != -1) { buffer.write(temp, 0, read); }
                itemImage = buffer.toByteArray();
            }
        } else if (existingItem != null) {
            itemImage = existingItem.getItemImage();
        }

        Items item = new Items(itemId, name, description, price, stock, null, itemImage);

        boolean success = new ItemDAO().updateItem(item);
        if (success) {
            response.sendRedirect("item-list.jsp");
        } else {
            request.setAttribute("error", "Failed to update item.");
            request.setAttribute("item", item);
            request.getRequestDispatcher("edit-item.jsp").forward(request, response);
        }
    }
}
