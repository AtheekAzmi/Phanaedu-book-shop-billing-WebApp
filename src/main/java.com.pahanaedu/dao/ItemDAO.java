package dao;

import model.Items;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    // Add new item
    public boolean addItem(Items item) {
        String sql = "INSERT INTO items (item_name, description, price, stock_quantity) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getItem_name());
            stmt.setString(2, item.getDescription());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getStock_quantity());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Update item details
    public boolean updateItem(Items item) {
        String sql = "UPDATE items SET item_name=?, description=?, price=?, stock_quantity=? WHERE item_id=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, item.getItem_name());
            stmt.setString(2, item.getDescription());
            stmt.setDouble(3, item.getPrice());
            stmt.setInt(4, item.getStock_quantity());
            stmt.setInt(5, item.getItem_id());

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
                        rs.getInt("stock_quantity")
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
                        rs.getInt("stock_quantity")
                );
                itemList.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return itemList;
    }
}
