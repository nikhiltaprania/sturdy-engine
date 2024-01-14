<%@ page import="com.bookmanagement.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bookmanagement.model.Book" %>
<%@ page import="com.bookmanagement.dao.UserCartDAOImpl" %>
<%@ page import="com.bookmanagement.model.Address" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>User Cart</title>
    <%@ include file="contents/common.jsp" %>
</head>
<body style="background-color: #fcf7f7">
<%@ include file="contents/navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="login.jsp"/>
</c:if>

<c:if test="${not empty message}">
    <h5 class="text-center text-success">${message}</h5>
    <c:remove var="message" scope="session"/>
</c:if>

<div class="container">
    <div class="row p-2">
        <div class="col-md-6">
            <div class="card bg-white">
                <div class="card-body">
                    <h3 class="text-center text-success">Your Selected Item</h3>
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th scope="col">Book Name</th>
                            <th scope="col">Author</th>
                            <th scope="col">Price</th>
                            <th scope="col">Action</th>
                        </tr>
                        </thead>
                        <tbody>

                        <%
                            User user = (User) session.getAttribute("user");
                            Address address = user.getAddress();
                            List<Book> books = new UserCartDAOImpl().getAllBooksOfAUser(user.getUserId());
                            double totalPrice = 0.0;
                            for (Book book : books) {
                                totalPrice += book.getPrice();%>
                        <tr>
                            <th scope="row"><%= book.getBookName() %>
                            </th>
                            <td><%= book.getAuthor() %>
                            </td>
                            <td><%= book.getPrice() %>
                            </td>
                            <td>
                                <a href="removeBook?book-id=<%= book.getBookId() %>&user-id=<%= user.getUserId() %>"
                                   class="btn btn-sm btn-danger">Remove</a>
                            </td>
                        </tr>
                        <%}%>
                        <tr>
                            <th>Total Price</th>
                            <td></td>
                            <td><a href="" class="btn btn-success"><i
                                    class="fa-solid fa-indian-rupee-sign"></i> <%= totalPrice %>
                            </a></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card bg-white">
                <div class="card-body">
                    <h3 class="text-center text-success">Order Details</h3>

                    <form action="processOrder" method="post">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="inputEmail4">Name</label>
                                <input type="text" class="form-control" id="inputEmail4" value="<%= user.getName() %>"
                                       readonly>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="inputEmail2">Email</label>
                                <input type="email" class="form-control" id="inputEmail2" value="<%= user.getEmail() %>"
                                       readonly>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="inputEmail1">Phone</label>
                                <input type="number" class="form-control" id="inputEmail1"
                                       value="<%= user.getPhone() %>" name="phone" required>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="inputPassword1">Total Amount</label>
                                <input type="number" class="form-control" id="inputPassword1" value="<%= totalPrice %>"
                                       name="totalAmount" readonly>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-4">
                                <label for="inputCity">City</label>
                                <input type="text" class="form-control" id="inputCity" value="<%= address.getCity() %>"
                                       name="city" required>
                            </div>
                            <div class="form-group col-md-4">
                                <label for="inputState">State</label>
                                <input type="text" class="form-control" id="inputState"
                                       value="<%= address.getState() %>" name="state" required>
                            </div>
                            <div class="form-group col-md-3">
                                <label for="inputZip">Zip</label>
                                <input type="text" class="form-control" id="inputZip"
                                       value="<%= address.getPinCode() %>" name="pinCode" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="inputState1">Payment Type</label>
                            <select id="inputState1" class="form-control" required>
                                <option value="" disabled selected>Choose...</option>
                                <option>Cash On Delivery</option>
                            </select>
                        </div>

                        <div class="text-center">
                            <%if (totalPrice != 0) {%>
                            <button type="submit" class="btn btn-warning">Order Now</button>
                            <%}%>
                            <a href="index.jsp" class="btn btn-success">Continue Shopping</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="contents/footer.jsp" %>
</body>
</html>
