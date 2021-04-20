<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <c:if test="${vehicle != null}">
                <form action="updateVehicle" method="post">
                    </c:if>
                    <c:if test="${vehicle == null}">
                    <form action="insertVehicle" method="post">
                        </c:if>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <c:if test="${vehicle != null}">
                                    <h3 class="register-heading">Modifica Veicolo</h3>
                                </c:if>
                                <c:if test="${vehicle == null}">
                                    <h3 class="register-heading">Nuovo Veicolo</h3>
                                </c:if>
                                <c:if test="${vehicle != null}">
                                    <input type="hidden" name="id" value="<c:out value='${vehicle.id}' />" />
                                </c:if>
                                <div class="row register-form">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <input type="text" name="model" class="form-control" value="<c:out value='${vehicle.model}' />" placeholder="MODELLO *" title="Modello" required />
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="licensePlate" class="form-control" maxlength="7" minlenght="7" style="text-transform:uppercase" value="<c:out value='${vehicle.licensePlate}' />" title="Targa" placeholder="TARGA *" required />
                                        </div>
                                        <div class="form-group">
                                            <select name="category" class="form-control" title="Categoria">
                                                <c:if test="${vehicle == null}">
                                                    <option selected>CATEGORIA *</option>
                                                    <c:forEach var="category" items="${listCategories}">
                                                        <option value="${category.id}">${category.typology}</option>
                                                    </c:forEach>
                                                </c:if>
                                                <c:if test="${vehicle != null}">
                                                    <c:forEach var="category" items="${listCategories}">
                                                        <c:if test="${category.id == vehicle.category.id}">
                                                            <option selected value="${category.id}">${category.typology}</option>
                                                        </c:if>
                                                        <c:if test="${category.id != vehicle.category.id}">
                                                            <option value="${category.id}">${category.typology}</option>
                                                        </c:if>
                                                    </c:forEach>
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <input type="text" name="manufacturer" class="form-control" value="<c:out value='${vehicle.manufacturer}' />" placeholder="CASA PRODUTTRICE *" title="Casa Produttrice" required />
                                        </div>
                                        <div class="form-group">
                                            <input type="number" name="yearOfRegistration" class="form-control" maxlength="4" minlenght="4" style="text-transform:uppercase" value="<c:out value='${vehicle.yearOfRegistration}' />" title="Anno di Registrazione" placeholder="ANNO *" required />
                                        </div>
                                        <c:if test="${vehicle != null}">
                                            <input type="submit" value="Modifica" class="btnRegister" />
                                        </c:if>
                                        <c:if test="${vehicle == null}">
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
</div>
</body>
</html>