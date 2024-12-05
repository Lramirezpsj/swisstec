
<%@page import="logica.Controladora"%>
<%@page import="logica.Usuarios"%>
<%@page import="logica.Suministros"%>
<%@page import="java.util.List"%>
<%@include file="components/header.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <style>

            .body-ver-suministros {
                background-color: #f8f9fa;
            }

            /* Contenedor con scroll horizontal */
            .content-ver-suministros .table-responsive {
                overflow-x: auto;
                padding: 20px;
                margin: 0 auto;
                width: 100%;
            }

            /* Ajuste de ancho mínimo de la tabla */
            .table-ver-suministros table {
                min-width: 1400px; /* Aumenta el ancho mínimo para que se fuerce el scroll */
                width: 100%;
            }

            /* Estilo de la tarjeta que contiene la tabla */
            .table-ver-suministros {
                background-color: #f8f9fa;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 20px;
            }

            /* Ajuste para la columna de Fecha */
            .table-ver-suministros th:nth-child(1), .table-ver-suministros td:nth-child(1) {
                white-space: nowrap; /* Impide el quiebre de línea */
                padding-right: 15px; /* Espacio extra entre columnas */

            }
            .table-ver-suministros th{
                background: #2780E3;
            }
            /* Aumenta el tamaño de los botones y agrega espacio */
            .btn-group-sm .btn {
                font-size: 14px; /* Ajusta el tamaño de la fuente si es necesario */
                padding: 10px 15px; /* Ajusta el relleno interno para agrandar los botones */
                margin: 0 8px; /* Agrega espacio horizontal entre los botones */

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
                .content-ver-suministros {
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
    <body class="body-ver-suministros">
        <div class="content-ver-suministros">
            <h1 class="text-center mb-4">Lista de suministros</h1>

            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4">

                <div class="d-flex flex-wrap mb-2 mb-md-0" style="margin-left: 35px">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#filtroModal">
                        Filtro
                    </button>
                </div>
                <div class="">
                    <a href="SvSuministros" class="suministros-btn">
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

            <div class="table-ver-suministros">
                <div class="table-responsive" style="overflow-x: auto; width: 100%">
                    <table id="tablaSuministros" class="table table-striped table-bordered">
                        <thead>
                            <tr>
                                <th>Acciones</th>
                                <th>Operador</th>
                                <th>Fecha</th>
                                <th>Maquina</th>
                                <th>Horometro</th>
                                <th>Total</th>
                                <th>Comentarios</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%        // Obtener la lista de suministros de la sesión
                                List<Suministros> listaSuministros = (List<Suministros>) request.getSession().getAttribute("listaSuministros");
                                if (listaSuministros == null || listaSuministros.isEmpty()) {
                            %>
                            <tr>
                                <td colspan="9" class="text-center">No hay registros disponibles.</td>
                            </tr>
                            <%
                            } else {
                                for (Suministros suministro : listaSuministros) {
                            %>
                            <tr>
                                <td>
                                    <div class="btn-group btn-group-sm" role="group">
                                        <% if (usuarioLogueado != null && !"INVITADO".equals(usuarioLogueado.getRol())) {%>
                                        <button class="btn btn-outline-primary" onclick="editarRegistro(<%= suministro.getId_suministros()%>)" title="Editar">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                        <% }%>

                                        <% if (usuarioLogueado != null && !"OPERADOR".equals(usuarioLogueado.getRol())
                                                    && !"USUARIO".equals(usuarioLogueado.getRol()) && !"INVITADO".equals(usuarioLogueado.getRol())) {%>
                                        <button class="btn btn-outline-danger" onclick="eliminarRegistro(<%= suministro.getId_suministros()%>)" title="Eliminar">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                        <% }%>
                                    </div>
                                </td>
                                <td><%= suministro.getOperador()%></td>
                                <td><%= suministro.getFecha()%></td>
                                <td><%= suministro.getMaquina()%></td>
                                <td><%= suministro.getHorometro()%></td>
                                <td><%= suministro.getTotal()%></td>
                                <td><%= suministro.getComentarios()%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>


                    </table>
                </div>
                <% if (usuarioLogueado != null && !"INVITADO".equals(usuarioLogueado.getRol())) {
                %>
                <div class="floating-button" onclick="mostrarFormularioNuevoRegistro()">
                    <i class="fa fa-plus"></i>
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
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>

                                </button>
                            </div>

                            <div class="modal-body">
                                <form id="nuevoRegistroForm" action="SvSuministros" method="post" enctype="multipart/form-data">
                                    <div class="form-group">
                                        <label for="fecha">Fecha</label>
                                        <input type="datetime-local" class="form-control" id="fecha" name="fecha" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="maquina">Máquina</label>
                                        <select id="maquina" name="maquina" class="form-control">
                                            <option value="" disabled selected>Seleccionar m quina</option>
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
                                        <label for="horometro">Horometro de máquina</label>
                                        <input type="number" class="form-control" id="hInicio" step="0.1" name="horometro" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="total">Total de suministro</label>
                                        <input type="number" class="form-control" id="total" name="total" required >
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
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                                    <button type="submit" class="btn btn-primary" style="left: ">Guardar</button>
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
                                        $('#tablaSuministros').DataTable({

                                            "pageLength": 10,
                                            "order": [[2, "desc"]],
                                            "columnDefs": [
                                                {
                                                    "targets": 0,
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
                                                    "last": " ltimo",
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
                                            url: 'SvSuministros',
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

                                        window.location.href = 'SvSuministros?action=filtrar&fechaInicio=' + fechaInicio + '&fechaFin=' + fechaFin;
                                    }

                                    function exportarExcel() {
                                        window.location.href = 'SvExportarExcelSuministros';
                                    }

                                    function editarRegistro(id) {
                                        window.location.href = 'SvEditSuministros?id=' + id;
                                    }

                                    function eliminarRegistro(id) {
                                        if (confirm(' Esta seguro de que desea eliminar este registro?')) {
                                            $.ajax({
                                                url: 'SvElimSuministros',
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

                                    function calcularTotal() {
                                        const hInicio = parseFloat(document.getElementById('hInicio').value) || 0;
                                        const hFinal = parseFloat(document.getElementById('hFinal').value) || 0;
                                        const total = hFinal - hInicio;
                                        document.getElementById('total').value = total >= 0 ? total : 0;
                                    }

                                    // Escuchar los cambios en H-Inicio y H-Final
                                    document.getElementById('hInicio').addEventListener('input', calcularTotal);
                                    document.getElementById('hFinal').addEventListener('input', calcularTotal);
    </script>
</body>
</html>
