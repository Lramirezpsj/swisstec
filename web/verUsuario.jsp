<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="logica.Usuarios"%>
<%@page import="java.util.List"%>
<%@include file="components/header.jsp"%>
<!DOCTYPE html>
<body class="body-usuarios">
    <%        // Verificar que el usuario logueado no sea null y que su rol no sea "OPERADOR"
        if (usuarioLogueado != null && !"OPERADOR".equals(usuarioLogueado.getRol()) && !"USUARIO".equals(usuarioLogueado.getRol())) {
    %>

    <style>

        .body-usuarios {
            background-color: gray;
        }

        .content-ver-usuario {
            width: 950px;
            margin: 0 auto;
            padding: 25px;
            max-width: 90%;
            min-width: 420px;
        }

        .table-ver-usuario {
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

        .btn.btn-primary.top-right-btn {
            float: right; /* Alinea el botón a la derecha */
            margin-bottom: 15px;
        }

    </style>


    <!-- Bootstrap 4 y DataTables CSS/JS -->
    <!-- Se agregan los archivos necesarios para la integración con Bootstrap y DataTables -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

    <main class="content-ver-usuario">
        <section class="table-ver-usuario">
            <h2 class="text-center">Lista de usuarios</h2>

            <!-- Botón para abrir el modal -->
            <button type="button" class="btn btn-primary top-right-btn" data-bs-toggle="modal" data-bs-target="#registroModal">
                Agregar nuevo usuario
            </button>

            <!-- Modal -->
            <div class="modal fade" id="registroModal" tabindex="-1" aria-labelledby="registroModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="registroModalLabel">Nuevo Usuario</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="SvUsuarios" method="POST">
                                <div class="mb-3">
                                    <label for="usuario" class="form-label">Usuario</label>
                                    <input type="text" class="form-control" id="usuario" name="nombreusu" required>
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" id="password" name="contrasenia" required>
                                </div>
                                <div class="mb-3">
                                    <label for="rol" class="form-label">Rol</label>
                                    <input type="text   " class="form-control" id="rol" name="rol" required>
                                </div>
                                <button type="submit" class="btn btn-primary">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="table-responsive"> <!-- Contenedor responsivo -->
                <table id="tablaUsuarios" class="table table-striped table-bordered" style="width:100%">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Usuario</th>
                            <th scope="col">Rol</th>
                            <th scope="col">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // Obtener la lista de usuarios desde la sesión
                            List<Usuarios> listaUsuarios = (List<Usuarios>) request.getSession().getAttribute("listaUsuarios");

                            // Verificamos si la lista no es nula y contiene elementos
                            if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                                // Ordenar la lista de usuarios en función del ID de manera ascendente
                                // Ordenar la lista de usuarios en función del ID de manera descendente
                                Collections.sort(listaUsuarios, Comparator.comparing(Usuarios::getId_usuario).reversed());

                                // Recorremos la lista de usuarios
                                for (Usuarios usuarioItem : listaUsuarios) {  // Renombramos 'usuario' a 'usuarioItem' para evitar el conflicto de nombres
                        %>
                        <tr class="table-light">
                            <!-- Mostrar los datos del usuario en la tabla -->
                            <td><%= usuarioItem.getId_usuario()%></td>
                            <td><%= usuarioItem.getUsuario()%></td>
                            <td><%= usuarioItem.getRol()%></td>
                            <td class="actions">
                                <!-- Botón para editar el usuario -->
                                <form action="SvEditUsuario" method="get">
                                    <button class="btn btn-success btn-sm">Editar</button>
                                    <input type="hidden" name="id" value="<%= usuarioItem.getId_usuario()%>">
                                </form>
                                <!-- Botón para eliminar el usuario -->
                                <form action="SvElimUsuario" method="post">
                                    <input type="hidden" name="id" value="<%= usuarioItem.getId_usuario()%>">
                                    <button class="btn btn-danger btn-sm">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <%
                            }  // Fin del bucle for
                        } else {  // Si la lista está vacía o es nula
                        %>
                        <tr>
                            <!-- Mostrar un mensaje cuando no hay usuarios -->
                            <td colspan="4">No hay usuarios disponibles.</td>
                        </tr>
                        <%
                            }  // Fin del condicional if
                        %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
    <script>
        $(document).ready(function () {
            $('#tablaUsuarios').DataTable({
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
    <%
        } // Cierre del if
%>
</body>
</html>

