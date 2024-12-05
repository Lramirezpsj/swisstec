
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <!-- Enlace a Cosmo de Bootswatch -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.1/cosmo/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-image: url('img/fondo.png');
                background-size: cover; /* Ajusta el tamaño de la imagen para cubrir toda la página */
                background-position: center; /* Centra la imagen */
                background-repeat: no-repeat; /* Evita que la imagen se repita */
                height: 100vh; /* Asegura que cubra toda la ventana */
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: gray;
            }
            .login-form {
                width: 100%;
                max-width: 400px;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            }
            .form-control {
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <div class="login-form">
            <h2 class="text-center mb-4">Login</h2>
            <form action="SvLogin" method="POST">
                <div class="form-group">
                    <label for="username">Usuario</label>
                    <input type="text" id="username" class="form-control" name="username" placeholder="Ingresa tu usuario" required>
                </div>
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password" id="password" class="form-control" name="password" placeholder="Ingresa tu contraseña" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Iniciar sesión</button>
            </form>
        </div>

        <!-- JavaScript de Bootstrap -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.1/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

