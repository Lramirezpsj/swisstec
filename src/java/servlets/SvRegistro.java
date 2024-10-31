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
import logica.Registro;

@WebServlet(name = "SvRegistro", urlPatterns = {"/SvRegistro"})
public class SvRegistro extends HttpServlet {

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

        List<Registro> listaRegistro;

        if (fechaInicio != null && fechaFin != null) {
            // Llamada al método que filtra por fechas en Controladora
            listaRegistro = control.getRegistrosPorFecha(fechaInicio, fechaFin);
        } else {
            // Obtiene todos los registros si no hay fechas de filtro
            listaRegistro = control.getRegistro();
        }

        // Guardar la lista filtrada o completa en la sesión
        HttpSession misesion = request.getSession();
        misesion.setAttribute("listaRegistros", listaRegistro);

        // Redirigir a la página JSP
        response.sendRedirect("verRegistros.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fecha = request.getParameter("fecha");
        String maquina = request.getParameter("maquina");
        String cliente = request.getParameter("cliente");
        String inicio = request.getParameter("hinicio");
        String fin = request.getParameter("hfinal");
        String turno = request.getParameter("turno");
        String comentarios = request.getParameter("comentarios").toUpperCase();
        String operador = request.getParameter("operador").toUpperCase();

        control.registro(fecha, maquina, cliente, inicio, fin, turno, comentarios, operador);
        response.sendRedirect("SvRegistro");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
