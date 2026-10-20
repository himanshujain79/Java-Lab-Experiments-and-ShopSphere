
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.shopsphere.model.Order" %>

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Orders | ShopSphere</title>

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
            background: #ffffff;
            border-bottom: 1px solid #e5e7eb;
            padding: 16px 6%;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        .brand {
            color: #2563eb;
            font-size: 24px;
            font-weight: 800;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 18px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #374151;
            text-decoration: none;
            font-weight: 600;
        }

        .nav-links a:hover {
            color: #2563eb;
        }

        .page-container {
            width: 92%;
            max-width: 1200px;
            margin: 36px auto;
        }

        .page-heading {
            margin-bottom: 24px;
        }

        .page-heading h1 {
            margin: 0 0 8px;
            font-size: 30px;
            color: #111827;
        }

        .page-heading p {
            margin: 0;
            color: #6b7280;
            line-height: 1.6;
        }

        .orders-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            padding: 24px;
            box-shadow: 0 5px 20px rgba(15, 23, 42, 0.04);
        }

        .table-wrapper {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            min-width: 850px;
            border-collapse: collapse;
        }

        th {
            background: #f8fafc;
            color: #4b5563;
            font-size: 13px;
            text-align: left;
            padding: 15px 12px;
            border-bottom: 1px solid #e5e7eb;
            white-space: nowrap;
        }

        td {
            padding: 16px 12px;
            border-bottom: 1px solid #eef0f4;
            font-size: 14px;
            vertical-align: middle;
        }

        tbody tr:hover {
            background: #fafbff;
        }

        tbody tr:last-child td {
            border-bottom: none;
        }

        .order-id {
            color: #2563eb;
            font-weight: 700;
        }

        .amount {
            font-weight: 700;
            white-space: nowrap;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
            background: #f3f4f6;
            color: #374151;
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

        .status-placed,
        .status-pending,
        .status-online_pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-processing,
        .status-shipped,
        .status-cod {
            background: #dbeafe;
            color: #1d4ed8;
        }

        .details-link {
            display: inline-block;
            color: #2563eb;
            font-weight: 700;
            text-decoration: none;
            white-space: nowrap;
        }

        .details-link:hover {
            text-decoration: underline;
        }

        .empty-state {
            text-align: center;
            padding: 48px 20px;
        }

        .empty-icon {
            font-size: 46px;
            margin-bottom: 12px;
        }

        .empty-state h2 {
            margin: 0 0 10px;
            font-size: 22px;
            color: #111827;
        }

        .empty-state p {
            margin: 0 0 22px;
            color: #6b7280;
            line-height: 1.6;
        }

        .primary-button {
            display: inline-block;
            background: #2563eb;
            color: #ffffff;
            padding: 12px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
        }

        .primary-button:hover {
            background: #1d4ed8;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #2563eb;
            text-decoration: none;
            font-weight: 600;
        }

        @media (max-width: 600px) {
            .navbar {
                padding: 14px 4%;
            }

            .brand {
                font-size: 21px;
            }

            .nav-links {
                gap: 12px;
                font-size: 14px;
            }

            .page-container {
                width: 94%;
                margin: 24px auto;
            }

            .page-heading h1 {
                font-size: 25px;
            }

            .orders-card {
                padding: 14px;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a class="brand"
       href="${pageContext.request.contextPath}/home.jsp">ShopSphere</a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/products">Shop</a>
        <a href="${pageContext.request.contextPath}/cart">My Cart</a>
        <a href="${pageContext.request.contextPath}/orders">My Orders</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<main class="page-container">

    <div class="page-heading">
        <h1>My Orders</h1>
        <p>View your purchases, payment information, and delivery status.</p>
    </div>

    <section class="orders-card">

        <% if (orders == null || orders.isEmpty()) { %>

            <div class="empty-state">
                <div class="empty-icon">📦</div>
                <h2>No orders yet</h2>
                <p>Your orders will appear here once you complete a purchase.</p>

                <a class="primary-button"
                   href="${pageContext.request.contextPath}/products">
                    Start Shopping
                </a>
            </div>

        <% } else { %>

            <div class="table-wrapper">
                <table>
                    <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Order Date</th>
                        <th>Total Amount</th>
                        <th>Payment Method</th>
                        <th>Payment Status</th>
                        <th>Order Status</th>
                        <th>Details</th>
                    </tr>
                    </thead>

                    <tbody>
                    <% for (Order order : orders) {
                        String paymentStatus = order.getPaymentStatus() == null
                                ? "UNKNOWN" : order.getPaymentStatus();

                        String orderStatus = order.getOrderStatus() == null
                                ? "UNKNOWN" : order.getOrderStatus();

                        String paymentClass = paymentStatus
                                .toLowerCase(Locale.ROOT)
                                .replaceAll("[^a-z0-9_-]", "");

                        String orderClass = orderStatus
                                .toLowerCase(Locale.ROOT)
                                .replaceAll("[^a-z0-9_-]", "");
                    %>

                        <tr>
                            <td class="order-id">
                                #<%= order.getOrderId() %>
                            </td>

                            <td>
                                <%= order.getCreatedAt() %>
                            </td>

                            <td class="amount">
                                ₹<%= String.format(Locale.US, "%.2f",
                                        order.getTotalAmount()) %>
                            </td>

                            <td>
                                <%= order.getPaymentMethod() == null
                                        ? "—" : order.getPaymentMethod() %>
                            </td>

                            <td>
                                <span class="status status-<%= paymentClass %>">
                                    <%= paymentStatus.replace('_', ' ') %>
                                </span>
                            </td>

                            <td>
                                <span class="status status-<%= orderClass %>">
                                    <%= orderStatus.replace('_', ' ') %>
                                </span>
                            </td>

                            <td>
                                <a class="details-link"
                                   href="${pageContext.request.contextPath}/orders?id=<%= order.getOrderId() %>">
                                    View Details →
                                </a>
                            </td>
                        </tr>

                    <% } %>
                    </tbody>
                </table>
            </div>

        <% } %>

    </section>

    <a class="back-link"
       href="${pageContext.request.contextPath}/products">
        ← Continue Shopping
    </a>

</main>

</body>
</html>