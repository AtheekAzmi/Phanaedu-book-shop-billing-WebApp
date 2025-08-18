//package servlet;
//
//import dao.CustomerDAO;
//import model.Customer;
//
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.*;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet("/CustomerServlet")
//public class CustomerServlet extends HttpServlet {
//    private CustomerDAO customerDAO;
//
//    @Override
//    public void init() {
//        customerDAO = new CustomerDAO();
//    }
//
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        String action = request.getParameter("action");
//        if (action == null) action = "LIST";
//
//        switch (action) {
//            case "NEW":
//                request.getRequestDispatcher("customer-form.jsp").forward(request, response);
//                break;
//            case "INSERT":
//                insertCustomer(request, response);
//                break;
//            case "DELETE":
//                deleteCustomer(request, response);
//                break;
//            case "EDIT":
//                showEditForm(request, response);
//                break;
//            case "UPDATE":
//                updateCustomer(request, response);
//                break;
//            case "VIEW":
//                viewCustomer(request, response);
//                break;
//            default:
//                listCustomers(request, response);
//                break;
//        }
//    }
//
//    private void listCustomers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        List<Customer> customers = customerDAO.getAllCustomers();
//        request.setAttribute("customers", customers);
//        request.getRequestDispatcher("customer-list.jsp").forward(request, response);
//    }
//
//    private void viewCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        Customer customer = customerDAO.getCustomerById(id);
//        request.setAttribute("customer", customer);
//        request.getRequestDispatcher("customer-view.jsp").forward(request, response);
//    }
//
//
//    private void insertCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        Customer customer = new Customer(
//                request.getParameter("account_number"),
//                request.getParameter("full_name"),
//                request.getParameter("address"),
//                request.getParameter("contact_no"),
//                Integer.parseInt(request.getParameter("unit_consumed"))
//        );
//        customerDAO.addCustomer(customer);
//        response.sendRedirect("CustomerServlet");
//    }
//
//    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        customerDAO.deleteCustomer(id);
//        response.sendRedirect("CustomerServlet");
//    }
//
//    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        int id = Integer.parseInt(request.getParameter("id"));
//        Customer existingCustomer = customerDAO.getCustomerById(id);
//        request.setAttribute("customer", existingCustomer);
//        request.getRequestDispatcher("customer-form.jsp").forward(request, response);
//    }
//
//    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws IOException {
//        Customer customer = new Customer(
//                Integer.parseInt(request.getParameter("customer_id")),
//                request.getParameter("account_number"),
//                request.getParameter("full_name"),
//                request.getParameter("address"),
//                request.getParameter("contact_no"),
//                Integer.parseInt(request.getParameter("unit_consumed"))
//        );
//        customerDAO.updateCustomer(customer);
//        response.sendRedirect("CustomerServlet");
//    }
//}
