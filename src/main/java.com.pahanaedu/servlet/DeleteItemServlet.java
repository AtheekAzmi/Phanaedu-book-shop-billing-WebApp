package servlet;

import dao.ItemDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/deleteItem")
public class DeleteItemServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int itemId = Integer.parseInt(request.getParameter("item_id"));
        boolean success = new ItemDAO().deleteItem(itemId);
        if (success) {
            request.setAttribute("message", "Item deleted successfully!");
        } else {
            request.setAttribute("error", "Failed to delete item.");
        }
        response.sendRedirect("item-list.jsp");
    }
}

