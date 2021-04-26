<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page session="true" %>
<html>
<head>
    <title>Veicoli</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="register">
    <div class="row">
        <div class="col-sm register-right">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <h2 class="register-heading">Lista Veicoli</h2>
                    <div class="row register-form d-flex justify-content-center">
                        <div class="col-lg-2 col-md-3 col-sm-12 p-0">
                            <select id="searchField" name="searchField" class="form-control search-slt searchField">
                                <option value="id" selected>idVeicolo</option>
                                <option value="model">Modello</option>
                                <option value="manufacturer">Casa Produttrice</option>
                                <option value="licensePlate">Targa</option>
                                <option value="year">Anno Immatricolazione</option>
                                <option value="category">Categoria</option>
                            </select>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 p-0">
                            <input type="text" id="searchVehicle" class="form-control search-slt" onkeyup="searchFunction()" placeholder="Ricerca..." />
                        </div>
                        <div>
                            <table id="vehiclesTable" class="table table-striped" cellspacing="0" width="100%" style="clear:none!important;">
                                <thead>
                                <tr>
                                    <th class="th-sm">idVeicolo</th>
                                    <th class="th-sm">Modello</th>
                                    <th class="th-sm">Casa Produttrice</th>
                                    <th class="th-sm">Targa</th>
                                    <th class="th-sm">Anno Immatr.</th>
                                    <th class="th-sm">Categoria</th>
                                    <th class="th-sm">
                                        <sec:authorize access="hasRole('ADMIN')">
                                            <div class="d-flex justify-content-center">
                                                <a href="newVehicle"><input type="button" class="btnTable" value="Nuovo Veicolo" /></a>
                                            </div>
                                        </sec:authorize>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="vehicle" items="${listVehicles}">
                                    <tr>
                                        <td><c:out value="${vehicle.id}" /></td>
                                        <td><c:out value="${vehicle.model}" /></td>
                                        <td><c:out value="${vehicle.manufacturer}" /></td>
                                        <td><c:out value="${vehicle.licensePlate}" /></td>
                                        <td><c:out value="${vehicle.yearOfRegistration}" /></td>
                                        <td><c:out value="${vehicle.category.typology}" /></td>
                                        <td>
                                            <div class="d-flex justify-content-center">
                                                <sec:authorize access="hasRole('ADMIN')">
                                                    <a href="editVehicle_<c:out value='${vehicle.id}' />"><input type="button" class="btnTable" value="Modifica" /></a>
                                                    &nbsp;&nbsp;&nbsp;&nbsp;
                                                    <a href="deleteVehicle_<c:out value='${vehicle.id}' />"><input type="button" class="btnTable" value="Elimina" /></a>
                                                </sec:authorize>
                                                <sec:authorize access="hasRole('CUSTOMER')">
                                                    <c:set var="vehicleAlreadyRented" value="false" />
                                                    <c:forEach var="v_rental" items="${vehicle.getRentals()}">
                                                        <c:forEach var="rental" items="${listRentals}">
                                                            <c:if test="${v_rental.id == rental.id}">
                                                                <c:set var="vehicleAlreadyRented" value="true" />
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:forEach>
                                                    <c:if test="${user.getRentals().isEmpty() && vehicleAlreadyRented == false}">
                                                        <a href="newRental_<c:out value='${vehicle.id}' />"><input type="button" class="btnTable" value="Prenota" /></a>
                                                    </c:if>
                                                    <c:if test="${user.getRentals().isEmpty() && vehicleAlreadyRented == true}">
                                                        Veicolo già prenotato.
                                                    </c:if>
                                                    <c:if test="${!user.getRentals().isEmpty()}">
                                                        Hai già una prenotazione.
                                                    </c:if>
                                                </sec:authorize>
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

    <script>
        function searchFunction() {
            var input, field, filter, table, tr, td, i, txtValue;
            input = document.getElementById("searchVehicle");
            field = document.getElementById("searchField").value;
            filter = input.value.toUpperCase();
            table = document.getElementById("vehiclesTable");
            tr = table.getElementsByTagName("tr");
            for (i = 0; i < tr.length; i++) {
                if (field == "id"){
                    td = tr[i].getElementsByTagName("td")[0];
                } else if (field == "model") {
                    td = tr[i].getElementsByTagName("td")[1];
                } else if (field == "manufacturer") {
                    td = tr[i].getElementsByTagName("td")[2];
                } else if (field == "licensePlate") {
                    td = tr[i].getElementsByTagName("td")[3];
                } else if (field == "year") {
                    td = tr[i].getElementsByTagName("td")[4];
                } else if (field == "category") {
                    td = tr[i].getElementsByTagName("td")[5];
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
            $('#vehiclesTable').DataTable({
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
