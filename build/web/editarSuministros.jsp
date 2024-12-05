<%@include file="components/header.jsp"%>
<%@page import="logica.Usuarios"%>
<%@page import="logica.Suministros"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Editar Suministros</title>
        <link rel="stylesheet" href="css/registro.css">
    </head>
    <body>
        <div class="container-registro">
            <main class="content-registro">
                <section class="form-section-registro">
                    <% 
                        Suministros suministros = (Suministros) request.getSession().getAttribute("registroEditar");
                        Usuarios usuarioRegistro = (Usuarios) request.getSession().getAttribute("usuarioLogueado");
                        String usuarioRegistro1 = usuarioRegistro != null ? usuarioRegistro.getUsuario() : "";
                    %>

                    <!-- Formulario para editar registro -->
                    <form action="SvEditSuministros" method="post" class="form-usuario" enctype="multipart/form-data">
                        <!-- Fecha -->
                        <input type="datetime-local" id="fecha" value="<%=suministros.getFecha() != null ? suministros.getFecha() : ""%>" name="fecha" placeholder="Fecha" required>

                        <!-- Máquina -->
                        <input type="text" id="maquina" value="<%=suministros.getMaquina() != null ? suministros.getMaquina() : ""%>" name="maquina" placeholder="Máquina" required>

                        <!-- Horometro -->
                        <input type="number" id="horometro" value="<%=suministros.getHorometro() != null ? suministros.getHorometro() : ""%>" step="0.1" name="horometro" placeholder="Horometro de máquina">

                        <!-- Total -->
                        <input type="number" id="total" value="<%=suministros.getTotal() != null ? suministros.getTotal() : ""%>" name="total" step="any" placeholder="Total de suministro" required>

                        <!-- Comentarios -->
                        <textarea class="form-control" id="comentarios" name="comentarios" placeholder="Comentarios"><%=suministros.getComentarios() != null ? suministros.getComentarios() : ""%></textarea>

                        <!-- Operador -->
                        <input type="text" id="operador" name="operador" value="<%= usuarioRegistro1 %>" readonly="true">
                        <br>
                        <button type="submit">Actualizar</button>
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
