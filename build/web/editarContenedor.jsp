<%@page import="logica.RegistroContenedores"%>
<%@include file="components/header.jsp"%>
<%@page import="logica.Registro"%>
<!DOCTYPE html>
<html>
    <body>
        <link rel="stylesheet" href="css/registro.css">
        <div class="container-registro">
            <main class="content-registro">
                <section class="form-section-registro">
                    <%RegistroContenedores registro = (RegistroContenedores) request.getSession().getAttribute("registroEditar");%>

                    <form action="SvEditContenedor" method="post" class="form-usuario">
                        <input type="datetime-local" id="fecha" value="<%=registro.getFecha()%>" 
                               name="fecha" placeholder="Fecha" required>
                        <input type="text" id="maquina" value="<%=registro.getMaquina()%>" 
                               name="maquina" placeholder="maquina" required>
                        <input type="text" id="contenedor" value="<%=registro.getContenedor()%>"
                               name="contenedor" placeholder="Contenedor" required>
                        <input type="text" id="medida" value="<%=registro.getMedida()%>" 
                               name="medida" placeholder="Medida" required>
                        <input type="text" id="movimiento" value="<%=registro.getMovimiento()%>" 
                               name="movimiento" placeholder="Movimiento" required>
                        <input type="text" id="comentarios" value="<%=registro.getComentarios()%>" 
                               name="comentarios" placeholder="Comentarios">
                        <%
                        Usuarios usuarioRegistro = (Usuarios) request.getSession().getAttribute("usuarioLogueado");
                        String usuarioRegistro1 = null;
                        if (usuarioRegistro != null) {
                            usuarioRegistro1 = usuarioRegistro.getUsuario(); // Obtiene el nombre del usuario
                        }
                    %>
                        <input type="text"id="operador" name="operador" value="<%= usuarioRegistro1 != null ? usuarioRegistro1 : ""%>" readonly="true">
                        <button type="submit">Actualizar contenedor</button>
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
