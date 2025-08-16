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

@WebServlet("/addCustomer")
public class AddCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

        Customer customer = new Customer();
        customer.setAccount_number(accountNumber);
        customer.setFull_name(name);
        customer.setAddress(address);
        customer.setContact_no(telephone);
        customer.setUnit_consumed(unitsConsumed);

        try {
            CustomerDAO.save(customer);
            response.sendRedirect("customerSuccess.jsp");
        } catch (SQLException e) {
            request.setAttribute("error", "Failed to add customer. Please try again.");
            request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
        }
    }
}