
package com.shopsphere.controller;

import com.shopsphere.dao.AdminCategoryDAO;
import com.shopsphere.model.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/categories")
public class AdminCategoryServlet extends HttpServlet {

    private final AdminCategoryDAO categoryDAO = new AdminCategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String action = request.getParameter("action");

            if ("new".equals(action)) {
                request.getRequestDispatcher("/admin/category-form.jsp")
                       .forward(request, response);
                return;
            }

            if ("edit".equals(action)) {
                int id = parseId(request.getParameter("id"));

                if (id <= 0) {
                    response.sendError(400, "Invalid category ID.");
                    return;
                }

                Category category = categoryDAO.getCategoryById(id);

                if (category == null) {
                    response.sendError(404, "Category not found.");
                    return;
                }

                request.setAttribute("category", category);
                request.getRequestDispatcher("/admin/category-form.jsp")
                       .forward(request, response);
                return;
            }

            List<Category> categories = categoryDAO.getAllCategories();
            request.setAttribute("categories", categories);

            request.getRequestDispatcher("/admin/categories.jsp")
                   .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid category ID.");
        } catch (SQLException e) {
            throw new ServletException("Unable to load categories.", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        try {
            if ("deactivate".equals(action)) {
                int id = parseId(request.getParameter("id"));

                if (id <= 0) {
                    response.sendError(400, "Invalid category ID.");
                    return;
                }

                categoryDAO.deactivateCategory(id);
                response.sendRedirect(request.getContextPath()
                    + "/admin/categories?updated=1");
                return;
            }

            String name = request.getParameter("name");
            String description = request.getParameter("description");

            if (name == null || name.trim().isEmpty()
                    || name.trim().length() > 100) {
                request.setAttribute("error",
                    "Category name is required and must be at most 100 characters.");
                request.getRequestDispatcher("/admin/category-form.jsp")
                       .forward(request, response);
                return;
            }

            if (description != null && description.length() > 255) {
                request.setAttribute("error",
                    "Description must be at most 255 characters.");
                request.getRequestDispatcher("/admin/category-form.jsp")
                       .forward(request, response);
                return;
            }

            Category category = new Category();
            category.setName(name.trim());
            category.setDescription(
                description == null || description.trim().isEmpty()
                    ? null : description.trim()
            );

            category.setStatus("1".equals(request.getParameter("status")));

            String idValue = request.getParameter("categoryId");

            if (idValue == null || idValue.trim().isEmpty()) {
                categoryDAO.addCategory(category);
            } else {
                int id = parseId(idValue);

                if (id <= 0) {
                    response.sendError(400, "Invalid category ID.");
                    return;
                }

                category.setCategoryId(id);

                if (categoryDAO.updateCategory(category)) {
                    // Category updated.
                } else {
                    response.sendError(404, "Category not found.");
                    return;
                }
            }

            response.sendRedirect(request.getContextPath()
                + "/admin/categories?updated=1");

        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid category ID.");
        } catch (SQLException e) {
            throw new ServletException("Unable to save category.", e);
        }
    }

    private int parseId(String value) {
        if (value == null) {
            return -1;
        }
        return Integer.parseInt(value);
    }
}
