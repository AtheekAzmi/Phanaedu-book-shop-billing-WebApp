package servlet;

import dao.CustomerDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/editCustomer")
public class UpdateCustomerServlet extends HttpServlet {

    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("account_number");
        Customer customer = customerDAO.getCustomerByAccountNumber(accountNumber);

        if (customer != null) {
            request.setAttribute("customer", customer);
            request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
        } else {
            response.sendRedirect("customerList.jsp?error=CustomerNotFound");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String account_number = request.getParameter("account_number");
        String full_name = request.getParameter("name");
        String address = request.getParameter("address");
        String contact_no = request.getParameter("telephone");
        int unit_consumed = Integer.parseInt(request.getParameter("units_consumed"));

        Customer customer = new Customer(account_number, full_name, address, contact_no, unit_consumed);

        try {
            CustomerDAO.update(customer);
            response.sendRedirect("customerSuccess.jsp");
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to update customer details. Please try again.");
            request.getRequestDispatcher("addcustomer.jsp").forward(request, response);
        }
    }
}
