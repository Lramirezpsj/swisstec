package servlets;

import com.itextpdf.text.Paragraph;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import logica.Controladora;
import logica.Registro;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.PdfPCell;

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
                Paragraph titulo = new Paragraph("Registro de Horometro", fontTitulo);
                titulo.setAlignment(Paragraph.ALIGN_CENTER);
                document.add(titulo);

                // Agregar espacio después del título
                document.add(new Paragraph(" "));

                document.add(new Paragraph("No. de registro: " + registro.getId_data()));
                document.add(new Paragraph("Fecha: " + registro.getFecha()));
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
                celdaInicio.setPhrase(new Phrase("Inicio:"));
                celdaInicio.setBackgroundColor(azulCosmo); // Aplica el color azul
                celdaInicio.setBorder(Rectangle.BOX);

                PdfPCell celdaFinal = new PdfPCell();
                celdaFinal.setPhrase(new Phrase("Final:"));
                celdaFinal.setBackgroundColor(azulCosmo); // Aplica el color azul
                celdaFinal.setBorder(Rectangle.BOX);

                PdfPCell celdaVacia = new PdfPCell();
                celdaVacia.setPhrase(new Phrase("Total en horas"));
                celdaVacia.setBackgroundColor(azulCosmo); // Aplica el color azul
                celdaVacia.setBorder(Rectangle.BOX);

                // Agregar las celdas a la tabla
                tblcl.addCell(celdaInicio);
                tblcl.addCell(celdaFinal);
                tblcl.addCell(celdaVacia);

                document.add(tblcl);

                PdfPTable tblcl2 = new PdfPTable(3);
                tblcl2.setWidthPercentage(100);
                tblcl2.getDefaultCell().setBorder(0);
                float[] ColumnaEncacl2 = new float[]{15f, 15f, 20f,};
                tblcl2.setWidths(ColumnaEncacl2);
                tblcl2.setHorizontalAlignment(Element.ALIGN_LEFT);
                tblcl2.getDefaultCell().setBorder(Rectangle.BOX);

                // Obtener las horas de inicio y final
                double hInicio = Double.parseDouble(registro.getH_inicio());
                double hFinal = Double.parseDouble(registro.getH_fin());

// Calcular la diferencia en horas
                double diferencia = hFinal - hInicio;
                int horas = (int) diferencia;
                int minutos = (int) ((diferencia - horas) * 60);

// Formatear el resultado en "horas:minutos"
                String resultado = String.format("%02d:%02d", horas, minutos);

// Crear celdas con los datos y el resultado
                PdfPCell celdaInicioValor = new PdfPCell(new Phrase(registro.getH_inicio()));
                celdaInicioValor.setBorder(Rectangle.BOX);

                PdfPCell celdaFinalValor = new PdfPCell(new Phrase(registro.getH_fin()));
                celdaFinalValor.setBorder(Rectangle.BOX);

                PdfPCell celdaResultado = new PdfPCell(new Phrase(resultado));
                celdaResultado.setBorder(Rectangle.BOX);

                tblcl2.addCell(celdaInicioValor);
                tblcl2.addCell(celdaFinalValor);
                tblcl2.addCell(celdaResultado);

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
