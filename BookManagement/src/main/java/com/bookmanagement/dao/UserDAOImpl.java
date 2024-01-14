package com.bookmanagement.dao;

import com.bookmanagement.model.Address;
import com.bookmanagement.model.User;
import com.bookmanagement.utility.ConnectionManager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    private final Connection connection;

    public UserDAOImpl() {
        this.connection = ConnectionManager.getConnection();
    }

    @Override
    public Object[] registration(User user) {
        String email = user.getEmail();
        User existingUser = findUserByEmail(email);
        Object[] objects = new Object[2];

        if (existingUser != null) {
            objects[0] = false;
            objects[1] = "Account Already Exists";

        } else {
            String addressQuery = "INSERT INTO address (addressId, city, state, pinCode) VALUES (?, ?, ?, ?)";
            String userQuery = "INSERT INTO user (userId, name, email, password, phone, addressId) VALUES (?, ?, ?, ?, ?, ?)";

            Address address = user.getAddress();
            int nextId = findLargestAddressId() + 1;

            try {
                connection.setAutoCommit(false);

                PreparedStatement addressStatement = connection.prepareStatement(addressQuery);
                addressStatement.setInt(1, nextId);
                addressStatement.setString(2, address.getCity());
                addressStatement.setString(3, address.getState());
                addressStatement.setInt(4, address.getPinCode());
                addressStatement.executeUpdate();

                PreparedStatement userStatement = connection.prepareStatement(userQuery);
                userStatement.setInt(1, nextId);
                userStatement.setString(2, user.getName());
                userStatement.setString(3, email);
                userStatement.setString(4, user.getPassword());
                userStatement.setString(5, user.getPhone());
                userStatement.setInt(6, nextId);
                userStatement.executeUpdate();

                connection.commit();
                objects[0] = true;
                objects[1] = "Registration Successful";

            } catch (SQLException e) {
                objects[0] = false;
                objects[1] = e.getMessage();
            }
        }

        return objects;
    }

    @Override
    public Object[] login(String email, String password) {
        User existingUser = findUserByEmail(email);
        Object[] objects = new Object[3];

        if (existingUser == null) {
            objects[0] = false;
            objects[1] = "Account doesn't exist";
            return objects;

        }
        if (existingUser.getEmail().equals(email) && existingUser.getPassword().equals(password)) {
            objects[0] = true;
            objects[1] = "login successful";
            objects[2] = existingUser;

        } else {
            objects[0] = false;
            objects[1] = "Wrong Password";
        }

        return objects;
    }

    @Override
    public User findUserByEmail(String email) {
        String query = "SELECT u.*, a.* FROM user AS u JOIN address AS a ON u.addressId = a.addressId WHERE u.email = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setString(1, email);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getUser(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    public User findUserById(int userId) {
        String query = "SELECT u.*, a.* FROM user AS u JOIN address AS a ON u.addressId = a.addressId WHERE u.userId = ?";

        return getUserByQuery(userId, query);
    }

    @Override
    public User findUserByBookId(int bookId) {
        String query = "SELECT u.* FROM user AS u JOIN usercart AS uc ON u.userId = uc.userId WHERE uc.bookId = ?";

        return getUserByQuery(bookId, query);
    }

    @Override
    public boolean updateUser(User user) {
        String userSql = "UPDATE user SET name = ?, email = ?, password = ?, phone = ? WHERE userId = ?";

        try {
            PreparedStatement userStatement = connection.prepareStatement(userSql);

            userStatement.setString(1, user.getName());
            userStatement.setString(2, user.getEmail());
            userStatement.setString(3, user.getPassword());
            userStatement.setString(4, user.getPhone());
            userStatement.setInt(5, user.getUserId());
            int userRowsUpdated = userStatement.executeUpdate();

            Address address = user.getAddress();
            if (address != null) {
                String addressSql = "UPDATE address SET city = ?, state = ?, pinCode = ? WHERE addressId = ?";

                PreparedStatement addressStatement = connection.prepareStatement(addressSql);
                addressStatement.setString(1, address.getCity());
                addressStatement.setString(2, address.getState());
                addressStatement.setInt(3, address.getPinCode());
                addressStatement.setInt(4, user.getUserId());
                int addressRowsUpdated = addressStatement.executeUpdate();

                return userRowsUpdated > 0 && addressRowsUpdated > 0;
            }
            return userRowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteUser(int userId) {
        try {
            String orderBooksSql = "DELETE FROM orderbooks WHERE orderId IN (SELECT orderId FROM orders WHERE userId = ?)";
            try (PreparedStatement orderBooksStatement = connection.prepareStatement(orderBooksSql)) {
                orderBooksStatement.setInt(1, userId);
                orderBooksStatement.executeUpdate();
            }

            String ordersSql = "DELETE FROM orders WHERE userId = ?";
            try (PreparedStatement ordersStatement = connection.prepareStatement(ordersSql)) {
                ordersStatement.setInt(1, userId);
                ordersStatement.executeUpdate();
            }

            String userCartSql = "DELETE FROM usercart WHERE userId = ?";
            try (PreparedStatement userCartStatement = connection.prepareStatement(userCartSql)) {
                userCartStatement.setInt(1, userId);
                userCartStatement.executeUpdate();
            }

            String userSql = "DELETE FROM user WHERE userId = ?";
            try (PreparedStatement userStatement = connection.prepareStatement(userSql)) {
                userStatement.setInt(1, userId);
                int rowsAffected = userStatement.executeUpdate();
                return rowsAffected > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public boolean deleteAddressById(int addressId) {
        String query = "DELETE FROM address WHERE addressId = ?";

        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, addressId);

            int rowsDeleted = statement.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM user AS u INNER JOIN address AS a ON u.addressId = a.addressId";

        try {
            PreparedStatement preparedStatement = connection.prepareStatement(sql);

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                userList.add(getUser(resultSet));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return userList;
    }

    private int findLargestAddressId() {
        int largestAddressId = 0;
        String sql = "SELECT MAX(a.addressId) AS largest_address_id FROM address AS a";

        try {
            PreparedStatement statement = connection.prepareStatement(sql);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt("largest_address_id");
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return largestAddressId;
    }

    private User getUser(ResultSet resultSet) throws SQLException {
        User user = new User();
        user.setUserId(resultSet.getInt("userId"));
        user.setName(resultSet.getString("name"));
        user.setEmail(resultSet.getString("email"));
        user.setPassword(resultSet.getString("password"));
        user.setPhone(resultSet.getString("phone"));

        Address address = new Address();
        address.setAddressId(resultSet.getInt("addressId"));
        address.setCity(resultSet.getString("city"));
        address.setState(resultSet.getString("state"));
        address.setPinCode(resultSet.getInt("pinCode"));
        user.setAddress(address);

        return user;
    }

    private User getUserByQuery(int userId, String query) {
        try {
            PreparedStatement statement = connection.prepareStatement(query);
            statement.setInt(1, userId);

            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return getUser(resultSet);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}