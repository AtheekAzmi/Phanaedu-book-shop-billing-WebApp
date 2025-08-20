package dao;

import model.Bill;
import model.BillItem;
import util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class BillDAO {

    public boolean addBill(Bill bill) {
        String billSql = "INSERT INTO bills (customer_id, user_id, total_amount) VALUES (?, ?, ?)";
        String itemSql = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price, total_price) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            // Insert into bills table
            int billId = -1;
            try (PreparedStatement stmt = conn.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, bill.getCustomerId());
                stmt.setInt(2, bill.getUserId());
                stmt.setDouble(3, bill.getTotalAmount());
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
}
