
package persistencia;

import logica.Registro;
import logica.Usuarios;


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
    
}
