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
        List<Registro> listaRegistro = control.getRegistro();  // Asegúrate de que este método esté retornando clientes

        if (listaRegistro != null && !listaRegistro.isEmpty()) {
            // Si la lista contiene clientes, guardarla en la sesión
            HttpSession misesion = request.getSession();
            misesion.setAttribute("listaRegistros", listaRegistro);
        }
        // Redirigir a la página JSP
        response.sendRedirect("verRegistros.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fecha = request.getParameter("fecha");
        String inicio = request.getParameter("hinicio");
        String fin = request.getParameter("hfinal");
        String comentarios = request.getParameter("comentarios");
        String operador = request.getParameter("operador");

        control.registro(fecha, inicio, fin, comentarios, operador);
        response.sendRedirect("registro.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
