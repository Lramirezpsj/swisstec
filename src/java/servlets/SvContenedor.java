package servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.RegistroContenedores;

@WebServlet(name = "SvContenedor", urlPatterns = {"/SvContenedor"})
public class SvContenedor extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener parámetros de fecha
        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");

        List<RegistroContenedores> listaRegistro;  // Asegúrate de que este método esté retornando clientes

        if (fechaInicio != null && fechaFin != null) {
            // Llamada al método que filtra por fechas en Controladora
            listaRegistro = control.getContenedoresPorFecha(fechaInicio, fechaFin);
        } else {
            // Obtiene todos los registros si no hay fechas de filtro
            listaRegistro = control.getRegistroContenedores();
        }

        

        // Guardar la lista filtrada o completa en la sesión
        HttpSession misesion = request.getSession();
        misesion.setAttribute("listaRegistros", listaRegistro);

        // Redirigir a la página JSP
        response.sendRedirect("verContenedor.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fecha = request.getParameter("fecha");
        String maquina = request.getParameter("maquina");
        String contenedor = request.getParameter("contenedor").toUpperCase();
        String medida = request.getParameter("medida");
        String movimiento = request.getParameter("movimiento");
        String comentarios = request.getParameter("comentarios").toUpperCase();
        String operador = request.getParameter("operador");

        control.contenedores(fecha, maquina, contenedor, medida, movimiento, comentarios, operador);
        response.sendRedirect("registroContenedores.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
