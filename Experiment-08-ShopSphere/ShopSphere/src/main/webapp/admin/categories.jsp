
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.Category" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Category Management | ShopSphere Admin</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f5f7fb;
            color: #1f2937;
            font-family: Arial, Helvetica, sans-serif;
        }

        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
            padding: 16px 5%;
            background: #ffffff;
            border-bottom: 1px solid #e5e7eb;
        }

        .brand {
            color: #5141cb;
            font-size: 23px;
            font-weight: 800;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
        }

        .nav-links a {
            color: #4b5563;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
        }

        .nav-links a:hover {
            color: #5141cb;
        }

        .page-container {
            width: 92%;
            max-width: 1250px;
            margin: 32px auto;
        }

        .page-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: wrap;
            margin-bottom: 24px;
        }

        .page-header h1 {
            margin: 0 0 8px;
            color: #111827;
            font-size: 28px;
        }

        .page-header p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        .header-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .button {
            display: inline-block;
            padding: 11px 16px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: background 0.2s;
        }

        .primary-button {
            background: #5141cb;
            color: #ffffff;
        }

        .primary-button:hover {
            background: #4031ad;
        }

        .secondary-button {
            background: #ffffff;
            color: #374151;
            border: 1px solid #d1d5db;
        }

        .secondary-button:hover {
            background: #f9fafb;
        }

        .message {
            padding: 13px 16px;
            margin-bottom: 20px;
            border: 1px solid #bbf7d0;
            border-radius: 9px;
            background: #f0fdf4;
            color: #166534;
            font-size: 14px;
        }

        .table-card {
            overflow: hidden;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.04);
        }

        .table-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            padding: 20px 22px;
            border-bottom: 1px solid #e5e7eb;
        }

        .table-heading h2 {
            margin: 0;
            color: #111827;
            font-size: 18px;
        }

        .table-heading span {
            color: #6b7280;
            font-size: 13px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 750px;
            border-collapse: collapse;
        }

        thead {
            background: #f8fafc;
        }

        th {
            padding: 15px 18px;
            border-bottom: 1px solid #e5e7eb;
            color: #6b7280;
            font-size: 12px;
            font-weight: 700;
            text-align: left;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            white-space: nowrap;
        }

        td {
            padding: 16px 18px;
            border-bottom: 1px solid #eef0f4;
            color: #374151;
            font-size: 14px;
            vertical-align: middle;
        }

        tbody tr:hover {
            background: #fafaff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .category-id {
            color: #6b7280;
            font-weight: 700;
        }

        .category-name {
            color: #111827;
            font-weight: 700;
        }

        .description {
            max-width: 280px;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }

        .active {
            background: #dcfce7;
            color: #166534;
        }

        .inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        .actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .edit-link {
            display: inline-block;
            padding: 7px 11px;
            border-radius: 6px;
            background: #eef2ff;
            color: #4338ca;
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
        }

        .edit-link:hover {
            background: #e0e7ff;
        }

        .deactivate-button {
            padding: 7px 10px;
            border: 1px solid #fecaca;
            border-radius: 6px;
            background: #fff7f7;
            color: #b91c1c;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
        }

        .deactivate-button:hover {
            background: #fee2e2;
        }

        .empty-state {
            padding: 45px 20px;
            text-align: center;
        }

        .empty-icon {
            margin-bottom: 12px;
            font-size: 42px;
        }

        .empty-state h3 {
            margin: 0 0 8px;
            color: #111827;
            font-size: 20px;
        }

        .empty-state p {
            margin: 0 0 20px;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        a:focus-visible,
        button:focus-visible {
            outline: 3px solid #a5b4fc;
            outline-offset: 3px;
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 14px 4%;
            }

            .brand {
                font-size: 21px;
            }

            .nav-links {
                gap: 13px;
            }

            .page-container {
                width: 94%;
                margin: 24px auto;
            }

            .page-header h1 {
                font-size: 24px;
            }

            .header-actions {
                width: 100%;
            }

            .header-actions .button {
                text-align: center;
            }

            .table-heading {
                padding: 17px;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a class="brand"
       href="${pageContext.request.contextPath}/admin/dashboard">
        ShopSphere Admin
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/admin/dashboard">
            Dashboard
        </a>
        <a href="${pageContext.request.contextPath}/admin/products">
            Products
        </a>
        <a href="${pageContext.request.contextPath}/admin/orders">
            Orders
        </a>
        <a href="${pageContext.request.contextPath}/admin/users">
            Customers
        </a>
        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>
    </div>
</nav>

<main class="page-container">

    <header class="page-header">
        <div>
            <h1>Category Management</h1>
            <p>Create, update, and manage your store's product categories.</p>
        </div>

        <div class="header-actions">
            <a class="button secondary-button"
               href="${pageContext.request.contextPath}/admin/products">
                Manage Products
            </a>

            <a class="button primary-button"
               href="${pageContext.request.contextPath}/admin/categories?action=new">
                + Add Category
            </a>
        </div>
    </header>

    <% if ("1".equals(request.getParameter("updated"))) { %>
        <div class="message" role="status">
            ✓ Category operation completed.
        </div>
    <% } %>

    <%
        List<Category> categories =
                (List<Category>) request.getAttribute("categories");
    %>

    <section class="table-card">

        <div class="table-heading">
            <h2>All Categories</h2>

            <span>
                <%= categories == null ? 0 : categories.size() %>
                <%= categories != null && categories.size() == 1
                        ? "category" : "categories" %>
            </span>
        </div>

        <% if (categories == null || categories.isEmpty()) { %>

            <div class="empty-state">
                <div class="empty-icon">🗂️</div>
                <h3>No categories found</h3>
                <p>Create your first category to organize your products.</p>

                <a class="button primary-button"
                   href="${pageContext.request.contextPath}/admin/categories?action=new">
                    + Add Category
                </a>
            </div>

        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Category Name</th>
                        <th>Description</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% for (Category category : categories) { %>

                        <tr>
                            <td class="category-id">
                                #<%= category.getCategoryId() %>
                            </td>

                            <td class="category-name">
                                <%= category.getName() %>
                            </td>

                            <td class="description">
                                <%= category.getDescription() == null
                                        || category.getDescription().trim().isEmpty()
                                        ? "No description"
                                        : category.getDescription() %>
                            </td>

                            <td>
                                <span class="status-badge <%= category.isStatus()
                                        ? "active" : "inactive" %>">
                                    <%= category.isStatus()
                                            ? "Active" : "Inactive" %>
                                </span>
                            </td>

                            <td>
                                <div class="actions">

                                    <a class="edit-link"
                                       href="${pageContext.request.contextPath}/admin/categories?action=edit&id=<%= category.getCategoryId() %>">
                                        Edit
                                    </a>

                                    <% if (category.isStatus()) { %>

                                        <form method="post"
                                              action="${pageContext.request.contextPath}/admin/categories"
                                              onsubmit="return confirm('Are you sure you want to deactivate this category?');">

                                            <input type="hidden"
                                                   name="action"
                                                   value="deactivate">

                                            <input type="hidden"
                                                   name="id"
                                                   value="<%= category.getCategoryId() %>">

                                            <button class="deactivate-button"
                                                    type="submit">
                                                Deactivate
                                            </button>
                                        </form>

                                    <% } %>

                                </div>
                            </td>
                        </tr>

                    <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>

    </section>

</main>

</body>
</html>