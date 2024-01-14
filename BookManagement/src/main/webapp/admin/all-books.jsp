<%@ page import="java.util.List" %>
<%@ page import="com.bookmanagement.model.Book" %>
<%@ page import="com.bookmanagement.dao.BookDAOImpl" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>All Books</title>
    <%@ include file="common.jsp" %>
</head>
<body>
<%@ include file="navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="../login.jsp"/>
</c:if>

<h3 class="text-center">Hello Admin</h3>

<c:if test="${not empty successMessage}">
    <h5 class="text-center text-success">${successMessage}</h5>
    <c:remove var="successMessage" scope="session"/>
</c:if>

<c:if test="${not empty failedMessage}">
    <h5 class="text-center text-danger">${failedMessage}</h5>
    <c:remove var="failedMessage" scope="session"/>
</c:if>

<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">Book ID</th>
        <th scope="col">Image</th>
        <th scope="col">Book Name</th>
        <th scope="col">Author Name</th>
        <th scope="col">Book Price</th>
        <th scope="col">Categories</th>
        <th scope="col">Book Status</th>
        <th scope="col">Actions</th>
    </tr>
    </thead>
    <tbody>
    <%
        List<Book> books = new BookDAOImpl().getAllBooks();
        for (Book book : books) {%>

    <tr>
        <th><%= book.getBookId() %>
        </th>
        <td><img src="../book/<%= book.getPhotoName() %>" alt="Book Image" width="90px" height="120px"></td>
        <td><%= book.getBookName() %>
        </td>
        <td><%= book.getAuthor() %>
        </td>
        <td><%= book.getPrice() %>
        </td>
        <td><%= book.getBookType() %>
        </td>
        <td><%= book.getBookStatus() %>
        </td>
        <td>
            <a href="edit-book.jsp?book_id=<%= book.getBookId() %>" class="btn btn-sm btn-primary"><i
                    class="fa-solid fa-file-pen"></i> Edit</a>
            <a href="../delete?book_id=<%= book.getBookId() %>" class="btn btn-sm btn-danger"> <i
                    class="fa-solid fa-trash-can"></i> Delete</a>
        </td>
    </tr>

    <%}%>
    </tbody>
</table>

<%@ include file="footer.jsp" %>
</body>
</html>
