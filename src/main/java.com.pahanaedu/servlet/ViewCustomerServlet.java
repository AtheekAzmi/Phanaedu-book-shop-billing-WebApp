package servlet;

import dao.CustomerDAO;
import dao.BillDAO;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/viewCustomer")
public class ViewCustomerServlet extends HttpServlet {
    private CustomerDAO customerDAO = new CustomerDAO();
    private BillDAO billDAO = new BillDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerDAO.getCustomerById(id);
        double totalBilled = billDAO.getTotalBilledForCustomer(id);
        request.setAttribute("customer", customer);
        request.setAttribute("totalBilled", totalBilled);
        request.getRequestDispatcher("customer-view.jsp").forward(request, response);
    }
}
