<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <c:if test="${rental.id != 0}">
        <title>Modifica Prenotazione</title>
    </c:if>
    <c:if test="${rental.id == 0}">
        <title>Nuova Prenotazione</title>
    </c:if>
    <link href="webjars/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="webjars/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/css-form.css" type="text/css" />
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div align="center">
        <div class="register">
            <div class="row">
                <div class="col-sm register-right">
                    <div class="tab-content" id="myTabContent">
                        <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                            <c:if test="${rental.id == 0}">
                                <h3 class="register-heading">Nuova Prenotazione</h3>
                            </c:if>
                            <c:if test="${rental.id != 0}">
                                <h3 class="register-heading">Modifica Prenotazione</h3>
                            </c:if>
                            <form:form action="insertUpdateRental" method="post" modelAttribute="rental">
                                <form:hidden path="id" />
                                <div class="row register-form d-flex justify-content-center">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <form:select id="vehicle" path="vehicle" class="form-control" title="Veicolo" required="required">
                                                <form:option value="${vehicle.model}" selected="selected">${vehicle.model}</form:option>
                                            </form:select>
                                        </div>
                                        <div class="form-group">
                                            <form:input type="text" class="form-control" id="dateOfEnd" path="dateOfEnd" placeholder="DATA DI FINE *" onfocus="(this.type='date')" title="Data di Fine" required="required" />
                                            <form:errors path="dateOfEnd" class="form-control" />
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <form:input type="text" class="form-control" id="dateOfStart" path="dateOfStart" placeholder="DATA DI INIZIO *" onfocus="(this.type='date')" title="Data di Inizio" required="required" />
                                            <form:errors path="dateOfStart" class="form-control" />
                                        </div>
                                        <c:if test="${rental.id == 0}">
                                            <input type="submit" value="Inserisci" class="btnRegister" />
                                        </c:if>
                                        <c:if test="${rental.id != 0}">
                                            <input type="submit" value="Modifica" class="btnRegister" />
                                        </c:if>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>