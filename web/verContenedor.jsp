
<%@page import="logica.RegistroContenedores"%>
<%@page import="logica.Usuarios"%>
<%@page import="persistencia.ControladoraPersistencia"%>
<%@page import="logica.Controladora"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="logica.Registro"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@include file="components/header.jsp"%>


<body class="body-ver-registro">

    <style>
        /* Estilos generales */
        .body-ver-registro {
            background-color: gray;
        }

        .content-ver-registro {
            width: 1600px;
            margin: 0 auto;
            padding: 25px;
            max-width: 100%;
            min-width: 420px;
        }

        .table-ver-registro {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 100%;
        }

        table {
            width: auto;
            margin-left: auto;
            margin-right: auto;
            border-collapse: collapse;
            margin-bottom: 20px;
            max-width: 100%;
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
    </style>
    <!-- Bootstrap 4 y DataTables CSS/JS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>

    <main class="content-ver-registro">
        <section class="table-ver-registro">
            <h2 class="text-center">Lista de contenedores</h2>

            <div class="text-right" style="margin-bottom: 15px; text-align: right">
                <form action="registroContenedores.jsp" method="get">
                    <button class="btn btn-primary">Agregar Nuevo registro</button>
                </form>
            </div>
            <div class="text-right" style="margin-bottom: 15px; text-align: right">
                <form action="SvExportarExcelRegistros" method="get">
                    <input type="hidden" id="fechaInicioExportar" name="fechaInicio" value="<%= request.getParameter("fechaInicio")%>">
                    <input type="hidden" id="fechaFinExportar" name="fechaFin" value="<%= request.getParameter("fechaFin")%>">
                    <button class="btn btn-success">Exportar a Excel</button>
                </form>
            </div>
            <div class="text-right" style="margin-bottom: 15px; text-align: right">
                <form action="verRegistros.jsp" method="get">
                    <label for="fechaInicio">Desde:</label>
                    <input type="date" id="fechaInicio" name="fechaInicio" value="<%= request.getParameter("fechaInicio")%>" required>
                    <label for="fechaFin">Hasta:</label>
                    <input type="date" id="fechaFin" name="fechaFin" value="<%= request.getParameter("fechaFin")%>" required>
                    <button class="btn btn-primary">Filtrar</button>
                </form>
            </div>
            <div class="text-right" style="margin-bottom: 15px; text-align: right">
                <a href="SvContenedor">
                    <img src="img/actualizar.png" alt="Horometros" class="icono" width="25px">
                </a>
            </div>

            <div class="table-responsive">
                <table id="tablaRegistros" class="table table-striped table-bordered" style="width:100%">
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Fecha</th>
                            <th scope="col">Máquina</th>
                            <th scope="col">Contenedor</th>
                            <th scope="col">Medida</th>
                            <th scope="col">Movimiento</th>
                            <th scope="col">Comentarios</th>
                            <th scope="col">Operador</th>
                            <th scope="col">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<RegistroContenedores> listaRegistro = (List<RegistroContenedores>) request.getSession().getAttribute("listaRegistros");
                            String fechaInicioParam = request.getParameter("fechaInicio");
                            String fechaFinParam = request.getParameter("fechaFin");
                            List<RegistroContenedores> registrosFiltrados = new ArrayList<>();

                            if (listaRegistro != null && !listaRegistro.isEmpty()) {
                                // Ordenar la lista de registros en función del ID de manera descendente
                                Collections.sort(listaRegistro, Comparator.comparing(RegistroContenedores::getId_contenedor).reversed());

                                // Filtrar por fechas si se proporcionaron
                                if (fechaInicioParam != null && fechaFinParam != null) {
                                    try {
                                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                        Date fechaInicio = sdf.parse(fechaInicioParam);
                                        Date fechaFin = sdf.parse(fechaFinParam);

                                        for (RegistroContenedores registroItem : listaRegistro) {
                                            // Convertir la fecha del registro a Date
                                            String fechaRegistroString = registroItem.getFecha();
                                            Date fechaRegistro = sdf.parse(fechaRegistroString);

                                            if (!fechaRegistro.before(fechaInicio) && !fechaRegistro.after(fechaFin)) {
                                                registrosFiltrados.add(registroItem);
                                            }
                                        }
                                    } catch (ParseException e) {
                                        e.printStackTrace();
                                        // Manejar la excepción, tal vez mostrar un mensaje de error al usuario
                                    }
                                } else {
                                    // Si no se proporcionaron fechas, mostrar todos los registros
                                    registrosFiltrados.addAll(listaRegistro);
                                }

                                SimpleDateFormat formatoEntrada = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm"); // Para parsear la fecha que llega
                                SimpleDateFormat formatoSalida = new SimpleDateFormat("dd-MM-yyyy HH:mm"); // Para formatear la fecha como deseas

                                for (RegistroContenedores registroItem : registrosFiltrados) {
                                    Date fechaRegistro = formatoEntrada.parse(registroItem.getFecha()); // Parsear con el formato de entrada
                                    String fechaFormateada = formatoSalida.format(fechaRegistro); // Formatear con el formato de salida
%>
                        <tr class="table-light">
                            <td><%= registroItem.getId_contenedor()%></td>
                            <td><%= formatoSalida.format(fechaRegistro)%></td> <!-- Fecha formateada -->
                            <td><%= registroItem.getMaquina()%></td>
                            <td><%= registroItem.getContenedor()%></td>
                            <td><%= registroItem.getMedida()%></td>
                            <td><%= registroItem.getMovimiento()%></td>
                            <td><%= registroItem.getComentarios()%></td>
                            <td><%= registroItem.getOperador()%></td>
                            <td class="actions">

                                <!-- Botón para editar el registro -->
                                <form action="SvEditContenedor" method="get">
                                    <button class="btn btn-success btn-sm">Editar</button>
                                    <input type="hidden" name="id" value="<%= registroItem.getId_contenedor()%>">
                                </form>
                                <!-- Mostrar acciones solo si el rol no es "operador" -->
                                <%
                                    // Verificar que el usuario logueado no sea null y que su rol no sea "OPERADOR"
                                    if (usuarioLogueado != null && !"OPERADOR".equals(usuarioLogueado.getRol()) && !"USUARIO".equals(usuarioLogueado.getRol())) {
                                %>
                                <!-- Botón para eliminar el registro -->
                                <form action="SvElimContenedor" method="post">
                                    <input type="hidden" name="id" value="<%= registroItem.getId_contenedor()%>">
                                    <button class="btn btn-danger btn-sm">Eliminar</button>
                                </form>
                                <%
                                    } // Cierre del if
                                %>

                                <!-- Botón para exportar a PDF, visible para todos los roles -->
                                <form action="SvExportarPdfContenedor" method="get">
                                    <input type="hidden" name="id" value="<%= registroItem.getId_contenedor()%>">
                                    <button class="btn btn-warning btn-sm">PDF</button>
                                </form>

                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="7">No hay registros disponibles.</td>
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
            $('#tablaRegistros').DataTable({
                "pagingType": "simple_numbers",
                "lengthMenu": [5, 10, 25, 50],
                "pageLength": 10,
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
