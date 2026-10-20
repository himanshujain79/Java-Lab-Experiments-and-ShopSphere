
package com.shopsphere.controller;

import com.shopsphere.dao.ProductDAO;
import com.shopsphere.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products", "/product"})
public class ProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter = request.getParameter("id");

        // No ID means show all products.
        if (idParameter == null || idParameter.isBlank()) {

            List<Product> products = productDAO.getAllProducts();

            request.setAttribute("products", products);

            request.getRequestDispatcher("/products.jsp")
                    .forward(request, response);

            return;
        }

        // An ID means show one product.
        try {
            int id = Integer.parseInt(idParameter);

            if (id <= 0) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid product ID"
                );
                return;
            }

            Product product = productDAO.getProductById(id);

            if (product == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );
                return;
            }

            request.setAttribute("product", product);

            request.getRequestDispatcher("/product-details.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product ID"
            );
        }
    }
}
