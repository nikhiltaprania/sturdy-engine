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

<div class="container p-2">
    <div class="row">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="text-center">Login</h4>
                    <c:if test="${not empty failedMessage}">
                        <p class="text-center text-danger">${failedMessage}</p>
                        <c:remove var="failedMessage" scope="session"/>
                    </c:if>
                    <c:if test="${not empty successMessage}">
                        <p class="text-center text-success">${successMessage}</p>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>

                    <form action="login" method="post">
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" class="form-control" id="exampleInputEmail1"
                                   aria-describedby="emailHelp" placeholder="Enter email" required name="email">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" class="form-control" id="exampleInputPassword1"
                                   placeholder="Password" required name="password">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-primary">Login</button>
                            <br>
                            Don't have an account ? <a href="register.jsp">register here</a>
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
