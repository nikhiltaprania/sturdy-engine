<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Sell Book</title>
    <%@ include file="contents/common.jsp" %>
</head>
<body style="background-color: floralwhite">
<%@ include file="contents/navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="login.jsp"/>
</c:if>

<div class="container">
    <div class="row">
        <div class="col-md4 offset-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="text-center text-danger p-1">Upload Your Book Detail</h5>

                    <c:if test="${not empty successMessage}">
                        <p class="text-center text-success">${successMessage}</p>
                        <c:remove var="successMessage" scope="session"/>
                    </c:if>

                    <c:if test="${not empty failedMessage}">
                        <p class="text-center text-danger">${failedMessage}</p>
                        <c:remove var="failedMessage" scope="session"/>
                    </c:if>

                    <form action="sellBook" method="post" enctype="multipart/form-data">

                        <input type="hidden" value="${user.email}" name="tempEmail">

                        <div class="form-group">
                            <label for="exampleInputEmail1">Book Name</label>
                            <input name="bookName" type="text" class="form-control" id="exampleInputEmail1"
                                   aria-describedby="emailHelp">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputName1">Author Name</label>
                            <input name="author" type="text" class="form-control" id="exampleInputName1"
                                   aria-describedby="emailHelp">
                        </div>

                        <div class="form-group">
                            <label for="exampleInputPassword1">Price</label>
                            <input name="price" type="number" class="form-control" id="exampleInputPassword1"
                                   aria-describedby="emailHelp">
                        </div>

                        <div class="form-group">
                            <label for="exampleFormControlFile1">Upload Photo</label>
                            <input name="bookImg" type="file" class="form-control-file" id="exampleFormControlFile1"
                                   aria-describedby="emailHelp">
                        </div>

                        <button type="submit" class="btn btn-primary">Sell</button>
                    </form>


                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="contents/footer.jsp" %>
</body>
</html>
