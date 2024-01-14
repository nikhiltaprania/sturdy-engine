package com.bookmanagement.servlet;

import com.bookmanagement.dao.UserDAO;
import com.bookmanagement.dao.UserDAOImpl;
import com.bookmanagement.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            Object[] objects = userDAO.login(request.getParameter("email"), request.getParameter("password"));
            boolean result = (boolean) objects[0];
            String message = (String) objects[1];
            User user = (User) objects[2];

            if (result) {
                if (user.getEmail().equals("admin@gmail.com") && user.getPassword().equals("admin")) {
                    session.setAttribute("user", user);
                    response.sendRedirect("admin/home.jsp");

                } else {
                    session.setAttribute("user", user);
                    response.sendRedirect("index.jsp");
                }

            } else {
                session.setAttribute("failedMessage", message);
                response.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMessage", e.getMessage());
            response.sendRedirect("login.jsp");
        }
    }
}