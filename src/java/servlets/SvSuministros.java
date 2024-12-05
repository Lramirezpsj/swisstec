package servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Suministros;

@WebServlet(name = "SvSuministros", urlPatterns = {"/SvSuministros"})

@MultipartConfig
public class SvSuministros extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");

        List<Suministros> listaSuministros;

        if (fechaInicio != null && fechaFin != null) {
            listaSuministros = control.getSuministrosPorFecha(fechaInicio, fechaFin);
        } else {
            listaSuministros = control.getSuministros();
        }

        // Guardar la lista filtrada o completa en la sesión
        HttpSession misesion = request.getSession();
        misesion.setAttribute("listaSuministros", listaSuministros);

        // Redirigir a la página JSP
        response.sendRedirect("verSuministros.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener parámetros del formulario
        String fecha = request.getParameter("fecha");
        String maquina = request.getParameter("maquina");
        String horometro = request.getParameter("horometro");
        String total = request.getParameter("total");
        String comentarios = request.getParameter("comentarios").toUpperCase();
        String operador = request.getParameter("operador");

        
        // Guardar datos en la base de datos
        control.suministros(fecha, maquina, horometro, total, comentarios, operador);
        response.sendRedirect("SvSuministros");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
