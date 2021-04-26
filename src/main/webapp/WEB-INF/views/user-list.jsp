<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<body>
<h2 class="register-subheading">Lista Utenti</h2>
<div class="row register-form d-flex justify-content-center">
    <div class="col-lg-2 col-md-3 col-sm-12 p-0">
        <select id="searchField" name="searchField" class="form-control search-slt searchField">
            <option value="id" selected>idUtente</option>
            <option value="name">Nome</option>
            <option value="surname">Cognome</option>
            <option value="birthDate">Data di Nascita</option>
            <option value="fiscalCode">Codice Fiscale</option>
            <option value="username">Username</option>
        </select>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-12 p-0">
        <input type="text" id="searchUsers" class="form-control search-slt" onkeyup="searchFunction()" placeholder="Ricerca..." />
    </div>
    <table id="usersTable" class="table table-striped" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th class="th-sm">idUtente</th>
            <th class="th-sm">Nome</th>
            <th class="th-sm">Cognome</th>
            <th class="th-sm">Data di Nascita</th>
            <th class="th-sm">Codice Fiscale</th>
            <th class="th-sm">Username</th>
            <th class="th-sm">
                <div class="d-flex justify-content-center">
                    <a href="newUser"><input type="button" class="btnTable" value="Nuovo Utente" /></a>
                </div>
            </th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="user" items="${listUsers}">
            <tr>
                <td><c:out value="${user.id}" /></td>
                <td><c:out value="${user.name}" /></td>
                <td><c:out value="${user.surname}" /></td>
                <td><fmt:formatDate value="${user.dateOfBirth}" pattern="dd-MM-yyyy" /></td>
                <td><c:out value="${user.fiscalCode}" /></td>
                <td><c:out value="${user.username}" /></td>
                <td>
                    <div class="d-flex justify-content-center">
                        <a href="<c:url value='editUser_${user.id}' />"><input type="button" class="btnTable" value="Modifica" /></a>
                        &nbsp;&nbsp;&nbsp;
                        <a href="<c:url value='deleteUser_${user.id}' />"><input type="button" class="btnTable" value="Elimina" /></a>
                        &nbsp;&nbsp;&nbsp;
                        <a href="<c:url value='rentals_${user.id}' />"><input type="button" class="btnTable" value="Prenotazioni" /></a>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<script>
    function searchFunction() {
        var input, field, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchUsers");
        field = document.getElementById("searchField").value;
        filter = input.value.toUpperCase();
        table = document.getElementById("usersTable");
        tr = table.getElementsByTagName("tr");
        for (i = 0; i < tr.length; i++) {
            if (field == "id"){
                td = tr[i].getElementsByTagName("td")[0];
            } else if (field == "name") {
                td = tr[i].getElementsByTagName("td")[1];
            } else if (field == "surname") {
                td = tr[i].getElementsByTagName("td")[2];
            } else if (field == "birthDate") {
                td = tr[i].getElementsByTagName("td")[3];
            } else if (field == "fiscalCode") {
                td = tr[i].getElementsByTagName("td")[4];
            } else if (field == "username") {
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
        $('#usersTable').DataTable({
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
</body>
</html>
