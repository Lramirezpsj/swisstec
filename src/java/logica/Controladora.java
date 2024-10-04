
package logica;

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

    public void registro(String fecha, String inicio, String fin, String comentarios, String operador) {
        Registro registro = new Registro();
        
        registro.setFecha(fecha);
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
}
