
package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.Order;
import com.shopsphere.model.OrderItem;
import com.shopsphere.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

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
            String idParameter = request.getParameter("id");

            if (idParameter == null || idParameter.isBlank()) {
                List<Order> orders = orderDAO.getOrdersByUser(userId);
                request.setAttribute("orders", orders);
                request.getRequestDispatcher("/orders.jsp")
                        .forward(request, response);
                return;
            }

            int orderId;
            try {
                orderId = Integer.parseInt(idParameter);
            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid order ID");
                return;
            }

            if (orderId <= 0) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid order ID");
                return;
            }

            Order order = orderDAO.getOrderById(userId, orderId);

            if (order == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Order not found");
                return;
            }

            List<OrderItem> items =
                    orderDAO.getOrderItems(userId, orderId);

            request.setAttribute("order", order);
            request.setAttribute("orderItems", items);

            request.getRequestDispatcher("/order-details.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load orders.", e);
        }
    }
}
