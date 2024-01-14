<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Title</title>
    <%@ include file="contents/common.jsp" %>
</head>
<body>
<%@ include file="contents/navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="container text-center mt-3">
    <i class="fas fa-check-circle fa-5x text-success"></i>
    <h1>Thank You</h1>
    <h3>Your Order Has Been Placed Successfully</h3>
    <h5>Products will be delivered within 7 working days</h5>
    <a href="index.jsp" class="btn btn-primary mt-3">Home</a>
    <a href="user-orders.jsp" class="btn btn-success mt-3">View All Orders</a>
</div>

<%@ include file="contents/footer.jsp" %>
</body>
</html>
