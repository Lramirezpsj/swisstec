<%@page import="logica.Usuarios"%>
<%@page import="java.util.List"%>
<%@include file="components/header.jsp"%>
<!DOCTYPE html>
<body class="body-usuarios">
        <link rel="stylesheet" href="css/usuarios.css">
    <main class="content-ver-usuario">
        <section class="table-ver-usuario">
            <h2 class="text-center">Lista de usuarios</h2>
            <div class="table-responsive"> <!-- Contenedor responsivo -->
            <table>
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">Usuario</th>
                        <th scope="col">Contraseña</th>
                        <th scope="col">Rol</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Usuarios> listaUsuarios = (List<Usuarios>) request.getSession().getAttribute("listaUsuarios");
                        if (listaUsuarios != null && !listaUsuarios.isEmpty()) {
                            for (Usuarios usuario : listaUsuarios) {
                    %>
                    <tr class="table-light">
                        <td><%= usuario.getId_usuario()%></td>
                        <td><%= usuario.getUsuario()%></td>
                        <td><%= usuario.getRol()%></td>
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
</html>
