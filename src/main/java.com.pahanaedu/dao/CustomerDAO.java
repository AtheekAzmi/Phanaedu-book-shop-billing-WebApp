package dao;

import model.Customer;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import static util.DBConnection.getConnection;

public class CustomerDAO {

    public static void save(Customer customer) throws SQLException {
        String sql = "INSERT INTO customer (account_number, full_name, address, contact_no, unit_consumed) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getAccount_number());
            stmt.setString(2, customer.getFull_name());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getContact_no());
            stmt.setInt(5, customer.getUnit_consumed());
            stmt.executeUpdate();
        }
    }

        public Customer findById ( int id) throws SQLException {
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToCustomer(rs);
            }
        }
        return null;
    }

        public List<Customer> findAll () throws SQLException {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customer";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        }
        return customers;
    }

        public void update (Customer customer) throws SQLException {
        String sql = "UPDATE customer SET account_number=?, full_name=?, address=?, contact_no=?, unit_consumed=? WHERE customer_id=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, customer.getAccount_number());
            stmt.setString(2, customer.getFull_name());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getContact_no());
            stmt.setInt(5, customer.getUnit_consumed());
            stmt.setInt(6, customer.getCustomer_id());
            stmt.executeUpdate();
        }
    }

        public void delete ( int id) throws SQLException {
        String sql = "DELETE FROM customer WHERE customer_id=?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

        private Customer mapResultSetToCustomer (ResultSet rs) throws SQLException {
        return new Customer(
                rs.getInt("customer_id"),
                rs.getString("account_number"),
                rs.getString("full_name"),
                rs.getString("address"),
                rs.getString("contact_no"),
                rs.getInt("unit_consumed")
        );
    }
}

