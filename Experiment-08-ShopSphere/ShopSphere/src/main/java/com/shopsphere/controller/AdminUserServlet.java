
package com.shopsphere.controller;

import com.shopsphere.dao.AdminUserDAO;
import com.shopsphere.dao.AdminUserDAO.Customer;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserServlet extends HttpServlet {

    private final AdminUserDAO userDAO = new AdminUserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Customer> customers = userDAO.getAllCustomers();
            request.setAttribute("customers", customers);

            request.getRequestDispatcher("/admin/users.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load customers.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String idValue = request.getParameter("userId");
        String statusValue = request.getParameter("status");

        try {
            int userId = Integer.parseInt(idValue);

            if (userId <= 0 ||
                (!"0".equals(statusValue) && !"1".equals(statusValue))) {
                response.sendError(400, "Invalid customer or status.");
                return;
            }

            boolean active = "1".equals(statusValue);

            if (!userDAO.updateCustomerStatus(userId, active)) {
                response.sendError(404, "Customer not found.");
                return;
            }

            response.sendRedirect(
                request.getContextPath() + "/admin/users?updated=1"
            );

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid customer ID.");
        } catch (SQLException e) {
            throw new ServletException(
                "Unable to update customer status.", e
            );
        }
    }
}

