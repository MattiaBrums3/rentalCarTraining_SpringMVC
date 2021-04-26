<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
    <title>Rental Car</title>
    <link rel="stylesheet" type="text/css" href="static/css/css-login.css" />
</head>
<body>
<div class="wrapper fadeInDown">
    <div id="formContent">
        <h2 class="active"> ACCEDI A RENTAL CAR </h2>
        <form action="login" method="post">
            <c:if test="${param.error != null}">
                <div class="alert alert-danger">
                    <p>Username e Password errati.</p>
                </div>
            </c:if>
            <c:if test="${param.logout != null}">
                <div class="alert alert-success">
                    <p>Logout effettuato correttamente.</p>
                </div>
            </c:if>
            <input type="text" id="login" class="fadeIn second" name="username" placeholder="Username" required>
            <input type="password" id="login" class="fadeIn third" name="password" placeholder="Password" required>
            <label id="remember" class="fadeIn fourth"><input type="checkbox" name="rememberMe">Ricordami</label>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
            <input type="submit" class="fadeIn fifth" value="ACCEDI">
        </form>
    </div>
</div>

<script type="text/javascript">
    var msg = "${sessionScope.msg}";
    if (msg != "") {
        alert(msg);
    }
</script>
<c:remove var="msg" />
</body>
</html>