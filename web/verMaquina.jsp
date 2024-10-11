<%@page import="java.util.Comparator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="logica.Maquina"%>
<%@include file="components/header.jsp"%>
<body class="bodytblmqn">
    <link rel="stylesheet" href="css/maquina.css">
    <main class="content-section-tblmqn">
        <section class="table-section-tblmqn">
            <h2 class="text-center">Lista de maquinas</h2>
            <!-- Botón para agregar un nueva maquina en la parte superior derecha -->
            <div class="text-right" style="margin-bottom: 15px; text-align: right">
                <form action="maquina.jsp" method="get">
                    <button class="btn btn-primary">Agregar máquina</button>
                </form>
            </div>
            <div class="table-responsive"> <!-- Contenedor responsivo -->
                <table>
                    <thead class="thead-dark">
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Máquina</th>
                            <th scope="col">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Maquina> listaMaquinas = (List<Maquina>) request.getSession().getAttribute("listaMaquinas");
                            if (listaMaquinas != null && !listaMaquinas.isEmpty()) {
                                // Ordenar la lista de usuarios en función del ID de manera descendente
                            Collections.sort(listaMaquinas, Comparator.comparing(Maquina::getId_maquina).reversed());
                                
                                for (Maquina mqn : listaMaquinas) {
                        %>
                        <tr class="table-light">
                            <td><%= mqn.getId_maquina()%></td>
                            <td><%= mqn.getMaquina()%></td>
                            <td class="actions">
                                <!-- Botón para editar el maquina -->
                                <form action="SvEditMaquina" method="get">
                                    <button class="btn btn-success btn-sm">Editar</button>
                                    <input type="hidden" name="id" value="<%= mqn.getId_maquina()%>">
                                </form>
                                <!-- Botón para eliminar el maquina -->
                                <form action="SvElimMaquina" method="post">
                                    <input type="hidden" name="id" value="<%= mqn.getId_maquina()%>">
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
