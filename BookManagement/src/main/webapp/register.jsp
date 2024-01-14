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
                    <h4 class="text-center">Register Here</h4>

                    <c:if test="${not empty successMessage}">
                        <h5 class="text-center text-success">${successMessage}</h5>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>
                    <c:if test="${not empty failedMessage}">
                        <h5 class="text-center text-danger">${failedMessage}</h5>
                        <c:remove var="failedMessage" scope="session"/>
                    </c:if>

                    <form action="register" method="post">
                        <div class="form-group">
                            <label for="formGroupExampleInput">Full Name</label>
                            <input type="text" class="form-control" id="formGroupExampleInput"
                                   aria-describedby="emailHelp" placeholder="Enter full name" required name="fullName">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" class="form-control" id="exampleInputEmail1"
                                   aria-describedby="emailHelp" placeholder="Enter email" required name="email">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput2">Phone Number</label>
                            <input type="number" class="form-control" id="formGroupExampleInput2"
                                   aria-describedby="emailHelp" placeholder="Enter phone number" required name="phone">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" class="form-control" id="exampleInputPassword1"
                                   placeholder="Password" required name="password" dirname="check">
                        </div>
                        <div class="form-check">
                            <input type="checkbox" class="form-check-input" id="exampleCheck1" name="checkbox">
                            <label class="form-check-label" for="exampleCheck1">Agree</label>
                        </div>
                        <div>
                            <button type="submit" class="btn btn-primary m-1">Submit</button>
                            <br>
                            Already have an account ? <a href="login.jsp">login here</a>
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
