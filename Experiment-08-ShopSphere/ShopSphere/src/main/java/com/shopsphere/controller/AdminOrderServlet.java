
package com.shopsphere.controller;

import com.shopsphere.dao.AdminOrderDAO;
import com.shopsphere.model.AdminOrder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Set;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {

    private final AdminOrderDAO orderDAO = new AdminOrderDAO();

    private static final Set<String> VALID_STATUSES = Set.of(
        "PLACED",
        "PROCESSING",
        "SHIPPED",
        "DELIVERED",
        "CANCELLED"
    );

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<AdminOrder> orders = orderDAO.getAllOrders();

            request.setAttribute("orders", orders);

            request.getRequestDispatcher("/admin/orders.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load orders.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int orderId = Integer.parseInt(
                request.getParameter("orderId")
            );

            String status = request.getParameter("orderStatus");

            if (orderId <= 0 || status == null
                    || !VALID_STATUSES.contains(status)) {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid order ID or status."
                );
                return;
            }

            boolean updated =
                orderDAO.updateOrderStatus(orderId, status);

            if (!updated) {
                response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Order not found."
                );
                return;
            }

            response.sendRedirect(
                request.getContextPath()
                + "/admin/orders?updated=1"
            );

        } catch (NumberFormatException e) {
            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid order ID."
            );
        } catch (SQLException e) {
            throw new ServletException(
                "Unable to update order status.", e
            );
        }
    }
}
