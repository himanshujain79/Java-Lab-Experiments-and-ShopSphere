package com.shopsphere.dao;

import com.shopsphere.model.User;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.BCrypt;

public class UserDAO {

    // Register a new user
 public boolean registerUser(User user) {

    String hashedPassword =
            BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

    String sql = """
            INSERT INTO users
            (name, email, password, mobile, role, status)
            VALUES (?, ?, ?, ?, ?, ?)
            """;

    try (
            Connection connection = DBConnection.getConnection();
            PreparedStatement ps = connection.prepareStatement(sql)
    ) {

        ps.setString(1, user.getName());
        ps.setString(2, user.getEmail());
        ps.setString(3, hashedPassword);
        ps.setString(4, user.getMobile());
        ps.setString(5, user.getRole());
        ps.setBoolean(6, user.isStatus());

        return ps.executeUpdate() > 0;

    } catch (Exception e) {

    System.out.println("USER REGISTRATION FAILED");

    e.printStackTrace();

    return false;
}
}
    // Find user by email
    public User findByEmail(String email) {

        String sql = """
                SELECT *
                FROM users
                WHERE email = ?
                """;

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement ps = connection.prepareStatement(sql)
        ) {

            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                User user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setMobile(rs.getString("mobile"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));

                return user;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return null;
    }
}