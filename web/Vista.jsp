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
            .table-ver-registro th:nth-child(1), .table-ver-registro td:nth-child(1) {
                white-space: nowrap; /* Impide el quiebre de línea */
                padding-right: 15px; /* Espacio extra entre columnas */

            }
            .table-ver-registro th{
                background: #2780E3
                    ;
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
            <h1 class="text-center mb-4">Lista de horómetros</h1>

            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">
                <!-- Botón para abrir el modal -->
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
                <div style="margin-right: 25px; margin-left: 35px">
                    <button class="btn btn-success mb-2 mb-md-0" onclick="exportarExcel()">
                        <i class="fas fa-file-excel"></i> Exportar a Excel
                    </button>
                </div>
            </div>

            <!-- Botón de Búsqueda -->
            <!--<div class="input-group">
                <input type="text" class="form-control" placeholder="Buscar..." readonly data-toggle="modal" data-target="#searchModal">
                <div class="input-group-append">
                    <button class="btn btn-outline-secondary" type="button" data-toggle="modal" data-target="#searchModal">
                        <i class="fas fa-search"></i> <!-- ícono de búsqueda -->
            <!--</button>
        </div>
    </div>-->

            <div class="table-ver-registro" >
                <div class="table-responsive" style="overflow-x: auto; width: 100%;">
                    <table id="tablaRegistros" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Fecha</th>
                                <th>Máquina</th>
                                <th>Cliente</th>
                                <th>H-Inicio</th>
                                <th>H-Final</th>
                                <th>Turno</th>
                                <th>Comentarios</th>
                                <th>Operador</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>

                            <%                                List<Registro> listaRegistro = (List<Registro>) request.getSession().getAttribute("listaRegistros");
                                if (listaRegistro != null && !listaRegistro.isEmpty()) {
                                    for (Registro registro : listaRegistro) {
                            %>


                            <tr>
                                <td><%= registro.getFecha()%></td>
                                <td><%= registro.getMaquina()%></td>
                                <td><%= registro.getCliente()%></td>
                                <td><%= registro.getH_inicio()%></td>
                                <td><%= registro.getH_fin()%></td>
                                <td><%= registro.getTurno()%></td>
                                <td><%= registro.getComentarios()%></td>
                                <td><%= registro.getOperador()%></td>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <button class="btn btn-outline-primary" onclick="editarRegistro(<%= registro.getId_data()%>)" title="Editar"><i class="fas fa-edit"></i></button>

                                        <button class="btn btn-outline-info" onclick="verPDF(<%= registro.getId_data()%>)" title="Ver PDF"><i class="fas fa-file-pdf"></i></button>
                                            <%
                                                // Verificar que el usuario logueado no sea null y que su rol no sea "OPERADOR"
                                                if (usuarioLogueado != null && !"OPERADOR".equals(usuarioLogueado.getRol()) && !"USUARIO".equals(usuarioLogueado.getRol())) {
                                            %>
                                        <button class="btn btn-outline-danger" onclick="eliminarRegistro(<%= registro.getId_data()%>)" title="Eliminar"><i class="fas fa-trash"></i></button>
                                            <%
                                                } // Cierre del if
                                            %>
                                    </div>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="9" class="text-center">No hay registros disponibles.</td>
                            </tr>
                            <% }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="floating-button" onclick="mostrarFormularioNuevoRegistro()">
                <i class="fas fa-plus"></i>
            </div>
        </div>

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
                                <input type="number" class="form-control" id="hInicio" name="hinicio" required>
                            </div>
                            <div class="form-group">
                                <label for="hFinal">H-Final</label>
                                <input type="number" class="form-control" id="hFinal" name="hfinal" required>
                            </div>
                            <div class="form-group">
                                <label for="turno">Turno</label>
                                <select class="form-control" id="turno" name="turno" required>
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

        <!-- Modal de Búsqueda -->
        <div class="modal fade" id="searchModal" tabindex="-1" role="dialog" aria-labelledby="searchModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="searchModalLabel">Buscar registros</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Formulario de búsqueda dentro del modal -->
                        <form id="filterForm">
                            <div class="form-group">
                                <label for="startDate">Fecha de inicio</label>
                                <input type="date" class="form-control" id="startDate">
                            </div>
                            <div class="form-group">
                                <label for="endDate">Fecha final</label>
                                <input type="date" class="form-control" id="endDate">
                            </div>
                            <div class="form-group">
                                <label for="machine">Máquina</label>
                                <input type="text" class="form-control" id="machine">
                            </div>
                            <div class="form-group">
                                <label for="client">Cliente</label>
                                <input type="text" class="form-control" id="client">
                            </div>
                            <!-- Otros filtros según sea necesario -->
                            <button type="submit" class="btn btn-primary">Buscar</button>
                        </form>
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
                            <label for="modalFechaInicio">Fecha Inicio</label>
                            <input type="date" class="form-control mr-2 mb-2 mb-md-0" id="modalFechaInicio" name="fechaInicio">
                            <label for="modalFechaFin">Fecha Fin</label>
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

        <!-- Tabla de registros -->
        <table id="tablaRegistros" class="table table-striped">
            <thead>
                <tr>
                    <th>Fecha</th>
                    <th>Máquina</th>
                    <th>Cliente</th>
                    <th>H-Inicio</th>
                    <th>H-Final</th>
                    <th>Turno</th>
                    <th>Comentarios</th>
                    <th>Operador</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% for (Registro registroItem : listaRegistro) {%>
                <tr>
                    <td><%= new SimpleDateFormat("dd-MM-yyyy HH:mm").format(registroItem.getFecha())%></td>
                    <td><%= registroItem.getMaquina()%></td>
                    <td><%= registroItem.getCliente()%></td>
                    <td><%= registroItem.getH_inicio()%></td>
                    <td><%= registroItem.getH_fin()%></td>
                    <td><%= registroItem.getTurno()%></td>
                    <td><%= registroItem.getComentarios()%></td>
                    <td><%= registroItem.getOperador()%></td>
                    <td>
                        <<!-- Asegúrate de que este botón esté en cada fila de tu tabla -->
                        <button class="btn btn-primary btn-sm" onclick="editarRegistro(<%= registroItem.getId_data()%>)">
                            <i class="fas fa-edit"></i> Editar
                        </button>
                        <!-- Otros botones de acción -->
                    </td>
                </tr>
                <% }%>
            </tbody>
        </table>

        <!-- Modal de Actualización -->
        <div class="modal fade" id="modalActualizar" tabindex="-1" aria-labelledby="modalActualizarLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalActualizarLabel">Actualizar Registro</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="formActualizar" action="SvEditRegistro" method="post">
                        <div class="modal-body">
                            <input type="hidden" id="registroId" name="registroId">

                            <div class="mb-3">
                                <label for="fecha" class="form-label">Fecha</label>
                                <input type="datetime-local" id="fecha" name="fecha" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="maquina" class="form-label">Máquina</label>
                                <input type="text" id="maquina" name="maquina" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="cliente" class="form-label">Cliente</label>
                                <input type="text" id="cliente" name="cliente" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="hInicio" class="form-label">Hora Inicio</label>
                                <input type="number" id="hInicio" name="hInicio" class="form-control" step="0.1" required>
                            </div>

                            <div class="mb-3">
                                <label for="hFinal" class="form-label">Hora Final</label>
                                <input type="number" id="hFinal" name="hFinal" class="form-control" step="0.1" required>
                            </div>

                            <div class="mb-3">
                                <label for="turno" class="form-label">Turno</label>
                                <input type="number" id="turno" name="turno" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="comentarios" class="form-label">Comentarios</label>
                                <input type="text" id="comentarios" name="comentarios" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label for="operador" class="form-label">Operador</label>
                                <input type="text" id="operador" name="operador" class="form-control" readonly>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                        </div>
                    </form>
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                            $(document).ready(function () {
                                $('#tablaRegistros').DataTable({
                                    "pageLength": 10,
                                    "order": [[0, "desc"]],
                                    "columnDefs": [
                                        {
                                            "targets": 0,
                                            "type": "date"
                                        }
                                    ],
                                    "language": {
                                        "search": "Buscar:",
                                        "lengthMenu": "Mostrar _MENU_ registros por página",
                                        "zeroRecords": "No se encontraron registros",
                                        "info": "Mostrando página _PAGE_ de _PAGES_",
                                        "infoEmpty": "No hay registros disponibles",
                                        "infoFiltered": "(filtrado de _MAX_ registros totales)",
                                        "paginate": {
                                            "first": "Primero",
                                            "last": "Último",
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
                                window.location.href = 'SvExportarExcelRegistros';
                            }

                            function editarRegistro(id) {
                                window.location.href = 'SvEditRegistro?id=' + id;
                            }

                            // Función para abrir el modal con datos
                            function abrirModalActualizar(registro) {
                                document.getElementById('registroId').value = registro.id;
                                document.getElementById('fecha').value = registro.fecha;
                                document.getElementById('maquina').value = registro.maquina;
                                document.getElementById('cliente').value = registro.cliente;
                                document.getElementById('hInicio').value = registro.hInicio;
                                document.getElementById('hFinal').value = registro.hFinal;
                                document.getElementById('turno').value = registro.turno;
                                document.getElementById('comentarios').value = registro.comentarios;
                                document.getElementById('operador').value = registro.operador;

                                // Mostrar el modal
                                var modal = new bootstrap.Modal(document.getElementById('modalActualizar'));
                                modal.show();
                            }


                            function eliminarRegistro(id) {
                                if (confirm('¿Está seguro de que desea eliminar este registro?')) {
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

                            function editarRegistro(id) {
                                // Hacer una petición AJAX para obtener los datos del registro
                                $.ajax({
                                    url: 'SvObtenerRegistro',
                                    type: 'GET',
                                    data: {id: id},
                                    dataType: 'json',
                                    success: function (registro) {
                                        // Llenar el formulario con los datos del registro
                                        $('#registroId').val(registro.id_data);
                                        $('#fecha').val(registro.fecha);
                                        $('#maquina').val(registro.maquina);
                                        $('#cliente').val(registro.cliente);
                                        $('#hInicio').val(registro.h_inicio);
                                        $('#hFinal').val(registro.h_fin);
                                        $('#turno').val(registro.turno);
                                        $('#comentarios').val(registro.comentarios);
                                        $('#operador').val(registro.operador);

                                        // Abrir el modal
                                        var modalActualizar = new bootstrap.Modal(document.getElementById('modalActualizar'));
                                        modalActualizar.show();
                                    },
                                    error: function (xhr, status, error) {
                                        alert('Error al cargar los datos del registro: ' + error);
                                    }
                                });
                            }

                            $(document).ready(function () {
                                $('#formActualizar').on('submit', function (e) {
                                    e.preventDefault();
                                    $.ajax({
                                        url: $(this).attr('action'),
                                        type: 'POST',
                                        data: $(this).serialize(),
                                        success: function (response) {
                                            var modalActualizar = bootstrap.Modal.getInstance(document.getElementById('modalActualizar'));
                                            modalActualizar.hide();
                                            // Recargar la tabla o actualizar la fila específica
                                            location.reload();
                                        },
                                        error: function (xhr, status, error) {
                                            alert('Error al actualizar el registro: ' + error);
                                        }
                                    });
                                });
                            });
        </script>
    </body>
</html>


