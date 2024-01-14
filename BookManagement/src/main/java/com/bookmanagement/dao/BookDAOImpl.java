package com.bookmanagement.dao;

import com.bookmanagement.enums.BookStatus;
import com.bookmanagement.enums.BookType;
import com.bookmanagement.model.Book;
import com.bookmanagement.utility.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class BookDAOImpl implements BookDAO {
    private final Connection connection;

    public BookDAOImpl() {
        this.connection = ConnectionManager.getConnection();
    }

    @Override
    public boolean addBook(Book book) {
        PreparedStatement statement;

        try {

            if (book.getTempEmail() == null) {
                String query = "INSERT INTO book (bookName, price, author, photoName, bookStatus, bookType) VALUES (?, ?, ?, ?, ?, ?)";
                statement = connection.prepareStatement(query);

            } else {
                String query = "INSERT INTO book (bookName, price, author, photoName, bookStatus, bookType, tempEmail) VALUES (?, ?, ?, ?, ?, ?, ?)";
                statement = connection.prepareStatement(query);
                statement.setString(7, book.getTempEmail());
            }

            statement.setString(1, book.getBookName());
            statement.setDouble(2, book.getPrice());
            statement.setString(3, book.getAuthor());
            statement.setString(4, book.getPhotoName());
            statement.setString(5, book.getBookStatus().name());
            statement.setString(6, book.getBookType().name());

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Book getBookById(int bookId) {
        String query = "SELECT * FROM book WHERE bookId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, bookId);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getBook(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public boolean updateBook(Book book) {
        String query = "UPDATE book SET bookName = ?, author = ?, price = ?, bookStatus = ?, bookType = ? WHERE bookId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, book.getBookName());
            statement.setString(2, book.getAuthor());
            statement.setDouble(3, book.getPrice());
            statement.setString(4, book.getBookStatus().name());
            statement.setString(5, book.getBookType().name());
            statement.setInt(6, book.getBookId());

            int rowsUpdated = statement.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteBookById(int bookId) {
        String query = "DELETE FROM book WHERE bookId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, bookId);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public Book getBook(ResultSet resultSet) throws SQLException {
        int id = resultSet.getInt("bookId");
        String bookName = resultSet.getString("bookName");
        String author = resultSet.getString("author");
        double price = resultSet.getDouble("price");
        String fileName = resultSet.getString("photoName");
        BookStatus bookStatus = BookStatus.valueOf(resultSet.getString("bookStatus"));
        BookType bookType = BookType.valueOf(resultSet.getString("bookType"));
        String tempEmail = resultSet.getString("tempEmail");

        Book book = new Book(bookName, price, author, fileName, bookStatus, bookType);
        book.setBookId(id);
        if (tempEmail != null) {
            book.setTempEmail(tempEmail);
        }

        return book;
    }

    @Override
    public List<Book> getAllBooks() {
        String query = "SELECT * FROM book";

        return getBookLists(query);
    }

    @Override
    public List<Book> allAvailableAndNewBooksWithLimit() {
        String sql = "SELECT * FROM book WHERE bookStatus = 'AVAILABLE' AND bookType = 'NEW' ORDER BY bookId DESC LIMIT 4";

        return getBookLists(sql);
    }

    @Override
    public List<Book> getRecentBooksWithLimit() {
        String sql = "SELECT * FROM book WHERE bookStatus = 'AVAILABLE' ORDER BY bookId DESC LIMIT 4";

        return getBookLists(sql);
    }

    @Override
    public List<Book> getAllOldBooksWithLimit() {
        String sql = "SELECT * FROM book WHERE bookType = 'OLD' ORDER BY bookId ASC LIMIT 4";

        return getBookLists(sql);
    }

    @Override
    public List<Book> allAvailableAndNewBooks() {
        return getAllBooks().stream().filter(book -> book.getBookStatus() == BookStatus.AVAILABLE && book.getBookType() == BookType.NEW).sorted(Comparator.comparingInt(Book::getBookId).reversed()).toList();
    }

    @Override
    public List<Book> getRecentBooks() {
        return getAllBooks().stream().filter(book -> book.getBookStatus() == BookStatus.AVAILABLE).sorted(Comparator.comparingInt(Book::getBookId).reversed()).toList();
    }

    @Override
    public List<Book> getAllOldBooks() {
        return getAllBooks().stream().filter(book -> book.getBookType() == BookType.OLD).sorted(Comparator.comparingInt(Book::getBookId)).toList();
    }

    @Override
    public List<Book> searchBook(String searchStr) {
        List<Book> booksList = new ArrayList<>();
        String query = "SELECT * FROM book WHERE bookName LIKE ? OR author LIKE ? OR bookType LIKE ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);

            statement.setString(1, "%" + searchStr + "%");
            statement.setString(2, "%" + searchStr + "%");
            statement.setString(3, "%" + searchStr.toUpperCase() + "%");

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                booksList.add(getBook(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return booksList;
    }

    private List<Book> getBookLists(String query) {
        List<Book> books = new ArrayList<>();

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                books.add(getBook(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }
}