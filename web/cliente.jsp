
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/cliente.css">
    </head>
    <body>
        <div class="container">
            <a class="btnRegresarCliente" href="index.jsp">Regresar</a>
            <h1>Registro de clientes</h1>
            <form action="SvCliente" method="POST">
                <input type="text" id="cliente" name="cliente" placeholder="Cliente" required>
                <button type="submit">Registrar cliente</button>
            </form>
            
        </div>
    </body>
</html>
