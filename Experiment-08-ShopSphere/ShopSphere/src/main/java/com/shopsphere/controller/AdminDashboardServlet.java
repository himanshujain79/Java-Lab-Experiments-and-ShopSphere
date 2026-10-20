
package com.shopsphere.controller;

import com.shopsphere.dao.AdminDashboardDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final AdminDashboardDAO dashboardDAO =
        new AdminDashboardDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            request.setAttribute(
                "productCount",
                dashboardDAO.getCount(
                    "SELECT COUNT(*) FROM products"
                )
            );

            request.setAttribute(
                "categoryCount",
                dashboardDAO.getCount(
                    "SELECT COUNT(*) FROM categories WHERE status = 1"
                )
            );

            request.setAttribute(
                "customerCount",
                dashboardDAO.getCount(
                    "SELECT COUNT(*) FROM users " +
                    "WHERE role = 'CUSTOMER' AND status = 1"
                )
            );

            request.setAttribute(
                "orderCount",
                dashboardDAO.getCount(
                    "SELECT COUNT(*) FROM orders"
                )
            );

            request.setAttribute(
                "lowStockCount",
                dashboardDAO.getCount(
                    "SELECT COUNT(*) FROM products " +
                    "WHERE stock <= 5 AND status = 1"
                )
            );

            request.setAttribute(
                "totalSales",
                dashboardDAO.getTotalSales()
            );

            request.getRequestDispatcher(
                "/admin/dashboard.jsp"
            ).forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                "Unable to load admin dashboard.", e
            );
        }
    }
}
    