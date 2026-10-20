package com.shopsphere.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/home.jsp",
        "/cart",
        "/checkout",
        "/orders",
        "/profile"
})
public class AuthenticationFilter implements Filter {

    @Override
public void doFilter(
        ServletRequest request,
        ServletResponse response,
        FilterChain chain)
        throws IOException, ServletException {

    HttpServletRequest req =
            (HttpServletRequest) request;

    HttpServletResponse res =
            (HttpServletResponse) response;

    // Discourage caching of protected pages
    res.setHeader(
            "Cache-Control",
            "no-cache, no-store, must-revalidate"
    );
    res.setHeader("Pragma", "no-cache");
    res.setDateHeader("Expires", 0);

    HttpSession session =
            req.getSession(false);

    boolean loggedIn =
            session != null &&
            session.getAttribute("user") != null;

    if (loggedIn) {
        chain.doFilter(request, response);
    } else {
        res.sendRedirect(
                req.getContextPath() + "/login.jsp"
        );
    }
}

}