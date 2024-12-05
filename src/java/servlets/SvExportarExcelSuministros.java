package servlets;

import java.io.IOException;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import logica.Suministros;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

@WebServlet(name = "SvExportarExcelSuministros", urlPatterns = {"/SvExportarExcelSuministros"})
public class SvExportarExcelSuministros extends HttpServlet {

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Formato de fecha

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }  

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Recibir parámetros de filtrado
        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");

        // Obtener la lista de registros filtrados
        List<Suministros> registrosFiltrados = obtenerRegistrosFiltrados(fechaInicio, fechaFin, request);

        // Configurar la respuesta para exportar a Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=registros_filtrados.xlsx");

        // Crear el archivo Excel con Apache POI
        try (XSSFWorkbook workbook = new XSSFWorkbook()) { // Usar XSSFWorkbook para .xlsx
            Sheet sheet = workbook.createSheet("Suministros");

            // Crear la fila de encabezado
            Row headerRow = sheet.createRow(0);
            headerRow.createCell(0).setCellValue("ID");
            headerRow.createCell(1).setCellValue("Fecha");
            headerRow.createCell(2).setCellValue("Maquina");
            headerRow.createCell(3).setCellValue("Horometro");
            headerRow.createCell(4).setCellValue("Total");
            headerRow.createCell(5).setCellValue("Comentarios");
            headerRow.createCell(6).setCellValue("Operador");

            // Rellenar el contenido del archivo con los datos filtrados
            int rowIndex = 1;
            for (Suministros suministros : registrosFiltrados) {
                Row row = sheet.createRow(rowIndex++);
                row.createCell(0).setCellValue(suministros.getId_suministros());
                row.createCell(1).setCellValue(suministros.getFecha()); // Asumiendo que registro.getFecha() devuelve un String con formato correcto
                row.createCell(2).setCellValue(suministros.getMaquina());
                row.createCell(3).setCellValue(suministros.getHorometro());
                row.createCell(4).setCellValue(suministros.getTotal());
                row.createCell(5).setCellValue(suministros.getComentarios());
                row.createCell(6).setCellValue(suministros.getOperador());
            }

            // Escribir el archivo Excel en la respuesta
            try (OutputStream out = response.getOutputStream()) {
                workbook.write(out);
            }
        }
    }
    
    // Método para filtrar registros según las fechas
    private List<Suministros> obtenerRegistrosFiltrados(String fechaInicio, String fechaFin, HttpServletRequest request) {
        List<Suministros> listaSuministros = (List<Suministros>) request.getSession().getAttribute("listaSuministros");

        if (fechaInicio != null && fechaFin != null) {
            try {
                // Convertir las fechas de filtro de String a Date
                Date inicio = sdf.parse(fechaInicio);
                Date fin = sdf.parse(fechaFin);

                // Filtrar los registros convirtiendo la fecha de los registros a Date
                return listaSuministros.stream()
                    .filter(r -> {
                        try {
                            // Convertir la fecha del registro a Date
                            Date fechaRegistro = sdf.parse(r.getFecha());
                            // Comparar las fechas
                            return !fechaRegistro.before(inicio) && !fechaRegistro.after(fin);
                        } catch (ParseException e) {
                            e.printStackTrace();
                            return false;
                        }
                    })
                    .collect(Collectors.toList());

            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        return listaSuministros; // Devolver todos los registros si no hay fechas de filtro
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
