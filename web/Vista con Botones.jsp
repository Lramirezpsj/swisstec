<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Vistas con Botones</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<div class="container">
    <h2 class="my-4">Mi Vista con Botones</h2>
    
    <!-- Botones para cambiar de vista -->
    <div class="btn-group mb-3" role="group">
        <button type="button" class="btn btn-primary" onclick="mostrarVista('vista1')">Vista 1</button>
        <button type="button" class="btn btn-secondary" onclick="mostrarVista('vista2')">Vista 2</button>
    </div>

    <!-- Contenedor de vistas -->
    <div id="contenido">
        <div id="vista1" class="vista" style="display: none;">
            <h3>Contenido de la Vista 1</h3>
            <p>Esta es la primera vista.</p>
        </div>
        <div id="vista2" class="vista" style="display: none;">
            <h3>Contenido de la Vista 2</h3>
            <p>Esta es la segunda vista.</p>
        </div>
    </div>
</div>

<script>
    function mostrarVista(vistaId) {
        $(".vista").hide(); // Oculta todas las vistas
        $("#" + vistaId).show(); // Muestra solo la vista seleccionada
    }

    // Muestra la primera vista al cargar la página
    $(document).ready(function() {
        mostrarVista('vista1');
    });
</script>
</body>
</html>

