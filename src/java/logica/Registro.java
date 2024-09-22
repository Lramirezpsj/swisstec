
package logica;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Registro implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id_data;
    private String fecha;
    private String h_inicio;
    private String h_fin;
    private String comentarios;
    private String operador;

    public Registro() {
    }

    public Registro(int id_data, String fecha, String h_inicio, String h_fin, String comentarios, String operador) {
        this.id_data = id_data;
        this.fecha = fecha;
        this.h_inicio = h_inicio;
        this.h_fin = h_fin;
        this.comentarios = comentarios;
        this.operador = operador;
    }

    public int getId_data() {
        return id_data;
    }

    public void setId_data(int id_data) {
        this.id_data = id_data;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getH_inicio() {
        return h_inicio;
    }

    public void setH_inicio(String h_inicio) {
        this.h_inicio = h_inicio;
    }

    public String getH_fin() {
        return h_fin;
    }

    public void setH_fin(String h_fin) {
        this.h_fin = h_fin;
    }

    public String getComentarios() {
        return comentarios;
    }

    public void setComentarios(String comentarios) {
        this.comentarios = comentarios;
    }

    public String getOperador() {
        return operador;
    }

    public void setOerador(String operador) {
        this.operador = operador;
    }
    
    
}
