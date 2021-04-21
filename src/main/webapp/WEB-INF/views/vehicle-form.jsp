<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <c:if test="${vehicle != null}">
        <title>Modifica Veicolo</title>
    </c:if>
    <c:if test="${vehicle == null}">
        <title>Nuovo Veicolo</title>
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
                            <c:choose>
                                <c:when test="${vehicle.id != 0}">
                                    <form:form action="updateVehicle" method="post" modelAttribute="vehicle">
                                        <h3 class="register-heading">Modifica Veicolo</h3>
                                        <form:hidden path="id" />
                                        <div class="row register-form d-flex justify-content-center">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <form:input type="text" class="form-control" id="model" path="model" placeholder="MODELLO *" title="Modello" required="required" />
                                                    <form:errors path="model" class="form-control" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input type="text" class="form-control" id="licensePlate" path="licensePlate" maxlength="7" minlenght="7" style="text-transform:uppercase" placeholder="TARGA *" title="Targa" required="required" />
                                                    <form:errors path="licensePlate" class="form-control" />
                                                </div>
                                                <div class="form-group">
                                                    <form:select id="category" path="category" class="form-control" title="Categoria" required="required">
                                                        <c:forEach var="category" items="${listCategories}">
                                                            <c:if test="${category.id == vehicle.category.id}">
                                                                <form:option selected="selected" value="${category.id}">${category.typology}</form:option>
                                                            </c:if>
                                                            <c:if test="${category.id != vehicle.category.id}">
                                                                <form:option value="${category.id}">${category.typology}</form:option>
                                                            </c:if>
                                                        </c:forEach>
                                                    </form:select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <form:input type="text" class="form-control" id="manufacturer" path="manufacturer" placeholder="CASA PRODUTTRICE *" title="Casa Produttrice" required="required" />
                                                    <form:errors path="manufacturer" class="form-control" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input type="text" class="form-control" id="yearOfRegistration" path="yearOfRegistration" maxlength="4" minlenght="4" onfocus="(this.type='number')" placeholder="ANNO *" title="Anno di Immatricolazione" required="required" />
                                                    <form:errors path="yearOfRegistration" class="form-control" />
                                                </div>
                                                <input type="submit" value="Modifica" class="btnRegister" />
                                            </div>
                                        </div>
                                    </form:form>
                                </c:when>
                                <c:otherwise>
                                    <form:form action="insertVehicle" method="post" modelAttribute="vehicle">
                                        <h3 class="register-heading">Nuovo Veicolo</h3>
                                        <div class="row register-form d-flex justify-content-center">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <form:input type="text" class="form-control" id="model" path="model" placeholder="MODELLO *" title="Modello" required="required" />
                                                    <form:errors path="model" class="form-control" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input type="text" class="form-control" id="licensePlate" path="licensePlate" maxlength="7" minlenght="7" style="text-transform:uppercase" placeholder="TARGA *" title="Targa" required="required" />
                                                    <form:errors path="licensePlate" class="form-control" />
                                                </div>
                                                <div class="form-group">
                                                    <form:select name="category" path="category" class="form-control" title="Categoria" required="required">
                                                        <form:option selected="selected" value="0">CATEGORIA *</form:option>
                                                        <c:forEach var="c" items="${listCategories}">
                                                            <form:option value="${c.typology}">${c.typology}</form:option>
                                                        </c:forEach>
                                                    </form:select>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <form:input type="text" class="form-control" id="manufacturer" path="manufacturer" placeholder="CASA PRODUTTRICE *" title="Casa Produttrice" required="required" />
                                                    <form:errors path="manufacturer" class="form-control" />
                                                </div>
                                                <div class="form-group">
                                                    <form:input type="text" class="form-control" id="yearOfRegistration" path="yearOfRegistration" onfocus="(this.type='number')" maxlength="4" minlenght="4" placeholder="ANNO *" title="Anno di Immatricolazione" required="required" />
                                                    <form:errors path="yearOfRegistration" class="form-control" />
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
    </div>
</body>
</html>