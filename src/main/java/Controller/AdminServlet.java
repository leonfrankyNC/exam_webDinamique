
package Controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;

import Model.Admin;
import Model.Dest_populaire;
import dao.AdminDao;
import dao.Dest_populaireDao;

public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            List<Dest_populaire> destinations = Dest_populaireDao.findAll();
            req.setAttribute("destinations", destinations);
        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors du chargement des destinations : " + e.getMessage());
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("View/admin_index.jsp");
        dispatcher.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        String nom = req.getParameter("nom");
        String mdp = req.getParameter("mdp");
        
        Admin admin = AdminDao.findByCredentials(nom, mdp);
        
        if (admin != null) {
            // Créer une session et stocker les infos admin
            HttpSession session = req.getSession();
            session.setAttribute("admin", admin);
            
            // Rediriger vers la liste des vols
            res.sendRedirect("liste_admin_vol");
        } else {
            req.setAttribute("error", "Identifiants incorrects");
            RequestDispatcher dispatcher = req.getRequestDispatcher("View/admin_index.jsp");
            dispatcher.forward(req, res);
        }
    }
}