<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>User Setting</title>
    <%@ include file="contents/common.jsp" %>
    <style>
        a {
            text-decoration: none;
            color: black;
        }

        a:hover {
            text-decoration: none;
        }
    </style>
</head>
<body style="background-color: floralwhite">
<%@ include file="contents/navbar.jsp" %>

<c:if test="${empty user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="container">
    <c:if test="${not empty user}">
        <h3 class="text-center m-2 text-dark">Hello! ${user.name}</h3>
    </c:if>
    <div class="row">
        <div class="col-md-4">
            <a href="sell-book.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="text-primary">
                            <i class="fa-solid fa-book fa-3x"></i>
                        </div>
                        <h3>Sell Old Book</h3>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="user-uploaded-books.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="text-dark">
                            <i class="fa-solid fa-book-atlas fa-3x"></i>
                        </div>
                        <h3>Your Uploaded Books</h3>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4">
            <a href="edit-profile.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="text-success">
                            <i class="fa-solid fa-shield-halved fa-3x"></i>
                        </div>
                        <h3>Secure Account</h3>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4 mt-3">
            <a href="user-address.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="text-warning">
                            <i class="fa-solid fa-location-dot fa-3x"></i>
                        </div>
                        <h3>Your Address</h3>
                        <p>Edit Address</p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4 mt-3">
            <a href="user-orders.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="text-danger">
                            <i class="fa-solid fa-box fa-3x"></i>
                        </div>
                        <h3>My Orders</h3>
                        <p>Track Your Order</p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-4 mt-3">
            <a href="">
                <div class="card">
                    <div class="card-body text-center">
                        <div class="text-primary">
                            <i class="fa-regular fa-circle-user fa-3x"></i>
                        </div>
                        <h3>Help Center</h3>
                        <p>24*7 Service</p>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<%@ include file="contents/footer.jsp" %>
</body>
</html>
