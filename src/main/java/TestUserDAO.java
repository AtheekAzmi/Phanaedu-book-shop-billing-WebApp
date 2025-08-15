import dao.UserDAO;

public class TestUserDAO {
    public static void main(String[] args) {
        // Test credentials (must match values in your database)
        String username = "admin";
        String password = "admin123";
        String role = "admin";

        boolean result = UserDAO.validateUser(username, password, role);

        if (result) {
            System.out.println("✅ Login successful for \nuser: " +  username);
            System.out.println("Password: " + password);
            System.out.println("role: " + role);
        } else {
            System.out.println("❌ Login failed for user: " + username);
        }
    }
}
