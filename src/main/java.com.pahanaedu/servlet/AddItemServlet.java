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
        double price = Double.parseDouble(request.getParameter("price"));
        int stock = Integer.parseInt(request.getParameter("stock_quantity"));

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
            request.setAttribute("message", "Item added successfully!");
            response.sendRedirect("item-list.jsp");
        } else {
            request.setAttribute("error", "Failed to add item.");
            request.getRequestDispatcher("add-item.jsp").forward(request, response);
        }
    }
}
