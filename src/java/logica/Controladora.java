
package logica;

import java.util.ArrayList;
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

    public void registro(String fecha, String maquina, String inicio, String fin, String comentarios, String operador) {
        Registro registro = new Registro();
        
        registro.setFecha(fecha);
        registro.setMaquina(maquina);
        registro.setH_inicio(inicio);
        registro.setH_fin(fin);
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
