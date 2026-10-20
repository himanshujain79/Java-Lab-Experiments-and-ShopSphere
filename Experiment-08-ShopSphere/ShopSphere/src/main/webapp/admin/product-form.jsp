
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.shopsphere.model.Product" %>
<%@ page import="com.shopsphere.model.Category" %>

<%
    Product product = (Product) request.getAttribute("product");
    List<Category> categories =
            (List<Category>) request.getAttribute("categories");

    if (product == null) {
        response.sendError(
                jakarta.servlet.http.HttpServletResponse.SC_BAD_REQUEST,
                "Product information is missing."
        );
        return;
    }

    boolean editing = product.getProductId() > 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><%= editing ? "Edit" : "Add" %> Product | ShopSphere Admin</title>

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

        .nav-links a:hover,
        .back-link:hover {
            color: #5141cb;
        }

        .page-container {
            width: 92%;
            max-width: 850px;
            margin: 32px auto;
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
            margin-bottom: 27px;
        }

        .form-heading h1 {
            margin: 0 0 9px;
            color: #111827;
            font-size: 28px;
        }

        .form-heading p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.7;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 21px 20px;
        }

        .form-group {
            min-width: 0;
        }

        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #374151;
            font-size: 14px;
            font-weight: 700;
        }

        .required {
            color: #dc2626;
        }

        .form-control {
            display: block;
            width: 100%;
            min-width: 0;
            padding: 12px 13px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #ffffff;
            color: #111827;
            font-family: inherit;
            font-size: 14px;
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
            gap: 12px;
            margin-top: 30px;
            padding-top: 22px;
            border-top: 1px solid #eef0f4;
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
        input:focus-visible,
        select:focus-visible,
        textarea:focus-visible {
            outline: 3px solid #a5b4fc;
            outline-offset: 3px;
        }

        @media (max-width: 650px) {
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
                margin: 23px auto;
            }

            .form-card {
                padding: 22px 18px;
            }

            .form-heading h1 {
                font-size: 24px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 19px;
            }

            .form-group.full-width {
                grid-column: auto;
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
        <a href="${pageContext.request.contextPath}/admin/orders">
            Orders
        </a>
        <a href="${pageContext.request.contextPath}/logout">
            Logout
        </a>
    </div>
</nav>

<main class="page-container">

    <a class="back-link"
       href="${pageContext.request.contextPath}/admin/products">
        ← Back to Product Management
    </a>

    <section class="form-card">

        <header class="form-heading">
            <h1><%= editing ? "Edit Product" : "Add New Product" %></h1>

            <p>
                <%= editing
                        ? "Update the product details, pricing, and available stock."
                        : "Fill in the details below to add a product to your store." %>
            </p>
        </header>

        <form action="${pageContext.request.contextPath}/admin/products"
              method="post">

            <input type="hidden" name="action" value="save">

            <% if (editing) { %>
                <input type="hidden"
                       name="productId"
                       value="<%= product.getProductId() %>">
            <% } %>

            <div class="form-grid">

                <div class="form-group">
                    <label for="name">
                        Product Name <span class="required">*</span>
                    </label>

                    <input class="form-control"
                           type="text"
                           id="name"
                           name="name"
                           maxlength="150"
                           placeholder="e.g. Wireless Headphones"
                           value="<%= product.getName() == null
                                   ? "" : product.getName() %>"
                           required>
                </div>

                <div class="form-group">
                    <label for="categoryId">
                        Category <span class="required">*</span>
                    </label>

                    <select class="form-control"
                            id="categoryId"
                            name="categoryId"
                            required>

                        <option value="">Select a category</option>

                        <% if (categories != null) {
                            for (Category c : categories) { %>

                                <option value="<%= c.getCategoryId() %>"
                                    <%= product.getCategoryId() == c.getCategoryId()
                                            ? "selected" : "" %>>
                                    <%= c.getName() %>
                                </option>

                        <%  }
                           } %>

                    </select>
                </div>

                <div class="form-group">
                    <label for="brand">Brand</label>

                    <input class="form-control"
                           type="text"
                           id="brand"
                           name="brand"
                           maxlength="100"
                           placeholder="e.g. Samsung"
                           value="<%= product.getBrand() == null
                                   ? "" : product.getBrand() %>">
                </div>

                <div class="form-group">
                    <label for="imageUrl">Image URL</label>

                    <input class="form-control"
                           type="url"
                           id="imageUrl"
                           name="imageUrl"
                           maxlength="500"
                           placeholder="https://example.com/product.jpg"
                           value="<%= product.getImageUrl() == null
                                   ? "" : product.getImageUrl() %>">

                    <span class="field-hint">
                        Optional. Enter a valid image URL.
                    </span>
                </div>

                <div class="form-group full-width">
                    <label for="description">
                        Description <span class="required">*</span>
                    </label>

                    <textarea class="form-control"
                              id="description"
                              name="description"
                              rows="4"
                              maxlength="5000"
                              placeholder="Describe the product and its features"
                              required><%= product.getDescription() == null
                                      ? "" : product.getDescription() %></textarea>
                </div>

                <div class="form-group">
                    <label for="price">
                        Price (₹) <span class="required">*</span>
                    </label>

                    <input class="form-control"
                           type="number"
                           id="price"
                           name="price"
                           min="0.01"
                           step="0.01"
                           value="<%= product.getPrice() %>"
                           required>
                </div>

                <div class="form-group">
                    <label for="discount">Discount (%)</label>

                    <input class="form-control"
                           type="number"
                           id="discount"
                           name="discount"
                           min="0"
                           max="100"
                           step="0.01"
                           value="<%= product.getDiscount() %>"
                           required>

                    <span class="field-hint">
                        Enter 0 if there is no discount.
                    </span>
                </div>

                <div class="form-group">
                    <label for="stock">
                        Available Stock <span class="required">*</span>
                    </label>

                    <input class="form-control"
                           type="number"
                           id="stock"
                           name="stock"
                           min="0"
                           step="1"
                           value="<%= product.getStock() %>"
                           required>
                </div>

            </div>

            <div class="form-actions">
                <button class="button primary-button" type="submit">
                    <%= editing ? "Save Changes" : "Add Product" %>
                </button>

                <a class="button secondary-button"
                   href="${pageContext.request.contextPath}/admin/products">
                    Cancel
                </a>
            </div>

        </form>

    </section>

</main>

</body>
</html>