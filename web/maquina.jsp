<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Máquina</title>
        <link rel="stylesheet" href="css/maquina.css">
    </head>
    <body>
        <div class="container">
         <a href="index.jsp" class="btnRegresarMaquina">Regresar</a>
        <h1>Registro de máquina</h1>
        <form action="SvMaquina" method="post">
            <input type="text" id="maquina" name="maquina" placeholder="Máquina" required>
            <button type="submit">
                registrar Maquina
            </button>
        </form>
        </div>
    </body>
</html>
