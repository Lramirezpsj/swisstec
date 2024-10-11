
package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Maquina;


@WebServlet(name = "SvEditMaquina", urlPatterns = {"/SvEditMaquina"})
public class SvEditMaquina extends HttpServlet {

    Controladora control = new Controladora();
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        Maquina maquina = control.traerMaquina(id);
        
        HttpSession misession = request.getSession();
        misession.setAttribute("maquinaEditar", maquina);
        response.sendRedirect("editarMaquina.jsp");
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String maquina = request.getParameter("maquina").toUpperCase();
        
        Maquina mqn = (Maquina)request.getSession().getAttribute("maquinaEditar");
        
        mqn.setMaquina(maquina);
        
        control.editarMaquina(mqn);
        
        response.sendRedirect("SvMaquina");
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
