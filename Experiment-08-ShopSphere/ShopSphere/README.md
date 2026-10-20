# ShopSphere E-Commerce – Java / JSP / Servlet / MySQL

\====================================================

This project is a Java-based e-commerce web application built using JSP, Servlets, JDBC, and MySQL. It follows a layered architecture to separate presentation, request handling, business logic, and database operations.

## FEATURES INCLUDED

- User registration, login, and logout.
- Password hashing and verification using BCrypt.
- Product listing and product details.
- Product categories and product browsing.
- Shopping cart with quantity updates and item removal.
- Secure checkout for authenticated users.
- Order placement and order confirmation.
- Order history for customers.
- Admin order management and order status updates.
- Role-based access control for customer and admin pages.
- Responsive styling using CSS.
- MySQL database integration using JDBC.
- Authentication filter to protect restricted pages.

## TECHNOLOGY STACK

- **Language:** Java
- **Frontend:** HTML, CSS, JSP
- **Backend:** Java Servlets
- **Database:** MySQL
- **Database Connectivity:** JDBC
- **Build Tool:** Apache Maven
- **Server:** Apache Tomcat
- **Password Security:** BCrypt

## PROJECT ARCHITECTURE

The project follows a layered architecture:

JSP → Servlet (Controller) → Service → DAO → JDBC → MySQL

- **JSP:** Displays the user interface.
- **Controller:** Handles HTTP requests and responses.
- **Service:** Contains business logic.
- **DAO:** Executes database operations.
- **Model:** Represents application entities.
- **MySQL:** Stores users, products, categories, carts, addresses, orders, and order items.

## DATABASE SAFETY

- Back up your existing database before making schema changes.
- Do NOT run SQL scripts containing `DROP TABLE` against your existing database.
- Preserve existing user accounts, products, orders, and other records.
- Use the SQL schema or migration script appropriate to your existing database.
- Verify that all required tables and columns exist before running the application.
- Never commit your real database password or other credentials to GitHub.

The application uses the existing `shopsphere` database.

Typical tables include:

- `users`
- `categories`
- `products`
- `cart`
- `orders`
- `order_items`

Your actual schema may contain additional tables or columns depending on your implementation.

## DATABASE CONFIGURATION

Configure the MySQL connection in your project's `DBConnection` class or configuration file.

Example JDBC URL:

```
jdbc:mysql://localhost:3306/shopsphere
```

Set the appropriate values for:

- Database URL
- Database username
- Database password

If the project supports environment variables, configure them before starting Tomcat:

```
$env:DB_USER = "root"
$env:DB_PASSWORD = "YOUR_MYSQL_PASSWORD"
$env:SHOPSPHERE_DB_URL = "jdbc:mysql://localhost:3306/shopsphere?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Kolkata"
```

Use only the configuration supported by your current `DBConnection` implementation.

Do not commit or share your real database credentials. If a real password was previously exposed in source code or an archive, rotate it.

## BUILD AND DEPLOY

1. Open PowerShell in the `shopsphere` project folder containing `pom.xml`.

2. Ensure MySQL is running and the database is configured.

3. Ensure Java, Maven, and Apache Tomcat are installed.

4. Build the project:

   ```
   mvn clean package
   ```

5. Locate the generated WAR file inside the `target` directory.

6. Stop Tomcat if the application is already deployed.

7. Copy the generated WAR file into Tomcat's `webapps` directory.

8. Remove the old exploded application directory if necessary, ensuring you are removing only the ShopSphere deployment.

9. Start Tomcat again.

10. Open the application in your browser:

    [http://localhost:8080/shopsphere/index.jsp](http://localhost:8080/shopsphere/index.jsp)

The exact WAR filename and context path depend on your Maven configuration.

## ADMIN ACCESS

1. Register a normal customer account.

2. Open MySQL Workbench.

3. Promote the registered account to the admin role:

   ```
   UPDATE users
   SET role = 'ADMIN'
   WHERE email = 'your-account-email@example.com';
   ```

4. Replace the example email with your actual registered email.

5. Log out and log in again to refresh the user's role in the session.

Do not expose public admin registration. Only trusted accounts should receive administrator privileges.

## ORDER PROCESSING

- Customers must log in before accessing the cart and checkout pages.
- Customers can add products to the cart and update quantities.
- The application calculates the order total and saves the order.
- Successful orders are stored in the `orders` and `order_items` tables.
- Customers can view their order history.
- Administrators can view orders and update their statuses.

Order placement records an order in the database. Online payment processing is not included unless a payment gateway has been separately integrated.

## SECURITY NOTES

- Use BCrypt for password hashing and verification.
- Protect restricted routes using authentication and authorization checks.
- Validate user input on the server side.
- Use prepared statements to help prevent SQL injection.
- Keep database credentials outside publicly accessible source code.
- Restrict administrative operations to authorized users.

## TESTING CHECKLIST

- User registration and login.
- Logout functionality.
- Product listing and product details.
- Add products to cart.
- Increase and decrease product quantities.
- Remove products from cart.
- Redirect unauthenticated users away from restricted pages.
- Checkout and order placement.
- Verify records in `orders` and `order_items`.
- Customer order history.
- Admin order management.
- Database connectivity and error handling.

## IMPORTANT

This README describes the ShopSphere E-Commerce project using the existing Java/JSP/Servlet/MySQL architecture. Adjust the database configuration, filenames, table names, and deployment paths if your local implementation differs.

Do not overwrite working project files or run destructive database scripts without taking a backup first.
