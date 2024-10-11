<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="logica.Registro"%>
<%@page import="java.util.List"%>
<%@include file="components/header.jsp"%>
<body class="body-ver-registro">
    <link rel="stylesheet" href="css/registro.css">
    <main class="content-ver-registro">
        <section class="table-ver-registro">
            <h2 class="text-center">Lista de horometros</h2>
            <!-- Botón para agregar un nuevo usuario en la parte superior derecha -->
            <div class="text-right" style="margin-bottom: 15px; text-align: right">
                <form action="registro.jsp" method="get">
                    <button class="btn btn-primary">Agregar Nuevo registro</button>
                </form>
            </div>
            <div class="table-responsive"> <!-- Contenedor responsivo -->
            <table>
                <thead class="thead-dark">
                    <tr>
                        <th scope="cosl">ID</th>
                        <th scope="cosl">Fecha</th>
                        <th scope="cosl">H-Inicio</th>
                        <th scope="cosl">H-Final</th>
                        <th scope="cosl">Comentarios</th>
                        <th scope="cosl">Operador</th>
                        <th scope="cosl">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Registro> listaRegistro = (List<Registro>) request.getSession().getAttribute("listaRegistros");
                        if (listaRegistro != null && !listaRegistro.isEmpty()) {
                            // Ordenar la lista de usuarios en función del ID de manera descendente
                            Collections.sort(listaRegistro, Comparator.comparing(Registro::getId_data).reversed());
                            
                            for (Registro registroItem : listaRegistro) {
                    %>
                    <tr class="table-light">
                        <td><%= registroItem.getId_data()%></td>
                        <td><%= registroItem.getFecha()%></td>
                        <td><%= registroItem.getH_inicio()%></td>
                        <td><%= registroItem.getH_fin()%></td>
                        <td><%= registroItem.getComentarios()%></td>
                        <td><%= registroItem.getOperador()%></td>
                        <td class="actions">
                            <!-- Botón para editar el registro -->
                                <form action="SvEditRegistro" method="get">
                                    <button class="btn btn-success btn-sm">Editar</button>
                                    <input type="hidden" name="id" value="<%= registroItem.getId_data()%>">
                                </form>
                                <!-- Botón para eliminar el registro -->
                                <form action="SvElimRegistro" method="post">
                                    <input type="hidden" name="id" value="<%= registroItem.getId_data()%>">
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
</body>
