<%@page import="java.util.List"%>
<%@page import="logica.Cliente"%>
<%@include file="components/header.jsp"%>
<body class="bodytblcliente">
    <link rel="stylesheet" href="css/cliente.css">
    <main class="content-section-tblcliente">
        <section class="table-section-tblcliente">
            <h2 class="text-center">Lista de Clientes</h2>
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
                                for (Cliente clt : listaClientes) {
                        %>
                        <tr class="table-light">
                            <td><%= clt.getId_cliente() %></td>
                            <td><%= clt.getCliente() %></td>
                            <td class="actions">
                                <button class="btn btn-success btn-sm">Editar</button> <!-- Botón de editar -->
                                <button class="btn btn-danger btn-sm">Eliminar</button> <!-- Botón de eliminar -->
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

