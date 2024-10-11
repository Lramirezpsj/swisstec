
package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Usuarios;


@WebServlet(name = "SvEditUsuario", urlPatterns = {"/SvEditUsuario"})
public class SvEditUsuario extends HttpServlet {
    
    Controladora control = new Controladora();

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        Usuarios usu = control.traerUsuario(id);
        
        HttpSession misession = request.getSession();
        misession.setAttribute("usuEditar", usu);
        response.sendRedirect("editarUsuario.jsp");
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usuario = request.getParameter("nombreusu").toUpperCase();
        String contrasenia = request.getParameter("contrasenia");
        String rol = request.getParameter("rol").toUpperCase();
        
        Usuarios usu = (Usuarios)request.getSession().getAttribute("usuEditar");
        
        usu.setUsuario(usuario);
        usu.setContrasenia(contrasenia);
        usu.setRol(rol);
        
        control.editarUsuario(usu);
        
        response.sendRedirect("SvUsuarios");
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
