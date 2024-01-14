<%@ page import="com.bookmanagement.dao.BookDAOImpl" %>
<%@ page import="com.bookmanagement.model.Book" %>
<%@ page import="com.bookmanagement.model.User" %>
<%@ page import="com.bookmanagement.enums.BookType" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Title</title>
    <%@ include file="contents/common.jsp" %>
    <link rel="stylesheet" href="contents/styles.css">
</head>
<body style="background-color: #f0f1f2">
<%@ include file="contents/navbar.jsp" %>
<%@ include file="contents/javascriptcode.jsp" %>

<%
    User user = (User) session.getAttribute("user");
    int book_id = Integer.parseInt(request.getParameter("book_id"));
    Book book = new BookDAOImpl().getBookById(book_id);
%>

<div class="container p-3">
    <div class="row">
        <div class="col-md-6 text-center p-5 border bg-white">
            <img src="book/<%= book.getPhotoName() %>" width="150px" height="190px" alt="">
            <h5>Book Name: <%= book.getBookName() %>
            </h5>
            <h5>Author: <%= book.getAuthor() %>
            </h5>
            <h5>Category: <%= book.getBookType() %>
            </h5>
        </div>
        <div class="col-md-6 text-center p-5 border bg-white">
            <h2><%= book.getBookName() %>
            </h2>
            <%if (book.getBookType() == BookType.OLD && book.getTempEmail() != null) {%>
            <h5>Contact To Seller</h5>
            <h5 class="text-primary"><i class="fa-regular fa-envelope"></i> <%= book.getTempEmail() %>
            </h5>
            <%} else if (book.getBookType() == BookType.OLD) {%>
            <h5>Contact To Seller</h5>
            <h5 class="text-primary"><i class="fa-regular fa-envelope"></i> Not Available</h5>
            <%}%>

            <div class="row m-3">
                <div class="col-md-4 text-danger text-center">
                    <i class="fa-solid fa-sack-dollar fa-2x"></i>
                    <p>Cash On Delivery</p>
                </div>
                <div class="col-md-4 text-danger text-center">
                    <i class="fa-solid fa-rotate-left fa-2x"></i>
                    <p>Return Available</p>
                </div>
                <div class="col-md-4 text-danger text-center">
                    <i class="fa-solid fa-truck fa-2x"></i>
                    <p>Free Shipping</p>
                </div>
            </div>

            <%if (book.getBookType() == BookType.OLD) {%>
            <div class="text-center p-3">
                <a href="index.jsp" class="btn btn-success"><i class="fa-solid fa-cart-shopping"></i> Continue Shopping</a>
                <a href="" class="btn btn-danger"><i class="fa-solid fa-indian-rupee-sign"></i> <%= book.getPrice() %>
                </a>
            </div>
            <%} else {%>
            <div class="text-center p-3">
                <%if (user == null) {%>
                <a href="login.jsp" class="btn btn-danger"><i class="fa-solid fa-cart-plus"></i> Add</a>
                <%} else {%>
                <a href="addToCart?book_id=<%= book_id %>&user_id=<%= user.getUserId() %>&page=view_books"
                   class="btn btn-danger">
                    <i class="fa-solid fa-cart-plus"></i> Add
                </a>
                <%}%>
                <a href="" class="btn btn-success"><i class="fa-solid fa-indian-rupee-sign"></i> <%= book.getPrice() %>
                </a>
            </div>
            <%}%>
        </div>
    </div>
</div>

<%@ include file="contents/footer.jsp" %>
</body>
</html>
