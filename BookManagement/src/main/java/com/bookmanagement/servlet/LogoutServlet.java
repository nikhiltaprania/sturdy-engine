package com.bookmanagement.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session2 = request.getSession();
        try {
            HttpSession session1 = request.getSession();
            session1.removeAttribute("user");

            session2.setAttribute("successMessage", "Logout Successfully");
            response.sendRedirect("login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            session2.setAttribute("successMessage", e.getMessage());
            response.sendRedirect("login.jsp");
        }
    }
}