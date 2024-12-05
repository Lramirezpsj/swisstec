
package logica;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

@WebListener
public class MyAppContextListener implements ServletContextListener {

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Asegura que el hilo de limpieza de conexiones de MySQL se detenga
        AbandonedConnectionCleanupThread.checkedShutdown();
    }

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("Aplicación iniciada");
    }
}
