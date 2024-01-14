package com.bookmanagement.servlet;

import com.bookmanagement.dao.UserDAO;
import com.bookmanagement.dao.UserDAOImpl;
import com.bookmanagement.model.Address;
import com.bookmanagement.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/register")
public class RegistrationServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String password = request.getParameter("password");
            String check = request.getParameter("checkbox");

            User user = new User(fullName, email, password, phone);
            user.setAddress(new Address());
            Object[] results = userDAO.registration(user);
            boolean result1 = (boolean) results[0];
            String result2 = (String) results[1];

            if (check != null) {
                if (result1) {
                    session.setAttribute("successMessage", result2);
                    response.sendRedirect("register.jsp");

                } else {
                    session.setAttribute("failedMessage", result2);
                    response.sendRedirect("register.jsp");
                }

            } else {
                session.setAttribute("failedMessage", "Please Agree To Create Account");
                response.sendRedirect("register.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMessage", e.getMessage());
            response.sendRedirect("register.jsp");
        }
    }
}