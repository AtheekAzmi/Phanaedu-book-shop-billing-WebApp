# PhanaEdu Book Shop Billing WebApp

<img src="src/main/webapp/assets/logo.jpg" alt="PhanaEdu Logo" width="50%">

A simple Java Servlet + JSP billing web application for a book shop.  
This repository implements user registration/login, item management (with image upload), customers, and bills (invoices). The project is packaged as a WAR and intended to run on a servlet container (Tomcat, Jetty, etc.).

Table of contents
- Project highlights
- Tech stack & requirements
- Quick start (build, configure, run)
- Database schema & sample data
- Endpoints & form parameters (examples)
- Project layout
- Security & configuration notes
- Known issues & troubleshooting
- Contributing
- License

---

## Project highlights
- User registration & login (servlets + JSP).
- CRUD for customers and items; item image upload supported.
- Billing flow: create bill with multiple items; bill items saved in separate table.
- Server-side stock checks and stock update after successful billing.
- Data access implemented with DAOs (JDBC) and central DB connection helper.

---

## Tech stack & requirements
- Java 8 (project configured with source/target 8)
- Maven for build (pom.xml included)
- MySQL (or compatible) database
- Servlet container (Tomcat 9/10+, Jetty) — Servlets use annotations; web.xml is effectively empty.
- Recommended: IDE with Maven support (IntelliJ IDEA, Eclipse)

Maven dependencies of note (pom.xml)
- javax.servlet-api / jakarta.servlet-api (provided)
- mysql-connector-j (JDBC driver)
- JUnit, Mockito (test scope)

---

## Quick start (local development)

1. Clone repository:
   git clone https://github.com/AtheekAzmi/Phanaedu-book-shop-billing-WebApp.git
   cd Phanaedu-book-shop-billing-WebApp

2. Prepare the database:
   - Create a MySQL database named `pahanedu` (default used in code).
   - Create tables (see "Database schema" below) and optionally load sample data.

3. Build WAR with Maven:
   mvn clean package

   Output: target/PahanaEdu_BillingWebApp.war

4. Deploy to Tomcat:
   - Copy the WAR to Tomcat's webapps folder or deploy using the Tomcat manager.
   - Start Tomcat and open: http://localhost:8080/PahanaEdu_BillingWebApp/ (adjust context if renamed)

5. Default DB connection:
   - DB connection is in src/main/java.com.pahanaedu/util/DBConnection.java
   - Default (as checked into repo):
     - URL: jdbc:mysql://localhost:3306/pahanedu
     - USER: root
     - PASS: @Athk9782#
   - IMPORTANT: change these values before production. See "Security & configuration notes".

---

## Database schema (SQL)

Below DDL matches queries in DAOs. Adjust types and constraints as needed.

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  full_Name VARCHAR(255)
);

CREATE TABLE customer (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  account_number VARCHAR(100) NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  address TEXT,
  contact_no VARCHAR(50),
  unit_consumed INT DEFAULT 0
);

CREATE TABLE items (
  item_id INT AUTO_INCREMENT PRIMARY KEY,
  item_name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL DEFAULT 0.00,
  stock_quantity INT NOT NULL DEFAULT 0,
  item_image LONGBLOB,
  -- Optional: photo path if you want filesystem storage
  photo_path VARCHAR(512)
);

CREATE TABLE bills (
  bill_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  user_id INT NOT NULL,
  total_amount DECIMAL(12,2) NOT NULL,
  payment_method VARCHAR(50),
  FOREIGN KEY (customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

CREATE TABLE bill_items (
  bill_item_id INT AUTO_INCREMENT PRIMARY KEY,
  bill_id INT NOT NULL,
  item_id INT NOT NULL,
  quantity INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  total_price DECIMAL(12,2) NOT NULL,
  FOREIGN KEY (bill_id) REFERENCES bills(bill_id) ON DELETE CASCADE,
  FOREIGN KEY (item_id) REFERENCES items(item_id) ON DELETE SET NULL
);

Sample seed (optional):
INSERT INTO users (username, password, full_Name) VALUES ('admin', 'admin123', 'Administrator');
INSERT INTO customer (account_number, full_name, address, contact_no, unit_consumed) VALUES ('ACC001','John Doe','123 Street','0123456789',0);

---

## Main endpoints & parameters

Note: Servlets use HTTP form POST/GET. The server expects form fields as described. All endpoints are relative to the app root.

1) Register — GET/POST
- URL: /register
- GET: shows registration form (register.jsp)
- POST parameters:
  - username, password, fullName
- Example (curl):
  curl -X POST -d "username=alice&password=secret&fullName=Alice%20A" http://localhost:8080/PahanaEdu_BillingWebApp/register

2) Login
- URL: /login
- POST parameters:
  - username, password
- Example:
  curl -X POST -d "username=admin&password=admin123" http://localhost:8080/PahanaEdu_BillingWebApp/login

3) Add Customer (AJAX/JSON response)
- URL: /AddCustomerServlet
- POST parameters (form-url-encoded):
  - account, name, address, contact, unit
- Response: JSON { "success": true, "id": <newId>, "name": "<name>" } or { "success": false }
- Example:
  curl -X POST -d "account=ACC002&name=Bob&address=Addr&contact=0123&unit=0" http://localhost:8080/PahanaEdu_BillingWebApp/AddCustomerServlet

4) Add Item (multipart form for image)
- URL: /addItem
- GET: form page (add-item.jsp)
- POST fields:
  - item_name, description, price, stock_quantity, photo (file)
- Example:
  curl -X POST \
    -F "item_name=Book A" \
    -F "description=A good book" \
    -F "price=12.50" \
    -F "stock_quantity=10" \
    -F "photo=@./cover.jpg" \
    http://localhost:8080/PahanaEdu_BillingWebApp/addItem

5) Add Bill (create invoice)
- URL: /addBill
- POST parameters:
  - itemId (array), quantity (array), unitPrice (array) — e.g. itemId=1&itemId=2
  - customerId, userId, paymentMethod
- Notes:
  - Quantities are validated server-side against stock.
  - Server computes the totalAmount (ignores client-submitted totals).
- Example (curl using form encoding — arrays by repeating param):
  curl -X POST \
    -d "itemId=1" -d "quantity=2" -d "unitPrice=10.0" \
    -d "itemId=2" -d "quantity=1" -d "unitPrice=5.0" \
    -d "customerId=1" -d "userId=1" -d "paymentMethod=cash" \
    http://localhost:8080/PahanaEdu_BillingWebApp/addBill

6) Item image retrieval
- There is an ItemImageServlet (src/main/webapp has related JSPs) which serves images; consult code if you need raw access.

7) Additional JSP pages and flows:
- login.jsp, register.jsp, dashboard.jsp
- add-item.jsp, edit-item.jsp, item-list.jsp
- customer-list.jsp, customer-add.jsp, customer-edit.jsp, customer-view.jsp
- billForm.jsp, billSuccess.jsp, bill-history.jsp, bill-details.jsp

---

## Project layout (important files)
- pom.xml — Maven project configuration
- src/main/java.com.pahanaedu/util/DBConnection.java — JDBC connection helper (contains DB credentials in repo)
- src/main/java.com.pahanaedu/dao/* — DAO classes for persistence (UserDAO, CustomerDAO, ItemDAO, BillDAO)
- src/main/java.com.pahanaedu/servlet/* — Servlets (login, register, add customer/item/bill, etc.)
- src/main/java.com.pahanaedu/model/* — Domain model classes (User, Customer, Items, Bill, BillItem)
- src/main/webapp/*.jsp — User interface
- src/main/webapp/assets/* — static assets (logo, background)

---

## Security & configuration notes (please read)

- Hard-coded DB credentials: DBConnection.java currently contains:
  - URL: jdbc:mysql://localhost:3306/pahanedu
  - USER: root
  - PASS: @Athk9782#
  This is in plaintext in the repository — DO NOT use this in production. Replace with environment-based configuration, a properties file outside of version control, or a secret manager.

- Password storage: passwords are stored in plain text in the users table (and DAO uses direct equality). For production always:
  - Hash passwords using a strong algorithm (bcrypt/argon2) and salt.
  - Use parameterized statements (the code already uses PreparedStatement) — good.

- Use TLS (HTTPS) for the app in production.

- The app depends on client-side form data in some places. The server does perform checks for stock & quantities — trust server-side checks.

How to externalize DB config quickly:
- Option A: edit DBConnection.java and read from environment variables:
  String DB_USER = System.getenv("DB_USER"); etc.
- Option B: use a properties file loaded from classpath/external path.

---

## Known issues & suggestions (observations from code)

- ItemDAO.addItem has duplicate parameter binding:
  stmt.setString(5, item.getPhotoPath());
  stmt.setBytes(5, item.getItemImage());
  -> The second call overwrites parameter 5. Correct approach: if you store both path and blob, change SQL to include both columns and set the correct parameter index. If you store only blob, remove photoPath set or change parameter index accordingly.

- web.xml is empty and servlets use @WebServlet annotations — this is fine. If you prefer explicit mappings or to add security constraints, modify web.xml.

- DB foreign key constraints in provided DDL are suggestions — adjust ON DELETE behavior to fit your business rules.

- DB driver: pom includes mysql-connector-j 8.2.0 — ensure your MySQL server is compatible.

---

## Troubleshooting

- Connection issues:
  - Verify MySQL is running and reachable on host/port.
  - Verify database `pahanedu` exists and user credentials are correct.
  - If using a different DB name / user, update DBConnection.java or externalize config.

- Missing driver (ClassNotFoundException):
  - Ensure mysql-connector-j is in your runtime classpath (Maven includes it; in Tomcat you may need to put driver in tomcat/lib or bundle in WAR).

- 404 for servlet endpoints:
  - Confirm deployed WAR context path and that Tomcat has deployed WAR successfully.
  - Servlets are registered via annotations; ensure the server supports Servlet 3.0+.

- Errors saving item images:
  - Check maximum POST size in container and the @MultipartConfig settings (currently default). If large files, adjust servlet container limits.

---

## Tests
- Basic unit tests are not included; pom has test dependencies (JUnit 5 + Mockito) so you can add tests for DAOs and services.
- For servlet tests, you can use mock frameworks (Mockito + mock servlets) or integration tests with an embedded container.

---

## Contributing
Contributions are welcome. Suggested workflow:
- Fork the repo
- Create a feature branch
- Add tests for major behavioral changes (DAOs/Servlets)
- Open a pull request describing the change

Please avoid committing credentials or other secrets.

---

## License
This project currently does not contain a license file. If you want this to be open source, add a LICENSE file (MIT, Apache 2.0, etc.).

---

## Contact / Notes
- Repo: https://github.com/AtheekAzmi/Phanaedu-book-shop-billing-WebApp
- If you want help setting up the DB or packaging for Docker/Tomcat, open an issue or PR with the environment you want to target.

Happy coding! If you want, I can:
- Produce a docker-compose + Dockerfile to run MySQL + Tomcat with the app deployed.
- Create a fix patch for the ItemDAO addItem parameter bug.
