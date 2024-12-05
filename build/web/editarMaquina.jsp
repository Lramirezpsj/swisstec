<%@include file="components/header.jsp"%>
<%@page import="logica.Maquina"%>
<!DOCTYPE html>
<html>

    <body>
        <link rel="stylesheet" href="css/maquina.css">
        <div class="container-section-mqn">
            <main class="content">
                <section class="form-section-mqn">
                    <%Maquina maquina = (Maquina) request.getSession().getAttribute("maquinaEditar");%>

                    <form action="SvEditMaquina" method="post" class="form-usuario">
                        <input type="text" id="maquina" value="<%=maquina.getMaquina()%>" 
                               name="maquina" placeholder="Maquina" required>
                        <button type="submit">Actualizar maquina</button>
                    </form>
                </section>
            </main>
        </div>
    </body>
</html>
