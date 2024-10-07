<%@include file="components/header.jsp"%>
<body>
    <style>
        /* Estilo general para la cuadrícula */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(2, 1fr); /* 2 columnas de igual tamaño */
            gap: 20px;
            padding: 20px;
            max-width: 900px; /* Limitar el ancho máximo de la cuadrícula */
            margin: 0 auto; /* Centrar la cuadrícula */
        }

        /* Estilo para cada ítem */
        .grid-item {
            text-align: center;
            background-color: white; /* Fondo blanco para el cuadro */
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0px 2px 6px rgba(0, 0, 0, 0.1);
        }

        /* Estilo para los iconos medianos */
        .icono {
            width: 100px;
            height: auto;
            margin-bottom: 10px;
        }

        /* Hacer los enlaces dentro de cada grid item responsivos */
        .grid-item a {
            text-decoration: none;
            font-size: 18px;
            color: #000;
        }

        /* Ajustes para dispositivos móviles */
        @media (max-width: 768px) {
            .grid-container {
                grid-template-columns: 1fr; /* 1 columna en pantallas pequeñas */
            }

            .icono {
                width: 80px;
            }

            .grid-item a {
                font-size: 16px;
            }
        }

        /* Opciones dentro del menú de clientes */
        .cliente-opciones {
            margin-top: 10px;
        }

        .cliente-opciones a {
            display: block;
            margin-bottom: 5px;
        }

        /* Fondo de la página */
        body {
            background-color: gray;
        }
    </style>

    <div class="grid-container">
        <div class="grid-item">
            <a href="usuarios.jsp">
                <img src="img/usuario.png" alt="Usuarios" class="icono">
                Usuarios
            </a>
        </div>
        <div class="grid-item">
            <a href="registro.jsp">
                <img src="img/tiempo-restante.png" alt="Horometros" class="icono">
                Horometros
            </a>
        </div>
        <div class="grid-item">
            <a href="maquina.jsp">
                <img src="img/carretilla.png" alt="Maquina" class="icono">
                Maquina
            </a>
        </div>
        <div class="grid-item">
            <a href="usuarios.jsp" class="cliente-btn">
                <img src="img/nueva-cuenta.png" alt="Cliente" class="icono">
                Cliente
            </a>
        </div>
    </div>
</body>
</html>
