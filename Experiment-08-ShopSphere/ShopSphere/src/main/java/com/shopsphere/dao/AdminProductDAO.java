
package com.shopsphere.dao;

import com.shopsphere.model.Category;
import com.shopsphere.model.Product;
import com.shopsphere.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminProductDAO {

    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();

        String sql = """
                SELECT * FROM products
                ORDER BY product_id DESC
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
        }

        return products;
    }

    public List<Category> getCategories() throws SQLException {
        List<Category> categories = new ArrayList<>();

        String sql = """
                SELECT category_id, name
                FROM categories
                WHERE status = true
                ORDER BY name
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("category_id"));
                category.setName(rs.getString("name"));
                categories.add(category);
            }
        }

        return categories;
    }

    public Product getProductById(int id) throws SQLException {
        String sql = """
                SELECT * FROM products
                WHERE product_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }
        }

        return null;
    }

    public void addProduct(Product p) throws SQLException {
        String sql = """
                INSERT INTO products
                (category_id, name, brand, description, price,
                 discount, stock, image_url, status)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, true)
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            setProductParameters(ps, p);
            ps.executeUpdate();
        }
    }

    public boolean updateProduct(Product p) throws SQLException {
        String sql = """
                UPDATE products
                SET category_id = ?, name = ?, brand = ?,
                    description = ?, price = ?, discount = ?,
                    stock = ?, image_url = ?
                WHERE product_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            setProductParameters(ps, p);
            ps.setInt(9, p.getProductId());

            return ps.executeUpdate() == 1;
        }
    }

    public boolean deactivateProduct(int productId)
            throws SQLException {

        String sql = """
                UPDATE products
                SET status = false
                WHERE product_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, productId);
            return ps.executeUpdate() == 1;
        }
    }

    private void setProductParameters(
            PreparedStatement ps, Product p) throws SQLException {

        ps.setInt(1, p.getCategoryId());
        ps.setString(2, p.getName());
        ps.setString(3, p.getBrand());
        ps.setString(4, p.getDescription());
        ps.setDouble(5, p.getPrice());
        ps.setDouble(6, p.getDiscount());
        ps.setInt(7, p.getStock());
        ps.setString(8, p.getImageUrl());
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product p = new Product();

        p.setProductId(rs.getInt("product_id"));
        p.setCategoryId(rs.getInt("category_id"));
        p.setName(rs.getString("name"));
        p.setBrand(rs.getString("brand"));
        p.setDescription(rs.getString("description"));
        p.setPrice(rs.getDouble("price"));
        p.setDiscount(rs.getDouble("discount"));
        p.setStock(rs.getInt("stock"));
        p.setImageUrl(rs.getString("image_url"));
        p.setStatus(rs.getBoolean("status"));

        return p;
    }
}
