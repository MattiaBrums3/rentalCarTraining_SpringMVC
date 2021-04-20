<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <c:if test="${category != null}">
        <title>Modifica Categoria</title>
    </c:if>
    <c:if test="${category == null}">
        <title>Nuova Categoria</title>
    </c:if>
    <link href="webjars/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="webjars/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="static/css/css-form.css" type="text/css" />
</head>
<body>
    <jsp:include page="header.jsp"/>
    <div class="register">
        <div class="row">
            <div class="col-sm register-right">
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <c:choose>
                            <c:when test="${category.id != 0}">
                                <form:form action="updateCategory" method="post" modelAttribute="category">
                                    <h3 class="register-heading">Modifica Categoria</h3>
                                    <form:hidden path="id" />
                                    <div class="row register-form d-flex justify-content-center">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="typology" path="typology" placeholder="TIPOLOGIA *" required="required" />
                                                <form:errors path="typology" class="form-control" />
                                            </div>
                                            <input type="submit" value="Modifica" class="btnRegister" />
                                        </div>
                                    </div>
                                </form:form>
                            </c:when>
                            <c:otherwise>
                                <form:form action="insertCategory" method="post" modelAttribute="category">
                                    <h3 class="register-heading">Nuova Categoria</h3>
                                    <div class="row register-form d-flex justify-content-center">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <form:input type="text" class="form-control" id="typology" path="typology" placeholder="TIPOLOGIA *" required="required" />
                                                <form:errors path="typology" class="form-control" />
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
