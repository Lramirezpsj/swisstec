
<%@page import="java.util.stream.Collectors"%>
<%@page import="java.util.Arrays"%>
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



<head>
    <style>
        /* Estilos generales */
        .body-ver-registro {
            background-color: #f8f9fa;
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
            border: 1px solid;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
        }

        .table-ver-registro th{
            background: #2780E3;
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

        /* Botón flotante */
        .floating-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background-color: #007bff;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
            cursor: pointer;
            transition: background-color 0.3s;
            z-index: 1000;
        }

        .floating-button:hover {
            background-color: #0056b3;
        }

    </style>
</head>
<body class="body-ver-registro">
    <!-- Bootstrap 4 y DataTables CSS/JS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap4.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap4.min.js"></script>

    <main class="content-ver-registro">
        <section class="table-ver-registro">
            <h2 class="text-center">Lista de contenedores</h2>

            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">

                <div class="d-flex flex-wrap mb-2 mb-md-0" style="margin-left: 35px">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filtroModal">
                        Filtrar
                    </button>
                </div>
                <div class="">
                    <a href="SvContenedor" class="cliente-btn">
                        <img src="img/actualizar.png" alt="Registro" class="icono" style="width: 25px">
                        Actualizar
                    </a>
                </div>
                <div style="margin-right: 30px; margin-left: 35px">
                    <button class="btn btn-success mb-2 mb-md-0" onclick="exportarExcel()">
                        <i class="fas fa-file-excel"></i> Exportar a Excel
                    </button>
                </div>
            </div>

            <div class="table-responsive">
                <table id="tablaRegistros" class="table table-striped table-bordered" style="width:100%">
                    <thead class="">
                        <tr>
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
                        <%        List<RegistroContenedores> listaRegistro = (List<RegistroContenedores>) request.getSession().getAttribute("listaRegistros");
                            String fechaInicioParam = request.getParameter("fechaInicio");
                            String fechaFinParam = request.getParameter("fechaFin");
                            List<RegistroContenedores> registrosFiltrados = new ArrayList<>();

                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            SimpleDateFormat formatoEntrada = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                            SimpleDateFormat formatoSalida = new SimpleDateFormat("dd-MM-yyyy HH:mm");

                            if (listaRegistro != null && !listaRegistro.isEmpty()) {
                                Collections.sort(listaRegistro, Comparator.comparing(RegistroContenedores::getId_contenedor).reversed());
                                if (fechaInicioParam != null && fechaFinParam != null) {
                                    try {
                                        Date fechaInicio = sdf.parse(fechaInicioParam);
                                        Date fechaFin = sdf.parse(fechaFinParam);
                                        registrosFiltrados = listaRegistro.stream()
                                                .filter(r -> {
                                                    try {
                                                        Date fechaRegistro = sdf.parse(r.getFecha());
                                                        return !fechaRegistro.before(fechaInicio) && !fechaRegistro.after(fechaFin);
                                                    } catch (ParseException e) {
                                                        return false;
                                                    }
                                                })
                                                .collect(Collectors.toList());
                                    } catch (ParseException e) {
                                        e.printStackTrace();
                                    }
                                } else {
                                    registrosFiltrados.addAll(listaRegistro);
                                }

                                for (RegistroContenedores registroItem : registrosFiltrados) {
                                    try {
                                        Date fechaRegistro = formatoEntrada.parse(registroItem.getFecha());
                                        String fechaFormateada = formatoSalida.format(fechaRegistro);
                        %>
                        <tr class="table-light">
                            <td><%= fechaFormateada%></td> <!-- Fecha formateada -->
                            <td><%= registroItem.getMaquina()%></td>
                            <td><%= registroItem.getContenedor()%></td>
                            <td><%= registroItem.getMedida()%></td>
                            <td><%= registroItem.getMovimiento()%></td>
                            <td><%= registroItem.getComentarios()%></td>
                            <td><%= registroItem.getOperador()%></td>
                            <td class="actions">
                                <!-- Mostrar acciones según el rol del usuario -->
                                <% if (usuarioLogueado != null && !"OPERADOR".equals(usuarioLogueado.getRol()) && !"INVITADO".equals(usuarioLogueado.getRol())) {%>
                                <form action="SvEditContenedor" method="get">
                                    <button class="btn btn-success btn-sm">Editar</button>
                                    <input type="hidden" name="id" value="<%= registroItem.getId_contenedor()%>">
                                </form>
                                <% }%>

                                <form action="SvExportarPdfContenedor" method="get">
                                    <input type="hidden" name="id" value="<%= registroItem.getId_contenedor()%>">
                                    <button class="btn btn-warning btn-sm">PDF</button>
                                </form>

                                <% if (usuarioLogueado != null && !"OPERADOR".equals(usuarioLogueado.getRol()) && !"USUARIO".equals(usuarioLogueado.getRol()) && !"INVITADO".equals(usuarioLogueado.getRol())) {%>
                                <form action="SvElimContenedor" method="post">
                                    <input type="hidden" name="id" value="<%= registroItem.getId_contenedor()%>">
                                    <button class="btn btn-danger btn-sm">Eliminar</button>
                                </form>
                                <% } %>
                            </td>
                        </tr>
                        <%
                                } catch (ParseException e) {
                                    e.printStackTrace();
                                }
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="9" class="text-center">No hay registros disponibles.</td>
                        </tr>
                        <% } %>
                    </tbody>


                </table>
            </div>
        </section>
    </main>
    <%
        if (usuarioLogueado != null && !"INVITADO".equals(usuarioLogueado.getRol())) {
    %>
    <div class="floating-button" onclick="mostrarFormularioNuevoRegistro()">
        <i class="fas fa-plus"></i>
    </div>
    <%
        }
    %>

    <!-- Modal para nuevo registro -->
    <div class="modal fade" id="nuevoRegistroModal" tabindex="-1" role="dialog" aria-labelledby="nuevoRegistroModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="nuevoRegistroModalLabel">Nuevo Registro</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <form id="nuevoRegistroForm" action="SvRegistro" method="post">
                        <div class="form-group">
                            <label for="fecha">fecha</label>
                            <input type="datetime-local" class="form-control" id="fecha" name="fecha" required>
                        </div>  
                        <div class="form-group">
                            <label for="maquina">Máquina</label>
                            <select id="maquina" name="maquina" class="form-control">
                                <option value="" disabled selected>Seleccionar máquina</option>
                                <%                                HttpSession sesion = request.getSession(true);
                                    List<Maquina> listaMaquinas = (List<Maquina>) request.getSession().getAttribute("listaMaquinas");
                                    if (listaMaquinas != null) {
                                        for (Maquina maquina : listaMaquinas) {
                                %>
                                <option value="<%= maquina.getMaquina()%>"><%= maquina.getMaquina()%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="contenedor">Contenedor</label>
                            <input type="text" class="form-control" id="contenedor" name="contenedor" required>
                        </div>
                        <div class="form-group">
                            <label for="medida">Medida</label>
                            <select class="form-control" id="medida" name="medida" required>
                                <option value="" disabled selected>Seleccionar medida</option>
                                <option value="20STD">20STD</option>
                                <option value="40STD">40STD</option>
                                <option value="40HC">40HC</option>
                                <option value="40RE">40RE</option>
                                <option value="45HC">45HC</option>
                                <option value="OPEN-TOP">OPEN-TOP</option>
                                <option value="FLAT-RACK">FLAT-RACK</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="movimiento">Movimiento</label>
                            <select class="form-control" id="movimiento" name="movimiento" required>
                                <option value="" disabled selected>Seleccionar movimiento</option>
                                <option value="INGRESO">INGRESO</option>
                                <option value="SALIDA">SALIDA</option>
                                <option value="RESTIVA">RESTIVA</option>
                                <option value="VACIADO">VACIADO</option>
                                <option value="M&R">M&R</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="comentarios">Comentarios</label>
                            <textarea class="form-control" id="comentarios" name="comentarios"></textarea>
                        </div>
                        <%
                            Usuarios usuarioRegistro = (Usuarios) request.getSession().getAttribute("usuarioLogueado");
                            String usuarioRegistro1 = null;
                            if (usuarioRegistro != null) {
                                usuarioRegistro1 = usuarioRegistro.getUsuario();
                            }
                        %>
                        <div class="form-group">
                            <label for="operador">Operador</label>
                            <input type="text" id="operador" name="operador" class="form-control" value="<%= usuarioRegistro1 != null ? usuarioRegistro1 : ""%>" readonly>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" onclick="guardarNuevoRegistro()">Guardar</button>
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal de filtro -->
    <div class="modal fade" id="filtroModal" tabindex="-1" aria-labelledby="filtroModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="filtroModalLabel">Filtrar Registros</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                </div>
                <div class="modal-body">
                    <div class="d-flex flex-wrap mb-2 mb-md-0">
                        <label for="modalFehaInicio"> Fecha inicio</label>
                        <input type="date" class="form-control mr-2 mb-2 mb-md-0" id="modalFechaInicio" name="fechaInicio">
                        <label for="modalFechaFin">fecha fin</label>
                        <input type="date" class="form-control mr-2 mb-2 mb-md-0" id="modalFechaFin" name="fechaFin">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" onclick="filtrarRegistros()" data-bs-dismiss="modal">Aplicar filtro</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">

    <script>
                        $(document).ready(function () {
                            $('#tablaRegistros').DataTable({
                                "pageLength": 10,
                                "order": [[2, "desc"]],
                                "columnDefs": [
                                    {
                                        "targets": 2,
                                        "type": "date"
                                    }
                                ],
                                "language": {
                                    "search": "Buscar:",
                                    "lengthMenu": "Mostrar _MENU_ registros por pagina",
                                    "zeroRecords": "No se encontraron registros",
                                    "info": "Mostrando pagina _PAGE_ de _PAGES_",
                                    "infoEmpty": "No hay registros disponibles",
                                    "infoFiltered": "(filtrado de _MAX_ registros totales)",
                                    "paginate": {
                                        "first": "Primero",
                                        "last": " ultimo",
                                        "next": "Siguiente",
                                        "previous": "Anterior"
                                    }
                                }
                            });

                            // Asegurarse de que el modal se pueda cerrar
                            $('.close, .btn-secondary').on('click', function () {
                                $('#nuevoRegistroModal').modal('hide');
                            });
                        });

                        function mostrarFormularioNuevoRegistro() {
                            // Redirige a la página registroContenedores.jsp
                            //window.location.href = 'registroContenedores.jsp';

                            $('#nuevoRegistroForm')[0].reset(); // Reiniciar el formulario
                            $('#nuevoRegistroModal').modal('show');
                        }

                        function guardarNuevoRegistro() {
                            $.ajax({
                                url: 'SvContenedor',
                                type: 'POST',
                                data: $('#nuevoRegistroForm').serialize(),
                                success: function (response) {
                                    $('#nuevoRegistroModal').modal('hide');
                                    location.reload();
                                },
                                error: function (xhr, status, error) {
                                    alert('Error al guardar el registro: ' + error);
                                }
                            });
                        }

                        function filtrarRegistros() {
                            var fechaInicio = document.getElementById('modalFechaInicio').value;
                            var fechaFin = document.getElementById('modalFechaFin').value;
                            if (!fechaInicio || !fechaFin) {
                                alert("Por favor selecciona ambas fechas para filtrar.");
                                return;
                            }

                            window.location.href = 'SvContenedor?action=filtrar&fechaInicio=' + fechaInicio + '&fechaFin=' + fechaFin;
                        }
                        function verPDF(id) {
                            window.open('SvExportarPdfContenedor?id=' + id, '_blank');
                        }

                        function exportarExcel() {
                            window.location.href = 'SvExportarExcelContenedor';
                        }

    </script>
</body>