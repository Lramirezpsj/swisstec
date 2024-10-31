<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="logica.Maquina"%>
<%@include file="components/header.jsp"%>
<body class="body-ver-maquina">
    <style>
        /* Estilos generales */
.body-ver-maquina {
    background-color: gray;
}

.content-section-tblmqn {
    width: 720px;
    margin: 0 auto;
    padding: 20px;
    max-width: 90%;
    min-width: 420px;
}

.table-section-tblmqn {
    background-color: #ffffff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

table {
    width: auto;
    margin-left: auto;
    margin-right: auto;
    border-collapse: collapse;
    margin-bottom: 20px;

}

table, th, td {
    border: 1px solid #dddddd;
}

th, td {
    padding: 12px 15px;
    text-align: left;
}

th {
    background-color: #007bff;
    color: white;
}

tr:nth-child(even) {
    background-color: #f2f2f2;
}

.actions {
    display: flex;
    gap: 10px;
}

.btn {
    padding: 8px 12px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 14px;
    color: white;
}

.btn-edit {
    background-color: #28a745;
}

.btn-edit:hover {
    background-color: #218838;
}

.btn-delete {
    background-color: #dc3545;
}

.btn-delete:hover {
    background-color: #c82333;
}

/* Ajustes para dispositivos móviles */
@media (max-width: 768px) {


    .icono {
        width: 25px;
    }


}
    </style>
    <!-- Bootstrap 4 y DataTables CSS/JS -->
    <!-- Se agregan los archivos necesarios para la integración con Bootstrap y DataTables -->
      <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
    
    <main class="content-section-tblmqn">
        <section class="table-section-tblmqn">
            <h2 class="text-center">Lista de máquinas</h2>
            <!-- Botón para agregar un nueva maquina en la parte superior derecha -->
            <div class="text-right" style="margin-bottom: 15px; text-align: right">
                <form action="maquina.jsp" method="get">
                    <button class="btn btn-primary">Agregar máquina</button>
                </form>
            </div>
            <div class="table-responsive"> <!-- Contenedor responsivo -->
                <table id="tablaMaquina" class="table table-striped table-bordered" style="width:100%">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Máquina</th>
                            <th scope="col">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Maquina> listaMaquinas = (List<Maquina>) request.getSession().getAttribute("listaMaquinas");
                            if (listaMaquinas != null && !listaMaquinas.isEmpty()) {
                                // Ordenar la lista de usuarios en función del ID de manera descendente
                                Collections.sort(listaMaquinas, Comparator.comparing(Maquina::getId_maquina).reversed());

                                for (Maquina mqn : listaMaquinas) {
                        %>
                        <tr class="table-light">
                            <td><%= mqn.getId_maquina()%></td>
                            <td><%= mqn.getMaquina()%></td>
                            <td class="actions">
                                <!-- Botón para editar el maquina -->
                                <form action="SvEditMaquina" method="get">
                                    <button class="btn btn-success btn-sm">Editar</button>
                                    <input type="hidden" name="id" value="<%= mqn.getId_maquina()%>">
                                </form>
                                <!-- Botón para eliminar el maquina -->
                                <form action="SvElimMaquina" method="post">
                                    <input type="hidden" name="id" value="<%= mqn.getId_maquina()%>">
                                    <button class="btn btn-danger btn-sm">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="3">No hay máquina disponibles.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
        </section>
    </main>
    <script>
        $(document).ready(function () {
            $('#tablaMaquina').DataTable({
                "pagingType": "simple_numbers", // Paginación estilo Bootstrap
                "lengthMenu": [5, 10, 25, 50], // Opciones de cantidad de filas
                "pageLength": 10, // Cantidad de filas mostradas por defecto
                "language": {
                    "search": "Buscar:",
                    "lengthMenu": "Mostrar _MENU_ entradas",
                    "info": "Mostrando _START_ a _END_ de _TOTAL_ entradas",
                    "paginate": {
                        "previous": "Anterior",
                        "next": "Siguiente"
                    }
                }
            });
        });
    </script>
</body>
