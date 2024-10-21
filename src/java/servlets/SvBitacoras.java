
package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.PersistenceUnit;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Bitacoras;
import logica.Revision;


@WebServlet(name = "SvBitacoras", urlPatterns = {"/SvBitacoras"})
public class SvBitacoras extends HttpServlet {

    @PersistenceUnit(unitName = "tuUnidadDePersistencia")
    private EntityManagerFactory emf;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        EntityManager em = emf.createEntityManager();

        // Recibir datos del formulario
        String operador = request.getParameter("operador");
        String equipo = request.getParameter("equipo");
        String turno = request.getParameter("turno");
        double horometroInicial = Double.parseDouble(request.getParameter("horometroInicial"));
        double horometroFinal = Double.parseDouble(request.getParameter("horometroFinal"));
        double combustibleInicial = Double.parseDouble(request.getParameter("combustibleInicial"));
        double combustibleFinal = Double.parseDouble(request.getParameter("combustibleFinal"));

        // Crear la entidad Bitacoras
        Bitacoras bitacora = new Bitacoras();
        bitacora.setOperador(operador);
        bitacora.setEquipo(equipo);
        bitacora.setTurno(turno);
        bitacora.setHorometroInicial(horometroInicial);
        bitacora.setHorometroFinal(horometroFinal);
        bitacora.setCombustibleInicial(combustibleInicial);
        bitacora.setCombustibleFinal(combustibleFinal);

        // Recibir y procesar revisiones
        String[] descripciones = request.getParameterValues("descripcion[]");
        String[] reparacionNecesaria = request.getParameterValues("reparacionNecesaria[]");
        String[] ok = request.getParameterValues("ok[]");
        String[] observaciones = request.getParameterValues("observaciones[]");

        List<Revision> revisiones = new ArrayList<>();
        for (int i = 0; i < descripciones.length; i++) {
            Revision revision = new Revision();
            revision.setDescripcion(descripciones[i]);
            revision.setReparacionNecesaria(Boolean.parseBoolean(reparacionNecesaria[i]));
            revision.setOk(Boolean.parseBoolean(ok[i]));
            revision.setObservaciones(observaciones[i]);
            revisiones.add(revision);
        }
        bitacora.setRevisiones(revisiones);

        // Persistir la bitácora
        em.getTransaction().begin();
        em.persist(bitacora);
        em.getTransaction().commit();

        // Redirigir o mostrar un mensaje
        response.sendRedirect("registroBitacora.jsp?success=true");
    }

}
