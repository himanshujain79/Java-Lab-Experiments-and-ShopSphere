
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | ShopSphere</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: #f6f6fc;
        }

        .login-nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            padding: 18px 6%;
            background: white;
            border-bottom: 1px solid #e8e8f2;
        }

        .login-brand {
            color: #5141cb;
            font-size: 25px;
            font-weight: 800;
            letter-spacing: -0.7px;
        }

        .login-nav a:last-child {
            font-weight: 650;
        }

        .login-main {
            width: 100%;
            max-width: 470px;
            margin: auto;
            padding: 35px 20px;
        }

        .login-card {
            padding: 35px;
            border: 1px solid #e7e7f0;
            border-radius: 20px;
            background: white;
            box-shadow: 0 14px 40px rgba(35, 32, 90, 0.08);
        }

        .login-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 58px;
            height: 58px;
            border-radius: 16px;
            background: #f0eeff;
            font-size: 29px;
            margin-bottom: 20px;
        }

        .login-card h1 {
            margin: 0 0 10px;
            font-size: 29px;
            letter-spacing: -0.5px;
        }

        .login-subtitle {
            color: #737891;
            margin: 0 0 25px;
            line-height: 1.7;
        }

        .login-error {
            padding: 13px 15px;
            margin-bottom: 20px;
            border: 1px solid #f2cbd0;
            border-radius: 10px;
            background: #fff0f1;
            color: #b52d3b;
            font-size: 14px;
            line-height: 1.5;
        }

        .login-form label {
            display: block;
            margin: 17px 0 7px;
            font-size: 14px;
            font-weight: 650;
            color: #454963;
        }

        .login-form input {
            width: 100%;
            max-width: none;
            padding: 13px 14px;
            border: 1px solid #dcddec;
            border-radius: 10px;
            font: inherit;
            background: #fff;
            box-sizing: border-box;
        }

        .login-form input:focus {
            outline: none;
            border-color: #5b4bdb;
            box-shadow: 0 0 0 3px rgba(91, 75, 219, 0.12);
        }

        .password-wrap {
            position: relative;
        }

        .password-wrap input {
            padding-right: 72px;
        }

        .password-toggle {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            margin: 0;
            padding: 5px 7px;
            background: transparent;
            color: #5141cb;
            font-size: 12px;
        }

        .password-toggle:hover {
            background: #f0eeff;
            color: #35258f;
            transform: translateY(-50%);
        }

        .login-button {
            width: 100%;
            margin: 25px 0 0;
            padding: 14px;
            border-radius: 10px;
            background: #5b4bdb;
            font-size: 15px;
            font-weight: 700;
        }

        .login-button:hover {
            background: #4435b5;
        }

        .login-bottom {
            margin-top: 23px;
            padding-top: 20px;
            border-top: 1px solid #ececf4;
            text-align: center;
            font-size: 14px;
            color: #737891;
        }

        .login-bottom p {
            margin: 8px 0;
        }

        .login-bottom a {
            font-weight: 700;
        }

        .login-footer {
            padding: 20px;
            text-align: center;
            color: #85879b;
            font-size: 13px;
        }

        @media (max-width: 480px) {
            .login-main {
                padding: 25px 16px;
            }

            .login-card {
                padding: 25px 21px;
                border-radius: 16px;
            }

            .login-card h1 {
                font-size: 25px;
            }
        }
    </style>
</head>

<body>

    <nav class="login-nav">
        <a class="login-brand"
           href="${pageContext.request.contextPath}/index.jsp">
            ShopSphere<span style="color:#ff8a45;">.</span>
        </a>

        <a href="${pageContext.request.contextPath}/register.jsp">
            Create account
        </a>
    </nav>

    <main class="login-main">

        <section class="login-card">
            <div class="login-icon" aria-hidden="true">🔐</div>

            <h1>Welcome back!</h1>
            <p class="login-subtitle">
                Sign in to continue shopping with ShopSphere.
            </p>

            <%
                String error = request.getParameter("error");
                String message = null;

                if ("invalid".equals(error) || "1".equals(error)) {
                    message = "Invalid email or password. Please try again.";
                } else if ("inactive".equals(error)) {
                    message = "Your account is inactive. Please contact the administrator.";
                }
            %>

            <% if (message != null) { %>
                <div class="login-error" role="alert">
                    <%= message %>
                </div>
            <% } %>

            <form class="login-form"
                  action="${pageContext.request.contextPath}/login"
                  method="post">

                <label for="email">Email address</label>
                <input
                    type="email"
                    id="email"
                    name="email"
                    placeholder="you@example.com"
                    autocomplete="email"
                    required>

                <label for="password">Password</label>
                <div class="password-wrap">
                    <input
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        autocomplete="current-password"
                        required>

                    <button
                        class="password-toggle"
                        type="button"
                        id="togglePassword"
                        aria-controls="password"
                        aria-pressed="false">
                        Show
                    </button>
                </div>

                <button class="login-button" type="submit">
                    Login to ShopSphere →
                </button>
            </form>

            <div class="login-bottom">
                <p>Don't have an account?
                    <a href="${pageContext.request.contextPath}/register.jsp">
                        Create one
                    </a>
                </p>

                <p>
                    <a href="${pageContext.request.contextPath}/index.jsp">
                        ← Back to home
                    </a>
                </p>
            </div>
        </section>

    </main>

    <footer class="login-footer">
        &copy; 2026 ShopSphere. Happy shopping!
    </footer>

    <script>
        const passwordInput = document.getElementById("password");
        const togglePassword = document.getElementById("togglePassword");

        togglePassword.addEventListener("click", function () {
            const isHidden = passwordInput.type === "password";

            passwordInput.type = isHidden ? "text" : "password";
            togglePassword.textContent = isHidden ? "Hide" : "Show";
            togglePassword.setAttribute("aria-pressed", String(isHidden));
        });
    </script>

</body>
</html>