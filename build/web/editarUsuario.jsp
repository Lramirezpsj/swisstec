<%@include file="components/header.jsp"%>
<%@page import="logica.Usuarios"%>
<!DOCTYPE html>
<html>

    <body>
        <link rel="stylesheet" href="css/usuarios.css">
        <div class="container-user">
            <main class="content-user">
                <section class="form-user">
                    <%Usuarios usu = (Usuarios) request.getSession().getAttribute("usuEditar");%>

                    <form action="SvEditUsuario" method="post" class="form-usuario">
                        <input type="text" id="nombreusu" value="<%=usu.getUsuario()%>" 
                               name="nombreusu" placeholder="Nombre de usuario" required>
                        <input type="password" id="contrasenia" value="<%=usu.getContrasenia()%>"
                               name="contrasenia" placeholder="Contraseña" required>
                        <input type="text" id="rol" value="<%=usu.getRol()%>" name="rol" placeholder="Rol" required>
                        <button type="submit">Actualizar Usuario</button>
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
