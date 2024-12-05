package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Suministros;

@WebServlet(
        name = "SvEditSuministros",
        urlPatterns = {"/SvEditSuministros"}
)
@MultipartConfig
public class SvEditSuministros extends HttpServlet {

    Controladora control = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Suministros suministros = control.traerSuministros(id);
        HttpSession misession = request.getSession();
        misession.setAttribute("registroEditar", suministros);
        response.sendRedirect("editarSuministros.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fecha = request.getParameter("fecha");
        String maquina = request.getParameter("maquina");
        String horometro = request.getParameter("horometro");
        String total = request.getParameter("total");
        String comentarios = request.getParameter("comentarios");
        String operador = request.getParameter("operador");

        Suministros suministros = (Suministros) request.getSession().getAttribute("registroEditar");
        if (suministros == null) {
            throw new ServletException("No se encontró el objeto registroEditar en la sesión.");
        }

        suministros.setFecha(fecha);
        suministros.setMaquina(maquina);
        suministros.setHorometro(horometro);
        suministros.setTotal(total);
        suministros.setComentarios(comentarios);
        suministros.setOperador(operador);
        
        control.editarSuministros(suministros);
        response.sendRedirect("SvSuministros");
    }

    public String getServletInfo() {
        return "Short description";
    }
}
