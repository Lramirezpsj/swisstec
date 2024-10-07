
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
import logica.Maquina;

@WebServlet(name = "SvMaquina", urlPatterns = {"/SvMaquina"})
public class SvMaquina extends HttpServlet {

    Controladora control = new Controladora();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Maquina> listaMaquina = control.getMaquina();  // Asegúrate de que este método esté retornando clientes

    if (listaMaquina != null && !listaMaquina.isEmpty()) {
        // Si la lista contiene clientes, guardarla en la sesión
        HttpSession misesion = request.getSession();
        misesion.setAttribute("listaMaquinas", listaMaquina);
    }

    // Redirigir a la página JSP
    response.sendRedirect("verMaquina.jsp");
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String maquina = request.getParameter("maquina");
        control.maquina(maquina);
        response.sendRedirect("maquina.jsp");
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
