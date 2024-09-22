
package logica;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Maquina implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id_maquina;
    private String maquina;

    public Maquina() {
    }

    public Maquina(int id_maquina, String maquina) {
        this.id_maquina = id_maquina;
        this.maquina = maquina;
    }

    public int getId_maquina() {
        return id_maquina;
    }

    public void setId_maquina(int id_maquina) {
        this.id_maquina = id_maquina;
    }

    public String getMaquina() {
        return maquina;
    }

    public void setMaquina(String maquina) {
        this.maquina = maquina;
    }
    
    
}
