<%@include file="components/header.jsp"%>
<body class="bodymqn">
    <link rel="stylesheet" href="css/maquina.css">     
    <div class="container-section-mqn">
        <main class="content">
            <section class="form-section-mqn">
                <h2>Registro de Máquina</h2>
                <form action="SvMaquina" method="POST" class="row">
                    <input type="text" id="maquina" name="maquina" placeholder="Máquina" required>
                    <button type="submit" class="btn btn-primary" >Registrar Cliente</button>
                </form>
            </section>
        </main>
    </div>
</body>
