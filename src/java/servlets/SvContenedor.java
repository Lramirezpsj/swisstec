
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
         List<RegistroContenedores> listaRegistro = control.getRegistroContenedores();  // Asegúrate de que este método esté retornando clientes

        if (listaRegistro != null && !listaRegistro.isEmpty()) {
            // Si la lista contiene clientes, guardarla en la sesión
            HttpSession misesion = request.getSession();
            misesion.setAttribute("listaRegistros", listaRegistro);
        }
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
