
package logica;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Usuarios implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id_usuario;
    private String usuario;
    private String contrasenia;
    private String rol;

    public Usuarios() {
    }

    public Usuarios(int id_usuario, String usuario, String rol, String contrasenia) {
        this.id_usuario = id_usuario;
        this.usuario = usuario;
        this.contrasenia = contrasenia;
        this.rol = rol;
    }

    

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }
    
    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getContrasenia() {
        return contrasenia;
    }

    public void setContrasenia(String contrasenia) {
        this.contrasenia = contrasenia;
    }
    
}
