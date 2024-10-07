<%@page import="java.util.List"%>
<%@page import="logica.Maquina"%>
<%@include file="components/header.jsp"%>
<body class="bodytblmqn">
    <link rel="stylesheet" href="css/maquina.css">
    <main class="content-section-tblmqn">
        <section class="table-section-tblmqn">
            <h2 class="text-center">Lista de maquinas</h2>
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
                                for (Maquina mqn : listaMaquinas) {
                        %>
                        <tr class="table-light">
                            <td><%= mqn.getId_maquina()%></td>
                            <td><%= mqn.getMaquina()%></td>
                            <td class="actions">
                                <button class="btn btn-success btn-sm"">Editar</button>
                                <button class="btn btn-danger btn-sm">Eliminar</button>
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
