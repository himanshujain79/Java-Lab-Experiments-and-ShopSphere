
package com.shopsphere.dao;

import com.shopsphere.model.CartItem;
import com.shopsphere.model.Product;
import com.shopsphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public boolean addToCart(int userId, int productId, int quantity)
            throws SQLException {

        String productSql = """
                SELECT stock FROM products
                WHERE product_id = ? AND status = true
                """;

        String cartSql = """
                SELECT quantity FROM cart
                WHERE user_id = ? AND product_id = ?
                """;

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try {
                int stock;

                try (PreparedStatement ps =
                             con.prepareStatement(productSql)) {
                    ps.setInt(1, productId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            con.rollback();
                            return false;
                        }
                        stock = rs.getInt("stock");
                    }
                }

                int existingQuantity = 0;

                try (PreparedStatement ps =
                             con.prepareStatement(cartSql)) {
                    ps.setInt(1, userId);
                    ps.setInt(2, productId);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            existingQuantity = rs.getInt("quantity");
                        }
                    }
                }

                if (quantity < 1 || existingQuantity + quantity > stock) {
                    con.rollback();
                    return false;
                }

                if (existingQuantity > 0) {
                    String updateSql = """
                            UPDATE cart
                            SET quantity = quantity + ?
                            WHERE user_id = ? AND product_id = ?
                            """;

                    try (PreparedStatement ps =
                                 con.prepareStatement(updateSql)) {
                        ps.setInt(1, quantity);
                        ps.setInt(2, userId);
                        ps.setInt(3, productId);
                        ps.executeUpdate();
                    }
                } else {
                    String insertSql = """
                            INSERT INTO cart (user_id, product_id, quantity)
                            VALUES (?, ?, ?)
                            """;

                    try (PreparedStatement ps =
                                 con.prepareStatement(insertSql)) {
                        ps.setInt(1, userId);
                        ps.setInt(2, productId);
                        ps.setInt(3, quantity);
                        ps.executeUpdate();
                    }
                }

                con.commit();
                return true;

            } catch (SQLException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    public List<CartItem> getCartItems(int userId) throws SQLException {
        List<CartItem> items = new ArrayList<>();

        String sql = """
                SELECT c.cart_id, c.user_id, c.product_id, c.quantity,
                       p.category_id, p.name, p.brand, p.description,
                       p.price, p.discount, p.stock, p.image_url, p.status
                FROM cart c
                JOIN products p ON c.product_id = p.product_id
                WHERE c.user_id = ?
                ORDER BY c.cart_id DESC
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setName(rs.getString("name"));
                    product.setBrand(rs.getString("brand"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setDiscount(rs.getDouble("discount"));
                    product.setStock(rs.getInt("stock"));
                    product.setImageUrl(rs.getString("image_url"));
                    product.setStatus(rs.getBoolean("status"));

                    CartItem item = new CartItem();
                    item.setCartId(rs.getInt("cart_id"));
                    item.setUserId(rs.getInt("user_id"));
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProduct(product);

                    items.add(item);
                }
            }
        }

        return items;
    }

    public boolean updateQuantity(int userId, int cartId, int quantity)
            throws SQLException {

        if (quantity < 1) {
            return false;
        }

        String sql = """
                UPDATE cart c
                JOIN products p ON p.product_id = c.product_id
                SET c.quantity = ?
                WHERE c.cart_id = ? AND c.user_id = ?
                  AND p.status = true AND p.stock >= ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.setInt(3, userId);
            ps.setInt(4, quantity);

            return ps.executeUpdate() == 1;
        }
    }

    public boolean removeItem(int userId, int cartId)
            throws SQLException {

        String sql = """
                DELETE FROM cart
                WHERE cart_id = ? AND user_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, cartId);
            ps.setInt(2, userId);

            return ps.executeUpdate() == 1;
        }
    }
}
