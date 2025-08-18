package servlet;

import dao.CustomerDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/addCustomer")
public class AddCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Customer customer = new Customer(
                request.getParameter("account_number"),
                request.getParameter("full_name"),
                request.getParameter("address"),
                request.getParameter("contact_no"),
                Integer.parseInt(request.getParameter("unit_consumed"))
        );
        customerDAO.addCustomer(customer);
        response.sendRedirect("listCustomers");
    }
}
