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

@WebServlet("/addToCart")
public class AddToCartServlet extends HttpServlet {
    private final UserCartDAO userCartDAO = new UserCartDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int bookId = Integer.parseInt(request.getParameter("book_id"));
        int userId = Integer.parseInt(request.getParameter("user_id"));


        HttpSession session = request.getSession();
        boolean isAssigned = userCartDAO.assignBookToUser(userId, bookId);
        String page = request.getParameter("page");

        if (isAssigned) {
            session.setAttribute("message", "Book Added To Cart");
        } else {
            session.setAttribute("message", "Book Already in cart");
        }

        switch (page) {
            case "new_books" -> response.sendRedirect("new-books.jsp");
            case "recent_books" -> response.sendRedirect("recent-books.jsp");
            case "old_books" -> response.sendRedirect("old-books.jsp");
            case "view_books" -> response.sendRedirect("view-book.jsp?book_id=" + bookId);
        }
    }
}