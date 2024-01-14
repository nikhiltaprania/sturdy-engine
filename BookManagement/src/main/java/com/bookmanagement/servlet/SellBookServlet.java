package com.bookmanagement.servlet;

import com.bookmanagement.dao.BookDAO;
import com.bookmanagement.dao.BookDAOImpl;
import com.bookmanagement.enums.BookStatus;
import com.bookmanagement.enums.BookType;
import com.bookmanagement.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;

@WebServlet("/sellBook")
@MultipartConfig
public class SellBookServlet extends HttpServlet {
    private final BookDAO bookDAO = new BookDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        try {
            String bookName = request.getParameter("bookName");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));
            Part part = request.getPart("bookImg");
            String fileName = part.getSubmittedFileName();
            BookType bookType = BookType.valueOf("OLD");
            BookStatus bookStatus = BookStatus.valueOf("AVAILABLE");

            Book book = new Book(bookName, price, author, fileName, bookStatus, bookType);
            book.setTempEmail(request.getParameter("tempEmail"));

            if (bookDAO.addBook(book)) {
                String path = getServletContext().getRealPath("") + "book";
                File file = new File(path);
                part.write(path + File.separator + fileName);
                session.setAttribute("successMessage", "Book Uploaded");
                response.sendRedirect("sell-book.jsp");

            } else {
                session.setAttribute("failedMessage", "Something Went Wrong On Server");
                response.sendRedirect("sell-book.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMessage", e.getMessage());
            response.sendRedirect("sell-book.jsp");
        }
    }
}