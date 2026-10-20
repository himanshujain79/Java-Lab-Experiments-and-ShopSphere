
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.shopsphere.model.CartItem" %>

<%
    List<CartItem> items =
            (List<CartItem>) request.getAttribute("cartItems");

    Double total = (Double) request.getAttribute("cartTotal");
    if (total == null) {
        total = 0.0;
    }

    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout | ShopSphere</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .checkout-page {
            max-width: 1100px;
            margin: 35px auto;
        }

        .checkout-heading {
            margin-bottom: 28px;
        }

        .checkout-heading h1 {
            margin-bottom: 8px;
        }

        .checkout-heading p {
            margin-top: 0;
        }

        .checkout-layout {
            display: grid;
            grid-template-columns: minmax(0, 1fr) 340px;
            gap: 25px;
            align-items: start;
        }

        .checkout-panel,
        .summary-panel {
            background: white;
            border: 1px solid #e5e7f0;
            border-radius: 16px;
            padding: 26px;
            box-shadow: 0 8px 28px rgba(35, 32, 90, 0.06);
        }

        .checkout-panel h2,
        .summary-panel h2 {
            margin-top: 0;
            margin-bottom: 20px;
        }

        .checkout-error {
            padding: 14px 17px;
            margin-bottom: 20px;
            border-radius: 10px;
            color: #b52d3b;
            background: #fff0f1;
            border: 1px solid #f4d0d4;
        }

        .checkout-form label {
            display: block;
            margin: 16px 0 7px;
            font-weight: 600;
        }

        .checkout-form input,
        .checkout-form textarea,
        .checkout-form select {
            display: block;
            width: 100%;
            max-width: none;
            padding: 12px 14px;
            border: 1px solid #d9dced;
            border-radius: 9px;
            background: #fff;
            font: inherit;
        }

        .checkout-form textarea {
            min-height: 100px;
            resize: vertical;
        }

        .checkout-form input:focus,
        .checkout-form textarea:focus,
        .checkout-form select:focus {
            outline: none;
            border-color: #5b4bdb;
            box-shadow: 0 0 0 3px rgba(91, 75, 219, 0.12);
        }

        .checkout-form button {
            width: 100%;
            margin: 24px 0 0;
            padding: 14px;
            font-size: 16px;
        }

        .checkout-item {
            padding: 15px 0;
            border-bottom: 1px solid #ececf4;
        }

        .checkout-item:last-child {
            border-bottom: none;
        }

        .checkout-item-name {
            font-weight: 700;
            color: #292b43;
            margin-bottom: 5px;
        }

        .checkout-item-details {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            color: #737891;
            font-size: 14px;
        }

        .checkout-item-price {
            color: #5141cb;
            font-weight: 700;
            white-space: nowrap;
        }

        .checkout-total {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-top: 18px;
            padding-top: 20px;
            border-top: 2px solid #e5e3fa;
            font-size: 19px;
            font-weight: 750;
        }

        .checkout-total strong {
            color: #5141cb;
            white-space: nowrap;
        }

        .checkout-note {
            margin-top: 18px;
            padding: 13px;
            background: #f5f3ff;
            color: #5141a0;
            border-radius: 9px;
            font-size: 13px;
        }

        .checkout-back {
            display: inline-block;
            margin-bottom: 18px;
            font-weight: 600;
        }

        .empty-checkout {
            background: white;
            border: 1px solid #e5e7f0;
            border-radius: 15px;
            padding: 35px;
            text-align: center;
        }

        @media (max-width: 800px) {
            .checkout-layout {
                grid-template-columns: 1fr;
            }

            .summary-panel {
                order: -1;
            }
        }

        @media (max-width: 600px) {
            .checkout-page {
                width: 94%;
                margin: 22px auto;
            }

            .checkout-panel,
            .summary-panel {
                padding: 19px;
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

    <main class="container checkout-page">

        <a class="checkout-back"
           href="${pageContext.request.contextPath}/cart">
            ← Back to Cart
        </a>

        <header class="checkout-heading">
            <h1>Secure Checkout</h1>
            <p>Enter your delivery details and review your order before placing it.</p>
        </header>

        <% if ("address".equals(error)) { %>
            <div class="checkout-error" role="alert">
                Please enter valid delivery details and try again.
            </div>
        <% } else if ("failed".equals(error)) { %>
            <div class="checkout-error" role="alert">
                Checkout failed. Your order was not confirmed.
                Please check product availability and try again.
            </div>
        <% } %>

        <% if (items == null || items.isEmpty()) { %>

            <section class="empty-checkout">
                <h2>Your cart is empty</h2>
                <p>Add some products before proceeding to checkout.</p>

                <a class="btn"
                   href="${pageContext.request.contextPath}/products">
                    Browse Products
                </a>
            </section>

        <% } else { %>

            <div class="checkout-layout">

                <section class="checkout-panel">
                    <h2>Delivery Information</h2>

                    <form class="checkout-form"
                          action="${pageContext.request.contextPath}/checkout"
                          method="post">

                        <label for="addressLine">Street Address</label>
                        <textarea id="addressLine"
                                  name="addressLine"
                                  maxlength="255"
                                  placeholder="House number, street, area"
                                  required></textarea>

                        <label for="city">City</label>
                        <input id="city"
                               name="city"
                               maxlength="100"
                               placeholder="Enter your city"
                               required>

                        <label for="state">State</label>
                        <input id="state"
                               name="state"
                               maxlength="100"
                               placeholder="Enter your state"
                               required>

                        <label for="pincode">PIN Code</label>
                        <input id="pincode"
                               name="pincode"
                               maxlength="10"
                               placeholder="Enter your PIN code"
                               autocomplete="postal-code"
                               required>

                        <label for="addressType">Address Type</label>
                        <select id="addressType" name="addressType">
                            <option value="Home">Home</option>
                            <option value="Work">Work</option>
                            <option value="Other">Other</option>
                        </select>

                        <label for="paymentMethod">Payment Method</label>
                        <select id="paymentMethod"
                                name="paymentMethod"
                                required>
                            <option value="COD">Cash on Delivery</option>
                            <option value="ONLINE_PENDING">
                                Online Payment (not yet integrated)
                            </option>
                        </select>

                        <button type="submit">Place Order →</button>
                    </form>
                </section>

                <aside class="summary-panel">
                    <h2>Order Summary</h2>

                    <% for (CartItem item : items) { %>
                        <div class="checkout-item">
                            <div class="checkout-item-name">
                                <%= item.getProduct().getName() %>
                            </div>

                            <div class="checkout-item-details">
                                <span>Quantity: <%= item.getQuantity() %></span>

                                <span class="checkout-item-price">
                                    ₹<%= String.format(Locale.US, "%.2f",
                                            item.getSubtotal()) %>
                                </span>
                            </div>
                        </div>
                    <% } %>

                    <div class="checkout-total">
                        <span>Cart Total</span>
                        <strong>
                            ₹<%= String.format(Locale.US, "%.2f", total) %>
                        </strong>
                    </div>

                    <div class="checkout-note">
                        Please verify your delivery address and payment method
                        before placing your order.
                    </div>
                </aside>

            </div>

        <% } %>

    </main>

</body>
</html>
