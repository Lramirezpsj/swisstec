<%@page import="java.util.List"%>
<%@page import="logica.Maquina"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Máquina</title>
        <link rel="stylesheet" href="css/maquina.css">
    </head>
    <body>
        <div class="container">
        <nav class="navigation">
            <a class="btn" href="index.jsp">Regresar</a>
            <a class="btn" href="SvMaquina">Ver Máquina</a>
        </nav>
        
        <main class="content">
            <section class="table-section">
                <h2>Lista de Clientes</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Máquina</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        List<Maquina> listaMaquinas = (List<Maquina>) request.getSession().getAttribute("listaMaquinas");
                        if (listaMaquinas != null && !listaMaquinas.isEmpty()) {
                            for (Maquina mqn : listaMaquinas) {
                        %>
                        <tr>
                            <td><%= mqn.getId_maquina()%></td>
                            <td><%= mqn.getMaquina()%></td>
                            <td class="actions">
                                <button class="btn btn-edit">Editar</button>
                                <button class="btn btn-delete">Eliminar</button>
                            </td>
                        </tr>
                        <% 
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="3">No hay máquina disponibles.</td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </section>
            
            <section class="form-section">
                <h2>Registro de Máquina</h2>
                <form action="SvMaquina" method="POST">
                    <input type="text" id="maquina" name="maquina" placeholder="Máquina" required>
                    <a href="maquina.jsp">
                    <button type="submit" class="btn btn-submit" >Registrar Cliente</button>
                </form>
            </section>
        </main>
    </div>
    </body>
</html>
