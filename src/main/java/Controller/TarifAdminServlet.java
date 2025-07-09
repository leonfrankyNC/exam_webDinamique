package Controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.TarifClasse;
import dao.TarifClasseDao;

public class TarifAdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        try {
            String idVolParam = req.getParameter("id_vol");
            req.setAttribute("id_vols", idVolParam);
            
            RequestDispatcher dispatcher = req.getRequestDispatcher("/View/tarif_admin_vol.jsp");
            dispatcher.forward(req, res);
            
        } catch (Exception e) {
            req.setAttribute("erreur", "Erreur lors du chargement du formulaire: " + e.getMessage());
            req.getRequestDispatcher("View/erreur.jsp").forward(req, res);
        }
    }
     protected void doPost(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        try {
            // Retrieve form parameters
            String idVolParam = req.getParameter("id_vol");
            String type = req.getParameter("type");
            String classe = req.getParameter("classe");
            String trancheDebutParam = req.getParameter("tranche_debut");
            String trancheFinParam = req.getParameter("tranche_fin");
            String tarifParam = req.getParameter("tarif");

            // Validate inputs
            if (idVolParam == null || type == null || classe == null || 
                trancheDebutParam == null || trancheFinParam == null || tarifParam == null ||
                idVolParam.isEmpty() || type.isEmpty() || classe.isEmpty() || 
                trancheDebutParam.isEmpty() || trancheFinParam.isEmpty() || tarifParam.isEmpty()) {
                throw new IllegalArgumentException("Tous les champs sont obligatoires.");
            }

            // Parse numeric fields
            int idVol;
            int trancheDebut;
            int trancheFin;
            double tarif;
            try {
                idVol = Integer.parseInt(idVolParam);
                trancheDebut = Integer.parseInt(trancheDebutParam);
                trancheFin = Integer.parseInt(trancheFinParam);
                tarif = Double.parseDouble(tarifParam);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("Les champs numériques doivent être valides.");
            }

            // Validate tranche
            if (trancheDebut >= trancheFin) {
                throw new IllegalArgumentException("La tranche de début doit être inférieure à la tranche de fin.");
            }

            // Create TarifClasse object
            TarifClasse tarifClasse = new TarifClasse(idVol, type, classe, trancheDebut, trancheFin, (int) tarif);

            // Save to database
            TarifClasseDao.saveTarif(tarifClasse);

            // Redirect to confirmation page
            req.setAttribute("message", "Tarif ajouté avec succès pour le vol ID " + idVol + ".");
            req.getRequestDispatcher("/View/tarif_confirmation.jsp").forward(req, res);

        } catch (IllegalArgumentException e) {
            req.setAttribute("erreur", e.getMessage());
            req.getRequestDispatcher("/View/erreur.jsp").forward(req, res);
        } catch (SQLException e) {
            req.setAttribute("erreur", "Erreur lors de l'enregistrement du tarif: " + e.getMessage());
            req.getRequestDispatcher("/View/erreur.jsp").forward(req, res);
        } catch (Exception e) {
            req.setAttribute("erreur", "Erreur inattendue: " + e.getMessage());
            req.getRequestDispatcher("/View/erreur.jsp").forward(req, res);
        }
    }
}