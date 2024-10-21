<%@page import="logica.Maquina"%>
<%@page import="logica.Usuarios"%>
<%@page import="java.util.List"%>
<%@include file="components/header.jsp"%>
<body>
    <link rel="stylesheet" href="css/registro.css">
    <div class="container-registro">
        <main class="content-registro">
            <section class="form-section-registro">
                <h2>Registro de horometros</h2>
                <form action="SvRegistro" method="POST" class="row">
                    <input type="datetime-local" id="fecha" name="fecha" placeholder="Fecha" required>
                    <!-- Combo de selección maquina, llenado dinámicamente desde la lista de maquinas -->
                    <select id="maquina" name="maquina" class="form-control" >
                        <option value="" disabled selected>Seleccionar máquina</option>
                        <%                          
                            HttpSession sesion = request.getSession(true);
                            // Obtener la lista de operadores desde la sesión
                            List<Maquina> listaMaquinas = (List<Maquina>) request.getSession().getAttribute("listaMaquinas");

                            // Verificar que la lista no sea nula
                            if (listaMaquinas != null) {
                                for (Maquina maquina : listaMaquinas) {
                        %>
                        <option value="<%= maquina.getMaquina()%>"><%= maquina.getMaquina()%></option>
                        <%
                                }
                            }
                        %>
                    </select>
                    <input type="number" id="hinicio" name="hinicio" placeholder="Horometro inicio" required>
                    <input type="number" id="hfinal" name="hfinal" placeholder="Horometro final" required>
                    <input type="text" id="comentarios" name="comentarios" placeholder="Comentarios" required>
                    <%
                        Usuarios usuarioRegistro = (Usuarios) request.getSession().getAttribute("usuarioLogueado");
                        String usuarioRegistro1 = null;
                        if (usuarioRegistro != null) {
                            usuarioRegistro1 = usuarioRegistro.getUsuario(); // Obtiene el nombre del usuario
                        }
                    %>
                    <input type="text"id="operador" name="operador" value="<%= usuarioRegistro1 != null ? usuarioRegistro1 : ""%>" readonly="true">
                    <div class="buttons">
                        <button type="submit" class="btn btn-primary">Guardar registro</button>
                        <button type="button" class="btn btn-secondary" onclick="window.location.href = 'verRegistros.jsp'">Cancelar</button>
                    </div> 
                </form>
            </section>
        </main>
    </div>
</body>

