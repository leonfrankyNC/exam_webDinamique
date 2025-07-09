package Controller;

import Main.Main;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class SimulationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Appeler la logique de Main.java
            Main.main(new String[]{});
            response.getWriter().println("Simulation exécutée avec succès !");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Erreur lors de la simulation : " + e.getMessage());
        }
    }
}