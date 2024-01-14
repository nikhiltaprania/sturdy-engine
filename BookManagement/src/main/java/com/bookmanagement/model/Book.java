package com.bookmanagement.model;

import com.bookmanagement.enums.BookStatus;
import com.bookmanagement.enums.BookType;

public class Book {
    private int bookId;
    private String bookName;
    private double price;
    private String author;
    private String photoName;
    private BookStatus bookStatus;
    private BookType bookType;
    private String tempEmail;

    public Book() {
    }

    public Book(String bookName, double price, String author, String photoName, BookStatus bookStatus, BookType bookType) {
        this.bookName = bookName;
        this.price = price;
        this.author = author;
        this.photoName = photoName;
        this.bookStatus = bookStatus;
        this.bookType = bookType;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPhotoName() {
        return photoName;
    }

    public void setPhotoName(String photoName) {
        this.photoName = photoName;
    }

    public BookStatus getBookStatus() {
        return bookStatus;
    }

    public void setBookStatus(BookStatus bookStatus) {
        this.bookStatus = bookStatus;
    }

    public BookType getBookType() {
        return bookType;
    }

    public void setBookType(BookType bookType) {
        this.bookType = bookType;
    }

    public String getTempEmail() {
        return tempEmail;
    }

    public void setTempEmail(String tempEmail) {
        this.tempEmail = tempEmail;
    }
}