
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.shopsphere.model.Product" %>
<%@ page import="java.util.Locale" %>

<%
    Product product = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Product Details | ShopSphere</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        .product-image {
    width: 100%;
    max-width: 420px;
    height: 350px;
    object-fit: contain;
    background: #f8f7ff;
    border-radius: 12px;
    padding: 12px;
}

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
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 16px;
        }

        .brand {
            font-size: 24px;
            font-weight: 800;
            color: #2563eb;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #374151;
            text-decoration: none;
            font-weight: 600;
        }

        .nav-links a:hover,
        .back-link:hover {
            color: #2563eb;
        }

        .page-container {
            width: 92%;
            max-width: 1100px;
            margin: 32px auto;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: #4b5563;
            text-decoration: none;
            font-weight: 600;
        }

        .product-card {
            display: grid;
            grid-template-columns: minmax(0, 1fr) minmax(0, 1.2fr);
            gap: 36px;
            padding: 32px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            box-shadow: 0 8px 28px rgba(15, 23, 42, 0.05);
        }

        .product-visual {
            min-height: 340px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(145deg, #eff6ff, #f8fafc);
            border-radius: 12px;
            font-size: 100px;
        }

        .product-info {
            padding: 8px 0;
        }

        .product-label {
            display: inline-block;
            padding: 7px 12px;
            margin-bottom: 12px;
            border-radius: 20px;
            background: #dbeafe;
            color: #1d4ed8;
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .product-info h1 {
            margin: 0 0 12px;
            color: #111827;
            font-size: 30px;
            line-height: 1.3;
            overflow-wrap: anywhere;
        }

        .brand-name {
            margin-bottom: 20px;
            color: #6b7280;
        }

        .description {
            color: #4b5563;
            line-height: 1.8;
            overflow-wrap: anywhere;
        }

        .price-section {
            margin: 24px 0;
            padding: 20px;
            background: #f8fafc;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
        }

        .final-price {
            color: #111827;
            font-size: 30px;
            font-weight: 800;
        }

        .original-price {
            margin-top: 8px;
            color: #6b7280;
            font-size: 14px;
        }

        .discount {
            display: inline-block;
            margin-left: 8px;
            color: #15803d;
            font-weight: 700;
        }

        .stock {
            margin: 18px 0;
            font-size: 14px;
            font-weight: 700;
        }

        .in-stock {
            color: #15803d;
        }

        .out-stock {
            color: #dc2626;
        }

        .quantity-label {
            display: block;
            margin-bottom: 8px;
            font-size: 14px;
            font-weight: 700;
        }

        .quantity-input {
            width: 100px;
            padding: 11px;
            margin-bottom: 16px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            font-size: 15px;
        }

        .add-button {
            display: block;
            width: 100%;
            padding: 14px 20px;
            background: #2563eb;
            color: #ffffff;
            border: none;
            border-radius: 9px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.2s;
        }

        .add-button:hover {
            background: #1d4ed8;
        }

        .add-button:focus-visible,
        a:focus-visible,
        input:focus-visible {
            outline: 3px solid #93c5fd;
            outline-offset: 3px;
        }

        .unavailable {
            padding: 14px;
            background: #fef2f2;
            color: #b91c1c;
            border-radius: 8px;
            font-weight: 700;
        }

        .not-found {
            padding: 50px 20px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            text-align: center;
        }

        .not-found h1 {
            margin-top: 0;
        }

        .shop-button {
            display: inline-block;
            margin-top: 12px;
            padding: 12px 18px;
            background: #2563eb;
            color: #ffffff;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
        }

        @media (max-width: 700px) {
            .navbar {
                padding: 14px 4%;
            }

            .brand {
                font-size: 21px;
            }

            .nav-links {
                gap: 14px;
                font-size: 14px;
            }

            .page-container {
                width: 94%;
                margin: 22px auto;
            }

            .product-card {
                grid-template-columns: 1fr;
                gap: 22px;
                padding: 18px;
            }

            .product-visual {
                min-height: 220px;
                font-size: 75px;
            }

            .product-info h1 {
                font-size: 25px;
            }

            .final-price {
                font-size: 27px;
            }
        }

        .product-visual img.product-image {
    width: 100%;
    height: 100%;
    max-width: 420px;
    min-height: 220px;
    object-fit: contain;
    padding: 12px;
    display: block;
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

    <a class="back-link"
       href="${pageContext.request.contextPath}/products">
        ← Back to Products
    </a>

    <% if (product == null) { %>

        <section class="not-found">
            <h1>Product Not Found</h1>
            <p>This product may no longer be available.</p>

            <a class="shop-button"
               href="${pageContext.request.contextPath}/products">
                Browse Products
            </a>
        </section>

    <% } else { %>

        <section class="product-card">

            <div class="product-visual">
    <% if (product.getImageUrl() != null
            && !product.getImageUrl().trim().isEmpty()) { %>

        <img class="product-image"
             src="<%= product.getImageUrl() %>"
             alt="<%= product.getName() %>"
             onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">

        <span style="display:none; font-size:75px;">🛍️</span>

    <% } else { %>
        🛍️
    <% } %>
</div>

            <div class="product-info">

                <span class="product-label">Product Details</span>

                <h1><%= product.getName() %></h1>

                <p class="brand-name">
                    <strong>Brand:</strong>
                    <%= product.getBrand() == null
                            || product.getBrand().trim().isEmpty()
                            ? "Not specified" : product.getBrand() %>
                </p>

                <p class="description">
                    <%= product.getDescription() == null
                            || product.getDescription().trim().isEmpty()
                            ? "No description is available for this product."
                            : product.getDescription() %>
                </p>

                <div class="price-section">

                    <div class="final-price">
                        ₹<%= String.format(Locale.US, "%.2f",
                                product.getFinalPrice()) %>
                    </div>

                    <div class="original-price">
                        Original Price:
                        ₹<%= String.format(Locale.US, "%.2f",
                                product.getPrice()) %>

                        <% if (product.getDiscount() > 0) { %>
                            <span class="discount">
                                <%= product.getDiscount() %>% OFF
                            </span>
                        <% } %>
                    </div>

                </div>

                <% if (product.getStock() > 0) { %>

                    <p class="stock in-stock">
                        ✓ In Stock — <%= product.getStock() %> available
                    </p>

                    <form action="${pageContext.request.contextPath}/cart"
                          method="post">

                        <input type="hidden"
                               name="action"
                               value="add">

                        <input type="hidden"
                               name="productId"
                               value="<%= product.getProductId() %>">

                        <label class="quantity-label" for="quantity">
                            Select Quantity
                        </label>

                        <input class="quantity-input"
                               type="number"
                               id="quantity"
                               name="quantity"
                               value="1"
                               min="1"
                               max="<%= product.getStock() %>"
                               required>

                        <button class="add-button" type="submit">
                            Add to Cart
                        </button>

                    </form>

                <% } else { %>

                    <p class="stock out-stock">Currently out of stock</p>

                    <div class="unavailable">
                        This product cannot be added to your cart right now.
                    </div>

                <% } %>

            </div>
        </section>

    <% } %>

</main>

</body>
</html>