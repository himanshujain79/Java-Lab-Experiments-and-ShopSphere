
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="com.shopsphere.model.Product" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopSphere | Products</title>

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
            color: #5141cb;
            font-size: 24px;
            font-weight: 800;
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: #374151;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
        }

        .nav-links a:hover {
            color: #5141cb;
        }

        .container {
            width: 92%;
            max-width: 1250px;
            margin: 32px auto;
        }

        .products-header {
            background: linear-gradient(135deg, #5141cb, #8878f5);
            color: #ffffff;
            padding: 38px;
            border-radius: 16px;
            margin-bottom: 30px;
            box-shadow: 0 8px 24px rgba(81, 65, 203, 0.14);
        }

        .products-header h1 {
            color: #ffffff;
            margin: 0 0 10px;
            font-size: 32px;
            line-height: 1.3;
        }

        .products-header p {
            color: #f0edff;
            margin: 0;
            line-height: 1.7;
        }

        .section-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }

        .section-heading h2 {
            margin: 0;
            color: #111827;
            font-size: 22px;
        }

        .product-count {
            color: #6b7280;
            font-size: 14px;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 24px;
        }

        .product-card {
            min-width: 0;
            display: flex;
            flex-direction: column;
            padding: 20px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 14px;
            box-shadow: 0 5px 20px rgba(35, 32, 90, 0.04);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 28px rgba(35, 32, 90, 0.10);
        }

        .product-icon {
    height: 190px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: #f8f7ff;
    border-radius: 11px;
    overflow: hidden;
    margin-bottom: 18px;
    font-size: 60px;
}

.product-icon img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    display: block;
}

        .product-brand {
            color: #777a94;
            font-size: 13px;
            margin: 0 0 7px;
            overflow-wrap: anywhere;
        }

        .product-name {
            color: #111827;
            font-size: 18px;
            line-height: 1.45;
            margin: 0 0 10px;
            overflow-wrap: anywhere;
        }

        .product-description {
    color: #6b7280;
    font-size: 14px;
    line-height: 1.65;
    margin: 0 0 14px;
    overflow-wrap: anywhere;
    flex-grow: 1;

    /* Standard property */
    line-clamp: 3;

    /* Browser compatibility */
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

        .product-pricing {
            border-top: 1px solid #e5e7f0;
            padding-top: 15px;
            margin-top: auto;
        }

        .product-final-price {
            color: #5141cb;
            font-size: 23px;
            font-weight: 800;
            line-height: 1.5;
        }

        .product-original-price {
            color: #888ba0;
            text-decoration: line-through;
            font-size: 13px;
            font-weight: 400;
            margin-left: 5px;
        }

        .discount-badge {
            display: inline-block;
            background: #e4f8ed;
            color: #16865c;
            padding: 5px 9px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 700;
            margin-top: 8px;
        }

        .stock-label {
            font-size: 13px;
            margin: 14px 0;
            font-weight: 600;
        }

        .in-stock {
            color: #16865c;
        }

        .out-of-stock {
            color: #d94352;
        }

        .details-button {
            display: block;
            text-align: center;
            margin-top: auto;
            padding: 12px;
            border-radius: 9px;
            background: #5141cb;
            color: #ffffff;
            font-weight: 700;
            text-decoration: none;
            transition: background 0.2s;
        }

        .details-button:hover {
            background: #4031ad;
            color: #ffffff;
        }

        .empty-products {
            background: #ffffff;
            padding: 48px 20px;
            text-align: center;
            border: 1px solid #e5e7eb;
            border-radius: 15px;
        }

        .empty-icon {
            font-size: 48px;
            margin-bottom: 12px;
        }

        .empty-products h2 {
            color: #111827;
            margin: 0 0 10px;
        }

        .empty-products p {
            color: #6b7280;
            line-height: 1.6;
        }

        .shop-button {
            display: inline-block;
            margin-top: 10px;
            padding: 11px 18px;
            background: #5141cb;
            color: #ffffff;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 700;
        }

        a:focus-visible {
            outline: 3px solid #a5b4fc;
            outline-offset: 3px;
        }

        @media (max-width: 950px) {
            .product-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 18px;
            }
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

            .container {
                width: 94%;
                margin: 22px auto;
            }

            .products-header {
                padding: 25px 21px;
            }

            .products-header h1 {
                font-size: 25px;
            }

            .product-grid {
                grid-template-columns: 1fr;
            }

            .product-icon {
                height: 190px;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a class="brand"
       href="${pageContext.request.contextPath}/home.jsp">
        ShopSphere
    </a>

    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/products">Products</a>
        <a href="${pageContext.request.contextPath}/cart">My Cart</a>
        <a href="${pageContext.request.contextPath}/orders">My Orders</a>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</nav>

<main class="container">

    <section class="products-header">
        <h1>Discover Your Next Favourite</h1>
        <p>Explore our collection and find something you love.</p>
    </section>

    <%
        List<Product> products =
                (List<Product>) request.getAttribute("products");
    %>

    <% if (products != null && !products.isEmpty()) { %>

        <div class="section-heading">
            <h2>Explore Products</h2>
            <span class="product-count">
                <%= products.size() %>
                <%= products.size() == 1 ? "product" : "products" %>
            </span>
        </div>

        <div class="product-grid">

            <% for (Product product : products) { %>

                <article class="product-card">

                   <div class="product-icon">
    <% if (product.getImageUrl() != null
            && !product.getImageUrl().trim().isEmpty()) { %>

        <img
            src="<%= product.getImageUrl() %>"
            alt="<%= product.getName() %>"
            onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">

        <span style="display:none;">🛍️</span>

    <% } else { %>
        🛍️
    <% } %>
</div>

                    <p class="product-brand">
                        <%= product.getBrand() == null
                                || product.getBrand().trim().isEmpty()
                                ? "ShopSphere Collection"
                                : product.getBrand() %>
                    </p>

                    <h2 class="product-name">
                        <%= product.getName() %>
                    </h2>

                    <p class="product-description">
                        <%= product.getDescription() == null
                                || product.getDescription().trim().isEmpty()
                                ? "Discover this product from ShopSphere."
                                : product.getDescription() %>
                    </p>

                    <div class="product-pricing">

                        <div class="product-final-price">
                            ₹<%= String.format(Locale.US, "%.2f",
                                    product.getFinalPrice()) %>

                            <% if (product.getDiscount() > 0) { %>
                                <span class="product-original-price">
                                    ₹<%= String.format(Locale.US, "%.2f",
                                            product.getPrice()) %>
                                </span>
                            <% } %>
                        </div>

                        <% if (product.getDiscount() > 0) { %>
                            <span class="discount-badge">
                                <%= product.getDiscount() %>% OFF
                            </span>
                        <% } %>

                    </div>

                    <% if (product.getStock() > 0) { %>
                        <p class="stock-label in-stock">
                            ✓ In stock: <%= product.getStock() %>
                        </p>
                    <% } else { %>
                        <p class="stock-label out-of-stock">
                            Currently out of stock
                        </p>
                    <% } %>

                    <a class="details-button"
                       href="${pageContext.request.contextPath}/product?id=<%= product.getProductId() %>">
                        View Details →
                    </a>

                </article>

            <% } %>

        </div>

    <% } else { %>

        <section class="empty-products">
            <div class="empty-icon">🛍️</div>
            <h2>No Products Available</h2>
            <p>There are no products to display right now. Please check back later.</p>

            <a class="shop-button"
               href="${pageContext.request.contextPath}/home.jsp">
                Back to Home
            </a>
        </section>

    <% } %>

</main>

</body>
</html>