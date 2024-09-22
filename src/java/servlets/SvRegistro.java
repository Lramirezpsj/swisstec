
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Controladora;


@WebServlet(name = "SvRegistro", urlPatterns = {"/SvRegistro"})
public class SvRegistro extends HttpServlet {

    Controladora control = new Controladora();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
