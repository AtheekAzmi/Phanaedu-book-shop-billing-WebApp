package dao;

import model.Customer;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    // Insert new customer
    public void addCustomer(Customer customer) {
        String sql = "INSERT INTO customer (account_number, full_name, address, contact_no, unit_consumed) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customer.getAccount_number());
            ps.setString(2, customer.getFull_name());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getContact_no());
            ps.setInt(5, customer.getUnit_consumed());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get all customers
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customer";
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Customer customer = new Customer(
                        rs.getInt("customer_id"),
                        rs.getString("account_number"),
                        rs.getString("full_name"),
                        rs.getString("address"),
                        rs.getString("contact_no"),
                        rs.getInt("unit_consumed")
                );
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Get customer by ID
    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM customer WHERE customer_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("customer_id"),
                        rs.getString("account_number"),
                        rs.getString("full_name"),
                        rs.getString("address"),
                        rs.getString("contact_no"),
                        rs.getInt("unit_consumed")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update customer
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customer SET account_number=?, full_name=?, address=?, contact_no=?, unit_consumed=? WHERE customer_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, customer.getAccount_number());
            ps.setString(2, customer.getFull_name());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getContact_no());
            ps.setInt(5, customer.getUnit_consumed());
            ps.setInt(6, customer.getCustomer_id());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete customer
    public void deleteCustomer(int id) {
        String sql = "DELETE FROM customer WHERE customer_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
