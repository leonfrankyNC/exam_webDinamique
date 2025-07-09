package Controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Model.*;
import dao.BilletDao;
import dao.Dest_populaireDao;
import dao.VolDao;


public class FormreservationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) 
            throws ServletException, IOException {
        
        try {
            // 1. Récupérer l'ID du vol depuis les paramètres
            String idVolParam = req.getParameter("id_vol");
            if (idVolParam == null || idVolParam.trim().isEmpty()) {
                throw new IllegalArgumentException("ID de vol manquant");
            }
            int idVol = Integer.parseInt(idVolParam);
            
            // 2. Récupérer le vol correspondant
            Vol vol = VolDao.getVolById(idVol);
            if (vol == null) {
                throw new Exception("Vol introuvable pour l'ID: " + idVol);
            }
            
            // 3. Récupérer les destinations populaires
            List<Dest_populaire> destinations = Dest_populaireDao.findAll();
            
            // 4. Calculer les places disponibles
            int placesEco = BilletDao.getPlacesDisponibles(idVol, "economique");
            int placesBusiness = BilletDao.getPlacesDisponibles(idVol, "business");
            
            // 5. Ajouter les attributs à la requête
            req.setAttribute("vol", vol);
            req.setAttribute("destinations", destinations);
            req.setAttribute("placesEco", placesEco);
            req.setAttribute("placesBusiness", placesBusiness);
            
            // 6. Afficher le formulaire de réservation
            RequestDispatcher dispatcher = req.getRequestDispatcher("View/reservation.jsp");
            dispatcher.forward(req, res);
            
        } catch (Exception e) {
            req.setAttribute("erreur", "Erreur lors du chargement du formulaire: " + e.getMessage());
            req.getRequestDispatcher("View/erreur.jsp").forward(req, res);
        }
    }
}