<%@ page import="com.bookmanagement.dao.BookDAO" %>
<%@ page import="com.bookmanagement.dao.BookDAOImpl" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bookmanagement.model.Book" %>
<%@ page import="com.bookmanagement.model.User" %>
<%@ page import="com.bookmanagement.enums.BookType" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html lang="en">
<head>
    <title>Title</title>
    <%@ include file="contents/common.jsp" %>
    <style>
        .back-img {
            background: url("img/book.jpg") no-repeat;
            height: 75vh;
            width: 100%;
            background-size: cover;
        }

        .card-ho:hover {
            background-color: #fcf7f7;
        }
    </style>
</head>
<body style="background-color: #f7f7f7">
<%@ include file="contents/navbar.jsp" %>

<%
    User user = (User) session.getAttribute("user");
%>

<div class="container-fluid back-img">
    <h2 class="text-center text-white">E-Book Management</h2>
</div>
<hr>
<!--Start Recent Books-->
<div class="container">
    <h3 class="text-center m-3">Recent Books</h3>
    <div class="row">
        <%
            BookDAO bookDAO = new BookDAOImpl();
            List<Book> recentBooks = bookDAO.getRecentBooksWithLimit();
            for (Book book : recentBooks) {%>
        <div class="col-md-3">
            <div class="card card-ho">
                <div class="card-body text-center">
                    <img src="book/<%= book.getPhotoName() %>" alt="book" width="150px">
                    <p><%= book.getBookName() %>
                    </p>
                    <p><%= book.getAuthor() %>
                    </p>
                    <%if (book.getBookType() == BookType.OLD) {%>
                    <p> Category: <%= book.getBookType() %>
                    </p>
                    <div class="row">
                        <a href="view-book.jsp?book_id=<%= book.getBookId() %>" class="btn btn-success btn-sm ml-5"><i
                                class="fa-solid fa-magnifying-glass"></i> View</a>
                        <a href="" class="btn btn-danger btn-sm ml-1"><%= book.getPrice() %> <i
                                class="fa-solid fa-indian-rupee-sign"></i></a>
                    </div>
                    <%} else {%>
                    <p>Category: <%= book.getBookType() %>
                    </p>
                    <div class="row">

                        <%if (user == null) {%>
                        <a href="login.jsp" class="btn btn-danger btn-sm ml-4"><i class="fa-solid fa-cart-plus"></i> Add</a>
                        <%} else {%>
                        <a href="addToCart?book_id=<%= book.getBookId() %>&&user_id=<%= user.getUserId() %>&&page=recent_books"
                           class="btn btn-danger btn-sm ml-4"><i class="fa-solid fa-cart-plus"></i> Add</a>
                        <% }%>

                        <a href="view-book.jsp?book_id=<%= book.getBookId() %>" class="btn btn-success btn-sm ml-1"><i
                                class="fa-solid fa-magnifying-glass"></i> View</a>
                        <a href="" class="btn btn-danger btn-sm ml-1"><%= book.getPrice() %> <i
                                class="fa-solid fa-indian-rupee-sign"></i></a>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <div class="text-center">
        <a href="recent-books.jsp" class="btn btn-danger btn-sm text-white m-3"><i
                class="fa-solid fa-magnifying-glass"></i> View All</a>
    </div>
</div>
<!--End Recent Books-->
<hr>

<!--Start New Books-->
<div class="container">
    <h3 class="text-center m-1">New Books</h3>
    <div class="row">
        <%
            List<Book> newBooks = bookDAO.allAvailableAndNewBooksWithLimit();
            for (Book book : newBooks) {%>
        <div class="col-md-3">
            <div class="card card-ho">
                <div class="card-body text-center">
                    <img src="book/<%= book.getPhotoName() %>" alt="book" width="150px">
                    <p><%= book.getBookName() %>
                    </p>
                    <p><%= book.getAuthor() %>
                    </p>
                    <p>Category: <%= book.getBookType() %>
                    </p>
                    <div class="row">

                        <%if (user == null) {%>
                        <a href="login.jsp" class="btn btn-danger btn-sm ml-4"><i class="fa-solid fa-cart-plus"></i> Add</a>
                        <%} else {%>
                        <a href="addToCart?book_id=<%= book.getBookId() %>&&user_id=<%= user.getUserId() %>&&page=new_books"
                           class="btn btn-danger btn-sm ml-4"><i class="fa-solid fa-cart-plus"></i> Add</a>
                        <% }%>

                        <a href="view-book.jsp?book_id=<%= book.getBookId() %>" class="btn btn-success btn-sm ml-1"><i
                                class="fa-solid fa-magnifying-glass"></i> View</a>
                        <a href="" class="btn btn-danger btn-sm ml-1"><%= book.getPrice() %> <i
                                class="fa-solid fa-indian-rupee-sign"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
    </div>
    <div class="text-center">
        <a href="new-books.jsp" class="btn btn-danger btn-sm text-white m-3"><i
                class="fa-solid fa-magnifying-glass"></i> View All</a>
    </div>
</div>
<!--End New Book-->
<hr>

<!--Start Old Books-->
<div class="container">
    <h3 class="text-center m-1">Old Books</h3>
    <div class="row">
        <%
            List<Book> oldBooks = bookDAO.getAllOldBooksWithLimit();
            for (Book book : oldBooks) {%>
        <div class="col-md-3">
            <div class="card card-ho">
                <div class="card-body text-center">
                    <img src="book/<%= book.getPhotoName() %>" alt="book" width="150px">
                    <p><%= book.getBookName() %>
                    </p>
                    <p><%= book.getAuthor() %>
                    </p>
                    <p>Category: <%= book.getBookType() %>
                    </p>
                    <div class="row">

                        <%if (user == null) {%>
                        <a href="login.jsp" class="btn btn-danger btn-sm ml-4"><i class="fa-solid fa-cart-plus"></i> Add</a>
                        <%} else {%>
                        <a href="addToCart?book_id=<%= book.getBookId() %>&&user_id=<%= user.getUserId() %>&&page=old_books"
                           class="btn btn-danger btn-sm ml-4"><i class="fa-solid fa-cart-plus"></i> Add</a>
                        <%}%>

                        <a href="view-book.jsp?book_id=<%= book.getBookId() %>" class="btn btn-success btn-sm ml-1"><i
                                class="fa-solid fa-magnifying-glass"></i> View</a>
                        <a href="" class="btn btn-danger btn-sm ml-1"><%= book.getPrice() %> <i
                                class="fa-solid fa-indian-rupee-sign"></i></a>
                    </div>
                </div>
            </div>
        </div>
        <%}%>
    </div>

    <div class="text-center">
        <a href="old-books.jsp" class="btn btn-danger btn-sm text-white m-3"><i
                class="fa-solid fa-magnifying-glass"></i> View All</a>
    </div>
</div>
<!--End Old Book-->

<%@ include file="contents/footer.jsp" %>
</body>
</html>