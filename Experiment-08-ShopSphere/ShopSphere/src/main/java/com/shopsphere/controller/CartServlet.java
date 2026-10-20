
package com.shopsphere.controller;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.model.CartItem;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    private Integer getLoggedInUserId(HttpSession session) {
        Object value = session.getAttribute("user");

        if (value instanceof User user) {
            return user.getUserId();
        }

        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = session == null ? null : getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<CartItem> items = cartDAO.getCartItems(userId);
            double total = items.stream()
                    .mapToDouble(CartItem::getSubtotal)
                    .sum();

            request.setAttribute("cartItems", items);
            request.setAttribute("cartTotal", total);

            request.getRequestDispatcher("/cart.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load cart", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = session == null ? null : getLoggedInUserId(session);

        if (userId == null) {
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(
                        request.getParameter("productId"));

                int quantity = Integer.parseInt(
                        request.getParameter("quantity"));

                boolean added = cartDAO.addToCart(
                        userId, productId, quantity);

                response.sendRedirect(
                        request.getContextPath() + "/cart?message="
                                + (added ? "added" : "unavailable"));
                return;
            }

            if ("update".equals(action)) {
                int cartId = Integer.parseInt(
                        request.getParameter("cartId"));

                int quantity = Integer.parseInt(
                        request.getParameter("quantity"));

                boolean updated = cartDAO.updateQuantity(
                        userId, cartId, quantity);

                response.sendRedirect(
                        request.getContextPath() + "/cart?message="
                                + (updated ? "updated" : "unavailable"));
                return;
            }

            if ("remove".equals(action)) {
                int cartId = Integer.parseInt(
                        request.getParameter("cartId"));

                cartDAO.removeItem(userId, cartId);

                response.sendRedirect(
                        request.getContextPath() + "/cart?message=removed");
                return;
            }

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Unknown cart action");

        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart input");
        } catch (SQLException e) {
            throw new ServletException("Cart operation failed", e);
        }
    }
}
