
package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Cliente;
import logica.Controladora;


@WebServlet(name = "SvEditCliente", urlPatterns = {"/SvEditCliente"})
public class SvEditCliente extends HttpServlet {

    Controladora control = new Controladora();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
    }

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        
        Cliente cliente = control.traerCliente(id);
        
        HttpSession misession = request.getSession();
        misession.setAttribute("clienteEditar", cliente);
        response.sendRedirect("editarCliente.jsp");
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cliente = request.getParameter("cliente").toUpperCase();
        
        Cliente clt = (Cliente)request.getSession().getAttribute("clienteEditar");
        
        clt.setCliente(cliente);
        
        control.editarCliente(clt);
        
        response.sendRedirect("SvCliente");
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
