
package com.shopsphere.dao;

import com.shopsphere.model.Order;
import com.shopsphere.model.OrderItem;
import com.shopsphere.util.DBConnection;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    private static class CheckoutLine {
        int productId;
        int quantity;
        String name;
        BigDecimal price;

        CheckoutLine(int productId, int quantity,
                     String name, BigDecimal price) {
            this.productId = productId;
            this.quantity = quantity;
            this.name = name;
            this.price = price;
        }
    }

    public int placeOrder(
            int userId,
            String addressLine,
            String city,
            String state,
            String pincode,
            String addressType,
            String paymentMethod) throws SQLException {

        if (!"COD".equals(paymentMethod)
                && !"ONLINE_PENDING".equals(paymentMethod)) {
            throw new SQLException("Invalid payment method.");
        }

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try {
                List<CheckoutLine> lines = new ArrayList<>();
                BigDecimal total = BigDecimal.ZERO;

                String cartSql = """
                    SELECT c.product_id, c.quantity, p.name,
                           p.price, p.discount, p.stock, p.status
                    FROM cart c
                    JOIN products p ON p.product_id = c.product_id
                    WHERE c.user_id = ?
                    ORDER BY c.product_id
                    FOR UPDATE
                    """;

                try (PreparedStatement ps = con.prepareStatement(cartSql)) {
                    ps.setInt(1, userId);

                    try (ResultSet rs = ps.executeQuery()) {
                        while (rs.next()) {
                            int quantity = rs.getInt("quantity");
                            int stock = rs.getInt("stock");

                            if (quantity <= 0 || stock < quantity
                                    || !rs.getBoolean("status")) {
                                throw new SQLException(
                                    "Insufficient stock for "
                                    + rs.getString("name"));
                            }

                            BigDecimal price = rs.getBigDecimal("price");
                            BigDecimal discount =
                                    rs.getBigDecimal("discount");

                            if (discount == null) {
                                discount = BigDecimal.ZERO;
                            }

                            BigDecimal finalPrice = price
                                    .multiply(
                                        BigDecimal.valueOf(100)
                                            .subtract(discount))
                                    .divide(
                                        BigDecimal.valueOf(100),
                                        2,
                                        RoundingMode.HALF_UP);

                            lines.add(new CheckoutLine(
                                rs.getInt("product_id"),
                                quantity,
                                rs.getString("name"),
                                finalPrice));

                            total = total.add(
                                finalPrice.multiply(
                                    BigDecimal.valueOf(quantity)));
                        }
                    }
                }

                if (lines.isEmpty()) {
                    throw new SQLException("Your cart is empty.");
                }

                String addressSql = """
                    INSERT INTO addresses
                    (user_id, address_line, city, state, pincode,
                     address_type)
                    VALUES (?, ?, ?, ?, ?, ?)
                    """;

                int addressId;

                try (PreparedStatement ps = con.prepareStatement(
                        addressSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, userId);
                    ps.setString(2, addressLine);
                    ps.setString(3, city);
                    ps.setString(4, state);
                    ps.setString(5, pincode);
                    ps.setString(6, addressType);
                    ps.executeUpdate();

                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException(
                                "Could not save delivery address.");
                        }
                        addressId = keys.getInt(1);
                    }
                }

                String orderSql = """
                    INSERT INTO orders
                    (user_id, address_id, total_amount, discount,
                     payment_method, payment_status, order_status)
                    VALUES (?, ?, ?, 0.00, ?, 'PENDING', 'PLACED')
                    """;

                int orderId;

                try (PreparedStatement ps = con.prepareStatement(
                        orderSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, userId);
                    ps.setInt(2, addressId);
                    ps.setBigDecimal(3, total);
                    ps.setString(4, paymentMethod);
                    ps.executeUpdate();

                    try (ResultSet keys = ps.getGeneratedKeys()) {
                        if (!keys.next()) {
                            throw new SQLException(
                                "Could not create order.");
                        }
                        orderId = keys.getInt(1);
                    }
                }

                String itemSql = """
                    INSERT INTO order_items
                    (order_id, product_id, quantity, price)
                    VALUES (?, ?, ?, ?)
                    """;

                String stockSql = """
                    UPDATE products
                    SET stock = stock - ?
                    WHERE product_id = ? AND status = true
                      AND stock >= ?
                    """;

                try (PreparedStatement itemPs =
                             con.prepareStatement(itemSql);
                     PreparedStatement stockPs =
                             con.prepareStatement(stockSql)) {

                    for (CheckoutLine line : lines) {
                        stockPs.setInt(1, line.quantity);
                        stockPs.setInt(2, line.productId);
                        stockPs.setInt(3, line.quantity);

                        if (stockPs.executeUpdate() != 1) {
                            throw new SQLException(
                                "Stock changed for " + line.name
                                + ". Please try checkout again.");
                        }

                        itemPs.setInt(1, orderId);
                        itemPs.setInt(2, line.productId);
                        itemPs.setInt(3, line.quantity);
                        itemPs.setBigDecimal(4, line.price);
                        itemPs.executeUpdate();
                    }
                }

                String paymentSql = """
                    INSERT INTO payments
                    (order_id, payment_method, amount, payment_status)
                    VALUES (?, ?, ?, 'PENDING')
                    """;

                try (PreparedStatement ps = con.prepareStatement(paymentSql)) {
                    ps.setInt(1, orderId);
                    ps.setString(2, paymentMethod);
                    ps.setBigDecimal(3, total);
                    ps.executeUpdate();
                }

                try (PreparedStatement ps = con.prepareStatement(
                        "DELETE FROM cart WHERE user_id = ?")) {
                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }

                con.commit();
                return orderId;

            } catch (SQLException | RuntimeException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    public List<Order> getOrdersByUser(int userId) throws SQLException {
        List<Order> orders = new ArrayList<>();

        String sql = """
            SELECT order_id, total_amount, payment_method,
                   payment_status, order_status, created_at
            FROM orders
            WHERE user_id = ?
            ORDER BY created_at DESC
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setTotalAmount(rs.getBigDecimal("total_amount"));
                    order.setPaymentMethod(rs.getString("payment_method"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setOrderStatus(rs.getString("order_status"));
                    order.setCreatedAt(rs.getTimestamp("created_at"));
                    orders.add(order);
                }
            }
        }

        return orders;
    }

    public Order getOrderById(int userId, int orderId)
            throws SQLException {

        String sql = """
            SELECT o.order_id, o.total_amount, o.payment_method,
                   o.payment_status, o.order_status, o.created_at,
                   a.address_line, a.city, a.state, a.pincode
            FROM orders o
            JOIN addresses a ON a.address_id = o.address_id
            WHERE o.order_id = ? AND o.user_id = ?
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    return null;
                }

                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                order.setAddressLine(rs.getString("address_line"));
                order.setCity(rs.getString("city"));
                order.setState(rs.getString("state"));
                order.setPincode(rs.getString("pincode"));
                return order;
            }
        }
    }

    public List<OrderItem> getOrderItems(int userId, int orderId)
            throws SQLException {

        List<OrderItem> items = new ArrayList<>();

        String sql = """
            SELECT p.name, oi.quantity, oi.price
            FROM order_items oi
            JOIN orders o ON o.order_id = oi.order_id
            JOIN products p ON p.product_id = oi.product_id
            WHERE o.order_id = ? AND o.user_id = ?
            """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setProductName(rs.getString("name"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getBigDecimal("price"));
                    items.add(item);
                }
            }
        }

        return items;
    }
}
