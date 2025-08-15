package dao;

import java.sql.*;

public class UserDAO {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/pahanedu";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "@Athk9782#";
    private static final String MYSQL_DRIVER = "com.mysql.cj.jdbc.Driver";

    // Static block to load the MySQL driver
    static {
        try {
            Class.forName(MYSQL_DRIVER);
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found. Make sure mysql-connector-java is in classpath.");
            e.printStackTrace();
        }
    }


//    public static boolean validateUser(String username, String password) {
//        boolean isValid = false;
//
//            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
//                String sql = "SELECT * FROM users WHERE username=? AND password=?";
//                PreparedStatement stmt = conn.prepareStatement(sql);
//                stmt.setString(1, username);
//                stmt.setString(2, password);
//
//                ResultSet rs = stmt.executeQuery();
//                if (rs.next()) {
//                    isValid = true ;
//                }
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//            return isValid; // no match
//
//    }

    public static boolean validateUser(String username, String password, String role) {
        boolean isValid = false;
        String sql = "SELECT COUNT(*) FROM users WHERE username = ? AND password = ?";

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    isValid = true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Database connection or query error: " + e.getMessage());
            e.printStackTrace();
        }
        return isValid;
    }

}
