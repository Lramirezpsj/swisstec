package logica;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import persistencia.ControladoraPersistencia;

public class Controladora {

    ControladoraPersistencia controlPersis = new ControladoraPersistencia();

    public void crearUsuario(String usuario, String contrasenia, String rol) {

        Usuarios usu = new Usuarios();

        usu.setUsuario(usuario);
        usu.setContrasenia(contrasenia);
        usu.setRol(rol);

        controlPersis.crearUsuario(usu);

    }

    public void registro(String fecha, String maquina, String cliente, String inicio, String fin, String turno, String comentarios, String operador) {
        Registro registro = new Registro();

        registro.setFecha(fecha);
        registro.setMaquina(maquina);
        registro.setCliente(cliente);
        registro.setH_inicio(inicio);
        registro.setH_fin(fin);
        registro.setTurno(turno);
        registro.setComentarios(comentarios);
        registro.setOerador(operador);

        controlPersis.registro(registro);
    }

    public void maquina(String maquina) {

        Maquina mqn = new Maquina();
        mqn.setMaquina(maquina);
        controlPersis.maquina(mqn);
    }

    public void cliente(String cliente) {
        Cliente clt = new Cliente();
        clt.setCliente(cliente);
        controlPersis.cliente(clt);
    }

    public void contenedores(String fecha, String maquina, String contenedor, String medida, String movimiento, String comentarios, String operador) {
        RegistroContenedores registroContenedores = new RegistroContenedores();

        registroContenedores.setFecha(fecha);
        registroContenedores.setMaquina(maquina);
        registroContenedores.setContenedor(contenedor);
        registroContenedores.setMedida(medida);
        registroContenedores.setMovimiento(movimiento);
        registroContenedores.setComentarios(comentarios);
        registroContenedores.setOperador(operador);

        controlPersis.registroContenedores(registroContenedores);
    }

    public List<Cliente> getClientes() {
        return controlPersis.getClientes();
    }

    public List<Maquina> getMaquina() {
        return controlPersis.getMaquina();
    }

    public List<Registro> getRegistro() {
        return controlPersis.getregistro();
    }

    public List<Usuarios> getUsuarios() {
        return controlPersis.getUsuarios();
    }

    public List<RegistroContenedores> getRegistroContenedores() {
        return controlPersis.getRegistroContenedores();
    }

    public List<Registro> getRegistrosPorFecha(String fechaInicio, String fechaFin) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Registro> registrosFiltrados = new ArrayList<>();

        try {
            Date inicio = sdf.parse(fechaInicio);
            Date fin = sdf.parse(fechaFin);

            for (Registro registro : getRegistro()) {
                Date fechaRegistro = sdf.parse(registro.getFecha());

                if (!fechaRegistro.before(inicio) && !fechaRegistro.after(fin)) {
                    registrosFiltrados.add(registro);
                }
            }
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return registrosFiltrados;
    }

    public Usuarios traerUsuario(int id) {
        return controlPersis.traerUsuario(id);
    }

    public void editarUsuario(Usuarios usu) {
        controlPersis.editarUsuario(usu);
    }

    public Registro traerRegistro(int id) {
        return controlPersis.traerRegistro(id);
    }

    public void editarRegistro(Registro registro) {
        controlPersis.editarRegistro(registro);
    }

    public Maquina traerMaquina(int id) {
        return controlPersis.traerMaquina(id);
    }

    public void editarMaquina(Maquina maquina) {
        controlPersis.editarMaquina(maquina);
    }

    public Cliente traerCliente(int id) {
        return controlPersis.traerCliente(id);
    }

    public void editarCliente(Cliente clt) {
        controlPersis.editarCliente(clt);
    }

    public RegistroContenedores traerContenedor(int id) {
        return controlPersis.traerContenedor(id);
    }

    public void editarRegistroContenedor(RegistroContenedores registro) {
        controlPersis.editarRegistroContenedor(registro);
    }

    public void borrarUsuario(int id) {
        controlPersis.borrarUsuario(id);
    }

    public void borrarRegistro(int id) {
        controlPersis.borrarRegistro(id);
    }

    public void borrarMaquina(int id) {
        controlPersis.borrarMaquina(id);
    }

    public void borrarCliente(int id) {
        controlPersis.borrarCliente(id);
    }

    public void borrarContenedor(int id) {
        controlPersis.borrarContenedor(id);
    }

    // Método actualizado para retornar un objeto Usuarios si las credenciales son correctas
    public Usuarios comprobarIngreso(String usuario, String password) {
        List<Usuarios> listaUsuarios = controlPersis.getUsuarios();

        for (Usuarios usu : listaUsuarios) {
            if (usu.getUsuario().equals(usuario) && usu.getContrasenia().equals(password)) {
                // Retornar el objeto Usuarios si las credenciales coinciden
                return usu;
            }
        }
        // Si no coincide ningún usuario, retornar null
        return null;
    }

    // Método para obtener un registro por ID
    public Registro obtenerRegistroPorId(int id) {
        Registro registro = controlPersis.traerRegistro(id);
        if (registro == null) {
            // Manejo de caso donde no se encuentra el registro
            throw new RuntimeException("Registro no encontrado con ID: " + id);
        }
        return registro;
    }

}
