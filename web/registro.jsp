<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Movimientos</title>
        <link rel="stylesheet" href="css/registro.css">
    </head>
    
    <body>
        <div class="container">
            <a href="index.jsp" class="btnRegresarRegistro">Regresar</a>
            <form action="SvRegistro" method="POST">
                <h1 class=>Registro de Movimientos</h1>
                <input type="datetime-local" id="fecha" name="fecha" placeholder="Fecha" required>
                <input type="number" id="hinicio" name="hinicio" placeholder="Horometro inicio" required>
                <input type="number" id="hfinal" name="hfinal" placeholder="Horometro final" required>
                <input type="text" id="comentarios" name="c0mentarios" placeholder="Comentarios" required>
                <input type="text" id="operador" name="operador" placeholder="Operador" required>
                <button type="submit">Registrar Usuario</button>
            </form>
        </div>
    </body>
