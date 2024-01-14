package com.bookmanagement.dao;

import com.bookmanagement.enums.BookStatus;
import com.bookmanagement.enums.BookType;
import com.bookmanagement.model.Book;
import com.bookmanagement.model.Orders;
import com.bookmanagement.model.User;
import com.bookmanagement.utility.ConnectionManager;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserCartDAOImpl implements UserCartDAO {
    private final Connection connection;
    private final BookDAO bookDAO;
    private final UserDAO userDAO;

    public UserCartDAOImpl() {
        this.connection = ConnectionManager.getConnection();
        this.bookDAO = new BookDAOImpl();
        this.userDAO = new UserDAOImpl();
    }

    @Override
    public boolean assignBookToUser(int userId, int bookId) {
        String query = "INSERT INTO usercart (userId, bookId) VALUES (?, ?)";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, userId);
            statement.setInt(2, bookId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return false;
    }

    @Override
    public boolean deleteABookOfAUser(int userId, int bookId) {
        String query = "DELETE FROM usercart WHERE userId = ? AND bookId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, userId);
            statement.setInt(2, bookId);

            int rowsAffected = statement.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean placeOrder(Orders order) {
        String orderSql = "INSERT INTO orders (orderDate, totalAmount, userId) VALUES (?, ?, ?)";
        String orderBooksSql = "INSERT INTO orderbooks (orderId, bookId) VALUES (?, ?)";

        try {
            PreparedStatement orderStatement = connection.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            PreparedStatement orderBooksStatement = connection.prepareStatement(orderBooksSql);

            orderStatement.setDate(1, order.getOrderDate());
            orderStatement.setDouble(2, order.getTotalAmount());
            orderStatement.setInt(3, order.getUser().getUserId());
            int rowsInserted = orderStatement.executeUpdate();

            if (rowsInserted > 0) {
                ResultSet generatedKeys = orderStatement.getGeneratedKeys();

                if (generatedKeys.next()) {
                    int orderId = generatedKeys.getInt(1);
                    for (Book book : order.getBooks()) {
                        orderBooksStatement.setInt(1, orderId);
                        orderBooksStatement.setInt(2, book.getBookId());
                        orderBooksStatement.addBatch();
                    }

                    int[] orderBooksRowsInserted = orderBooksStatement.executeBatch();
                    return orderBooksRowsInserted.length > 0;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<Book> getAllBooksOfAUser(int userId) {
        List<Book> books = new ArrayList<>();
        String query = "SELECT b.* FROM book AS b JOIN usercart AS uc ON b.bookId = uc.bookId WHERE uc.userId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, userId);

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                books.add(bookDAO.getBook(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    @Override
    public List<Book> booksUploadedByUser(String userEmail) {
        return bookDAO.getAllOldBooks().stream().filter(book -> (book.getTempEmail() != null && book.getTempEmail().equals(userEmail))).toList();
    }

    @Override
    public List<Orders> getAllOrdersOfAUser(int userId) {
        List<Orders> ordersList = new ArrayList<>();
        String sql = "SELECT * FROM orders WHERE userId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Orders order = new Orders();
                order.setOrderId(resultSet.getInt("orderId"));
                order.setOrderDate(resultSet.getDate("orderDate"));
                order.setTotalAmount(resultSet.getDouble("totalAmount"));

                User user = userDAO.findUserById(userId);
                order.setUser(user);

                List<Book> books = getBooksForOrder(order.getOrderId());
                order.setBooks(books);

                ordersList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return ordersList;
    }

    @Override
    public List<Book> getAllBooksByOrderId(int orderId) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT B.* FROM book AS B JOIN orderbooks AS OB ON B.bookId = OB.bookId WHERE OB.orderId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                books.add(bookDAO.getBook(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }

    private List<Book> getBooksForOrder(int orderId) {
        List<Book> books = new ArrayList<>();
        String query = "SELECT b.* FROM book AS b JOIN orderbooks AS ob ON b.bookId = ob.bookId WHERE ob.orderId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, orderId);

            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Book book = new Book();

                book.setBookId(resultSet.getInt("bookId"));
                book.setBookName(resultSet.getString("bookName"));
                book.setPrice(resultSet.getDouble("price"));
                book.setAuthor(resultSet.getString("author"));
                book.setPhotoName(resultSet.getString("photoName"));
                book.setBookStatus(BookStatus.valueOf(resultSet.getString("bookStatus")));
                book.setBookType(BookType.valueOf(resultSet.getString("bookType")));

                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return books;
    }
}