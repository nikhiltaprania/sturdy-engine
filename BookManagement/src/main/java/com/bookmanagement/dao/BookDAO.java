package com.bookmanagement.dao;

import com.bookmanagement.model.Book;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public interface BookDAO {
    boolean addBook(Book book);

    Book getBookById(int bookId);

    boolean updateBook(Book book);

    boolean deleteBookById(int bookId);

    Book getBook(ResultSet resultSet) throws SQLException;

    List<Book> getAllBooks();

    List<Book> allAvailableAndNewBooksWithLimit();

    List<Book> getRecentBooksWithLimit();

    List<Book> getAllOldBooksWithLimit();

    List<Book> allAvailableAndNewBooks();

    List<Book> getRecentBooks();

    List<Book> getAllOldBooks();

    List<Book> searchBook(String searchStr);
}