package servlets;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Registro;

@WebServlet(name = "SvExportarPdfRegistro", urlPatterns = {"/SvExportarPdfRegistro"})
public class SvExportarPdfRegistro extends HttpServlet {

    private Controladora controladora = new Controladora();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener el ID del registro
        String idParam = request.getParameter("id");

        // Convertir el parámetro a entero
        int id = Integer.parseInt(idParam);

        // Lógica para obtener el registro desde la controladora
        Registro registro = controladora.obtenerRegistroPorId(id);

        if (registro != null) {
            // Guardar el registro en la sesión
            HttpSession session = request.getSession();
            session.setAttribute("registro_" + registro.getId_data(), registro);

            // Configuración para el archivo PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=registro_" + id + ".pdf");

            try {
                Document document = new Document();
                OutputStream out = response.getOutputStream();
                PdfWriter.getInstance(document, out);

                document.open();
                document.add(new Paragraph("ID: " + registro.getId_data()));
                document.add(new Paragraph("Fecha: " + registro.getFecha()));
                document.add(new Paragraph("H-Inicio: " + registro.getH_inicio()));
                document.add(new Paragraph("H-Final: " + registro.getH_fin()));
                document.add(new Paragraph("Comentarios: " + registro.getComentarios()));
                document.add(new Paragraph("Operador: " + registro.getOperador()));
                document.close();
            } catch (DocumentException e) {
                e.printStackTrace();
            }
        } else {
            // Manejar caso cuando el registro no se encuentra
            response.setContentType("text/html");
            response.getWriter().println("<html><body><h2>No se encontró el registro con ID: " + id + "</h2></body></html>");
        }
    }

    private Registro obtenerRegistroPorId(HttpServletRequest request, String id) {
        HttpSession session = request.getSession();
        // Supongamos que los registros están almacenados en la sesión con la clave "registro_<id>"
        Registro registro = (Registro) session.getAttribute("registro_" + id);
        if (registro == null) {
            System.out.println("No se encontró el registro en la sesión para el ID: " + id);
        }
        return registro;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    public String getServletInfo() {
        return "Exporta un registro a PDF";
    }

}
