<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Edit Profile</title>
    <%@ include file="contents/common.jsp" %>
</head>
<body style="background-color: floralwhite">
<%@ include file="contents/navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="container p-2">
    <div class="row">
        <div class="col-md-4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h4 class="text-center">Edit Account Details</h4>

                    <c:if test="${not empty successMessage}">
                        <h5 class="text-center text-success">${successMessage}</h5>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>
                    <c:if test="${not empty failedMessage}">
                        <h5 class="text-center text-danger">${failedMessage}</h5>
                        <c:remove var="failedMessage" scope="session"/>
                    </c:if>

                    <form action="updateProfile" method="post">
                        <input type="hidden" value="${user.userId}" name="userId">

                        <div class="form-group">
                            <label for="formGroupExampleInput">Full Name</label>
                            <input type="text" class="form-control" id="formGroupExampleInput"
                                   aria-describedby="emailHelp" value="${user.name}" required name="fullName">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputEmail1">Email address</label>
                            <input type="email" class="form-control" id="exampleInputEmail1"
                                   aria-describedby="emailHelp" value="${user.email}" required name="email">
                        </div>
                        <div class="form-group">
                            <label for="formGroupExampleInput2">Phone Number</label>
                            <input type="number" class="form-control" id="formGroupExampleInput2"
                                   aria-describedby="emailHelp" value=${user.phone} required name="phone">
                        </div>
                        <div class="form-group">
                            <label for="exampleInputPassword1">Password</label>
                            <input type="password" class="form-control" id="exampleInputPassword1"
                                   placeholder="Enter Password" required name="password" dirname="check">
                        </div>
                        <div>
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
