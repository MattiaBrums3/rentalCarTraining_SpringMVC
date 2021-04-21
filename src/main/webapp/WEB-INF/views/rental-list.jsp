<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<html>
<head>
    <title>Prenotazioni</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="register">
    <div class="row">
        <div class="col-sm register-right">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <c:if test="${empty listRentals}">
                        <h2 class="register-heading">L'utente non ha effettuato prenotazioni.</h2>
                    </c:if>
                    <c:if test="${not empty listRentals}">
                        <h2 class="register-heading">Lista Prenotazioni</h2>
                        <div class="row register-form d-flex justify-content-center">
                            <div class="col-lg-2 col-md-3 col-sm-12 p-0">
                                <select id="searchField" name="searchField" class="form-control search-slt searchField">
                                    <option value="id" selected>idPrenotazione</option>
                                    <option value="user">Utente</option>
                                    <option value="vehicle">Veicolo</option>
                                    <option value="dateStart">Data di Inizio</option>
                                    <option value="dateEnd">Data di Fine</option>
                                </select>
                            </div>
                            <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                <input type="text" id="searchRental" class="form-control search-slt" onkeyup="searchFunction()" placeholder="Ricerca..." />
                            </div>
                            <div>
                                <table id="rentalsTable" class="table table-striped" cellspacing="0" width="100%" style="clear:none!important;">
                                    <thead>
                                    <tr>
                                        <th class="th-sm">idPrenotazione</th>
                                        <th class="th-sm">Utente</th>
                                        <th class="th-sm">Veicolo</th>
                                        <th class="th-sm">Data di Inizio</th>
                                        <th class="th-sm">Data di Fine</th>
                                        <th class="th-sm"></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="rental" items="${listRentals}">
                                        <tr>
                                            <td><c:out value="${rental.id}" /></td>
                                            <td><c:out value="${rental.user.name} ${rental.user.surname}" /></td>
                                            <td><c:out value="${rental.vehicle.model}" /></td>
                                            <td><fmt:formatDate value="${rental.dateOfStart}" pattern="dd-MM-yyyy" /></td>
                                            <td><fmt:formatDate value="${rental.dateOfEnd}" pattern="dd-MM-yyyy" /></td>
                                            <td>
                                                <div class="d-flex justify-content-center">
                                                    <c:if test="${rental.approved == false}">
                                                        <a href="approveRental_true_<c:out value='${rental.id}' />"><input type="button" class="btnTable" value="Accetta" /></a>
                                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                                        <a href="approveRental_false_<c:out value='${rental.id}' />"><input type="button" class="btnTable" value="Rifiuta" /></a>
                                                    </c:if>
                                                    <c:if test="${rental.approved == true}">
                                                        Prenotazione Approvata
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    function searchFunction() {
        var input, field, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchRental");
        field = document.getElementById("searchField").value;
        filter = input.value.toUpperCase();
        table = document.getElementById("rentalsTable");
        tr = table.getElementsByTagName("tr");
        for (i = 0; i < tr.length; i++) {
            if (field == "id"){
                td = tr[i].getElementsByTagName("td")[0];
            } else if (field == "user") {
                td = tr[i].getElementsByTagName("td")[1];
            } else if (field == "vehicle") {
                td = tr[i].getElementsByTagName("td")[2];
            } else if (field == "dateStart") {
                td = tr[i].getElementsByTagName("td")[3];
            } else if (field == "dateEnd") {
                td = tr[i].getElementsByTagName("td")[4];
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
        $('#rentalsTable').DataTable({
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