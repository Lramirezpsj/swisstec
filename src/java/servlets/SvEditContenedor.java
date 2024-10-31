
package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.RegistroContenedores;


@WebServlet(name = "SvEditContenedor", urlPatterns = {"/SvEditContenedor"})
public class SvEditContenedor extends HttpServlet {

    Controladora control = new Controladora();
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        RegistroContenedores registro = control.traerContenedor(id);
        
        HttpSession misession = request.getSession();
        misession.setAttribute("registroEditar", registro);
        response.sendRedirect("editarContenedor.jsp");
    }
    

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fecha = request.getParameter("fecha").toUpperCase();
            String maquina = request.getParameter("maquina").toUpperCase();
            String contenedor = request.getParameter("contenedor").toUpperCase();
            String medida = request.getParameter("medida").toUpperCase();
            String movimiento = request.getParameter("movimiento").toUpperCase();
            String comentarios = request.getParameter("comentarios").toUpperCase();
            String operador = request.getParameter("operador").toUpperCase();
        
        RegistroContenedores registro = (RegistroContenedores)request.getSession().getAttribute("registroEditar");
        
        registro.setFecha(fecha);
        registro.setMaquina(maquina);
        registro.setContenedor(contenedor);
        registro.setMedida(medida);
        registro.setMovimiento(movimiento);
        registro.setComentarios(comentarios);
        registro.setOperador(operador);
        
        control.editarRegistroContenedor(registro);
        
        response.sendRedirect("SvContenedor");
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
