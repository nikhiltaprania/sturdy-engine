<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page isELIgnored="false" %>
<div class="container-fluid" style="height: 10px; background-color: #303f9f"></div>
<div class="container-fluid p-3 bg-light">
    <div class="row">
        <div class="col-md-3">
            <a href="home.jsp" style="text-decoration: none; color: forestgreen"><h2><i class="fa-solid fa-book"></i> EBooks</h2></a>
        </div>
        <div class="col-md-6">
            <form class="form-inline my-2 my-lg-0">
                <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                <button class="btn btn-primary my-2 my-sm-0" type="submit">Search</button>
            </form>
        </div>
        <div class="col-md-3">
            <c:if test="${not empty user}">
                <a href="home.jsp" class="btn btn-success"><i class="fas fa-user"></i> ${user.name}</a>
                <a data-toggle="modal" data-target="#exampleModalCenter" class="btn btn-primary text-white"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
            </c:if>

            <c:if test="${empty user}">
                <a href="../login.jsp" class="btn btn-success"><i class="fa-solid fa-right-to-bracket"></i> Login</a>
                <a href="../register.jsp" class="btn btn-primary text-white"><i class="fas fa-user-plus"></i> Register</a>
            </c:if>
        </div>
    </div>
</div>
<!--Logout Model-->

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
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

<!--logout model end here-->
<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
    <a class="navbar-brand" href="#"><i class="fa-solid fa-house"></i></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active"><a class="nav-link" href="home.jsp"> Home <span class="sr-only">(current)</span></a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
            <button class="btn btn-light my-2 my-sm-0" type="submit"><i class="fa-solid fa-gear"></i> Setting</button>
            <button class="btn btn-light my-2 my-sm-0 ml-1" type="submit"><i class="fa-solid fa-phone"></i> Contact Us
            </button>
        </form>
    </div>
</nav>