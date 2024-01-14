<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Title</title>
    <%@ include file="contents/common.jsp" %>
</head>
<body style="background-color: floralwhite">
<%@ include file="contents/navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="container">
    <div class="row">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center text-success">Edit Address</h3>

                    <c:if test="${not empty successMessage}">
                        <h5 class="text-center text-success">${successMessage}</h5>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>
                    <c:if test="${not empty failedMessage}">
                        <h5 class="text-center text-danger">${failedMessage}</h5>
                        <c:remove var="failedMessage" scope="session"/>
                    </c:if>

                    <form action="addAddress" method="post">
                        <div class="form-group">
                            <label for="formGroupExampleInput">City</label>
                            <input type="text" class="form-control" id="formGroupExampleInput"
                                   value="${user.address.city}" name="city">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput1">State</label>
                            <input type="text" class="form-control" id="formGroupExampleInput1"
                                   value="${user.address.state}" name="state">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput2">Pin Code</label>
                            <input type="number" class="form-control" id="formGroupExampleInput2"
                                   value="${user.address.pinCode}" name="pinCode">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" class="form-control" id="exampleInputPassword1"
                                   placeholder="Enter Password" required name="password" dirname="check">
                        </div>
                        <div class="text-center">
                            <button type="submit" class="btn btn-success m-1">Update</button>
                            <br>
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
