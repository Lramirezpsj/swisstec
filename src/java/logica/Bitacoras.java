package logica;

import java.io.Serializable;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;

@Entity
public class Bitacoras implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String operador;
    private String equipo;
    private String turno;
    private double horometroInicial;
    private double horometroFinal;
    private double combustibleInicial;
    private double combustibleFinal;

    // Relación uno a muchos con Revision
    @OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinColumn(name = "bitacora_id")
    private List<Revision> revisiones;

    // Constructor

    public Bitacoras() {
    }

    public Bitacoras(Long id, String operador, String equipo, String turno, double horometroInicial, double horometroFinal, double combustibleInicial, double combustibleFinal, List<Revision> revisiones) {
        this.id = id;
        this.operador = operador;
        this.equipo = equipo;
        this.turno = turno;
        this.horometroInicial = horometroInicial;
        this.horometroFinal = horometroFinal;
        this.combustibleInicial = combustibleInicial;
        this.combustibleFinal = combustibleFinal;
        this.revisiones = revisiones;
    }
    

    // Getters y setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOperador() {
        return operador;
    }

    public void setOperador(String operador) {
        this.operador = operador;
    }

    public String getEquipo() {
        return equipo;
    }

    public void setEquipo(String equipo) {
        this.equipo = equipo;
    }

    public String getTurno() {
        return turno;
    }

    public void setTurno(String turno) {
        this.turno = turno;
    }

    public double getHorometroInicial() {
        return horometroInicial;
    }

    public void setHorometroInicial(double horometroInicial) {
        this.horometroInicial = horometroInicial;
    }

    public double getHorometroFinal() {
        return horometroFinal;
    }

    public void setHorometroFinal(double horometroFinal) {
        this.horometroFinal = horometroFinal;
    }

    public double getCombustibleInicial() {
        return combustibleInicial;
    }

    public void setCombustibleInicial(double combustibleInicial) {
        this.combustibleInicial = combustibleInicial;
    }

    public double getCombustibleFinal() {
        return combustibleFinal;
    }

    public void setCombustibleFinal(double combustibleFinal) {
        this.combustibleFinal = combustibleFinal;
    }

    public List<Revision> getRevisiones() {
        return revisiones;
    }

    public void setRevisiones(List<Revision> revisiones) {
        this.revisiones = revisiones;
    }
    
}

