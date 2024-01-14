<%@ page import="com.bookmanagement.dao.BookDAOImpl" %>
<%@ page import="com.bookmanagement.model.Book" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bookmanagement.model.User" %>
<%@ page import="com.bookmanagement.enums.BookType" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Recent Books</title>
    <%@ include file="contents/common.jsp" %>
    <link rel="stylesheet" href="contents/styles.css">
</head>
<body>
<%@ include file="contents/navbar.jsp" %>
<%@ include file="contents/javascriptcode.jsp" %>

<div class="container-fluid">
    <div class="row">
        <%
            String searchStr = request.getParameter("ch");
            User user = (User) session.getAttribute("user");
            List<Book> searchedBooks = new BookDAOImpl().searchBook(searchStr);
            for (Book book : searchedBooks) {%>
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
                        <a href="view-book.jsp?book_id=<%= book.getBookId() %>" class="btn btn-success btn-sm ml-5"><i class="fa-solid fa-magnifying-glass"></i> View</a>
                        <a href="" class="btn btn-danger btn-sm ml-1"><%= book.getPrice() %> <i
                                class="fa-solid fa-indian-rupee-sign"></i></a>
                    </div>
                    <%} else {%>
                    <p>Category: <%= book.getBookType() %>
                    </p>
                    <div class="row">

                        <%if(user == null) {%>
                        <a href="login.jsp" class="btn btn-danger btn-sm ml-4"><i class="fa-solid fa-cart-plus"></i> Add</a>
                        <%}else {%>
                        <a href="addToCart?book_id=<%= book.getBookId() %>&user_id=<%= user.getUserId() %>&page=recent_books" class="btn btn-danger btn-sm ml-4"><i class="fa-solid fa-cart-plus"></i> Add</a>
                        <%}%>

                        <a href="view-book.jsp?book_id=<%= book.getBookId() %>" class="btn btn-success btn-sm ml-1"><i class="fa-solid fa-magnifying-glass"></i> View</a>
                        <a href="" class="btn btn-danger btn-sm ml-1"><%= book.getPrice() %> <i
                                class="fa-solid fa-indian-rupee-sign"></i></a>
                    </div>
                    <%}%>
                </div>
            </div>
        </div>
        <%}%>
    </div>
</div>

<%@ include file="contents/footer.jsp" %>
</body>
</html>
