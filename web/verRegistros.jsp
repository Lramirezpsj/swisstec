<%@page import="logica.Registro"%>
<%@page import="java.util.List"%>
<%@include file="components/header.jsp"%>
<body class="body-ver-registro">
    <link rel="stylesheet" href="css/registro.css">
    <main class="content-ver-registro">
        <section class="table-ver-registro">
            <h2 class="text-center">Lista de horometros</h2>
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
                            for (Registro registro : listaRegistro) {
                    %>
                    <tr class="table-light">
                        <td><%= registro.getId_data()%></td>
                        <td><%= registro.getFecha()%></td>
                        <td><%= registro.getH_inicio()%></td>
                        <td><%= registro.getH_fin()%></td>
                        <td><%= registro.getComentarios()%></td>
                        <td><%= registro.getOperador()%></td>
                        <td class="actions">
                            <button class="btn btn-success btn-sm">Editar</button>
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
