<%@ page import="com.bookmanagement.model.Book" %>
<%@ page import="com.bookmanagement.dao.BookDAOImpl" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Add Books</title>
    <%@ include file="common.jsp" %>
</head>
<body>
<%@ include file="navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="../login.jsp"/>
</c:if>

<div class="container">
    <div class="row">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="text-center">Edit Book</h4>


                    <%
                        int book_id = Integer.parseInt(request.getParameter("book_id"));
                        Book book = new BookDAOImpl().getBookById(book_id);
                    %>

                    <form action="../editBook" method="post">
                        <input type="hidden" name="book_id" value="<%= book_id %>">

                        <div class="form-group">
                            <label for="exampleInputEmail1">Book Name</label>
                            <input name="bookName" type="text" class="form-control" id="exampleInputEmail1"
                                   aria-describedby="emailHelp" value="<%= book.getBookName() %>">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputName1">Author Name</label>
                            <input name="author" type="text" class="form-control" id="exampleInputName1"
                                   aria-describedby="emailHelp" value="<%= book.getAuthor() %>">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputPassword1">Price</label>
                            <input name="price" type="number" class="form-control" id="exampleInputPassword1"
                                   aria-describedby="emailHelp" value="<%= book.getPrice() %>">
                        </div>

                        <div class="form-group">
                            <label for="inputState">Book Categories</label>
                            <select id="inputState" class="form-control" name="bookType" required>
                                <option value="" disabled selected>--Select--</option>
                                <option value="NEW">New</option>
                                <option value="OLD">Old</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="inputStates">Book Status</label>
                            <select id="inputStates" class="form-control" name="bookStatus" required>
                                <option value="" disabled selected>--Select--</option>
                                <option value="AVAILABLE">Available</option>
                                <option value="UNAVAILABLE">Unavailable</option>
                            </select>
                        </div>

                        <button type="submit" class="btn btn-primary">Edit</button>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>