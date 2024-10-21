<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="logica.Maquina"%>
<%@page import="java.util.List"%>
<%@page import="logica.Cliente"%>
<%@include file="components/header.jsp"%>
<body class="bodytblcliente">
    <link rel="stylesheet" href="css/ver-cliente.css">
    
    <!-- Bootstrap 4 y DataTables CSS/JS -->
    <!-- Se agregan los archivos necesarios para la integración con Bootstrap y DataTables -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>
    
    <main class="content-section-tblcliente">
        <section class="table-section-tblcliente">
            <h2 class="text-center">Lista de Clientes</h2>
            <!-- Botón para agregar un nuevo usuario en la parte superior derecha -->
            <div class="text-right" style="margin-bottom: 15px; text-align: right">
                <form action="cliente.jsp" method="get">
                    <button class="btn btn-primary">Agregar cliente</button>
                </form>
            </div>
            <div class="table-responsive"> <!-- Contenedor responsivo -->
                <table id="tablaCliente" class="table table-striped table-bordered" style="width:100%">
                    <thead class="thead-dark"> <!-- Estilo para el encabezado -->
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Cliente</th>
                            <th scope="col">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Cliente> listaClientes = (List<Cliente>) request.getSession().getAttribute("listaClientes");
                            if (listaClientes != null && !listaClientes.isEmpty()) {
                                // Ordenar la lista de usuarios en función del ID de manera descendente
                            Collections.sort(listaClientes, Comparator.comparing(Cliente::getId_cliente).reversed());
                            
                                for (Cliente clt : listaClientes) {
                        %>
                        <tr class="table-light">
                            <td><%= clt.getId_cliente() %></td>
                            <td><%= clt.getCliente() %></td>
                            <td class="actions">
                                <!-- Botón para editar el cliente -->
                                <form action="SvEditCliente" method="get">
                                    <button class="btn btn-success btn-sm">Editar</button>
                                    <input type="hidden" name="id" value="<%= clt.getId_cliente()%>">
                                </form>
                                <!-- Botón para eliminar el maquina -->
                                <form action="SvElimCliente" method="post">
                                    <input type="hidden" name="id" value="<%= clt.getId_cliente()%>">
                                    <button class="btn btn-danger btn-sm">Eliminar</button>
                                </form>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="3" class="text-center">No hay clientes disponibles.</td> <!-- Mensaje si no hay datos -->
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
                    <script>
        $(document).ready(function () {
            $('#tablaCliente').DataTable({
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

