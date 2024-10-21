<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registro de Bitácora</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h2>Registro de Bitácora de Maquinaria</h2>
        <form action="SvBitacoras" method="post">
            <!-- Información del operador y equipo -->
            <div class="form-group">
                <label for="operador">Operador:</label>
                <input type="text" class="form-control" id="operador" name="operador" required>
            </div>

            <div class="form-group">
                <label for="equipo">Equipo:</label>
                <input type="text" class="form-control" id="equipo" name="equipo" required>
            </div>

            <div class="form-group">
                <label for="turno">Turno:</label>
                <input type="text" class="form-control" id="turno" name="turno" required>
            </div>

            <!-- Horómetro y combustible -->
            <div class="form-group">
                <label for="horometroInicial">Horómetro Inicial:</label>
                <input type="number" step="0.1" class="form-control" id="horometroInicial" name="horometroInicial" required>
            </div>

            <div class="form-group">
                <label for="horometroFinal">Horómetro Final:</label>
                <input type="number" step="0.1" class="form-control" id="horometroFinal" name="horometroFinal" required>
            </div>

            <div class="form-group">
                <label for="combustibleInicial">Combustible Inicial (%):</label>
                <input type="number" step="0.1" class="form-control" id="combustibleInicial" name="combustibleInicial" required>
            </div>

            <div class="form-group">
                <label for="combustibleFinal">Combustible Final (%):</label>
                <input type="number" step="0.1" class="form-control" id="combustibleFinal" name="combustibleFinal" required>
            </div>

            <!-- Revisiones de la maquinaria -->
            <h4>Revisiones</h4>
            <div id="revisiones">
                <div class="revision">
                    <div class="form-group">
                        <label for="descripcion">Descripción de la Revisión:</label>
                        <input type="text" class="form-control" name="descripcion[]" required>
                    </div>

                    <div class="form-group">
                        <label for="reparacionNecesaria">¿Requiere Reparación?</label>
                        <select class="form-control" name="reparacionNecesaria[]">
                            <option value="true">Sí</option>
                            <option value="false">No</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="ok">¿Está OK?</label>
                        <select class="form-control" name="ok[]">
                            <option value="true">Sí</option>
                            <option value="false">No</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="observaciones">Observaciones:</label>
                        <textarea class="form-control" name="observaciones[]"></textarea>
                    </div>
                </div>
            </div>

            <button type="button" class="btn btn-info" onclick="agregarRevision()">Añadir Revisión</button>
            <br><br>
            <button type="submit" class="btn btn-primary">Guardar Bitácora</button>
        </form>
    </div>

    <script>
        // Función para añadir más revisiones dinámicamente
        function agregarRevision() {
            var revisionesDiv = document.getElementById('revisiones');
            var nuevaRevision = document.createElement('div');
            nuevaRevision.classList.add('revision');
            nuevaRevision.innerHTML = `
                <div class="form-group">
                    <label for="descripcion">Descripción de la Revisión:</label>
                    <input type="text" class="form-control" name="descripcion[]" required>
                </div>
                <div class="form-group">
                    <label for="reparacionNecesaria">¿Requiere Reparación?</label>
                    <select class="form-control" name="reparacionNecesaria[]">
                        <option value="true">Sí</option>
                        <option value="false">No</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="ok">¿Está OK?</label>
                    <select class="form-control" name="ok[]">
                        <option value="true">Sí</option>
                        <option value="false">No</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="observaciones">Observaciones:</label>
                    <textarea class="form-control" name="observaciones[]"></textarea>
                </div>`;
            revisionesDiv.appendChild(nuevaRevision);
        }
    </script>
</body>
</html>

