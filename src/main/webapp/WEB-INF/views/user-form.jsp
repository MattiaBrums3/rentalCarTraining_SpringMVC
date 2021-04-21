<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
    <link rel="stylesheet" href="static/css/css-form.css" type="text/css" />
    <link href="webjars/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="webjars/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <c:if test="${user != null}">
        <title>Modifica Utente</title>
    </c:if>
    <c:if test="${user == null}">
        <title>Nuovo Utente</title>
    </c:if>
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="register">
        <div class="row">
            <div class="col-sm register-right">
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <c:choose>
                            <c:when test="${user.id != 0}">
                                <form:form action="updateUser" method="post" modelAttribute="user">
                                    <h3 class="register-heading">Modifica Utente</h3>
                                    <form:hidden path="id" />
                                    <div class="row register-form d-flex justify-content-center">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="name" path="name" placeholder="NOME *" title="Nome" required="required" />
                                                <form:errors path="name" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="dateOfBirth" path="dateOfBirth" placeholder="DATA DI NASCITA *" onfocus="(this.type='date')" title="Data di Nascita" required="required" />
                                                <form:errors path="dateOfBirth" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="username" path="username" placeholder="USERNAME *" title="Username" required="required" />
                                                <form:errors path="username" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="surname" path="surname" placeholder="COGNOME *" title="Cognome" required="required" />
                                                <form:errors path="surname" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="fiscalCode" path="fiscalCode" maxlength="16" minlenght="16" style="text-transform:uppercase" placeholder="CODICE FISCALE *" title="Codice Fiscale" required="required" />
                                                <form:errors path="fiscalCode" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <form:input type="password" class="form-control" id="password" path="password" placeholder="PASSWORD *" title="Password" required="required" />
                                                <form:errors path="password" class="form-control" />
                                            </div>
                                            <input type="submit" value="Modifica" class="btnRegister" />
                                        </div>
                                    </div>
                                </form:form>
                            </c:when>
                            <c:otherwise>
                                <form:form action="insertUser" method="post" modelAttribute="user">
                                    <h3 class="register-heading">Nuovo Utente</h3>
                                    <div class="row register-form d-flex justify-content-center">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="name" path="name" placeholder="NOME *" title="Nome" required="required" />
                                                <form:errors path="name" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="dateOfBirth" path="dateOfBirth" placeholder="DATA DI NASCITA *" onfocus="(this.type='date')" title="Data di Nascita" required="required" />
                                                <form:errors path="dateOfBirth" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="username" path="username" placeholder="USERNAME *" title="Username" required="required" />
                                                <form:errors path="username" class="form-control" />
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="surname" path="surname" placeholder="COGNOME *" title="Cognome" required="required" />
                                                <form:errors path="surname" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="fiscalCode" path="fiscalCode" maxlength="16" minlenght="16" style="text-transform:uppercase" placeholder="CODICE FISCALE *" title="Codice Fiscale" required="required" />
                                                <form:errors path="fiscalCode" class="form-control" />
                                            </div>
                                            <div class="form-group">
                                                <form:input type="password" class="form-control" id="password" path="password" placeholder="PASSWORD *" title="Password" required="required" />
                                                <form:errors path="password" class="form-control" />
                                            </div>
                                            <input type="submit" value="Inserisci" class="btnRegister" />
                                        </div>
                                    </div>
                                </form:form>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
