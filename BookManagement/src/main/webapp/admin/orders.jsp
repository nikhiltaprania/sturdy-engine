<%@ page import="java.util.List" %>
<%@ page import="com.bookmanagement.model.Orders" %>
<%@ page import="com.bookmanagement.dao.UserCartDAOImpl" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Title</title>
    <%@ include file="common.jsp" %>
</head>
<body>
<%@ include file="navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="container p-1">
    <h3 class="text-center text-primary">Your Orders</h3>
    <table class="table table-striped m-3">
        <thead>
        <tr>
            <th scope="col">Order Id</th>
            <th scope="col">Ordered Date</th>
            <th scope="col">Amount Paid</th>
            <th scope="col">Total Books</th>
            <th scope="col">Payment Mode</th>
            <th scope="col">Action</th>
        </tr>
        </thead>
        <tbody>

        <%
            List<Orders> orders = new UserCartDAOImpl()
                    .getAllOrdersOfAUser(Integer.parseInt(request.getParameter("userId")))
                    .reversed();
            for (Orders order : orders) {%>
        <tr>
            <th><%= order.getOrderId() %>
            </th>
            <td><%= order.getOrderDate() %>
            </td>
            <td><i class="fa-solid fa-indian-rupee-sign"></i> <%= order.getTotalAmount() %>
            </td>
            <td><%= order.getBooks().size() %>
            </td>
            <td>Cash On Delivery</td>
            <td><a href="single-order.jsp?orderId=<%= order.getOrderId() %>" class="btn btn-sm btn-primary"><i
                    class="fa-solid fa-eye"></i> View Order</a></td>
        </tr>
        <%}%>
        </tbody>
    </table>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>