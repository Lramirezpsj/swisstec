<%@include file="components/header.jsp"%>
<%@page import="logica.Cliente"%>
<!DOCTYPE html>
<html>
    <body>
        <link rel="stylesheet" href="css/cliente.css">
        <div class="container-section-cliente">
            <main class="content-sectio-cliente">
                <section class="form-section-cliene">
                    <%Cliente cliente = (Cliente) request.getSession().getAttribute("clienteEditar");%>

                    <form action="SvEditCliente" method="post" class="form-section-cliene">
                        <input type="text" id="cliente" value="<%=cliente.getCliente()%>" 
                               name="cliente" placeholder="Cliente" required>
                        <button type="submit">Actualizar Cliente</button>
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
