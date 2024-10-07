
package servlets;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Cliente;
import logica.Controladora;


@WebServlet(name = "SvCliente", urlPatterns = {"/SvCliente"})
public class SvCliente extends HttpServlet {
    
    Controladora control = new Controladora();

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
    }

    
    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    List<Cliente> listaCliente = control.getClientes();  // Asegúrate de que este método esté retornando clientes

    if (listaCliente != null && !listaCliente.isEmpty()) {
        // Si la lista contiene clientes, guardarla en la sesión
        HttpSession misesion = request.getSession();
        misesion.setAttribute("listaClientes", listaCliente);
        System.out.println(listaCliente);
    }

    // Redirigir a la página JSP
    response.sendRedirect("verCliente.jsp");
}


    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cliente = request.getParameter("cliente");
        control.cliente(cliente);
        response.sendRedirect("cliente.jsp");
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
