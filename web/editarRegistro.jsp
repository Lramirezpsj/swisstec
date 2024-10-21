<%@include file="components/header.jsp"%>
<%@page import="logica.Registro"%>
<!DOCTYPE html>
<html>
    <body>
        <link rel="stylesheet" href="css/registro.css">
        <div class="container-registro">
            <main class="content-registro">
                <section class="form-section-registro">
                    <%Registro registro = (Registro) request.getSession().getAttribute("registroEditar");%>

                    <form action="SvEditRegistro" method="post" class="form-usuario">
                        <input type="datetime-local" id="fecha" value="<%=registro.getFecha()%>" 
                               name="fecha" placeholder="Fecha" required>
                        <input type="text" id="maquina" value="<%=registro.getMaquina()%>" 
                               name="maquina" placeholder="maquina" required>
                        <input type="number" id="hinicio" value="<%=registro.getH_inicio()%>"
                               name="hinicio" placeholder="Horometro inicio" required>
                        <input type="number" id="hfinal" value="<%=registro.getH_fin()%>" 
                               name="hfinal" placeholder="Horometro final" required>
                        <input type="text" id="comentarios" value="<%=registro.getComentarios()%>" 
                               name="comentarios" placeholder="Comentarios" required>
                        <%
                        Usuarios usuarioRegistro = (Usuarios) request.getSession().getAttribute("usuarioLogueado");
                        String usuarioRegistro1 = null;
                        if (usuarioRegistro != null) {
                            usuarioRegistro1 = usuarioRegistro.getUsuario(); // Obtiene el nombre del usuario
                        }
                    %>
                        <input type="text"id="operador" name="operador" value="<%= usuarioRegistro1 != null ? usuarioRegistro1 : ""%>" readonly="true">
                        <button type="submit">Actualizar registro</button>
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
