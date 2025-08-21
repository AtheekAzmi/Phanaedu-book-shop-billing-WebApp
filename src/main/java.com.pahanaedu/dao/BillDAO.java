package dao;

import model.Bill;
import model.BillItem;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BillDAO {

    public boolean addBill(Bill bill) {
        String billSql = "INSERT INTO bills (customer_id, user_id, total_amount, payment_method) VALUES (?, ?, ?, ?)";
        String itemSql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // Insert into bills table
            int billId = -1;
            try (PreparedStatement stmt = conn.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, bill.getCustomerId());
                stmt.setInt(2, bill.getUserId());
                stmt.setDouble(3, bill.getTotalAmount());
                stmt.setString(4, bill.getPaymentMethod());
                stmt.executeUpdate();

                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    billId = rs.getInt(1);
                }
            }

            // Insert bill items
            try (PreparedStatement stmt = conn.prepareStatement(itemSql)) {
                for (BillItem item : bill.getItems()) {
                    stmt.setInt(1, billId);
                    stmt.setInt(2, item.getItemId());
                    stmt.setInt(3, item.getQuantity());
                    stmt.setDouble(4, item.getUnitPrice());
                    stmt.setDouble(5, item.getTotalPrice());
                    stmt.addBatch();
                }
                stmt.executeBatch();
            }

            conn.commit();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Bill> getBillsByCustomer(int customerId) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills WHERE customer_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int billId = rs.getInt("bill_id");
                double totalAmount = rs.getDouble("total_amount");
                String paymentMethod = rs.getString("payment_method");
                // Fetch bill items
                List<BillItem> items = getBillItems(billId);
                Bill bill = new Bill(billId, customerId, rs.getInt("user_id"), totalAmount, items, paymentMethod);
                bills.add(bill);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bills;
    }

    public Bill getBillById(int billId) {
        String sql = "SELECT * FROM bills WHERE bill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                int customerId = rs.getInt("customer_id");
                int userId = rs.getInt("user_id");
                double totalAmount = rs.getDouble("total_amount");
                String paymentMethod = rs.getString("payment_method");
                List<BillItem> items = getBillItems(billId);
                return new Bill(billId, customerId, userId, totalAmount, items, paymentMethod);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM bills";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int billId = rs.getInt("bill_id");
                int customerId = rs.getInt("customer_id");
                int userId = rs.getInt("user_id");
                double totalAmount = rs.getDouble("total_amount");
                String paymentMethod = rs.getString("payment_method");
                List<BillItem> items = getBillItems(billId);
                Bill bill = new Bill(billId, customerId, userId, totalAmount, items, paymentMethod);
                bills.add(bill);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bills;
    }

    // Helper method to fetch bill items for a bill
    private List<BillItem> getBillItems(int billId) {
        List<BillItem> items = new ArrayList<>();
        String sql = "SELECT * FROM bill_items WHERE bill_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                BillItem item = new BillItem(
                    rs.getInt("bill_item_id"),
                    billId,
                    rs.getInt("item_id"),
                    rs.getInt("quantity"),
                    rs.getDouble("unit_price"),
                    rs.getDouble("total_price")
                );
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return items;
    }

    public double getTotalBilledForCustomer(int customerId) {
        String sql = "SELECT COALESCE(SUM(total_amount),0) FROM bills WHERE customer_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getDouble(1);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return 0.0;
    }

    public Map<Integer, Double> getTotalsForAllCustomers() {
        Map<Integer, Double> map = new HashMap<>();
        String sql = "SELECT customer_id, SUM(total_amount) total FROM bills GROUP BY customer_id";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                map.put(rs.getInt("customer_id"), rs.getDouble("total"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return map;
    }
}
