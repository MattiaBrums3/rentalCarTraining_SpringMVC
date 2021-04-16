<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true" %>
<html>
<head>
    <c:if test="${sessionScope.superUser == false}">
        <title>Customer Homepage</title>
    </c:if>
    <c:if test="${sessionScope.superUser == true}">
        <title>Admin Homepage</title>
    </c:if>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="register">
    <div class="row">
        <div class="col-sm register-right">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <c:if test="${sessionScope.superUser == true}">
                        <h1 class="register-heading">Admin Homepage</h1>
                        <div class="row register-form d-flex justify-content-center">
                            <div class="col-md-6">
                                <a href="category"><input type="button" class="btnAdminMenu" value="Categorie" /></a>
                                &nbsp;&nbsp;&nbsp;
                                <a href="vehicle"><input type="button" class="btnAdminMenu" value="Veicoli" /></a>
                            </div>
                        </div>
                        <jsp:include page="user-list.jsp"/>
                    </c:if>
                    <c:if test="${sessionScope.superUser == false}">
                        <h1 class="register-heading">Customer Homepage</h1>
                        <c:if test="${empty listRentals}">
                            <div class="row register-form d-flex justify-content-center">
                                <div class="col-md-6">
                                    <h2 class="register-subheading">Non hai effettuato prenotazioni.<br/>Clicca su "PARCO AUTO" per prenotare il tuo primo veicolo!</h2>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${not empty listRentals}">
                            <div class="row register-form d-flex justify-content-center" style="padding-bottom:2%!important;">
                                <div class="col-md-6">
                                    <h2 class="register-subheading">Lista Prenotazioni</h2>
                                </div>
                            </div>
                            <div class="row d-flex justify-content-center" style="margin:0!important;">
                                <div class="col-lg-2 col-md-3 col-sm-12 p-0">
                                    <select id="searchField" name="searchField" class="form-control search-slt searchField">
                                        <option value="id" selected>idPrenotazione</option>
                                        <option value="vehicle">Veicolo</option>
                                        <option value="dateStart">Data di Inizio</option>
                                        <option value="dateEnd">Data di fine</option>
                                    </select>
                                </div>
                                <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                                    <input type="text" id="searchRental" class="form-control search-slt" onkeyup="searchFunction()" placeholder="Ricerca..." />
                                </div>
                                <div style="width:70%;">
                                    <table id="rentalsTable" class="table table-striped" cellspacing="0" width="100%" style="clear:none!important;">
                                        <thead>
                                        <tr>
                                            <th class="th-sm">idPrenotazione</th>
                                            <th class="th-sm">Veicolo</th>
                                            <th class="th-sm">Data di Inizio</th>
                                            <th class="th-sm">Data di Fine</th>
                                            <th class="th-sm">Stato</th>
                                            <th class="th-sm">
                                                <c:if test="${user.getRentals().isEmpty()}">
                                                    <div class="d-flex justify-content-center">
                                                        <a href="newRental"><input type="button" class="btnTable" value="Nuova Prenotazione" /></a>
                                                    </div>
                                                </c:if>
                                            </th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="rental" items="${listRentals}">
                                            <tr>
                                                <td><c:out value="${rental.id}" /></td>
                                                <td><c:out value="${rental.vehicle.model}" /></td>
                                                <td><fmt:formatDate value="${rental.dateOfStart}" pattern="dd-MM-yyyy" /></td>
                                                <td><fmt:formatDate value="${rental.dateOfEnd}" pattern="dd-MM-yyyy" /></td>
                                                <td>
                                                    <c:if test="${rental.approved == false}">
                                                        In fase di approvazione
                                                    </c:if>
                                                    <c:if test="${rental.approved == true}">
                                                        Approvata
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <div class="d-flex justify-content-center">
                                                        <jsp:useBean id="today1" class="java.util.Date" />
                                                        <fmt:formatDate var="today_not_parsed" type="date" value="${today1}" pattern="dd-MM-yyyy" />
                                                        <fmt:formatDate var="sd_not_parsed" type="date" value="${rental.dateOfStart}" pattern="dd-MM-yyyy" />
                                                        <fmt:parseDate var="today" value="${today_not_parsed}" pattern="dd-MM-yyyy" />
                                                        <fmt:parseDate var="sd" value="${sd_not_parsed}" pattern="dd-MM-yyyy" />

                                                        <c:if test="${((today.time - sd.time) / (60 * 60 * 1000)) gt 48 && rental.approved == false}">
                                                            <a href="editRental?id=<c:out value='${rental.id}' />"><input type="button" class="btnTable" value="Modifica" /></a>
                                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                                            <a href="deleteRental?id=<c:out value='${rental.id}' />"><input type="button" class="btnTable" value="Elimina" /></a>
                                                        </c:if>
                                                        <c:if test="${((today.time - sd.time) / (60 * 60 * 1000)) lt 48 || rental.approved == true}">
                                                            Non modificabile.
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
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
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
            } else if (field == "vehicle") {
                td = tr[i].getElementsByTagName("td")[1];
            } else if (field == "dateStart") {
                td = tr[i].getElementsByTagName("td")[2];
            } else if (field == "dateEnd") {
                td = tr[i].getElementsByTagName("td")[3];
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
</html>

