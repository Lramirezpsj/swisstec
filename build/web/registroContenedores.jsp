<%@page import="logica.Usuarios"%>
<%@page import="logica.Maquina"%>
<%@page import="java.util.List"%>
<%@include file="components/header.jsp"%>
<!DOCTYPE html>
<html>

    <body>
        <link rel="stylesheet" href="css/contenedor.css">

        <div class="container-registro">
            <main class="content-registro">
                <section class="form-section-registro">
                    <h2>Registro de contenedores</h2>
                    <form action="SvContenedor" method="POST" class="row">
                        <input type="datetime-local" id="fecha" name="fecha" placeholder="Fecha" required>
                        <!-- Combo de selección maquina, llenado dinámicamente desde la lista de maquinas -->
                        <select id="maquina" name="maquina" class="form-control" >
                            <option value="" disabled selected>Seleccionar máquina</option>
                            <%                            HttpSession sesion = request.getSession(true);
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
                        <input type="text" id="contenedor" name="contenedor" placeholder="Contenedor" required>
                        <select id="medida" name="medida" required>
                            <option value="" disabled selected>Selecciona una medida</option>
                            <option value="20STD">20STD</option>
                            <option value="40STD">40STD</option>
                            <option value="40HC">40HC</option>
                            <option value="40RE">40RE</option>
                            <option value="45HC">45HC</option>
                            <option value="OPEN-TOP">OPEN-TOP</option>
                            <option value="FLAT-RACK">FLAT-RACK</option>
                        </select>
                        <select id="movimiento" name="movimiento" required>
                            <option value="" disabled selected>Tipo de movimiento</option>
                            <option value="INGRESO">Ingreso</option>
                            <option value="SALIDA">Salida</option>
                            <option value="RESTIVA">Restiva</option>
                            <option value="VACIADO">Vaciado</option>
                            <option value="M&R">M&R</option>
                        </select>
                        <input type="text" id="comentarios" name="comentarios" placeholder="Comentarios" >
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
                            <button type="button" class="btn btn-secondary" onclick="window.location.href = 'SvContenedor'">Salir</button>
                        </div> 
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
