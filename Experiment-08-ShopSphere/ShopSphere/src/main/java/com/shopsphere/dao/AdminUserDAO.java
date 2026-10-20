
package com.shopsphere.dao;

import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminUserDAO {

    public static class Customer {
        private int userId;
        private String name;
        private String email;
        private String mobile;
        private String role;
        private boolean status;
        private String createdAt;

        public int getUserId() { return userId; }
        public void setUserId(int userId) { this.userId = userId; }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getMobile() { return mobile; }
        public void setMobile(String mobile) { this.mobile = mobile; }

        public String getRole() { return role; }
        public void setRole(String role) { this.role = role; }

        public boolean isStatus() { return status; }
        public void setStatus(boolean status) { this.status = status; }

        public String getCreatedAt() { return createdAt; }
        public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
    }

    public List<Customer> getAllCustomers() throws SQLException {
        List<Customer> customers = new ArrayList<>();

        String sql =
            "SELECT user_id, name, email, mobile, role, status, created_at " +
            "FROM users WHERE role = 'CUSTOMER' ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Customer customer = new Customer();

                customer.setUserId(rs.getInt("user_id"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setMobile(rs.getString("mobile"));
                customer.setRole(rs.getString("role"));
                customer.setStatus(rs.getBoolean("status"));

                java.sql.Timestamp timestamp = rs.getTimestamp("created_at");
                customer.setCreatedAt(
                    timestamp == null ? "" : timestamp.toString()
                );

                customers.add(customer);
            }
        }

        return customers;
    }

    public boolean updateCustomerStatus(int userId, boolean status)
            throws SQLException {

        String sql =
            "UPDATE users SET status = ? " +
            "WHERE user_id = ? AND role = 'CUSTOMER'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setBoolean(1, status);
            ps.setInt(2, userId);

            return ps.executeUpdate() == 1;
        }
    }
}
