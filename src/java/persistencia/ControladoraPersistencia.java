
package persistencia;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import logica.Cliente;
import logica.Maquina;
import logica.Registro;
import logica.Usuarios;
import persistencia.exceptions.NonexistentEntityException;


public class ControladoraPersistencia {
    
    ClienteJpaController clienteJpa = new ClienteJpaController();
    RegistroJpaController registroJpa = new RegistroJpaController();
    MaquinaJpaController maquinaJpa = new MaquinaJpaController();
    UsuariosJpaController usuarioJpa = new UsuariosJpaController();

    public void crearUsuario(Usuarios usu) {
        usuarioJpa.create(usu);
    }

    public void registro(Registro registro) {
        registroJpa.create(registro);
    }

    public void maquina(Maquina maquina) {
        maquinaJpa.create(maquina);
    }

    public void cliente(Cliente clt) {
        clienteJpa.create(clt);
    }

    public List<Cliente> getClientes() {
        return clienteJpa.findClienteEntities();
    }

    public List<Maquina> getMaquina() {
        return maquinaJpa.findMaquinaEntities();
    }

    public List<Registro> getregistro() {
        return registroJpa.findRegistroEntities();
    }

    public List<Usuarios> getUsuarios() {
        return usuarioJpa.findUsuariosEntities();
    }

    public Usuarios traerUsuario(int id) {
        return usuarioJpa.findUsuarios(id);
    }
     public void editarUsuario(Usuarios usu) {
        try {
            usuarioJpa.edit(usu);
        } catch (Exception ex) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Registro traerRegistro(int id) {
        return registroJpa.findRegistro(id);
    }

    public void editarRegistro(Registro registro) {
        try {
            registroJpa.edit(registro);
        } catch (Exception e) {
        }
    }

    public Maquina traerMaquina(int id) {
        return maquinaJpa.findMaquina(id);
    }
    
    public void editarMaquina(Maquina maquina) {
        try {
            maquinaJpa.edit(maquina);
        } catch (Exception e) {
        }
    }

    public Cliente traerCliente(int id) {
        return clienteJpa.findCliente(id);
    }

    public void editarCliente(Cliente clt) {
        try {
            clienteJpa.edit(clt);
        } catch (Exception e) {
        }
    }
    
    public void borrarUsuario(int id) {
        try {
            usuarioJpa.destroy(id);
        } catch (NonexistentEntityException e) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void borrarRegistro(int id) {
        try {
            registroJpa.destroy(id);
        } catch (NonexistentEntityException e) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void borrarMaquina(int id) {
        try {
            maquinaJpa.destroy(id);
        } catch (NonexistentEntityException e) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, e);
        }
    }

    public void borrarCliente(int id) {
        try {
            clienteJpa.destroy(id);
        } catch (NonexistentEntityException e) {
            Logger.getLogger(ControladoraPersistencia.class.getName()).log(Level.SEVERE, null, e);
        }
    }
    
}
