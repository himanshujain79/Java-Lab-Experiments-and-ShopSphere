
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.shopsphere.model.Category" %>

<%
    Category category = (Category) request.getAttribute("category");
    boolean editing = category != null;

    String name = editing && category.getName() != null
            ? category.getName() : "";

    String description = editing && category.getDescription() != null
            ? category.getDescription() : "";

    boolean active = !editing || category.isStatus();

    Object errorMessage = request.getAttribute("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><%= editing ? "Edit" : "Add" %> Category | ShopSphere Admin</title>

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
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 16px;
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
            max-width: 650px;
            margin: 36px auto;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 18px;
            color: #5141cb;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
        }

        .form-card {
            padding: 30px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 15px;
            box-shadow: 0 8px 28px rgba(15, 23, 42, 0.05);
        }

        .form-heading {
            margin-bottom: 26px;
        }

        .form-heading h1 {
            margin: 0 0 9px;
            color: #111827;
            font-size: 27px;
        }

        .form-heading p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        .error-message {
            padding: 13px 15px;
            margin-bottom: 22px;
            border: 1px solid #fecaca;
            border-radius: 8px;
            background: #fef2f2;
            color: #b91c1c;
            font-size: 14px;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .form-group {
            margin-bottom: 21px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #374151;
            font-size: 14px;
            font-weight: 700;
        }

        .form-control {
            display: block;
            width: 100%;
            padding: 12px 13px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #ffffff;
            color: #111827;
            font-family: inherit;
            font-size: 15px;
            line-height: 1.5;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-control:focus {
            border-color: #5141cb;
            outline: none;
            box-shadow: 0 0 0 3px rgba(81, 65, 203, 0.12);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .field-hint {
            display: block;
            margin-top: 6px;
            color: #6b7280;
            font-size: 12px;
            line-height: 1.5;
        }

        .form-actions {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 12px;
            margin-top: 28px;
        }

        .button {
            display: inline-block;
            padding: 12px 19px;
            border: 1px solid transparent;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            text-align: center;
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
            border-color: #d1d5db;
        }

        .secondary-button:hover {
            background: #f9fafb;
        }

        a:focus-visible,
        button:focus-visible,
        select:focus-visible,
        input:focus-visible,
        textarea:focus-visible {
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

            .form-card {
                padding: 22px 18px;
            }

            .form-heading h1 {
                font-size: 24px;
            }

            .form-actions .button {
                flex: 1;
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
        <a href="${pageContext.request.contextPath}/admin/categories">
            Categories
        </a>
        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>
    </div>
</nav>

<main class="page-container">

    <a class="back-link"
       href="${pageContext.request.contextPath}/admin/categories">
        ← Back to Categories
    </a>

    <section class="form-card">

        <header class="form-heading">
            <h1><%= editing ? "Edit Category" : "Add New Category" %></h1>

            <p>
                <%= editing
                        ? "Update the category information and its status."
                        : "Enter the details to create a new product category." %>
            </p>
        </header>

        <% if (errorMessage != null) { %>
            <div class="error-message" role="alert">
                <%= errorMessage %>
            </div>
        <% } %>

        <form method="post"
              action="${pageContext.request.contextPath}/admin/categories">

            <% if (editing) { %>
                <input type="hidden"
                       name="categoryId"
                       value="<%= category.getCategoryId() %>">
            <% } %>

            <div class="form-group">
                <label for="name">Category Name</label>

                <input class="form-control"
                       type="text"
                       id="name"
                       name="name"
                       maxlength="100"
                       placeholder="e.g. Electronics"
                       value="<%= name %>"
                       required>

                <span class="field-hint">
                    Use a short, descriptive name for this category.
                </span>
            </div>

            <div class="form-group">
                <label for="description">Description</label>

                <textarea class="form-control"
                          id="description"
                          name="description"
                          maxlength="255"
                          rows="4"
                          placeholder="Describe the products in this category"><%= description %></textarea>

                <span class="field-hint">
                    Optional. Maximum 255 characters.
                </span>
            </div>

            <div class="form-group">
                <label for="status">Category Status</label>

                <select class="form-control"
                        id="status"
                        name="status">

                    <option value="1"
                        <%= active ? "selected" : "" %>>
                        Active
                    </option>

                    <option value="0"
                        <%= !active ? "selected" : "" %>>
                        Inactive
                    </option>

                </select>

                <span class="field-hint">
                    Choose whether this category should be active.
                </span>
            </div>

            <div class="form-actions">
                <button class="button primary-button" type="submit">
                    <%= editing ? "Save Changes" : "Create Category" %>
                </button>

                <a class="button secondary-button"
                   href="${pageContext.request.contextPath}/admin/categories">
                    Cancel
                </a>
            </div>

        </form>

    </section>

</main>

</body>
</html>