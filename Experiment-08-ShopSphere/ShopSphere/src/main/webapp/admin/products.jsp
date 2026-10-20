
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.shopsphere.model.Product" %>

<%
    List<Product> products =
        (List<Product>) request.getAttribute("products");

    String message = request.getParameter("message");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products | ShopSphere Admin</title>

    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #f4f6fb;
            color: #1f2937;
            font-family: Arial, Helvetica, sans-serif;
        }

        .admin-header {
            background: #172554;
            color: #ffffff;
            padding: 22px 5%;
        }

        .header-inner {
            max-width: 1250px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .brand {
            margin: 0;
            font-size: 25px;
        }

        .brand span {
            color: #93c5fd;
        }

        .header-subtitle {
            margin: 7px 0 0;
            color: #cbd5e1;
            font-size: 14px;
        }

        .header-links {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .header-links a {
            display: inline-block;
            color: #ffffff;
            text-decoration: none;
            padding: 10px 14px;
            border: 1px solid #64748b;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            background: #263b70;
            opacity: 1;
            visibility: visible;
        }

        .header-links a:hover {
            background: #3b5190;
        }

        .container {
            max-width: 1250px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .page-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
            margin-bottom: 22px;
        }

        .page-heading h2 {
            margin: 0 0 6px;
            font-size: 26px;
        }

        .page-heading p {
            margin: 0;
            color: #64748b;
            font-size: 14px;
        }

        .btn {
            display: inline-block;
            border: none;
            border-radius: 8px;
            padding: 11px 16px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .btn-primary {
            background: #2563eb;
            color: #ffffff;
        }

        .btn-primary:hover {
            background: #1d4ed8;
        }

        .btn-danger {
            background: #fee2e2;
            color: #b91c1c;
        }

        .btn-danger:hover {
            background: #fecaca;
        }

        .alert {
            padding: 13px 16px;
            margin-bottom: 18px;
            border-radius: 8px;
            font-size: 14px;
        }

        .alert-success {
            background: #dcfce7;
            color: #166534;
            border: 1px solid #bbf7d0;
        }

        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .table-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 12px;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.04);
            overflow: hidden;
        }

        .table-scroll {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 850px;
        }

        thead {
            background: #f8fafc;
        }

        th {
            color: #475569;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-align: left;
            padding: 16px 14px;
            border-bottom: 1px solid #e5e7eb;
            white-space: nowrap;
        }

        td {
            padding: 15px 14px;
            border-bottom: 1px solid #eef2f7;
            font-size: 14px;
            vertical-align: middle;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        tbody tr:hover {
            background: #f8fafc;
        }

        .product-name {
            font-weight: 600;
            color: #1e293b;
        }

        .product-id {
            color: #64748b;
        }

        .price {
            font-weight: 600;
            white-space: nowrap;
        }

        .badge {
            display: inline-block;
            padding: 5px 9px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            white-space: nowrap;
        }

        .badge-active {
            background: #dcfce7;
            color: #166534;
        }

        .badge-inactive {
            background: #f1f5f9;
            color: #475569;
        }

        .stock-low {
            color: #b91c1c;
            font-weight: 700;
        }

        .stock-normal {
            color: #334155;
        }

        .actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .edit-link {
            color: #2563eb;
            font-weight: 600;
            text-decoration: none;
            padding: 8px 10px;
        }

        .edit-link:hover {
            text-decoration: underline;
        }

        .actions form {
            margin: 0;
        }

        .empty-state {
            padding: 45px 20px;
            text-align: center;
            color: #64748b;
        }

        .empty-state strong {
            display: block;
            color: #334155;
            font-size: 17px;
            margin-bottom: 8px;
        }

        .table-footer {
            padding: 14px 18px;
            background: #ffffff;
            border-top: 1px solid #e5e7eb;
            color: #64748b;
            font-size: 13px;
        }

        @media (max-width: 600px) {
            .admin-header {
                padding: 18px 20px;
            }

            .brand {
                font-size: 22px;
            }

            .container {
                margin: 22px auto;
                padding: 0 12px;
            }

            .page-heading h2 {
                font-size: 23px;
            }

            .page-heading .btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>

<body>

<header class="admin-header">
    <div class="header-inner">
        <div>
            <h1 class="brand">Shop<span>Sphere</span> Admin</h1>
            <p class="header-subtitle">Manage your store products and inventory</p>
        </div>

        <nav class="header-links">
            <a href="<%= request.getContextPath() %>/admin/dashboard">Dashboard</a>
            <a href="<%= request.getContextPath() %>/products">View Store</a>
        </nav>
    </div>
</header>

<main class="container">

    <div class="page-heading">
        <div>
            <h2>Products</h2>
            <p>Add, edit, and manage the products available in your store.</p>
        </div>

        <a class="btn btn-primary"
           href="<%= request.getContextPath() %>/admin/products?action=new">
            + Add New Product
        </a>
    </div>

    <% if ("saved".equals(message)) { %>
        <div class="alert alert-success" role="status">
            Product saved successfully.
        </div>
    <% } else if ("deactivated".equals(message)) { %>
        <div class="alert alert-success" role="status">
            Product deactivated successfully.
        </div>
    <% } %>

    <% if ("invalid".equals(error) || "validation".equals(error)) { %>
        <div class="alert alert-error" role="alert">
            Invalid product input. Please check the fields and try again.
        </div>
    <% } %>

    <section class="table-card">
        <div class="table-scroll">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Category ID</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Stock</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                <% if (products != null && !products.isEmpty()) {
                       for (Product p : products) { %>
                    <tr>
                        <td class="product-id">
                            #<%= p.getProductId() %>
                        </td>

                        <td class="product-name">
                            <%= p.getName() %>
                        </td>

                        <td><%= p.getCategoryId() %></td>

                        <td class="price">
                            ₹<%= String.format(Locale.US, "%.2f", p.getPrice()) %>
                        </td>

                        <td><%= p.getDiscount() %>%</td>

                        <td class="<%= p.getStock() <= 5 ? "stock-low" : "stock-normal" %>">
                            <%= p.getStock() %>
                        </td>

                        <td>
                            <% if (p.isStatus()) { %>
                                <span class="badge badge-active">Active</span>
                            <% } else { %>
                                <span class="badge badge-inactive">Inactive</span>
                            <% } %>
                        </td>

                        <td>
                            <div class="actions">
                                <a class="edit-link"
                                   href="<%= request.getContextPath() %>/admin/products?action=edit&id=<%= p.getProductId() %>">
                                    Edit
                                </a>

                                <% if (p.isStatus()) { %>
                                    <form action="<%= request.getContextPath() %>/admin/products"
                                          method="post"
                                          onsubmit="return confirm('Deactivate this product?');">
                                        <input type="hidden" name="action" value="deactivate">
                                        <input type="hidden" name="productId"
                                               value="<%= p.getProductId() %>">

                                        <button class="btn btn-danger" type="submit">
                                            Deactivate
                                        </button>
                                    </form>
                                <% } %>
                            </div>
                        </td>
                    </tr>
                <%     }
                   } else { %>
                    <tr>
                        <td colspan="8">
                            <div class="empty-state">
                                <strong>No products found</strong>
                                Add your first product to start building your store.
                                <p>
                                    <a class="btn btn-primary"
                                       href="<%= request.getContextPath() %>/admin/products?action=new">
                                        Add Product
                                    </a>
                                </p>
                            </div>
                        </td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        </div>

        <% if (products != null && !products.isEmpty()) { %>
            <div class="table-footer">
                Total products displayed: <%= products.size() %>
            </div>
        <% } %>
    </section>

</main>

</body>
</html>