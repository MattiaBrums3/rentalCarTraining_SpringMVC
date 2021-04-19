<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                <c:if test="${category != null}">
                    <form action="updateCategory" method="post" modelAttribute="category">
                </c:if>
                <c:if test="${category == null}">
                    <form action="insertCategory" method="post" modelAttribute="category">
                </c:if>
                <div class="tab-content" id="myTabContent">
                    <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                        <c:if test="${category != null}">
                            <h3 class="register-heading">Modifica Categoria</h3>
                        </c:if>
                        <c:if test="${category == null}">
                            <h3 class="register-heading">Nuova Categoria</h3>
                        </c:if>
                        <c:if test="${category != null}">
                            <input type="hidden" name="id" value="<c:out value='${category.id}' />" />
                        </c:if>
                        <div class="row register-form d-flex justify-content-center">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" name="typology" class="form-control" value="<c:out value='${category.typology}' />" placeholder="TIPOLOGIA *" title="Tipologia" required />
                                </div>
                                <c:if test="${category != null}">
                                    <input type="submit" value="Modifica" class="btnRegister" />
                                </c:if>
                                <c:if test="${category == null}">
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
