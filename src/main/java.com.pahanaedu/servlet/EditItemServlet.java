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
import java.nio.file.Paths;

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
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock_quantity"));

        Items existingItem = new ItemDAO().getItemById(itemId);
        byte[] itemImage = null;
        Part photoPart = request.getPart("photo");
        if (photoPart != null && photoPart.getSize() > 0 && photoPart.getSubmittedFileName() != null && !photoPart.getSubmittedFileName().isEmpty()) {
            java.io.ByteArrayOutputStream buffer = new java.io.ByteArrayOutputStream();
            try (java.io.InputStream is = photoPart.getInputStream()) {
                byte[] temp = new byte[4096];
                int read;
                while ((read = is.read(temp)) != -1) {
                    buffer.write(temp, 0, read);
                }
                itemImage = buffer.toByteArray();
            }
        } else if (existingItem != null) {
            itemImage = existingItem.getItemImage();
        }

        Items item = new Items(itemId, name, description, price, stock, null, itemImage);

        boolean success = new ItemDAO().updateItem(item);
        if (success) {
            request.setAttribute("message", "Item updated successfully!");
            response.sendRedirect("item-list.jsp");
        } else {
            request.setAttribute("error", "Failed to update item.");
            request.setAttribute("item", item);
            request.getRequestDispatcher("edit-item.jsp").forward(request, response);
        }
    }
}
