    package logica;

    import java.io.Serializable;
    import javax.persistence.Entity;
    import javax.persistence.GeneratedValue;
    import javax.persistence.GenerationType;
    import javax.persistence.Id;

    @Entity
    public class Suministros implements Serializable{

        @Id
        @GeneratedValue(strategy = GenerationType.AUTO)
        int id_suministros;
        String fecha;
        String maquina;
        String horometro;
        String total;
        String comentarios;
        String operador;

        public Suministros() {
        }

        public Suministros(int id_suministros, String fecha, String maquina, String horometro, String total, String comentarios, byte[] foto, String operador) {
            this.id_suministros = id_suministros;
            this.fecha = fecha;
            this.maquina = maquina;
            this.horometro = horometro;
            this.total = total;
            this.comentarios = comentarios;
            this.operador = operador;
        }

        // Getters y setters
        public int getId_suministros() {
            return id_suministros;
        }

        public void setId_suministros(int id_suministros) {
            this.id_suministros = id_suministros;
        }

        public String getFecha() {
            return fecha;
        }

        public void setFecha(String fecha) {
            this.fecha = fecha;
        }

        public String getMaquina() {
            return maquina;
        }

        public void setMaquina(String maquina) {
            this.maquina = maquina;
        }

        public String getHorometro() {
            return horometro;
        }

        public void setHorometro(String horometro) {
            this.horometro = horometro;
        }


        public String getTotal() {
            return total;
        }

        public void setTotal(String total) {
            this.total = total;
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
