package servlets;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/subirImagen")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class SubirImagenServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads"; // Carpeta en el servidor

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener la ruta de la carpeta de uploads
        String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // Crear la carpeta si no existe
        }

        // Procesar el archivo subido
        for (Part part : request.getParts()) {
            String fileName = extractFileName(part);
            if (fileName != null && !fileName.isEmpty()) {
                // Guardar el archivo en la carpeta del servidor
                String filePath = uploadPath + File.separator + fileName;
                part.write(filePath);

                // Guardar solo la ruta relativa en la base de datos
                String relativePath = UPLOAD_DIR + "/" + fileName;

                // Aquí puedes guardar la ruta relativa en la base de datos si es necesario
                // Ejemplo: guardarRutaEnBD(relativePath);
            }
        }

        // Redirigir o mostrar un mensaje de éxito
        response.getWriter().write("Imagen subida con éxito");
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        for (String content : contentDisposition.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return null;
    }
}