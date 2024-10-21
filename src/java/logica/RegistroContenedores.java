
package logica;


public class RegistroContenedores {
    
    private int id_contenedor;
    private String fecha;
    private String contenedor;
    private String medida;
    private String movimiento;
    private String comentarios;
    private String operador;

    public RegistroContenedores() {
    }

    public RegistroContenedores(int id_contenedor, String fecha, String contenedor, String medida, String movimiento, String comentarios, String operador) {
        this.id_contenedor = id_contenedor;
        this.fecha = fecha;
        this.contenedor = contenedor;
        this.medida = medida;
        this.movimiento = movimiento;
        this.comentarios = comentarios;
        this.operador = operador;
    }

    public int getId_contenedor() {
        return id_contenedor;
    }

    public void setId_contenedor(int id_contenedor) {
        this.id_contenedor = id_contenedor;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getContenedor() {
        return contenedor;
    }

    public void setContenedor(String contenedor) {
        this.contenedor = contenedor;
    }

    public String getMedida() {
        return medida;
    }

    public void setMedida(String medida) {
        this.medida = medida;
    }

    public String getMovimiento() {
        return movimiento;
    }

    public void setMovimiento(String movimiento) {
        this.movimiento = movimiento;
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

    public void setOperador(String operador) {
        this.operador = operador;
    }
      
}
