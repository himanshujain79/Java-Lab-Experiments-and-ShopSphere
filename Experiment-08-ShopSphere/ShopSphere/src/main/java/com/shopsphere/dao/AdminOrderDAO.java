
package com.shopsphere.dao;

import com.shopsphere.model.AdminOrder;
import com.shopsphere.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AdminOrderDAO {

    public List<AdminOrder> getAllOrders() throws SQLException {
        List<AdminOrder> orders = new ArrayList<>();

        String sql =
            "SELECT o.order_id, u.name AS customer_name, " +
            "u.email AS customer_email, o.total_amount, " +
            "o.payment_method, o.payment_status, o.order_status, " +
            "o.created_at " +
            "FROM orders o " +
            "JOIN users u ON o.user_id = u.user_id " +
            "ORDER BY o.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                AdminOrder order = new AdminOrder();

                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setCustomerEmail(rs.getString("customer_email"));
                order.setTotalAmount(rs.getDouble("total_amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));

                java.sql.Timestamp timestamp =
                    rs.getTimestamp("created_at");

                order.setCreatedAt(
                    timestamp == null ? "" : timestamp.toString()
                );

                orders.add(order);
            }
        }

        return orders;
    }

    public boolean updateOrderStatus(int orderId, String status)
            throws SQLException {

        String sql =
            "UPDATE orders SET order_status = ? WHERE order_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setInt(2, orderId);

            return ps.executeUpdate() == 1;
        }
    }
}
