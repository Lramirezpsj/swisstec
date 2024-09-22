<%-- 
    Document   : data
    Created on : 21/09/2024, 06:00:29 PM
    Author     : ramir
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movimientos</title>
        <link rel="stylesheet" href="css/registro.css">
    </head>
    <a href="index.jsp"><-- Regresar</a>
    <body>
        <div class="container">
            <h1>Registro de Movimientos</h1>
            <form action="SvRegistro" method="POST">
                <input type="datetime-local" id="fecha" name="fecha" placeholder="Fecha" required>
                <input type="number" id="hinicio" name="hinicio" placeholder="Horometro inicio" required>
                <input type="number" id="hfinal" name="hfinal" placeholder="Horometro final" required>
                <input type="text" id="comentarios" name="c0mentarios" placeholder="Comentarios" required>
                <input type="text" id="operador" name="operador" placeholder="Operador" required>
                <button type="submit">Registrar Usuario</button>
            </form>
        </div>
    </body>
