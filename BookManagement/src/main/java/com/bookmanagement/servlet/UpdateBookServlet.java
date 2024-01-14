package com.bookmanagement.servlet;

import com.bookmanagement.dao.BookDAO;
import com.bookmanagement.dao.BookDAOImpl;
import com.bookmanagement.enums.BookStatus;
import com.bookmanagement.enums.BookType;
import com.bookmanagement.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/editBook")
public class UpdateBookServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        try {
            Book book = new Book();
            book.setBookId(Integer.parseInt(request.getParameter("book_id")));
            book.setBookName(request.getParameter("bookName"));
            book.setAuthor(request.getParameter("author"));
            book.setPrice(Double.parseDouble(request.getParameter("price")));
            book.setBookType(BookType.valueOf(request.getParameter("bookType")));
            book.setBookStatus(BookStatus.valueOf(request.getParameter("bookStatus")));

            if (bookDAO.updateBook(book)) {
                session.setAttribute("successMessage", "Book (ID " + book.getBookId() + ") Updated Successfully");
                response.sendRedirect("admin/all-books.jsp");

            } else {
                session.setAttribute("failedMessage", "Failed to update Book (ID " + book.getBookId() + ")");
                response.sendRedirect("admin/all-books.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMessage", e.getMessage());
            response.sendRedirect("admin/all-books.jsp");
        }
    }
}