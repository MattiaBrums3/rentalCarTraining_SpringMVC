<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="webjars/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="webjars/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <script src="webjars/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="webjars/datatables/1.10.24/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="webjars/datatables/1.10.24/js/jquery.dataTables.js"></script>
    <link rel="stylesheet" type="text/css" href="static/css/css-form.css" />
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarTogglerDemo02">
        <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
            <li class="nav-item active">
                <a class="nav-link" href="user">HOMEPAGE<span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="vehicle">PARCO AUTO</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="editUser?id=${sessionScope.id}">PROFILO UTENTE</a>
            </li>
        </ul>
        <form class="form-inline my-2 my-lg-0" action="logout" method="post">
            <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
                <li class="nav-item">
                    <a class="nav-link">Bentornato, ${sessionScope.username}</a>
                </li>
                <li class="nav-item">
                    <button class="btnNavbar my-2 my-sm-0" type="submit">LOGOUT</button>
                </li>
            </ul>
        </form>
    </div>
</nav>
</body>
</html>
