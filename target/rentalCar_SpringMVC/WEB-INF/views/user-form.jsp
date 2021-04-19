<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
body>
<jsp:include page="header.jsp"/>
<div class="register">
    <div class="row">
        <div class="col-sm register-right">
            <c:if test="${user != null}">
            <form action="updateUser" method="post">
                </c:if>
                <c:if test="${user == null}">
                <form action="insertUser" method="post">
                    </c:if>
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                            <c:if test="${user != null}">
                                <h3 class="register-heading">Modifica Utente</h3>
                            </c:if>
                            <c:if test="${user == null}">
                                <h3 class="register-heading">Nuovo Utente</h3>
                            </c:if>
                            <c:if test="${user != null}">
                                <input type="hidden" name="id" value="<c:out value='${user.id}' />" />
                            </c:if>

                            <div class="row register-form">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="name" class="form-control" value="<c:out value='${user.name}' />" placeholder="NOME *" title="Nome" required />
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="date_of_birth" class="form-control" value="<fmt:formatDate value="${user.dateOfBirth}" pattern="yyyy-MM-dd" />" placeholder="DATA DI NASCITA *" onfocus="(this.type='date')" title="Data di Nascita" required />
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="username" class="form-control" value="<c:out value='${user.username}' />" placeholder="USERNAME *" title="Username" required />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <input type="text" name="surname" class="form-control" value="<c:out value='${user.surname}' />" placeholder="COGNOME *" title="Cognome" required />
                                    </div>
                                    <div class="form-group">
                                        <input type="text" name="fiscal_code" class="form-control" maxlength="16" minlenght="16" style="text-transform:uppercase" value="<c:out value='${user.fiscalCode}' />" placeholder="Codice Fiscale *" title="Codice Fiscale" required />
                                    </div>
                                    <div class="form-group">
                                        <input type="password" name="password" class="form-control" value="<c:out value='${user.password}' />" placeholder="PASSWORD *" title="Password" required />
                                    </div>
                                    <c:if test="${user != null}">
                                        <input type="submit" value="Modifica" class="btnRegister" />
                                    </c:if>
                                    <c:if test="${user == null}">
                                        <input type="submit" value="Inserisci" class="btnRegister" />
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
        </div>
    </div>
</div>
</body>
</html>
