import java.sql.*;

public class DBconnection {

    static String url = "jdbc:mysql://127.0.0.1:3306/studentdb";
    static String username = "root";
    static String password = "Himanshu@123";

    public static Connection getConnection() {

        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                url,
                username,
                password
            );

            System.out.println("Database Connected!");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}