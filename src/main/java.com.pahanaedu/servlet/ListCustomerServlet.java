package servlet;

import dao.CustomerDAO;
import dao.BillDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/listCustomers")
public class ListCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();
    private BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Customer> customers = customerDAO.getAllCustomers();
        Map<Integer, Double> totals = billDAO.getTotalsForAllCustomers();
        request.setAttribute("customers", customers);
        request.setAttribute("billTotals", totals);
        request.getRequestDispatcher("customer-list.jsp").forward(request, response);
    }
}
