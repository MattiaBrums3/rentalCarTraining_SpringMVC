<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true" %>
<html>
<head>
    <title>Categorie</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="register">
    <div class="row">
        <div class="col-sm register-right">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <h2 class="register-heading">Lista Categorie</h2>
                    <div class="row register-form d-flex justify-content-center">
                        <div class="col-lg-2 col-md-3 col-sm-12 p-0">
                            <select id="searchField" name="searchField" class="form-control search-slt searchField">
                                <option value="id" selected>idCategoria</option>
                                <option value="typology">Tipologia</option>
                            </select>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                            <input type="text" id="searchCategory" class="form-control search-slt" onkeyup="searchFunction()" placeholder="Ricerca..." />
                        </div>
                        <div>
                            <table id="categoriesTable" class="table table-striped" cellspacing="0" width="100%" style="clear:none!important;">
                                <thead>
                                <tr>
                                    <th class="th-sm">idCategoria</th>
                                    <th class="th-sm">Tipologia</th>
                                    <th class="th-sm">
                                        <div class="d-flex justify-content-center">
                                            <a href="newCategory"><input type="button" class="btnTable" value="Nuova Categoria" /></a>
                                        </div>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="category" items="${listCategories}">
                                    <tr>
                                        <td><c:out value="${category.id}" /></td>
                                        <td><c:out value="${category.typology}" /></td>
                                        <td>
                                            <div class="d-flex justify-content-center">
                                                <a href="editCategory_<c:out value='${category.id}' />"><input type="button" class="btnTable" value="Modifica" /></a>
                                                &nbsp;&nbsp;&nbsp;&nbsp;
                                                <a href="deleteCategory_<c:out value='${category.id}' />"><input type="button" class="btnTable" value="Elimina" /></a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function searchFunction() {
        var input, field, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchCategory");
        field = document.getElementById("searchField").value;
        filter = input.value.toUpperCase();
        table = document.getElementById("categoriesTable");
        tr = table.getElementsByTagName("tr");
        for (i = 0; i < tr.length; i++) {
            if (field == "id"){
                td = tr[i].getElementsByTagName("td")[0];
            } else if (field == "typology") {
                td = tr[i].getElementsByTagName("td")[1];
            }
            if (td) {
                txtValue = td.textContent || td.innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = "";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    };
</script>
<script>
    $(document).ready(function () {
        $('#categoriesTable').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.24/i18n/Italian.json"
            },
            "searching": false
        });
        $('.dataTables_length').addClass('bs-select');
    });
</script>
<script>
    const choices = new Choices('[data-trigger]',
        {
            searchEnabled: false
        });
</script>
<script type="text/javascript">
    var msg = "${sessionScope.msg}";
    if (msg != "") {
        alert(msg);
    }
</script>
<c:remove var="msg" />
</body>
</html>
