package com.bookmanagement.utility;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ResourceBundle;

public class ConnectionManager {
    private static final String username;
    private static final String password;
    private static final String url;
    private static Connection connection;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        ResourceBundle bundle = ResourceBundle.getBundle("application");
        username = bundle.getString("db.username");
        password = bundle.getString("db.password");
        url = bundle.getString("db.url");
    }

    public static Connection getConnection() {
        try {
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }

    public static void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}