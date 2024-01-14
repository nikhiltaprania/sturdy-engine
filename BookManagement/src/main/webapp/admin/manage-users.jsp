<%@ page import="java.util.List" %>
<%@ page import="com.bookmanagement.model.User" %>
<%@ page import="com.bookmanagement.dao.UserDAOImpl" %>
<%@ page import="com.bookmanagement.dao.UserCartDAO" %>
<%@ page import="com.bookmanagement.dao.UserCartDAOImpl" %>
<%@ page import="com.bookmanagement.model.Address" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Manage Users</title>
    <%@ include file="common.jsp" %>
</head>
<body>
<%@ include file="navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="../login.jsp"/>
</c:if>

<h3 class="text-center">All Registered Users</h3>
<c:if test="${not empty message}">
    <h5 class="text-center text-success">${message}</h5>
    <c:remove var="message" scope="session"/>
</c:if>

<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">User ID</th>
        <th scope="col">Name</th>
        <th scope="col">Email</th>
        <th scope="col">Address</th>
        <th scope="col">Phone</th>
        <th scope="col">No. Of Orders</th>
        <th scope="col">Action</th>
    </tr>
    </thead>
    <tbody>
    <%
        UserCartDAO userCartDAO = new UserCartDAOImpl();
        List<User> users = new UserDAOImpl().getAllUsers();

        for (User user : users) {%>
    <tr>
        <td><%= user.getUserId() %>
        </td>
        <td><%= user.getName() %>
        </td>
        <td><%= user.getEmail() %>
        </td>
        <%
            Address address = user.getAddress();
            if (address.getCity() == null) {%>
        <td>User hasn't updated the profile</td>
        <%} else {%>
        <td><%= address.getFullAddress() %>
        </td>
        <%}%>
        <td><%= user.getPhone() %>
        </td>
        <td><a href="orders.jsp?userId=<%= user.getUserId() %>"
               class="btn btn-sm btn-success"><%= userCartDAO.getAllOrdersOfAUser(user.getUserId()).size() %> <i
                class="fa-solid fa-eye"></i></a></td>
        <td><a href="../deleteUser?userId=<%= user.getUserId() %>" class="btn btn-sm btn-danger">Delete</a></td>
    </tr>
    <%}%>
    </tbody>
</table>

<%@ include file="footer.jsp" %>
</body>
</html>