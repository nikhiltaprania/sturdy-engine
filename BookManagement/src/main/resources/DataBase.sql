show databases;
drop database if exists base1;
create database if not exists base1;
use base1;

CREATE TABLE Address
(
    addressId INT PRIMARY KEY,
    city      VARCHAR(255),
    state     VARCHAR(255),
    pinCode   INT
);
CREATE TABLE Book
(
    bookId     INT PRIMARY KEY AUTO_INCREMENT,
    bookName   VARCHAR(255),
    price      DOUBLE,
    author     VARCHAR(255),
    photoName  VARCHAR(255),
    bookStatus ENUM ('AVAILABLE', 'UNAVAILABLE'),
    bookType   ENUM ('NEW', 'OLD'),
    tempEmail  VARCHAR(255)
);
CREATE TABLE User
(
    userId    INT PRIMARY KEY,
    name      VARCHAR(255),
    email     VARCHAR(255),
    password  VARCHAR(255),
    phone     VARCHAR(15),
    addressId INT,
    FOREIGN KEY (addressId) REFERENCES Address (addressId)
);
CREATE TABLE Orders
(
    orderId     INT PRIMARY KEY AUTO_INCREMENT,
    orderDate   DATE,
    totalAmount DOUBLE,
    userId      INT,
    FOREIGN KEY (userId) REFERENCES User (userId)
);
CREATE TABLE UserCart
(
    userId INT,
    bookId INT,
    PRIMARY KEY (userId, bookId),
    FOREIGN KEY (userId) REFERENCES User (userId),
    FOREIGN KEY (bookId) REFERENCES Book (bookId)
);

CREATE TABLE OrderBooks
(
    orderBookId INT PRIMARY KEY AUTO_INCREMENT,
    orderId     INT,
    bookId      INT,
    FOREIGN KEY (orderId) REFERENCES Orders (orderId),
    FOREIGN KEY (bookId) REFERENCES Book (bookId)
);

INSERT INTO Book (bookId, bookName, price, author, photoName, bookStatus, bookType)
VALUES (1, 'The Hobbit', 25.99, 'J.R.R. Tolkien', 'thor.jpg', 'AVAILABLE', 'OLD'),
       (2, 'To Kill a Mockingbird', 15.99, 'Harper Lee', 'thor.jpg', 'AVAILABLE', 'NEW'),
       (3, '1984', 20.99, 'George Orwell', 'thor.jpg', 'AVAILABLE', 'NEW'),
       (4, 'Pride and Prejudice', 18.99, 'Jane Austen', 'thor.jpg', 'AVAILABLE', 'OLD'),
       (5, 'The Catcher in the Rye', 12.99, 'J.D. Salinger', 'thor.jpg', 'UNAVAILABLE', 'NEW'),
       (6, 'The Great Gatsby', 22.99, 'F. Scott Fitzgerald', 'thor.jpg', 'AVAILABLE', 'OLD'),
       (7, 'The Lord of the Rings', 29.99, 'J.R.R. Tolkien', 'thor.jpg', 'AVAILABLE', 'OLD'),
       (8, 'The Alchemist', 19.99, 'Paulo Coelho', 'thor.jpg', 'UNAVAILABLE', 'NEW'),
       (9, 'Brave New World', 21.99, 'Aldous Huxley', 'thor.jpg', 'AVAILABLE', 'NEW'),
       (10, 'The Shining', 17.99, 'Stephen King', 'thor.jpg', 'UNAVAILABLE', 'OLD'),
       (11, 'Harry Potter and the Sorcerer''s Stone', 26.99, 'J.K. Rowling', 'thor.jpg', 'AVAILABLE', 'NEW'),
       (12, 'The Da Vinci Code', 24.99, 'Dan Brown', 'thor.jpg', 'AVAILABLE', 'OLD'),
       (13, 'The Odyssey', 16.99, 'Homer', 'thor.jpg', 'AVAILABLE', 'OLD'),
       (14, 'Moby Dick', 23.99, 'Herman Melville', 'thor.jpg', 'UNAVAILABLE', 'NEW'),
       (15, 'The Road', 18.99, 'Cormac McCarthy', 'thor.jpg', 'AVAILABLE', 'OLD'),
       (16, 'The Hitchhiker''s Guide to the Galaxy', 20.99, 'Douglas Adams', 'thor.jpg', 'AVAILABLE', 'NEW'),
       (17, 'The Divine Comedy', 22.99, 'Dante Alighieri', 'thor.jpg', 'AVAILABLE', 'OLD'),
       (18, 'One Hundred Years of Solitude', 25.99, 'Gabriel García Márquez', 'thor.jpg', 'AVAILABLE', 'NEW'),
       (19, 'Frankenstein', 14.99, 'Mary Shelley', 'thor.jpg', 'UNAVAILABLE', 'OLD'),
       (20, 'The Grapes of Wrath', 19.99, 'John Steinbeck', 'thor.jpg', 'AVAILABLE', 'OLD');

