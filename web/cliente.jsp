<%@page import="java.util.List"%>
<%@page import="logica.Cliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Clientes</title>
    <link rel="stylesheet" href="css/cliente.css">  
</head>
<body>
    <div class="container">
        <nav class="navigation">
            <a class="btn" href="index.jsp">Regresar</a>
            <a class="btn" href="SvCliente">Ver Cliente</a>
        </nav>
        
        <main class="content">
            <section class="table-section">
                <h2>Lista de Clientes</h2>
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Cliente</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        List<Cliente> listaClientes = (List<Cliente>) request.getSession().getAttribute("listaClientes");
                        if (listaClientes != null && !listaClientes.isEmpty()) {
                            for (Cliente clt : listaClientes) {
                        %>
                        <tr>
                            <td><%= clt.getId_cliente()%></td>
                            <td><%= clt.getCliente()%></td>
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
                            <td colspan="3">No hay clientes disponibles.</td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
            </section>
            
            <section class="form-section">
                <h2>Registro de Clientes</h2>
                <form action="SvCliente" method="POST">
                    <input type="text" id="cliente" name="cliente" placeholder="Nombre del Cliente" required>
                    <a href="cliente.jsp">
                    <button type="submit" class="btn btn-submit" >Registrar Cliente</button>
                </form>
            </section>
        </main>
    </div>
</body>
</html>
