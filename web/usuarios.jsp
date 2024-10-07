<%@include file="components/header.jsp"%>
<body>
    <link rel="stylesheet" href="css/usuarios.css">
    <div class="container-user">
        <main class="content-user">
            <section class="form-user">
                <h2>Registro de Usuarios</h2>
                <form action="SvUsuarios" method="POST" class="form-usuario">
                    <input type="text" id="nombreusu" name="nombreusu" placeholder="Nombre de usuario" required>
                    <input type="password" id="contrasenia" name="contrasenia" placeholder="Contraseña" required>
                    <input type="text" id="rol" name="rol" placeholder="Rol" required>
                    <button type="submit">Registrar Usuario</button>
                </form>
            </section>
        </main>
    </div>
</body>
</html>

