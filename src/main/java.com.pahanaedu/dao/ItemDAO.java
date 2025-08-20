package dao;

import model.Items;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    // Add new item
    public boolean addItem(Items item) {String sql = "INSERT INTO items (item_name, description, price, stock_quantity, item_image) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getItem_name());
            stmt.setString(2, item.getDescription());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getStock_quantity());
            stmt.setString(5, item.getPhotoPath());
            stmt.setBytes(5, item.getItemImage());
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update item details
    public boolean updateItem(Items item) {
        boolean hasImage = item.getItemImage() != null;
        String sql = hasImage ?
            "UPDATE items SET item_name=?, description=?, price=?, stock_quantity=?, item_image=? WHERE item_id=?" :
            "UPDATE items SET item_name=?, description=?, price=?, stock_quantity=? WHERE item_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, item.getItem_name());
            stmt.setString(2, item.getDescription());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getStock_quantity());
            if (hasImage) {
                stmt.setBytes(5, item.getItemImage());
                stmt.setInt(6, item.getItem_id());
            } else {
                stmt.setInt(5, item.getItem_id());
            }
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete item
    public boolean deleteItem(int itemId) {
        String sql = "DELETE FROM items WHERE item_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, itemId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get item by ID
    public Items getItemById(int itemId) {
        String sql = "SELECT * FROM items WHERE item_id=?";
        Items item = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, itemId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                item = new Items(
                    rs.getInt("item_id"),
                    rs.getString("item_name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("stock_quantity"),
                    null, // photoPath not used
                    rs.getBytes("item_image")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return item;
    }

    // Get all items
    public List<Items> getAllItems() {
        List<Items> itemList = new ArrayList<>();
        String sql = "SELECT * FROM items";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Items item = new Items(
                    rs.getInt("item_id"),
                    rs.getString("item_name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("stock_quantity"),
                    null, // photoPath not used
                    rs.getBytes("item_image")
                );
                itemList.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return itemList;
    }

    public int getTotalStockQuantity() {
        String sql = "SELECT SUM(stock_quantity) FROM items";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void reduceStockAndIncrementSales(int itemId, int quantitySold) {
        String sql = "UPDATE items SET stock_quantity = stock_quantity - ? WHERE item_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantitySold);
            stmt.setInt(2, itemId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
