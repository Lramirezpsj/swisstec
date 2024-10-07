<%@include file="components/header.jsp"%>
<body>
    <link rel="stylesheet" href="css/registro.css">
    <div class="container-registro">
        <main class="content-registro">
            <section class="form-section-registro">
                <h2>Registro de horometros</h2>
                <form action="SvRegistro" method="POST" class="row">
                    <input type="datetime-local" id="fecha" name="fecha" placeholder="Fecha" required>
                    <input type="number" id="hinicio" name="hinicio" placeholder="Horometro inicio" required>
                    <input type="number" id="hfinal" name="hfinal" placeholder="Horometro final" required>
                    <input type="text" id="comentarios" name="comentarios" placeholder="Comentarios" required>
                    <input type="text" id="operador" name="operador" placeholder="Operador" required>
                    <button type="submit" class="btn btn-primary">Registrar Usuario</button>
                </form>
            </section>
        </main>
    </div>
</body>

