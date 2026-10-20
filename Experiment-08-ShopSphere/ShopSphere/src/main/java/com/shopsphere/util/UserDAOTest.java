package com.shopsphere.util;

import com.shopsphere.dao.UserDAO;
import com.shopsphere.model.User;

public class UserDAOTest {

    public static void main(String[] args) {

        User user = new User();

        user.setName("Test User");
        user.setEmail("test@gmail.com");
        user.setPassword("123456");
        user.setMobile("9876543210");
        user.setRole("CUSTOMER");
        user.setStatus(true);

        UserDAO userDAO = new UserDAO();

        boolean result = userDAO.registerUser(user);

        if (result) {
            System.out.println("User registered successfully!");
        } else {
            System.out.println("User registration failed!");
        }
    }
}