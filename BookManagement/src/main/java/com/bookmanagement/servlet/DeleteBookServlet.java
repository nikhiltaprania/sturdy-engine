package com.bookmanagement.servlet;

import com.bookmanagement.dao.BookDAO;
import com.bookmanagement.dao.BookDAOImpl;
import com.bookmanagement.model.Book;
import com.bookmanagement.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/delete")
public class DeleteBookServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            int bookId = Integer.parseInt(request.getParameter("book_id"));
            Book book = bookDAO.getBookById(bookId);

            User user = (User) session.getAttribute("user");

            if (book.getTempEmail() != null && user.getEmail().equals(book.getTempEmail())) {
                if (bookDAO.deleteBookById(bookId)) {
                    session.setAttribute("successMessage", "Book (ID " + bookId + ") Deleted Successfully");
                    response.sendRedirect("user-uploaded-books.jsp");

                } else {
                    session.setAttribute("failedMessage", "Something Went Wrong");
                    response.sendRedirect("user-uploaded-books.jsp");
                }

            } else {
                if (bookDAO.deleteBookById(bookId)) {
                    session.setAttribute("successMessage", "Book (ID " + bookId + ") Deleted Successfully");
                    response.sendRedirect("admin/all-books.jsp");

                } else {
                    session.setAttribute("failedMessage", "Something Went Wrong");
                    response.sendRedirect("admin/all-books.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMessage", e.getMessage());
            response.sendRedirect("admin/all-books.jsp");
        }
    }
}