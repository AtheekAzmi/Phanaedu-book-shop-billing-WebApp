package servlet;

import dao.ItemDAO;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/deleteItem")
public class DeleteItemServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idParam = request.getParameter("item_id");
        int itemId;
        try {
            itemId = Integer.parseInt(idParam);
        } catch (Exception e) {
            redirectWithError(response, "Invalid item id");
            return;
        }
        boolean success = new ItemDAO().deleteItem(itemId);
        if (success) {
            redirectWithMessage(response, "Item deleted successfully");
        } else {
            redirectWithError(response, "Failed to delete item (in use or not found)");
        }
    }

    private void redirectWithMessage(HttpServletResponse resp, String msg) throws IOException {
        resp.sendRedirect("item-list.jsp?message=" + URLEncoder.encode(msg, "UTF-8"));
    }
    private void redirectWithError(HttpServletResponse resp, String msg) throws IOException {
        resp.sendRedirect("item-list.jsp?error=" + URLEncoder.encode(msg, "UTF-8"));
    }
}
