
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.shopsphere.model.CartItem" %>

<%
    List<CartItem> cartItems =
            (List<CartItem>) request.getAttribute("cartItems");

    Double cartTotal = (Double) request.getAttribute("cartTotal");
    if (cartTotal == null) {
        cartTotal = 0.0;
    }

    String message = request.getParameter("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Cart | ShopSphere</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .cart-page {
            max-width: 1100px;
            margin: 35px auto;
        }

        .cart-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
            margin-bottom: 26px;
        }

        .cart-heading h1 {
            margin: 0 0 6px;
        }

        .cart-heading p {
            margin: 0;
        }

        .continue-link {
            display: inline-block;
            padding: 11px 17px;
            background: white;
            border: 1px solid #dedcf5;
            border-radius: 9px;
            font-weight: 600;
        }

        .cart-notice {
            padding: 14px 17px;
            border-radius: 10px;
            margin-bottom: 18px;
            font-weight: 500;
        }

        .cart-notice.success {
            color: #16764f;
            background: #e8f8ef;
            border: 1px solid #c8eed8;
        }

        .cart-notice.error {
            color: #b52d3b;
            background: #fff0f1;
            border: 1px solid #f4d0d4;
        }

        .cart-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 290px;
            gap: 24px;
            align-items: start;
        }

        .cart-items-panel,
        .order-summary,
        .empty-cart {
            background: white;
            border: 1px solid #e5e7f0;
            border-radius: 15px;
            box-shadow: 0 8px 28px rgba(35, 32, 90, 0.06);
        }

        .cart-items-panel {
            padding: 22px;
            min-width: 0;
        }

        .cart-items-panel h2,
        .order-summary h2 {
            margin-top: 0;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
            box-shadow: none;
            margin: 0;
        }

        .cart-table th {
            background: #f5f3ff;
            color: #4d438f;
            font-size: 12px;
            text-transform: uppercase;
        }

        .cart-table th,
        .cart-table td {
            padding: 16px 10px;
            border-bottom: 1px solid #ececf4;
            vertical-align: middle;
        }

        .cart-table tbody tr:last-child td {
            border-bottom: none;
        }

        .cart-product-name {
            font-weight: 700;
            color: #292b43;
        }

        .cart-price {
            font-weight: 600;
            white-space: nowrap;
        }

        .quantity-form {
            display: flex;
            align-items: center;
            gap: 7px;
            min-width: 155px;
        }

        .quantity-form input {
            width: 68px;
            min-width: 0;
            padding: 9px 6px;
            text-align: center;
        }

        .quantity-form button,
        .remove-form button {
            margin: 0;
            padding: 9px 11px;
            font-size: 13px;
        }

        .remove-form button {
            background: #fff0f1;
            color: #c13745;
        }

        .remove-form button:hover {
            background: #ffe0e3;
            color: #a31f2d;
        }

        .order-summary {
            padding: 23px;
            position: sticky;
            top: 20px;
        }

        .summary-line {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            padding: 13px 0;
            border-bottom: 1px solid #ececf4;
        }

        .summary-total {
            font-size: 19px;
            font-weight: 750;
            color: #5141cb;
            border-bottom: none;
            padding-top: 20px;
        }

        .checkout-button {
            display: block;
            text-align: center;
            margin-top: 18px;
            padding: 14px 12px;
            border-radius: 10px;
            background: #5b4bdb;
            color: white;
            font-weight: 700;
        }

        .checkout-button:hover {
            background: #4435b5;
            color: white;
        }

        .secure-note {
            text-align: center;
            font-size: 12px;
            margin: 14px 0 0;
        }

        .empty-cart {
            text-align: center;
            padding: 55px 20px;
        }

        .empty-cart-icon {
            font-size: 55px;
            margin-bottom: 10px;
        }

        .empty-cart h2 {
            margin-bottom: 8px;
        }

        .empty-cart .btn {
            margin-top: 12px;
        }

        @media (max-width: 850px) {
            .cart-layout {
                grid-template-columns: 1fr;
            }

            .order-summary {
                position: static;
            }
        }

        @media (max-width: 600px) {
            .cart-page {
                width: 94%;
                margin: 22px auto;
            }

            .cart-items-panel {
                padding: 12px;
            }

            .cart-table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            .cart-heading {
                align-items: flex-start;
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
            <a href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>

    <main class="container cart-page">

        <header class="cart-heading">
            <div>
                <h1>My Shopping Cart</h1>
                <p>Review your items before proceeding to checkout.</p>
            </div>

            <a class="continue-link"
               href="${pageContext.request.contextPath}/products">
                ← Continue Shopping
            </a>
        </header>

        <% if ("added".equals(message)) { %>
            <div class="cart-notice success" role="status">
                ✓ Product added to your cart successfully.
            </div>
        <% } else if ("updated".equals(message)) { %>
            <div class="cart-notice success" role="status">
                ✓ Cart quantity updated successfully.
            </div>
        <% } else if ("removed".equals(message)) { %>
            <div class="cart-notice success" role="status">
                ✓ Product removed from your cart.
            </div>
        <% } else if ("unavailable".equals(message)) { %>
            <div class="cart-notice error" role="alert">
                Unable to complete the action. Please check the product
                stock and requested quantity.
            </div>
        <% } %>

        <% if (cartItems == null || cartItems.isEmpty()) { %>

            <section class="empty-cart">
                <div class="empty-cart-icon">🛒</div>
                <h2>Your cart is empty</h2>
                <p>Looks like you haven't added anything to your cart yet.</p>

                <a class="btn"
                   href="${pageContext.request.contextPath}/products">
                    Explore Products →
                </a>
            </section>

        <% } else { %>

            <div class="cart-layout">

                <section class="cart-items-panel">
                    <h2>Your Items</h2>

                    <table class="cart-table">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Subtotal</th>
                                <th>Action</th>
                            </tr>
                        </thead>

                        <tbody>
                            <% for (CartItem item : cartItems) { %>
                                <tr>
                                    <td>
                                        <span class="cart-product-name">
                                            <%= item.getProduct().getName() %>
                                        </span>
                                    </td>

                                    <td class="cart-price">
                                        ₹<%= String.format(Locale.US, "%.2f",
                                                item.getProduct().getFinalPrice()) %>
                                    </td>

                                    <td>
                                        <form class="quantity-form"
                                              action="${pageContext.request.contextPath}/cart"
                                              method="post">

                                            <input type="hidden"
                                                   name="action"
                                                   value="update">

                                            <input type="hidden"
                                                   name="cartId"
                                                   value="<%= item.getCartId() %>">

                                            <input type="number"
                                                   name="quantity"
                                                   min="1"
                                                   max="<%= item.getProduct().getStock() %>"
                                                   value="<%= item.getQuantity() %>"
                                                   aria-label="Quantity for <%= item.getProduct().getName() %>"
                                                   required>

                                            <button type="submit">Update</button>
                                        </form>
                                    </td>

                                    <td class="cart-price">
                                        ₹<%= String.format(Locale.US, "%.2f",
                                                item.getSubtotal()) %>
                                    </td>

                                    <td>
                                        <form class="remove-form"
                                              action="${pageContext.request.contextPath}/cart"
                                              method="post">

                                            <input type="hidden"
                                                   name="action"
                                                   value="remove">

                                            <input type="hidden"
                                                   name="cartId"
                                                   value="<%= item.getCartId() %>">

                                            <button type="submit">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </section>

                <aside class="order-summary">
                    <h2>Order Summary</h2>

                    <div class="summary-line">
                        <span>Items</span>
                        <span><%= cartItems.size() %></span>
                    </div>

                    <div class="summary-line summary-total">
                        <span>Total</span>
                        <span>₹<%= String.format(Locale.US, "%.2f", cartTotal) %></span>
                    </div>

                    <a class="checkout-button"
                       href="${pageContext.request.contextPath}/checkout">
                        Proceed to Checkout →
                    </a>

                    <p class="secure-note">
                        Review your order details before placing your order.
                    </p>
                </aside>

            </div>

        <% } %>

    </main>

</body>
</html>