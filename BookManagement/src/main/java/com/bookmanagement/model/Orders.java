package com.bookmanagement.model;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class Orders {
    private int orderId;
    private Date orderDate;
    private double totalAmount;
    private User user = new User();
    private List<Book> books = new ArrayList<>();

    public Orders() {
    }

    public Orders(Date orderDate, double totalAmount) {
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Book> getBooks() {
        return books;
    }

    public void setBooks(List<Book> books) {
        this.books = books;
    }
}