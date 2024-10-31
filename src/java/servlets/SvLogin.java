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
import logica.Maquina;
import logica.Usuarios;

@WebServlet(name = "SvLogin", urlPatterns = {"/SvLogin"})
public class SvLogin extends HttpServlet {

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
        String usuario = request.getParameter("username").toUpperCase();
        String password = request.getParameter("password");

        // Llamar al método que valida el usuario y devuelve el objeto Usuarios
        Usuarios usuarioLogueado = control.comprobarIngreso(usuario, password);

        if (usuarioLogueado != null) {
            // Crear la sesión si no existe
            HttpSession sesion = request.getSession(true);
            HttpSession misesion = request.getSession(true);

            // Guardar el usuario logueado en la sesión
            String nombreUsuario = usuarioLogueado.getUsuario();
            sesion.setAttribute("usuarioLogueado", usuarioLogueado);

            // Obtener la lista de máquinas desde la base de datos (o fuente de datos)
            List<Maquina> listaMaquinas = control.getMaquina(); // Implementa este método para obtener las máquinas

            // Guardar la lista de máquinas en la sesión
            sesion.setAttribute("listaMaquinas", listaMaquinas);
            
            List<Cliente>listaClientes = control.getClientes();
            
            misesion.setAttribute("listaClientes", listaClientes);

            // Redirigir a la página principal (index.jsp) si la autenticación es correcta
            response.sendRedirect("index.jsp");
        } else {
            // Redirigir a una página de error si el usuario no es válido
            response.sendRedirect("loginError.jsp");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
