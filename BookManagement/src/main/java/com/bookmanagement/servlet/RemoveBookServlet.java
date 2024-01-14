package com.bookmanagement.servlet;

import com.bookmanagement.dao.UserCartDAO;
import com.bookmanagement.dao.UserCartDAOImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/removeBook")
public class RemoveBookServlet extends HttpServlet {
    private final UserCartDAO userCartDAO = new UserCartDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("user-id"));
        int bookId = Integer.parseInt(request.getParameter("book-id"));

        HttpSession session = request.getSession();

        if (userCartDAO.deleteABookOfAUser(userId, bookId)) {
            session.setAttribute("message", "Book (ID " + bookId + ") Removed From Cart");
            response.sendRedirect("payment-page.jsp");

        } else {
            session.setAttribute("message", "Something Went Wrong");
            response.sendRedirect("payment-page.jsp");
        }
    }
}