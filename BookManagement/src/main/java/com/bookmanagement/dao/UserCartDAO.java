package com.bookmanagement.dao;

import com.bookmanagement.model.Book;
import com.bookmanagement.model.Orders;

import java.util.List;

public interface UserCartDAO {
    boolean assignBookToUser(int userId, int bookId);

    boolean deleteABookOfAUser(int userId, int bookId);

    boolean placeOrder(Orders order);

    List<Book> getAllBooksOfAUser(int userId);

    List<Book> booksUploadedByUser(String userEmail);

    List<Orders> getAllOrdersOfAUser(int userId);

    List<Book> getAllBooksByOrderId(int orderId);
}