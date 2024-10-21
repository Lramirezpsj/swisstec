package servlets;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook; // Asegúrate de usar XSSFWorkbook
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
import logica.Registro;

@WebServlet(name = "SvExportarExcel", urlPatterns = {"/SvExportarExcel"})
public class SvExportarExcelRegistro extends HttpServlet {

    private static final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Formato de fecha

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Recibir parámetros de filtrado
        String fechaInicio = request.getParameter("fechaInicio");
        String fechaFin = request.getParameter("fechaFin");

        // Obtener la lista de registros filtrados
        List<Registro> registrosFiltrados = obtenerRegistrosFiltrados(fechaInicio, fechaFin, request);

        // Configurar la respuesta para exportar a Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=registros_filtrados.xlsx");

        // Crear el archivo Excel con Apache POI
        try (XSSFWorkbook workbook = new XSSFWorkbook()) { // Usar XSSFWorkbook para .xlsx
            Sheet sheet = workbook.createSheet("Registros");

            // Crear la fila de encabezado
            Row headerRow = sheet.createRow(0);
            headerRow.createCell(0).setCellValue("ID");
            headerRow.createCell(1).setCellValue("Fecha");
            headerRow.createCell(2).setCellValue("H-Inicio");
            headerRow.createCell(3).setCellValue("H-Final");
            headerRow.createCell(4).setCellValue("Comentarios");
            headerRow.createCell(5).setCellValue("Operador");

            // Rellenar el contenido del archivo con los datos filtrados
            int rowIndex = 1;
            for (Registro registro : registrosFiltrados) {
                Row row = sheet.createRow(rowIndex++);
                row.createCell(0).setCellValue(registro.getId_data());
                row.createCell(1).setCellValue(registro.getFecha()); // Asumiendo que registro.getFecha() devuelve un String con formato correcto
                row.createCell(2).setCellValue(registro.getH_inicio());
                row.createCell(3).setCellValue(registro.getH_fin());
                row.createCell(4).setCellValue(registro.getComentarios());
                row.createCell(5).setCellValue(registro.getOperador());
            }

            // Escribir el archivo Excel en la respuesta
            try (OutputStream out = response.getOutputStream()) {
                workbook.write(out);
            }
        }
    }

    // Método para filtrar registros según las fechas
    private List<Registro> obtenerRegistrosFiltrados(String fechaInicio, String fechaFin, HttpServletRequest request) {
        List<Registro> listaRegistros = (List<Registro>) request.getSession().getAttribute("listaRegistros");

        if (fechaInicio != null && fechaFin != null) {
            try {
                // Convertir las fechas de filtro de String a Date
                Date inicio = sdf.parse(fechaInicio);
                Date fin = sdf.parse(fechaFin);

                // Filtrar los registros convirtiendo la fecha de los registros a Date
                return listaRegistros.stream()
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
        return listaRegistros; // Devolver todos los registros si no hay fechas de filtro
    }
}




