
package com.shopsphere.controller;

import com.shopsphere.dao.AdminProductDAO;
import com.shopsphere.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;


@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {

    private final AdminProductDAO dao = new AdminProductDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");

            if ("new".equals(action)) {
                showForm(request, response, new Product());
                return;
            }

            if ("edit".equals(action)) {
                int id = parseId(request.getParameter("id"));

                Product product = dao.getProductById(id);

                if (product == null) {
                    response.sendError(404, "Product not found");
                    return;
                }

                showForm(request, response, product);
                return;
            }

            request.setAttribute("products", dao.getAllProducts());

            request.getRequestDispatcher("/admin/products.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid product ID");
        } catch (SQLException e) {
            throw new ServletException("Unable to load admin products", e);
        }
    }

    private void showForm(
            HttpServletRequest request,
            HttpServletResponse response,
            Product product)
            throws ServletException, IOException, SQLException {

        request.setAttribute("product", product);
        request.setAttribute("categories", dao.getCategories());

        request.getRequestDispatcher("/admin/product-form.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            String action = request.getParameter("action");

            if ("deactivate".equals(action)) {
                int id = parseId(request.getParameter("productId"));

                if (!dao.deactivateProduct(id)) {
                    response.sendError(404, "Product not found");
                    return;
                }

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/products?message=deactivated");
                return;
            }

            if (!"save".equals(action)) {
                response.sendError(400, "Invalid action");
                return;
            }

            Product product = readProduct(request);

            String idValue = request.getParameter("productId");
            boolean editing = idValue != null && !idValue.isBlank();

            if (editing) {
                product.setProductId(parseId(idValue));

                if (!dao.updateProduct(product)) {
                    response.sendError(404, "Product not found");
                    return;
                }
            } else {
                dao.addProduct(product);
            }

            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/products?message=saved");

        } catch (NumberFormatException e) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/products?error=invalid");
        } catch (IllegalArgumentException e) {
            response.sendRedirect(
                    request.getContextPath()
                    + "/admin/products?error=validation");
        } catch (SQLException e) {
            throw new ServletException("Unable to save product", e);
        }
    }

    private Product readProduct(HttpServletRequest request) {
        Product p = new Product();

        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");

        if (name == null || name.isBlank() || name.length() > 150
                || brand == null || brand.length() > 100
                || description == null
                || imageUrl == null || imageUrl.length() > 500) {
            throw new IllegalArgumentException("Invalid product fields");
        }

        int categoryId = parseId(request.getParameter("categoryId"));
        double price = Double.parseDouble(request.getParameter("price"));
        double discount = Double.parseDouble(
                request.getParameter("discount"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        if (!Double.isFinite(price) || !Double.isFinite(discount)
                || price <= 0 || discount < 0 || discount > 100
                || stock < 0) {
            throw new IllegalArgumentException("Invalid product values");
        }

        p.setCategoryId(categoryId);
        p.setName(name.trim());
        p.setBrand(brand.trim());
        p.setDescription(description.trim());
        p.setPrice(price);
        p.setDiscount(discount);
        p.setStock(stock);
        p.setImageUrl(imageUrl.trim());
        p.setStatus(true);

        return p;
    }

    private int parseId(String value) {
        int id = Integer.parseInt(value);

        if (id <= 0) {
            throw new NumberFormatException("ID must be positive");
        }

        return id;
    }
}
