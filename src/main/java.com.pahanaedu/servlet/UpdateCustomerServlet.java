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

        int customerId = Integer.parseInt(request.getParameter("customer_id"));
        String accountNumber = request.getParameter("account_number");
        String fullName = request.getParameter("full_name");
        String address = request.getParameter("address");
        String contactNo = request.getParameter("contact_no");
        int unitsConsumed = Integer.parseInt(request.getParameter("unit_consumed"));

        Customer customer = new Customer(customerId, accountNumber, fullName, address, contactNo, unitsConsumed);

        customerDAO.updateCustomer(customer);  // DAO is void, no boolean return

        response.sendRedirect("customerUpdateSuccess.jsp");
    }
}
