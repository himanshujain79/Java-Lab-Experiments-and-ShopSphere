
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.shopsphere.model.Order" %>
<%@ page import="com.shopsphere.model.OrderItem" %>

<%
    Order order = (Order) request.getAttribute("order");

    List<OrderItem> items =
            (List<OrderItem>) request.getAttribute("orderItems");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details | ShopSphere</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        body {
            background: #f6f6fc;
        }

        .order-page {
            max-width: 1000px;
            margin: 35px auto;
        }

        .order-success {
            padding: 27px;
            margin-bottom: 25px;
            border: 1px solid #c8eed8;
            border-radius: 17px;
            background: linear-gradient(120deg, #e8f8ef, #f5fff8);
        }

        .success-icon {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 45px;
            height: 45px;
            margin-bottom: 12px;
            border-radius: 50%;
            background: #d1f3df;
            color: #16865c;
            font-size: 25px;
            font-weight: 800;
        }

        .order-success h1 {
            margin: 0 0 8px;
            color: #176b4c;
            font-size: 28px;
        }

        .order-success p {
            margin: 0;
            color: #3b765d;
        }

        .order-number {
            margin-top: 15px !important;
            font-weight: 700;
        }

        .order-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.5fr) minmax(250px, 1fr);
            gap: 22px;
            align-items: start;
        }

        .order-card {
            padding: 25px;
            margin-bottom: 22px;
            border: 1px solid #e6e6f0;
            border-radius: 16px;
            background: white;
            box-shadow: 0 7px 24px rgba(35, 32, 90, 0.05);
        }

        .order-card h2 {
            margin: 0 0 20px;
            font-size: 20px;
        }

        .order-info-line {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 15px;
            padding: 12px 0;
            border-bottom: 1px solid #eeeeF5;
        }

        .order-info-line:last-child {
            border-bottom: none;
        }

        .info-label {
            color: #737891;
            font-size: 14px;
        }

        .info-value {
            text-align: right;
            font-weight: 650;
            overflow-wrap: anywhere;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 11px;
            border-radius: 20px;
            background: #eeecff;
            color: #5141cb;
            font-size: 12px;
            font-weight: 750;
        }

        .address-box {
            padding: 16px;
            border-radius: 11px;
            background: #f7f6ff;
            line-height: 1.8;
            overflow-wrap: anywhere;
        }

        .address-box p {
            margin: 0;
            color: #454963;
        }

        .items-card {
            margin-top: 22px;
        }

        .order-items-table {
            width: 100%;
            border-collapse: collapse;
            margin: 0;
            box-shadow: none;
        }

        .order-items-table th {
            padding: 13px 12px;
            background: #f0eeff;
            color: #5141a0;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .order-items-table td {
            padding: 15px 12px;
            border-bottom: 1px solid #ececf4;
        }

        .order-items-table tbody tr:last-child td {
            border-bottom: none;
        }

        .item-name {
            font-weight: 650;
            color: #292b43;
        }

        .money {
            white-space: nowrap;
            font-weight: 600;
        }

        .order-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            padding-top: 20px;
            margin-top: 15px;
            border-top: 2px solid #e7e4ff;
            font-size: 19px;
            font-weight: 750;
        }

        .order-total strong {
            color: #5141cb;
            white-space: nowrap;
        }

        .order-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 25px;
        }

        .order-actions a {
            display: inline-block;
            padding: 12px 18px;
            border-radius: 9px;
            background: #5b4bdb;
            color: white;
            font-weight: 650;
        }

        .order-actions a:hover {
            background: #4435b5;
            color: white;
        }

        .order-actions a.secondary {
            background: white;
            border: 1px solid #dedcf5;
            color: #5141cb;
        }

        .order-actions a.secondary:hover {
            background: #f0eeff;
        }

        @media (max-width: 760px) {
            .order-grid {
                grid-template-columns: 1fr;
            }

            .order-page {
                width: 94%;
                margin: 22px auto;
            }
        }

        @media (max-width: 520px) {
            .order-card {
                padding: 17px;
            }

            .order-success {
                padding: 22px;
            }

            .order-items-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            .order-actions {
                flex-direction: column;
            }

            .order-actions a {
                text-align: center;
            }
        }
    </style>
</head>

<body>

    <nav class="navbar">
        <a href="${pageContext.request.contextPath}/home.jsp">
            ShopSphere
        </a>

        <div>
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">My Cart</a>
            <a href="${pageContext.request.contextPath}/orders">My Orders</a>
        </div>
    </nav>

    <main class="container order-page">

        <% if ("1".equals(request.getParameter("placed"))) { %>
            <section class="order-success" role="status">
                <div class="success-icon" aria-hidden="true">✓</div>
                <h1>Order placed successfully!</h1>
                <p>
                    Thank you for shopping with ShopSphere.
                    Your order details are shown below.
                </p>

                <p class="order-number">
                    Order #<%= order.getOrderId() %>
                </p>
            </section>
        <% } else { %>
            <section class="order-card">
                <h1>Order Details</h1>
                <p>Review your order information and delivery details.</p>
            </section>
        <% } %>

        <div class="order-grid">

            <section class="order-card">
                <h2>Order Information</h2>

                <div class="order-info-line">
                    <span class="info-label">Order Number</span>
                    <span class="info-value">
                        #<%= order.getOrderId() %>
                    </span>
                </div>

                <div class="order-info-line">
                    <span class="info-label">Order Date</span>
                    <span class="info-value">
                        <%= order.getCreatedAt() %>
                    </span>
                </div>

                <div class="order-info-line">
                    <span class="info-label">Order Status</span>
                    <span class="status-badge">
                        <%= order.getOrderStatus() %>
                    </span>
                </div>

                <div class="order-info-line">
                    <span class="info-label">Payment Method</span>
                    <span class="info-value">
                        <%= order.getPaymentMethod() %>
                    </span>
                </div>

                <div class="order-info-line">
                    <span class="info-label">Payment Status</span>
                    <span class="info-value">
                        <%= order.getPaymentStatus() %>
                    </span>
                </div>
            </section>

            <section class="order-card">
                <h2>Delivery Address</h2>

                <div class="address-box">
                    <p><strong>Delivery location</strong></p>
                    <p><%= order.getAddressLine() %></p>
                    <p>
                        <%= order.getCity() %>,
                        <%= order.getState() %> -
                        <%= order.getPincode() %>
                    </p>
                </div>
            </section>

        </div>

        <section class="order-card items-card">
            <h2>Items in Your Order</h2>

            <% if (items != null && !items.isEmpty()) { %>

                <table class="order-items-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Unit Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                        </tr>
                    </thead>

                    <tbody>
                        <% for (OrderItem item : items) { %>
                            <tr>
                                <td class="item-name">
                                    <%= item.getProductName() %>
                                </td>

                                <td class="money">
                                    ₹<%= String.format(Locale.US, "%.2f",
                                            item.getPrice()) %>
                                </td>

                                <td>
                                    <%= item.getQuantity() %>
                                </td>

                                <td class="money">
                                    ₹<%= String.format(Locale.US, "%.2f",
                                            item.getSubtotal()) %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>

            <% } else { %>
                <p>Order item details are currently unavailable.</p>
            <% } %>

            <div class="order-total">
                <span>Order Total</span>
                <strong>
                    ₹<%= String.format(Locale.US, "%.2f",
                            order.getTotalAmount()) %>
                </strong>
            </div>
        </section>

        <div class="order-actions">
            <a href="${pageContext.request.contextPath}/orders">
                View All Orders
            </a>

            <a class="secondary"
               href="${pageContext.request.contextPath}/products">
                Continue Shopping
            </a>
        </div>

    </main>

</body>
</html>