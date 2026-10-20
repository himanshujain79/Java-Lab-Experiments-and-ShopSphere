
package com.shopsphere.controller;

import com.shopsphere.dao.CartDAO;
import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.CartItem;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    private Integer getUserId(HttpSession session) {
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
        Integer userId = session == null ? null : getUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            List<CartItem> items = cartDAO.getCartItems(userId);

            if (items.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/cart");
                return;
            }

            double total = items.stream()
                    .mapToDouble(CartItem::getSubtotal)
                    .sum();

            request.setAttribute("cartItems", items);
            request.setAttribute("cartTotal", total);

            request.getRequestDispatcher("/checkout.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load checkout.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        Integer userId = session == null ? null : getUserId(session);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String addressLine = request.getParameter("addressLine");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String pincode = request.getParameter("pincode");
        String addressType = request.getParameter("addressType");
        String paymentMethod = request.getParameter("paymentMethod");

        if (addressLine == null || addressLine.isBlank()
                || city == null || city.isBlank()
                || state == null || state.isBlank()
                || pincode == null || !pincode.matches("[0-9A-Za-z -]{3,10}")
                || addressLine.length() > 255
                || city.length() > 100
                || state.length() > 100
                || (addressType != null && addressType.length() > 30)) {

            response.sendRedirect(
                    request.getContextPath() + "/checkout?error=address");
            return;
        }

        try {
            int orderId = orderDAO.placeOrder(
                    userId,
                    addressLine.trim(),
                    city.trim(),
                    state.trim(),
                    pincode.trim(),
                    addressType == null ? "Home" : addressType,
                    paymentMethod
            );

            response.sendRedirect(
                    request.getContextPath()
                    + "/orders?id=" + orderId + "&placed=1");

        } catch (SQLException e) {
            getServletContext().log("Checkout failed", e);

            response.sendRedirect(
                    request.getContextPath() + "/checkout?error=failed");
        }
    }
}
