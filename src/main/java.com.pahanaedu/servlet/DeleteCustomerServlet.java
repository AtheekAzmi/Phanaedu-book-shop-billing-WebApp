package servlet;

import dao.CustomerDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteCustomer")
public class DeleteCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            customerDAO.deleteCustomer(id);
            response.sendRedirect("listCustomers?deleteSuccess=true");
        } catch (Exception e) {
            Throwable cause = e.getCause();
            if (cause instanceof java.sql.SQLIntegrityConstraintViolationException) {
                request.setAttribute("errorMessage", "Cannot delete customer: they have bills in the system.");
            } else {
                request.setAttribute("errorMessage", "An error occurred while deleting the customer.");
            }
            request.getRequestDispatcher("customer-list.jsp").forward(request, response);
        }
    }
}
