package Controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

import Model.Dest_populaire;
import dao.Dest_populaireDao;

public class MainServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            List<Dest_populaire> destinations = Dest_populaireDao.findAll();
            req.setAttribute("destinations", destinations);
        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors du chargement des destinations : " + e.getMessage());
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("View/index.jsp");
        dispatcher.forward(req, res);
    }
}
