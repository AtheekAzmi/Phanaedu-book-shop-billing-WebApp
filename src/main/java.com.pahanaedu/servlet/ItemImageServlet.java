package servlet;

import dao.ItemDAO;
import model.Items;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/ItemImageServlet")
public class ItemImageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("item_id");
        if (idStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        int itemId = Integer.parseInt(idStr);
        Items item = new ItemDAO().getItemById(itemId);
        byte[] image = (item != null) ? item.getItemImage() : null;
        if (image == null || image.length == 0) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        response.setContentType("image/jpeg");
        response.setContentLength(image.length);
        OutputStream out = response.getOutputStream();
        out.write(image);
        out.flush();
    }
}

