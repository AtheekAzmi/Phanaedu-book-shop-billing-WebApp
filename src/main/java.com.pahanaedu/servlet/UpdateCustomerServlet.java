package servlet;

import dao.CustomerDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/updateCustomer")
public class UpdateCustomerServlet extends HttpServlet {

    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int customerId = Integer.parseInt(request.getParameter("customer_id"));
            String accountNumber = request.getParameter("account_number");
            String fullName = request.getParameter("full_name");
            String address = request.getParameter("address");
            String contactNo = request.getParameter("contact_no");

            Customer existing = customerDAO.getCustomerById(customerId);
            int preservedUnits = existing != null ? existing.getUnit_consumed() : 0;

            Customer customer = new Customer(customerId, accountNumber, fullName, address, contactNo, preservedUnits);
            customerDAO.updateCustomer(customer);
            response.sendRedirect("customerUpdateSuccess.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Update failed: " + e.getMessage());
            request.getRequestDispatcher("customer-edit.jsp").forward(request, response);
        }
    }
}
