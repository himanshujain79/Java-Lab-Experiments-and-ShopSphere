
<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create Account | ShopSphere</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            background: #f5f7fb;
            color: #1f2937;
            font-family: Arial, Helvetica, sans-serif;
        }

        .navbar {
            background: #ffffff;
            border-bottom: 1px solid #e5e7eb;
            padding: 16px 6%;
        }

        .brand {
            color: #5141cb;
            font-size: 24px;
            font-weight: 800;
            text-decoration: none;
        }

        .page-container {
            width: 92%;
            max-width: 520px;
            margin: 40px auto;
        }

        .register-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 16px;
            padding: 32px;
            box-shadow: 0 10px 30px rgba(35, 32, 90, 0.07);
        }

        .register-heading {
            text-align: center;
            margin-bottom: 28px;
        }

        .register-icon {
            width: 64px;
            height: 64px;
            margin: 0 auto 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #f0eeff;
            border-radius: 16px;
            font-size: 30px;
        }

        .register-heading h1 {
            margin: 0 0 10px;
            color: #111827;
            font-size: 27px;
        }

        .register-heading p {
            margin: 0;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.6;
        }

        .form-group {
            margin-bottom: 19px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #374151;
            font-size: 14px;
            font-weight: 700;
        }

        .form-group input {
            display: block;
            width: 100%;
            min-width: 0;
            padding: 12px 13px;
            border: 1px solid #d1d5db;
            border-radius: 8px;
            background: #ffffff;
            color: #111827;
            font-size: 15px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        .form-group input:focus {
            border-color: #5141cb;
            box-shadow: 0 0 0 3px rgba(81, 65, 203, 0.12);
        }

        .password-wrapper {
            position: relative;
        }

        .password-wrapper input {
            padding-right: 78px;
        }

        .toggle-password {
            position: absolute;
            top: 50%;
            right: 10px;
            transform: translateY(-50%);
            padding: 6px;
            border: none;
            background: transparent;
            color: #5141cb;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
        }

        .register-button {
            display: block;
            width: 100%;
            margin-top: 8px;
            padding: 14px;
            border: none;
            border-radius: 9px;
            background: #5141cb;
            color: #ffffff;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.2s;
        }

        .register-button:hover {
            background: #4031ad;
        }

        .form-footer {
            margin-top: 24px;
            text-align: center;
            color: #6b7280;
            font-size: 14px;
            line-height: 1.8;
        }

        .form-footer a {
            color: #5141cb;
            font-weight: 700;
            text-decoration: none;
        }

        .form-footer a:hover {
            text-decoration: underline;
        }

        .home-link {
            display: block;
            margin-top: 18px;
            text-align: center;
            color: #6b7280;
            font-size: 14px;
            text-decoration: none;
        }

        .home-link:hover {
            color: #5141cb;
        }

        input:focus-visible,
        button:focus-visible,
        a:focus-visible {
            outline: 3px solid #a5b4fc;
            outline-offset: 3px;
        }

        @media (max-width: 500px) {
            .navbar {
                padding: 15px 5%;
            }

            .brand {
                font-size: 22px;
            }

            .page-container {
                width: 94%;
                margin: 25px auto;
            }

            .register-card {
                padding: 23px 19px;
            }

            .register-heading h1 {
                font-size: 24px;
            }
        }
    </style>
</head>

<body>

<nav class="navbar">
    <a class="brand"
       href="${pageContext.request.contextPath}/index.jsp">
        ShopSphere
    </a>
</nav>

<main class="page-container">

    <section class="register-card">

        <div class="register-heading">
            <div class="register-icon" aria-hidden="true">👤</div>
            <h1>Create Your Account</h1>
            <p>Join ShopSphere and discover products you'll love.</p>
        </div>

        <form action="${pageContext.request.contextPath}/register"
              method="post">

            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text"
                       id="name"
                       name="name"
                       placeholder="Enter your full name"
                       autocomplete="name"
                       maxlength="100"
                       required>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email"
                       id="email"
                       name="email"
                       placeholder="you@example.com"
                       autocomplete="email"
                       maxlength="150"
                       required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>

                <div class="password-wrapper">
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="Create a password"
                           autocomplete="new-password"
                           required>

                    <button class="toggle-password"
                            type="button"
                            id="togglePassword"
                            aria-controls="password"
                            aria-pressed="false">
                        Show
                    </button>
                </div>
            </div>

            <div class="form-group">
                <label for="mobile">Mobile Number</label>
                <input type="tel"
                       id="mobile"
                       name="mobile"
                       placeholder="Enter your mobile number"
                       autocomplete="tel"
                       maxlength="15"
                       pattern="[0-9]{10,15}"
                       title="Enter a mobile number containing 10 to 15 digits."
                       required>
            </div>

            <button class="register-button" type="submit">
                Create Account
            </button>

        </form>

        <div class="form-footer">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login.jsp">
                Sign in
            </a>
        </div>

        <a class="home-link"
           href="${pageContext.request.contextPath}/index.jsp">
            ← Back to Home
        </a>

    </section>

</main>

<script>
    const passwordInput = document.getElementById("password");
    const toggleButton = document.getElementById("togglePassword");

    toggleButton.addEventListener("click", function () {
        const isHidden = passwordInput.type === "password";

        passwordInput.type = isHidden ? "text" : "password";
        toggleButton.textContent = isHidden ? "Hide" : "Show";
        toggleButton.setAttribute("aria-pressed", String(isHidden));
    });
</script>

</body>
</html>
