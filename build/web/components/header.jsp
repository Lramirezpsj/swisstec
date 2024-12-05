<%@page import="java.util.List"%>
<%@page import="logica.Maquina"%>
<%@page import="logica.Usuarios"%>
<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect("login.jsp"); // Redirigir si no hay sesión o usuario
        return;
    }
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Swisstec</title>
        <!-- Agregar Bootswatch Cosmo -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@5.3.2/dist/cosmo/bootstrap.min.css">
    </head>
    <body>

        <!-- Barra de navegación con Bootstrap -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp">Menú</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="index.jsp">Inicio</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownUsuario" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Usuarios
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownUsuario">

                                <li><a class="dropdown-item" href="SvUsuarios">Ver usuarios</a></li>
                            </ul>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownHorometro" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Horometros
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownHorometro">

                                <li><a class="dropdown-item" href="SvRegistro">Ver horometros</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMaquina" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Maquina
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownMaquina">

                                <li><a class="dropdown-item" href="SvMaquina">Ver Maquinas</a></li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownCliente" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Cliente
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdownCliente">

                                <li><a class="dropdown-item" href="SvCliente">Ver Clientes</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <div style="color: #dddddd">

                <%
                    Usuarios usuarioLogueado = (Usuarios) request.getSession().getAttribute("usuarioLogueado");
                    String nombreUsuario = usuarioLogueado.getUsuario();
                %>
                <h10 >Bienvenido, <%=nombreUsuario%></h10>
            </div>

            <div>
                <a href="SvLogout"  style="color: #dddddd">Cerrar sesión</a>
            </div>
        </div>
    </nav>


    <!-- JavaScript de Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>  

</body>
</html>
