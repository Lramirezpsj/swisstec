<%@include file="components/header.jsp"%>
<body class="bodycliente">
    <link rel="stylesheet" href="css/cliente.css">
    <div class="container-section-cliente">

        <main class="content-sectio-cliente">

            <section class="form-section-cliene">
                <h2>Registro de Clientes</h2>
                <form action="SvCliente" method="POST" class="row">
                    <input type="text" id="cliente" name="cliente" placeholder="Nombre del Cliente" required>
                        <button type="submit" class="btn btn-primary" >Registrar Cliente</button>
                </form>
            </section>
        </main>
    </div>
</body>
