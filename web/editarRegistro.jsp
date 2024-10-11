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
                        <input type="number" id="hinicio" value="<%=registro.getH_inicio()%>"
                               name="hinicio" placeholder="Horometro inicio" required>
                        <input type="number" id="hfinal" value="<%=registro.getH_fin()%>" 
                               name="hfinal" placeholder="Horometro final" required>
                        <input type="text" id="comentarios" value="<%=registro.getComentarios()%>" 
                               name="comentarios" placeholder="Comentarios" required>
                        <input type="text" id="operador" value="<%=registro.getOperador()%>" 
                               name="operador" placeholder="Operador" required>
                        <button type="submit">Actualizar registro</button>
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
