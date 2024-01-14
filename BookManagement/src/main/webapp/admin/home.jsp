<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<html lang="en">
<head>
    <title>Title</title>
    <%@ include file="common.jsp" %>
    <style>
        a {
            text-decoration: none;
            color: black;
        }

        a:hover {
            text-decoration: none;
            color: black;
        }
    </style>
</head>
<body>
<%@ include file="navbar.jsp" %>
<c:if test="${empty user}">
    <c:redirect url="../login.jsp"/>
</c:if>

<h3 class="text-center">Hello Admin</h3>

<div class="container">
    <div class="row p-5">
        <div class="col-md-3">
            <a href="add-books.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fa-solid fa-plus fa-3x text-primary"></i> <br>
                        <h4>Add Books</h4>
                        -----
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-3">
            <a href="all-books.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fa-solid fa-book-open fa-3x text-danger"></i> <br>
                        <h4>All Books</h4>
                        -----
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-3">
            <a href="manage-users.jsp">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fa-solid fa-user-tie fa-3x text-warning"></i> <br>
                        <h4>Registered Users</h4>
                        -----
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-3">
            <a data-toggle="modal" data-target="#exampleModalCenter" style="cursor: pointer">
                <div class="card">
                    <div class="card-body text-center">
                        <i class="fa-solid fa-right-from-bracket fa-3x text-primary"></i> <br>
                        <h4>Logout</h4>
                        -----
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLongTitle"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="text-center">
                    <h4>Do You Want To Log out</h4>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <a href="../logout" type="button" class="btn btn-primary text-white">Logout</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
