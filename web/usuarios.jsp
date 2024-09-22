<%-- 
    Document   : Usuarios
    Created on : 15/09/2024, 16:27:59
    Author     : ramir
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Swisstec</title>
        <link rel="stylesheet" href="css/usuarios.css">
    </head>
    <a href="index.jsp"><-- Regresar</a>
    <body>
        <div class="container">
            <h1>Registro de Usuarios</h1>
            <form action="SvUsuarios" method="POST">
                <input type="text" id="nombreusu" name="nombreusu" placeholder="Nombre de usuario" required>
                <input type="password" id="contrasenia" name="contrasenia" placeholder="Contraseña" required>
                <input type="text" id="rol" name="rol" placeholder="Rol" required>
                <button type="submit">Registrar Usuario</button>
            </form>
        </div>
    </body>
</html>

