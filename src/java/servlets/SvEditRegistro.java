
package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Registro;


@WebServlet(name = "SvEditRegistro", urlPatterns = {"/SvEditRegistro"})
public class SvEditRegistro extends HttpServlet {

    Controladora control = new Controladora();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        Registro registro = control.traerRegistro(id);
        
        HttpSession misession = request.getSession();
        misession.setAttribute("registroEditar", registro);
        response.sendRedirect("editarRegistro.jsp");
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String fecha = request.getParameter("fecha").toUpperCase();
            String maquina = request.getParameter("maquina").toUpperCase();
            String hinicio = request.getParameter("hinicio");
            String hfinal = request.getParameter("hfinal");
            String comentarios = request.getParameter("comentarios").toUpperCase();
            String operador = request.getParameter("operador").toUpperCase();
        
        Registro registro = (Registro)request.getSession().getAttribute("registroEditar");
        
        registro.setFecha(fecha);
        registro.setMaquina(maquina);
        registro.setH_inicio(hinicio);
        registro.setH_fin(hfinal);
        registro.setComentarios(comentarios);
        registro.setOerador(operador);
        
        control.editarRegistro(registro);
        
        response.sendRedirect("SvRegistro");
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
