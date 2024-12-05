package servlets;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Image;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
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
import logica.RegistroContenedores;

@WebServlet(name = "SvExportarPdfContenedor", urlPatterns = {"/SvExportarPdfContenedor"})
public class SvExportarPdfContenedor extends HttpServlet {

    private Controladora controladora = new Controladora();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Obtener el ID del registro
        String idParam = request.getParameter("id");

        // Convertir el parámetro a entero
        int id = Integer.parseInt(idParam);

        // Lógica para obtener el registro desde la controladora
        RegistroContenedores registro = controladora.obtenerContenedoresPorId(id);

        if (registro != null) {
            // Guardar el registro en la sesión
            HttpSession session = request.getSession();
            session.setAttribute("registro_" + registro.getId_contenedor(), registro);

            // Configuración para el archivo PDF
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=registro_" + id + ".pdf");

            try {
                Document document = new Document();
                OutputStream out = response.getOutputStream();
                PdfWriter.getInstance(document, out);
                document.open();

                // Agregar logo
                String imagePath = getServletContext().getRealPath("/img/logo.jpg");
                Image img = Image.getInstance(imagePath);
                // Escalar imagen si es necesario
                img.scaleToFit(200, 100); // Ajusta estos valores según necesites
                // Posicionar la imagen en la parte superior
                img.setAlignment(Image.ALIGN_CENTER);
                document.add(img);
                // Agregar espacio después de la imagen
                document.add(new Paragraph(" "));

                // Crear y aplicar formato al título
                Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, BaseColor.BLACK); // Fuente Helvetica, tamaño 16, en negrita y de color negro
                Paragraph titulo = new Paragraph("Registro de Contenedor", fontTitulo);
                titulo.setAlignment(Paragraph.ALIGN_CENTER);
                document.add(titulo);

                // Agregar espacio después del título
                document.add(new Paragraph(" "));

                document.add(new Paragraph("No. de registro: " + registro.getId_contenedor()));
                document.add(new Paragraph("Fecha: " + registro.getFecha()));
                document.add(new Paragraph("Máquina: " + registro.getMaquina()));
                document.add(new Paragraph("Comentarios: " + registro.getComentarios()));

                // Agregar espacio después del título
                document.add(new Paragraph(" "));

                BaseColor azulCosmo = new BaseColor(52, 152, 219); // RGB del azul Cosmo

                PdfPTable tblcl = new PdfPTable(3);
                tblcl.setWidthPercentage(100);
                tblcl.getDefaultCell().setBorder(0);
                float[] ColumnaEncacl = new float[]{15f, 15f, 20f,};
                tblcl.setWidths(ColumnaEncacl);
                tblcl.setHorizontalAlignment(Element.ALIGN_LEFT);
                tblcl.getDefaultCell().setBorder(Rectangle.BOX);

                // Crear celdas con el color de fondo azul
                PdfPCell celdaInicio = new PdfPCell();
                celdaInicio.setPhrase(new Phrase("Contenedor:"));
                celdaInicio.setBackgroundColor(azulCosmo); // Aplica el color azul
                celdaInicio.setBorder(Rectangle.BOX);

                PdfPCell celdaMedida = new PdfPCell();
                celdaMedida.setPhrase(new Phrase("Medida:"));
                celdaMedida.setBackgroundColor(azulCosmo); // Aplica el color azul
                celdaMedida.setBorder(Rectangle.BOX);

                PdfPCell celdaMovimiento = new PdfPCell();
                celdaMovimiento.setPhrase(new Phrase("Movimiento"));
                celdaMovimiento.setBackgroundColor(azulCosmo); // Aplica el color azul
                celdaMovimiento.setBorder(Rectangle.BOX);

                // Agregar las celdas a la tabla
                tblcl.addCell(celdaInicio);
                tblcl.addCell(celdaMedida);
                tblcl.addCell(celdaMovimiento);

                document.add(tblcl);

                PdfPTable tblcl2 = new PdfPTable(3);
                tblcl2.setWidthPercentage(100);
                tblcl2.getDefaultCell().setBorder(0);
                float[] ColumnaEncacl2 = new float[]{15f, 15f, 20f,};
                tblcl2.setWidths(ColumnaEncacl2);
                tblcl2.setHorizontalAlignment(Element.ALIGN_LEFT);
                tblcl2.getDefaultCell().setBorder(Rectangle.BOX);

                tblcl2.addCell(registro.getContenedor());
                tblcl2.addCell(registro.getMedida());
                tblcl2.addCell(registro.getMovimiento());

                document.add(tblcl2);

                document.add(new Paragraph(" "));
                document.add(new Paragraph(" "));
                document.add(new Paragraph(" "));

                document.add(new Paragraph("Operador: " + registro.getOperador()));

                document.close();
            } catch (DocumentException e) {
                e.printStackTrace();
                // Manejar el error enviando una respuesta al cliente
                response.setContentType("text/html");
                response.getWriter().println("<html><body><h2>Error al generar el PDF: " + e.getMessage() + "</h2></body></html>");
            }
        } else {
            response.setContentType("text/html");
            response.getWriter().println("<html><body><h2>No se encontró el registro con ID: " + id + "</h2></body></html>");
        }
    }

    private RegistroContenedores obtenerContenedoresPorId(HttpServletRequest request, String id) {
        HttpSession session = request.getSession();
        // Supongamos que los registros están almacenados en la sesión con la clave "registro_<id>"
        RegistroContenedores registro = (RegistroContenedores) session.getAttribute("registro_" + id);
        if (registro == null) {
            System.out.println("No se encontró el registro en la sesión para el ID: " + id);
        }
        return registro;
    }



@Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
        public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
