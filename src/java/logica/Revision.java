package logica;

import java.io.Serializable;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Revision implements Serializable {
    @Id

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String descripcion;
    private boolean reparacionNecesaria;
    private boolean ok;
    private String observaciones;

    // Constructor

    public Revision() {
    }

    public Revision(Long id, String descripcion, boolean reparacionNecesaria, boolean ok, String observaciones) {
        this.id = id;
        this.descripcion = descripcion;
        this.reparacionNecesaria = reparacionNecesaria;
        this.ok = ok;
        this.observaciones = observaciones;
    }

    // Getters y setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public boolean isReparacionNecesaria() {
        return reparacionNecesaria;
    }

    public void setReparacionNecesaria(boolean reparacionNecesaria) {
        this.reparacionNecesaria = reparacionNecesaria;
    }

    public boolean isOk() {
        return ok;
    }

    public void setOk(boolean ok) {
        this.ok = ok;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }
    
}

