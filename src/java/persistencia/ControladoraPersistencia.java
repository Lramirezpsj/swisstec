
package persistencia;

import logica.Cliente;
import logica.Maquina;
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

    public void maquina(Maquina maquina) {
        maquinaJpa.create(maquina);
    }

    public void cliente(Cliente clt) {
        clienteJpa.create(clt);
    }
    
}
