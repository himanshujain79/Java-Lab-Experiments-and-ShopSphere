
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>ShopSphere | Online Shopping</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        body {
            background: #f7f7fc;
        }

        .landing-nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            padding: 18px 6%;
            background: #fff;
            border-bottom: 1px solid #e9e8f2;
        }

        .landing-brand {
            color: #5141cb;
            font-size: 25px;
            font-weight: 800;
            letter-spacing: -0.8px;
        }

        .landing-nav-actions {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 12px;
        }

        .landing-nav-actions a {
            padding: 10px 17px;
            border-radius: 9px;
            font-weight: 650;
        }

        .login-link {
            color: #5141cb;
        }

        .register-link {
            color: white;
            background: #5b4bdb;
        }

        .register-link:hover {
            background: #4435b5;
            color: white;
        }

        .landing-main {
            width: min(1160px, 90%);
            margin: 38px auto;
        }

        .landing-hero {
            position: relative;
            overflow: hidden;
            padding: 75px 55px;
            border-radius: 24px;
            background: linear-gradient(120deg, #4030aa, #6655df 60%, #9b8df8);
            color: white;
            box-shadow: 0 18px 45px rgba(73, 55, 189, 0.18);
        }

        .landing-hero::after {
            content: "";
            position: absolute;
            width: 300px;
            height: 300px;
            top: -95px;
            right: -60px;
            border-radius: 50%;
            background: rgba(255,255,255,0.09);
            pointer-events: none;
        }

        .landing-content {
            position: relative;
            z-index: 1;
            max-width: 670px;
        }

        .landing-label {
            display: inline-block;
            padding: 7px 13px;
            border: 1px solid rgba(255,255,255,0.25);
            border-radius: 30px;
            background: rgba(255,255,255,0.12);
            color: white;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 1px;
        }

        .landing-hero h1 {
            margin: 22px 0 16px;
            color: white;
            font-size: clamp(34px, 5vw, 54px);
            line-height: 1.12;
            letter-spacing: -1.5px;
        }

        .landing-hero p {
            max-width: 560px;
            color: #efedff;
            font-size: 17px;
            line-height: 1.8;
        }

        .landing-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 13px;
            margin-top: 30px;
        }

        .landing-buttons a {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            padding: 14px 21px;
            border-radius: 10px;
            background: white;
            color: #4937bd;
            font-weight: 750;
            transition: transform 0.2s, background 0.2s;
        }

        .landing-buttons a:hover {
            transform: translateY(-2px);
            background: #f1efff;
            color: #35258f;
        }

        .landing-buttons a.outline {
            background: transparent;
            border: 1px solid rgba(255,255,255,0.65);
            color: white;
        }

        .landing-buttons a.outline:hover {
            background: rgba(255,255,255,0.12);
        }

        .features-section {
            padding: 40px 0 10px;
        }

        .features-heading {
            margin-bottom: 24px;
        }

        .features-heading h2 {
            margin-bottom: 8px;
            font-size: 27px;
        }

        .features-heading p {
            margin-top: 0;
            color: #737891;
        }

        .feature-grid {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 22px;
        }

        .feature-card {
            padding: 26px;
            border: 1px solid #e8e8f2;
            border-radius: 17px;
            background: white;
            box-shadow: 0 7px 24px rgba(35, 32, 90, 0.045);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 14px 32px rgba(35, 32, 90, 0.09);
        }

        .feature-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 54px;
            height: 54px;
            border-radius: 15px;
            background: #f0eeff;
            font-size: 28px;
        }

        .feature-card h3 {
            margin: 18px 0 9px;
            font-size: 19px;
        }

        .feature-card p {
            margin: 0;
            color: #737891;
            font-size: 14px;
            line-height: 1.8;
        }

        .landing-footer {
            margin-top: 45px;
            padding: 25px 10px;
            border-top: 1px solid #e7e7f0;
            color: #85879b;
            text-align: center;
            font-size: 13px;
        }

        @media (max-width: 750px) {
            .feature-grid {
                grid-template-columns: 1fr;
            }

            .landing-hero {
                padding: 45px 28px;
            }
        }

        @media (max-width: 500px) {
            .landing-nav {
                align-items: flex-start;
                flex-direction: column;
            }

            .landing-nav-actions {
                width: 100%;
            }

            .landing-nav-actions a {
                padding: 9px 12px;
            }

            .landing-main {
                width: 94%;
                margin: 22px auto;
            }

            .landing-hero {
                padding: 34px 22px;
                border-radius: 17px;
            }

            .landing-buttons {
                flex-direction: column;
            }

            .landing-buttons a {
                width: 100%;
            }
        }
    </style>
</head>

<body>

    <nav class="landing-nav">
        <a class="landing-brand"
           href="${pageContext.request.contextPath}/index.jsp">
            ShopSphere<span style="color:#ff8a45;">.</span>
        </a>

        <div class="landing-nav-actions">
            <a class="login-link"
               href="${pageContext.request.contextPath}/login.jsp">
                Login
            </a>

            <a class="register-link"
               href="${pageContext.request.contextPath}/register.jsp">
                Create Account
            </a>
        </div>
    </nav>

    <main class="landing-main">

        <section class="landing-hero">
            <div class="landing-content">
                <span class="landing-label">
                    YOUR EVERYDAY SHOPPING DESTINATION
                </span>

                <h1>Find what you love.<br>Shop with confidence.</h1>

                <p>
                    Welcome to ShopSphere, your place to explore products,
                    manage your shopping cart, and keep track of your orders
                    in one convenient shopping experience.
                </p>

                <div class="landing-buttons">
                    <a href="${pageContext.request.contextPath}/register.jsp">
                        Get Started &rarr;
                    </a>

                    <a class="outline"
                       href="${pageContext.request.contextPath}/login.jsp">
                        I Already Have an Account
                    </a>
                </div>
            </div>
        </section>

        <section class="features-section">
            <div class="features-heading">
                <h2>A Better Way to Shop</h2>
                <p>Simple tools to make your shopping experience easier.</p>
            </div>

            <div class="feature-grid">

                <article class="feature-card">
                    <div class="feature-icon" aria-hidden="true">🛍️</div>
                    <h3>Discover Products</h3>
                    <p>
                        Explore the available collection and find products
                        that fit your needs.
                    </p>
                </article>

                <article class="feature-card">
                    <div class="feature-icon" aria-hidden="true">🛒</div>
                    <h3>Easy Shopping Cart</h3>
                    <p>
                        Add products, adjust quantities, and review your
                        total before checkout.
                    </p>
                </article>

                <article class="feature-card">
                    <div class="feature-icon" aria-hidden="true">📦</div>
                    <h3>Track Your Orders</h3>
                    <p>
                        Visit your account to review your order history
                        and check order status.
                    </p>
                </article>

            </div>
        </section>

        <footer class="landing-footer">
            &copy; 2026 ShopSphere. Your shopping journey starts here.
        </footer>

    </main>

</body>
</html>