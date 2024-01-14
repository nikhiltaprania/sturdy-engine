package com.bookmanagement.dao;

import com.bookmanagement.model.User;

import java.util.List;

public interface UserDAO {
    Object[] registration(User user);

    Object[] login(String email, String password);

    User findUserByEmail(String email);

    User findUserById(int userId);

    User findUserByBookId(int bookId);

    boolean updateUser(User user);

    boolean deleteUser(int userId);

    boolean deleteAddressById(int addressId);

    List<User> getAllUsers();
}