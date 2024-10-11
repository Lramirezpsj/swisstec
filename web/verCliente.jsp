<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="logica.Maquina"%>
<%@page import="java.util.List"%>
<%@page import="logica.Cliente"%>
<%@include file="components/header.jsp"%>
<body class="bodytblcliente">
    <link rel="stylesheet" href="css/cliente.css">
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
                <table> <!-- Clases de Bootstrap -->
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
</body>

