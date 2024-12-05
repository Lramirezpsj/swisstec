<%@page import="java.util.stream.Collectors"%>
<%@page import="logica.Cliente"%>
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

<!DOCTYPE html>
<html lang="es">
    <head>
        <style>

            .body-ver-registro {
                background-color: #f8f9fa;
            }

            /* Contenedor con scroll horizontal */
            .content-ver-registro .table-responsive {
                overflow-x: auto;
                padding: 20px;
                margin: 0 auto;
                width: 100%;
            }

            /* Ajuste de ancho mínimo de la tabla */
            .table-ver-registro table {
                min-width: 1400px; /* Aumenta el ancho mínimo para que se fuerce el scroll */
                width: 100%;
            }

            /* Estilo de la tarjeta que contiene la tabla */
            .table-ver-registro {
                background-color: #f8f9fa;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }



            /* Ajuste para la columna de Fecha */
            .table-ver-registro th:nth-child(3), .table-ver-registro td:nth-child(3) {
                white-space: nowrap; /* Impide el quiebre de línea */
                padding-right: 15px; /* Espacio extra entre columnas */

            }
            .table-ver-registro th{
                background: #2780E3;
            }



            /* Aumenta el tamaño de los botones y agrega espacio */
            .btn-group-sm .btn {
                font-size: 14px; /* Ajusta el tamaño de la fuente si es necesario */
                padding: 10px 15px; /* Ajusta el relleno interno para agrandar los botones */
                margin: 0 4px; /* Agrega espacio horizontal entre los botones */

            }
            .btn {
                border-width: 1px; /* Uniforma el ancho del borde */
                outline: none; /* Elimina contornos innecesarios */
            }


            .btn-outline-primary {
                border-color: #007bff;
            }

            .btn-outline-info {
                border-color: #17a2b8;
            }

            .btn-outline-danger {
                border-color: #dc3545;
            }

            /* Elimina el margen del primer y último botón */
            .btn-group-sm .btn:first-child {
                margin-left: 0;
            }

            .btn-group-sm .btn:last-child {
                margin-right: 0;
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


            /* Ajustes para dispositivos móviles */
            @media (max-width: 768px) {
                .content-ver-registro {
                    padding: 10px;
                }
                .table-ver-registro {
                    padding: 10px;
                }
                .btn-group-sm > .btn, .btn-sm {
                    padding: .25rem .5rem;
                    font-size: .875rem;
                    line-height: 1.5;
                }
            }
        </style>
    </head>
    <body class="body-ver-registro">
        <div class="content-ver-registro">
            <h1 class="text-center mb-4">Lista de horometros</h1>

            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">

                <div class="d-flex flex-wrap mb-2 mb-md-0" style="margin-left: 35px">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filtroModal">
                        Filtrar
                    </button>
                </div>
                <div class="">
                    <a href="SvRegistro" class="cliente-btn">
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

            <div class="table-ver-registro" >
                <div class="table-responsive" style="overflow-x: auto; width: 100%;">
                    <table id="tablaRegistros" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Acciones</th>
                                <th>Operador</th>
                                <th>Fecha</th>
                                <th>Maquina</th>
                                <th>Cliente</th>
                                <th>H-Inicio</th>
                                <th>H-Final</th>
                                <th>Turno</th>
                                <th>Comentarios</th>                                
                            </tr>
                        </thead>
                        <tbody>
                            <%        List<Registro> listaRegistro = (List<Registro>) request.getSession().getAttribute("listaRegistros");
                                String fechaInicioParam = request.getParameter("fechaInicio");
                                String fechaFinParam = request.getParameter("fechaFin");
                                List<Registro> registrosFiltrados = new ArrayList<>();

                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                                SimpleDateFormat formatoEntrada = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                                SimpleDateFormat formatoSalida = new SimpleDateFormat("dd-MM-yyyy HH:mm");

                                if (listaRegistro != null && !listaRegistro.isEmpty()) {
                                    Collections.sort(listaRegistro, Comparator.comparing(Registro::getId_data).reversed());
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

                                    for (Registro registroItem : registrosFiltrados) {
                                        try {
                                            Date fechaRegistro = formatoEntrada.parse(registroItem.getFecha());
                                            String fechaFormateada = formatoSalida.format(fechaRegistro);
                            %>
                            <tr>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <%
                                            boolean puedeEditar = usuarioLogueado != null && !"USUARIO".equals(usuarioLogueado.getRol()) && !"USUARIO".equals(usuarioLogueado.getRol()) && !"INVITADO".equals(usuarioLogueado.getRol());
                                        %>
                                        <% if (puedeEditar) {%>
                                        <button class="btn btn-outline-primary" onclick="editarRegistro(<%= registroItem.getId_data()%>)" title="Editar">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <% }%>
                                        <button class="btn btn-outline-info" onclick="verPDF(<%= registroItem.getId_data()%>)" title="Ver PDF">
                                            <i class="fas fa-file-pdf"></i>
                                        </button>
                                        <%
                                            boolean puedeEliminar = usuarioLogueado != null && !"OPERADOR".equals(usuarioLogueado.getRol()) && !"USUARIO".equals(usuarioLogueado.getRol()) && !"INVITADO".equals(usuarioLogueado.getRol());
                                        %>

                                        <% if (puedeEliminar) {%>
                                        <button class="btn btn-outline-danger" onclick="eliminarRegistro(<%= registroItem.getId_data()%>)" title="Eliminar">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <% }%>
                                    </div>
                                </td>
                                <td><%= registroItem.getOperador()%></td>
                                <td><%= fechaFormateada%></td>
                                <td><%= registroItem.getMaquina()%></td>
                                <td><%= registroItem.getCliente()%></td>
                                <td><%= registroItem.getH_inicio()%></td>
                                <td><%= registroItem.getH_fin()%></td>
                                <td><%= registroItem.getTurno()%></td>
                                <td><%= registroItem.getComentarios()%></td>
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
            </div>

            <%
                boolean puedeAgregar = usuarioLogueado != null && !"USUARIO".equals(usuarioLogueado.getRol()) && !"INVITADO".equals(usuarioLogueado.getRol());
            %>
            <% if (puedeAgregar) {%>
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
                                    <label for="cliente">Cliente</label>
                                    <select id="cliente" name="cliente" class="form-control">
                                        <option value="" disabled selected>Seleccionar cliente</option>
                                        <%
                                            List<Cliente> listaClientes = (List<Cliente>) request.getSession().getAttribute("listaClientes");
                                            if (listaClientes != null) {
                                                for (Cliente cliente : listaClientes) {
                                        %>
                                        <option value="<%= cliente.getCliente()%>"><%= cliente.getCliente()%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="hInicio">H-Inicio</label>
                                    <input type="number" class="form-control" id="hInicio" step="0.1" name="hinicio" required>
                                </div>
                                <div class="form-group">
                                    <label for="hFinal">H-Final</label>
                                    <input type="number" class="form-control" id="hFinal" step="0.1" name="hfinal" required>
                                </div>
                                <div class="form-group">
                                    <label for="turno">Turno</label>
                                    <select class="form-control" id="turno" name="turno" required>
                                        <option value="" disabled selected>Seleccionar Turno</option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
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
                                    $.fn.dataTable.moment('DD-MM-YYYY HH:mm:ss'); // Configura el formato de fecha
                                    $('#tablaRegistros').DataTable({
                                        "pageLength": 10,
                                        "order": [[3, "desc"]],
                                        "columnDefs": [
                                            {
                                                "targets": 3,
                                                "type": "datetime"
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
                                    $('#nuevoRegistroForm')[0].reset(); // Reiniciar el formulario
                                    $('#nuevoRegistroModal').modal('show');
                                }

                                function guardarNuevoRegistro() {
                                    $.ajax({
                                        url: 'SvRegistro',
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

                                    window.location.href = 'SvRegistro?action=filtrar&fechaInicio=' + fechaInicio + '&fechaFin=' + fechaFin;
                                }



                                function exportarExcel() {
                                    window.location.href = 'SvExportarExcel';
                                }

                                function editarRegistro(id) {
                                    window.location.href = 'SvEditRegistro?id=' + id;
                                }

                                function eliminarRegistro(id) {
                                    if (confirm(' Esta seguro de que desea eliminar este registro?')) {
                                        $.ajax({
                                            url: 'SvElimRegistro',
                                            type: 'POST',
                                            data: {id: id},
                                            success: function (response) {
                                                location.reload();
                                            },
                                            error: function (xhr, status, error) {
                                                alert('Error al eliminar el registro: ' + error);
                                            }
                                        });
                                    }
                                }

                                function verPDF(id) {
                                    window.open('SvExportarPdfRegistro?id=' + id, '_blank');
                                }
            </script>
    </body>
</html>