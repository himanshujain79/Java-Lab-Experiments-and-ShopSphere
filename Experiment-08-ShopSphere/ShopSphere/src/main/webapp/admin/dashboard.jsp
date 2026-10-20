
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>

<%
    NumberFormat currency =
            NumberFormat.getCurrencyInstance(new Locale("en", "IN"));

    Object salesAttribute = request.getAttribute("totalSales");
    double sales = salesAttribute instanceof Number
            ? ((Number) salesAttribute).doubleValue() : 0.0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | ShopSphere</title>

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
            max-width: 1300px;
            margin: 30px auto;
        }

        .welcome-banner {
            padding: 30px;
            border-radius: 15px;
            background: linear-gradient(135deg, #5141cb, #8878f5);
            color: #ffffff;
            box-shadow: 0 8px 24px rgba(81, 65, 203, 0.14);
        }

        .welcome-banner h1 {
            margin: 0 0 10px;
            color: #ffffff;
            font-size: 30px;
            line-height: 1.3;
        }

        .welcome-banner p {
            margin: 0;
            color: #f0edff;
            font-size: 15px;
            line-height: 1.7;
        }

        .section-heading {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin: 32px 0 18px;
        }

        .section-heading h2 {
            margin: 0;
            color: #111827;
            font-size: 22px;
        }

        .section-subtitle {
            margin: 7px 0 0;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 20px;
        }

        .stat-card {
            min-width: 0;
            padding: 23px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 13px;
            box-shadow: 0 4px 16px rgba(15, 23, 42, 0.035);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 9px 24px rgba(15, 23, 42, 0.07);
        }

        .stat-top {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 10px;
            margin-bottom: 19px;
        }

        .stat-label {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
            font-weight: 600;
            line-height: 1.5;
        }

        .stat-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            width: 43px;
            height: 43px;
            border-radius: 11px;
            background: #f0eeff;
            font-size: 22px;
        }

        .icon-green {
            background: #dcfce7;
        }

        .icon-blue {
            background: #dbeafe;
        }

        .icon-orange {
            background: #ffedd5;
        }

        .icon-red {
            background: #fee2e2;
        }

        .icon-purple {
            background: #f3e8ff;
        }

        .stat-number {
            margin: 0;
            color: #111827;
            font-size: 30px;
            font-weight: 800;
            line-height: 1.35;
            overflow-wrap: anywhere;
        }

        .sales-number {
            font-size: 25px;
        }

        .stat-note {
            display: block;
            margin-top: 8px;
            color: #6b7280;
            font-size: 12px;
            line-height: 1.5;
        }

        .warning-number {
            color: #dc2626;
        }

        .management-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 18px;
            margin-bottom: 35px;
        }

        .management-card {
            display: flex;
            align-items: flex-start;
            gap: 16px;
            padding: 23px;
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 13px;
            text-decoration: none;
            transition: transform 0.2s, border-color 0.2s,
                        box-shadow 0.2s;
        }

        .management-card:hover {
            transform: translateY(-3px);
            border-color: #c7d2fe;
            box-shadow: 0 8px 22px rgba(15, 23, 42, 0.06);
        }

        .management-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            width: 48px;
            height: 48px;
            border-radius: 12px;
            background: #f0eeff;
            font-size: 24px;
        }

        .management-content {
            min-width: 0;
        }

        .management-content h3 {
            margin: 2px 0 8px;
            color: #111827;
            font-size: 16px;
        }

        .management-content p {
            margin: 0;
            color: #6b7280;
            font-size: 13px;
            line-height: 1.7;
        }

        .management-arrow {
            margin-left: auto;
            color: #5141cb;
            font-size: 20px;
        }

        .logout-card .management-icon {
            background: #fee2e2;
        }

        a:focus-visible {
            outline: 3px solid #a5b4fc;
            outline-offset: 3px;
        }

        @media (max-width: 950px) {
            .stats {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
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
                margin: 22px auto;
            }

            .welcome-banner {
                padding: 24px 20px;
            }

            .welcome-banner h1 {
                font-size: 25px;
            }

            .section-heading {
                margin-top: 25px;
            }

            .stats {
                gap: 12px;
            }

            .stat-card {
                padding: 16px;
            }

            .stat-icon {
                width: 36px;
                height: 36px;
                font-size: 19px;
            }

            .stat-number {
                font-size: 25px;
            }

            .sales-number {
                font-size: 21px;
            }

            .management-grid {
                grid-template-columns: 1fr;
                gap: 12px;
            }

            .management-card {
                padding: 18px;
            }
        }

        @media (max-width: 380px) {
            .stats {
                grid-template-columns: 1fr;
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

    <section class="welcome-banner">
        <h1>Admin Dashboard</h1>
        <p>
            Welcome to ShopSphere management. Monitor your store
            and manage products, categories, customers, and orders.
        </p>
    </section>

    <section>
        <div class="section-heading">
            <div>
                <h2>Store Overview</h2>
                <p class="section-subtitle">
                    A quick overview of your store's current activity.
                </p>
            </div>
        </div>

        <div class="stats">

            <article class="stat-card">
                <div class="stat-top">
                    <h3 class="stat-label">Total Products</h3>
                    <div class="stat-icon">📦</div>
                </div>
                <p class="stat-number">${productCount}</p>
                <span class="stat-note">Products in the store</span>
            </article>

            <article class="stat-card">
                <div class="stat-top">
                    <h3 class="stat-label">Active Categories</h3>
                    <div class="stat-icon icon-purple">🗂️</div>
                </div>
                <p class="stat-number">${categoryCount}</p>
                <span class="stat-note">Available product categories</span>
            </article>

            <article class="stat-card">
                <div class="stat-top">
                    <h3 class="stat-label">Active Customers</h3>
                    <div class="stat-icon icon-green">👥</div>
                </div>
                <p class="stat-number">${customerCount}</p>
                <span class="stat-note">Active customer accounts</span>
            </article>

            <article class="stat-card">
                <div class="stat-top">
                    <h3 class="stat-label">Total Orders</h3>
                    <div class="stat-icon icon-blue">🛒</div>
                </div>
                <p class="stat-number">${orderCount}</p>
                <span class="stat-note">Orders recorded in the store</span>
            </article>

            <article class="stat-card">
                <div class="stat-top">
                    <h3 class="stat-label">Low Stock Products</h3>
                    <div class="stat-icon icon-orange">⚠️</div>
                </div>
                <p class="stat-number warning-number">${lowStockCount}</p>
                <span class="stat-note">Products needing stock attention</span>
            </article>

            <article class="stat-card">
                <div class="stat-top">
                    <h3 class="stat-label">Sales Total</h3>
                    <div class="stat-icon icon-green">₹</div>
                </div>
                <p class="stat-number sales-number">
                    <%= currency.format(sales) %>
                </p>
                <span class="stat-note">
                    Excludes cancelled orders; not net profit.
                </span>
            </article>

        </div>
    </section>

    <section>
        <div class="section-heading">
            <div>
                <h2>Store Management</h2>
                <p class="section-subtitle">
                    Select a section to manage your store.
                </p>
            </div>
        </div>

        <div class="management-grid">

            <a class="management-card"
               href="${pageContext.request.contextPath}/admin/products">
                <div class="management-icon">📦</div>
                <div class="management-content">
                    <h3>Product Management</h3>
                    <p>Add, edit, and deactivate products in your store.</p>
                </div>
                <span class="management-arrow" aria-hidden="true">→</span>
            </a>

            <a class="management-card"
               href="${pageContext.request.contextPath}/admin/categories">
                <div class="management-icon">🗂️</div>
                <div class="management-content">
                    <h3>Category Management</h3>
                    <p>Create and maintain your product categories.</p>
                </div>
                <span class="management-arrow" aria-hidden="true">→</span>
            </a>

            <a class="management-card"
               href="${pageContext.request.contextPath}/admin/orders">
                <div class="management-icon">🛒</div>
                <div class="management-content">
                    <h3>Order Management</h3>
                    <p>Review orders and update their status.</p>
                </div>
                <span class="management-arrow" aria-hidden="true">→</span>
            </a>

            <a class="management-card"
               href="${pageContext.request.contextPath}/admin/users">
                <div class="management-icon">👥</div>
                <div class="management-content">
                    <h3>Customer Management</h3>
                    <p>View registered customers and their account status.</p>
                </div>
                <span class="management-arrow" aria-hidden="true">→</span>
            </a>

            <a class="management-card logout-card"
               href="${pageContext.request.contextPath}/logout">
                <div class="management-icon">🚪</div>
                <div class="management-content">
                    <h3>Logout</h3>
                    <p>Securely end your administrator session.</p>
                </div>
                <span class="management-arrow" aria-hidden="true">→</span>
            </a>

        </div>
    </section>

</main>

</body>
</html>