package servlet;

import dao.CustomerDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/editCustomer")
public class EditCustomerServlet extends HttpServlet {

    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accountNumber = request.getParameter("account_number");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        int unitsConsumed = Integer.parseInt(request.getParameter("units_consumed"));

        Customer customer = new Customer(accountNumber, name, address, telephone, unitsConsumed);

        boolean updated = customerDAO.updateCustomer(customer);

        if (updated) {
            response.sendRedirect("customer-list.jsp?success=Customer updated successfully");
        } else {
            request.setAttribute("error", "Failed to update customer");
            request.getRequestDispatcher("customer-form.jsp").forward(request, response);
        }
    }
}
