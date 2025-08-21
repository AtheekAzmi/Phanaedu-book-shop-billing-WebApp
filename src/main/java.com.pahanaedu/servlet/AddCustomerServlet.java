package servlet;

import dao.CustomerDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/AddCustomerServlet")
public class AddCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String account = request.getParameter("account");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String contact = request.getParameter("contact");

        int unit = 0;
        try {
            unit = Integer.parseInt(request.getParameter("unit"));
        } catch (Exception e) { unit = 0; }
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (name == null || name.trim().isEmpty() || account == null || account.trim().isEmpty()) {
            out.print("{\"success\":false}");
            out.flush();
            return;
        }
        Customer customer = new Customer(account, name, address, contact, unit);
        int newId = customerDAO.addCustomer(customer);
        if (newId > 0) {
            out.print("{\"success\":true,\"id\":" + newId + ",\"name\":\"" + name + "\"}");
        } else {
            out.print("{\"success\":false}");
        }
        out.flush();
    }
}
