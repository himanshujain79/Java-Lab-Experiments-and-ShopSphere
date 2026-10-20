
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.shopsphere.model.User" %>

<%
    User loggedInUser =
            (User) session.getAttribute("user");

    String displayName = loggedInUser != null
            ? loggedInUser.getName()
            : "Shopper";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShopSphere | Home</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        body {
            background: #f7f7fc;
        }

        .navbar {
            position: sticky;
            top: 0;
            z-index: 10;
            padding: 16px 5%;
        }

        .brand {
            color: #5141cb;
            font-size: 23px;
            font-weight: 800;
            letter-spacing: -0.7px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 8px;
        }

        .nav-links a {
            margin: 0;
            padding: 9px 12px;
            border-radius: 8px;
            color: #454963;
            font-size: 14px;
        }

        .nav-links a:hover {
            background: #f0eeff;
            color: #5141cb;
        }

        .nav-links .logout-link {
            color: #c13745;
        }

        .home-main {
            max-width: 1200px;
            margin: 35px auto;
        }

        .home-hero {
            position: relative;
            overflow: hidden;
            padding: 58px 45px;
            border-radius: 22px;
            color: white;
            background: linear-gradient(120deg, #4030aa, #6655df 60%, #9b8df8);
            box-shadow: 0 16px 40px rgba(73, 55, 189, 0.18);
        }

        .home-hero::after {
            content: "";
            position: absolute;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            right: -55px;
            top: -75px;
            background: rgba(255, 255, 255, 0.09);
            pointer-events: none;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            max-width: 690px;
        }

        .hero-tag {
            display: inline-block;
            padding: 7px 12px;
            border: 1px solid rgba(255, 255, 255, 0.25);
            border-radius: 30px;
            background: rgba(255, 255, 255, 0.12);
            color: #fff;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .home-hero h1 {
            color: white;
            font-size: clamp(30px, 4vw, 45px);
            line-height: 1.2;
            margin: 20px 0 14px;
            overflow-wrap: anywhere;
        }

        .home-hero p {
            color: #efedff;
            font-size: 16px;
            line-height: 1.8;
            max-width: 570px;
        }

        .hero-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 28px;
        }

        .hero-actions a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 13px 20px;
            border-radius: 10px;
            background: white;
            color: #4937bd;
            font-weight: 700;
            transition: transform 0.2s, background 0.2s;
        }

        .hero-actions a:hover {
            transform: translateY(-2px);
            background: #f2efff;
            color: #35258f;
        }

        .hero-actions a.secondary {
            background: rgba(255, 255, 255, 0.08);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.55);
        }

        .hero-actions a.secondary:hover {
            background: rgba(255, 255, 255, 0.18);
        }

        .welcome-section {
            margin-top: 38px;
        }

        .section-heading {
            margin-bottom: 22px;
        }

        .section-heading h2 {
            margin: 0 0 8px;
            font-size: 25px;
        }

        .section-heading p {
            margin: 0;
            color: #737891;
        }

        .home-links {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 22px;
        }

        .home-link-card {
            display: flex;
            flex-direction: column;
            min-height: 235px;
            padding: 25px;
            background: white;
            border: 1px solid #e8e8f2;
            border-radius: 17px;
            box-shadow: 0 7px 24px rgba(35, 32, 90, 0.045);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .home-link-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 14px 32px rgba(35, 32, 90, 0.09);
        }

        .symbol {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 53px;
            height: 53px;
            border-radius: 14px;
            background: #f0eeff;
            font-size: 27px;
        }

        .home-link-card h3 {
            margin: 19px 0 8px;
            font-size: 19px;
        }

        .home-link-card p {
            margin: 0 0 20px;
            color: #737891;
            font-size: 14px;
            line-height: 1.7;
            flex-grow: 1;
        }

        .home-link-card a {
            color: #5141cb;
            font-weight: 700;
            font-size: 14px;
        }

        .home-link-card a:hover {
            color: #35258f;
        }

        .home-footer {
            text-align: center;
            padding: 25px 10px;
            margin-top: 45px;
            color: #85879b;
            border-top: 1px solid #e7e7f0;
            font-size: 13px;
        }

        @media (max-width: 850px) {
            .home-links {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 600px) {
            .navbar {
                align-items: center;
                gap: 12px;
            }

            .nav-links {
                width: 100%;
                gap: 4px;
            }

            .nav-links a {
                padding: 8px;
                font-size: 13px;
            }

            .home-main {
                width: 94%;
                margin: 22px auto;
            }

            .home-hero {
                padding: 34px 23px;
                border-radius: 17px;
            }

            .hero-actions {
                flex-direction: column;
            }

            .hero-actions a {
                width: 100%;
            }

            .home-links {
                grid-template-columns: 1fr;
            }

            .home-link-card {
                min-height: auto;
            }
        }
    </style>
</head>

<body>

    <nav class="navbar">
        <a class="brand"
           href="${pageContext.request.contextPath}/home.jsp">
            ShopSphere<span style="color:#ff8a45;">.</span>
        </a>

        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/products">Products</a>
            <a href="${pageContext.request.contextPath}/cart">My Cart</a>
            <a href="${pageContext.request.contextPath}/orders">My Orders</a>
            <a class="logout-link"
               href="${pageContext.request.contextPath}/logout">Logout</a>
        </div>
    </nav>

    <main class="container home-main">

        <section class="home-hero">
            <div class="hero-content">
                <span class="hero-tag">YOUR SHOPPING DESTINATION</span>

                <h1>Welcome back, <%= displayName %>!</h1>

                <p>
                    Find products you'll love, explore exciting deals,
                    and keep all your shopping in one convenient place.
                    Your next great find is just a click away.
                </p>

                <div class="hero-actions">
                    <a href="${pageContext.request.contextPath}/products">
                        Explore Products &rarr;
                    </a>

                    <a class="secondary"
                       href="${pageContext.request.contextPath}/orders">
                        View My Orders
                    </a>
                </div>
            </div>
        </section>

        <section class="welcome-section">
            <div class="section-heading">
                <h2>Your Shopping Space</h2>
                <p>Everything you need to manage your ShopSphere experience.</p>
            </div>

            <div class="home-links">

                <article class="home-link-card">
                    <div class="symbol" aria-hidden="true">🛍️</div>
                    <h3>Explore Products</h3>
                    <p>
                        Browse our collection and discover products
                        that match your needs.
                    </p>
                    <a href="${pageContext.request.contextPath}/products">
                        Start shopping &rarr;
                    </a>
                </article>

                <article class="home-link-card">
                    <div class="symbol" aria-hidden="true">🛒</div>
                    <h3>Shopping Cart</h3>
                    <p>
                        Review your selected items, adjust quantities,
                        and prepare for checkout.
                    </p>
                    <a href="${pageContext.request.contextPath}/cart">
                        Open my cart &rarr;
                    </a>
                </article>

                <article class="home-link-card">
                    <div class="symbol" aria-hidden="true">📦</div>
                    <h3>My Orders</h3>
                    <p>
                        Review your purchases and check the current
                        status of your orders.
                    </p>
                    <a href="${pageContext.request.contextPath}/orders">
                        View order history &rarr;
                    </a>
                </article>

            </div>
        </section>

        <footer class="home-footer">
            &copy; 2026 ShopSphere. Made for a better shopping experience.
        </footer>

    </main>

</body>
</html>