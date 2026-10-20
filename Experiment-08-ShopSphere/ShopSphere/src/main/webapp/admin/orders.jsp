
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.shopsphere.model.AdminOrder" %>

<%
    List<AdminOrder> orders =
            (List<AdminOrder>) request.getAttribute("orders");

    String[] statuses = {
        "PLACED",
        "PROCESSING",
        "SHIPPED",
        "DELIVERED",
        "CANCELLED"
    };
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Order Management | ShopSphere Admin</title>

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
            width: 94%;
            max-width: 1450px;
            margin: 32px auto;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 18px;
            margin-bottom: 24px;
        }

        .page-header h1 {
            margin: 0 0 9px;
            color: #111827;
            font-size: 28px;
        }

        .page-header p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        .header-link {
            display: inline-block;
            padding: 11px 16px;
            background: #5141cb;
            color: #ffffff;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 700;
            text-decoration: none;
        }

       

        .success-message {
            margin-bottom: 20px;
            padding: 14px 16px;
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

        .order-count {
            color: #6b7280;
            font-size: 13px;
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 1100px;
            border-collapse: collapse;
        }

        thead {
            background: #f8fafc;
        }

        th {
            padding: 15px 16px;
            border-bottom: 1px solid #e5e7eb;
            color: #6b7280;
            font-size: 12px;
            font-weight: 700;
            text-align: left;
            text-transform: uppercase;
            letter-spacing: 0.35px;
            white-space: nowrap;
        }

        td {
            padding: 16px;
            border-bottom: 1px solid #eef0f4;
            color: #374151;
            font-size: 13px;
            vertical-align: middle;
        }

        tbody tr:hover {
            background: #fafaff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .order-id {
            color: #5141cb;
            font-weight: 800;
            white-space: nowrap;
        }

        .customer-name {
            display: block;
            margin-bottom: 5px;
            color: #111827;
            font-size: 13px;
            font-weight: 700;
        }

        .customer-email {
            display: block;
            color: #6b7280;
            font-size: 12px;
            overflow-wrap: anywhere;
        }

        .amount {
            color: #111827;
            font-weight: 800;
            white-space: nowrap;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 9px;
            border-radius: 20px;
            background: #f3f4f6;
            color: #374151;
            font-size: 11px;
            font-weight: 700;
            white-space: nowrap;
        }

        .status-placed,
        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-processing,
        .status-shipped {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .status-delivered,
        .status-paid,
        .status-completed {
            background: #dcfce7;
            color: #166534;
        }

        .status-cancelled,
        .status-failed {
            background: #fee2e2;
            color: #991b1b;
        }

        .update-form {
            min-width: 150px;
        }

        .status-select {
            width: 100%;
            padding: 9px 10px;
            margin-bottom: 8px;
            border: 1px solid #d1d5db;
            border-radius: 7px;
            background: #ffffff;
            color: #374151;
            font-size: 12px;
        }

        .update-button {
            width: 100%;
            padding: 9px 12px;
            border: none;
            border-radius: 7px;
            background: #5141cb;
            color: #ffffff;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
        }

        .update-button:hover {
            background: #4031ad;
        }

        .empty-state {
            padding: 48px 20px;
            text-align: center;
        }

        .empty-icon {
            margin-bottom: 12px;
            font-size: 44px;
        }

        .empty-state h3 {
            margin: 0 0 9px;
            color: #111827;
            font-size: 20px;
        }

        .empty-state p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        a:focus-visible,
        button:focus-visible,
        select:focus-visible {
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
        <a href="${pageContext.request.contextPath}/admin/categories">
            Categories
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
            <h1>Order Management</h1>
            <p>Review customer orders and manage their fulfillment status.</p>
        </div>

        <a class="header-link"
           href="${pageContext.request.contextPath}/admin/products">
            Manage Products →
        </a>
    </header>

    <% if ("1".equals(request.getParameter("updated"))) { %>
        <div class="success-message" role="status">
            ✓ Order status updated successfully.
        </div>
    <% } %>

    <section class="table-card">

        <div class="table-heading">
            <h2>All Orders</h2>

            <span class="order-count">
                <%= orders == null ? 0 : orders.size() %>
                <%= orders != null && orders.size() == 1
                        ? "order" : "orders" %>
            </span>
        </div>

        <% if (orders == null || orders.isEmpty()) { %>

            <div class="empty-state">
                <div class="empty-icon">📦</div>
                <h3>No orders found</h3>
                <p>Customer orders will appear here when they are placed.</p>
            </div>

        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer</th>
                        <th>Total</th>
                        <th>Payment Method</th>
                        <th>Payment Status</th>
                        <th>Order Status</th>
                        <th>Order Date</th>
                        <th>Update Status</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% for (AdminOrder order : orders) {
                        String paymentStatus = order.getPaymentStatus() == null
                                ? "N/A" : order.getPaymentStatus();

                        String orderStatus = order.getOrderStatus() == null
                                ? "N/A" : order.getOrderStatus();

                        String paymentClass = paymentStatus
                                .toLowerCase(Locale.ROOT)
                                .replaceAll("[^a-z0-9_-]", "");

                        String orderClass = orderStatus
                                .toLowerCase(Locale.ROOT)
                                .replaceAll("[^a-z0-9_-]", "");

                        String current = order.getOrderStatus() == null
                                ? "" : order.getOrderStatus();
                    %>

                        <tr>
                            <td class="order-id">
                                #<%= order.getOrderId() %>
                            </td>

                            <td>
                                <span class="customer-name">
                                    <%= order.getCustomerName() == null
                                            || order.getCustomerName().trim().isEmpty()
                                            ? "Customer" : order.getCustomerName() %>
                                </span>

                                <span class="customer-email">
                                    <%= order.getCustomerEmail() == null
                                            ? "" : order.getCustomerEmail() %>
                                </span>
                            </td>

                            <td class="amount">
                                ₹<%= String.format(Locale.US, "%.2f",
                                        order.getTotalAmount()) %>
                            </td>

                            <td>
                                <%= order.getPaymentMethod() == null
                                        ? "N/A" : order.getPaymentMethod() %>
                            </td>

                            <td>
                                <span class="status-badge status-<%= paymentClass %>">
                                    <%= paymentStatus.replace('_', ' ') %>
                                </span>
                            </td>

                            <td>
                                <span class="status-badge status-<%= orderClass %>">
                                    <%= orderStatus.replace('_', ' ') %>
                                </span>
                            </td>

                            <td>
                                <%= order.getCreatedAt() == null
                                        ? "N/A" : order.getCreatedAt() %>
                            </td>

                            <td>
                                <form class="update-form"
                                      method="post"
                                      action="${pageContext.request.contextPath}/admin/orders">

                                    <input type="hidden"
                                           name="orderId"
                                           value="<%= order.getOrderId() %>">

                                    <label for="status-<%= order.getOrderId() %>"
                                           style="display:block; margin-bottom:6px; font-size:12px; font-weight:700;">
                                        New status
                                    </label>

                                    <select class="status-select"
                                            id="status-<%= order.getOrderId() %>"
                                            name="orderStatus"
                                            required>

                                        <% for (String status : statuses) {
                                            boolean selected =
                                                    status.equalsIgnoreCase(current);
                                        %>
                                            <option value="<%= status %>"
                                                <%= selected ? "selected" : "" %>>
                                                <%= status %>
                                            </option>
                                        <% } %>

                                    </select>

                                    <button class="update-button" type="submit">
                                        Update Status
                                    </button>
                                </form>
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