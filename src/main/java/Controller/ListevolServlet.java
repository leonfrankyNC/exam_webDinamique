package Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.*;
import javax.servlet.http.*;

import Model.Dest_populaire;
import Model.Lieu;
import Model.Vol;
import dao.Dest_populaireDao;
import dao.LieuDao;

import dao.TarifClasseDao;
import dao.VolDao;

public class ListevolServlet extends HttpServlet {
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
            // Récupération des paramètres de recherche
            Integer idLieuDepart = req.getParameter("depart") != null ? 
                Integer.parseInt(req.getParameter("depart")) : null;
            Integer idLieuArrivee = req.getParameter("arrivee") != null ? 
                Integer.parseInt(req.getParameter("arrivee")) : null;
            LocalDate dateDepart = req.getParameter("date") != null ? 
                LocalDate.parse(req.getParameter("date")) : null;
            Integer passagers = req.getParameter("nb_passagers") != null ? 
                Integer.parseInt(req.getParameter("nb_passagers")) : 1;

            // Recherche des vols correspondants
            List<Vol> vols = VolDao.findVolsByCriteria(idLieuDepart, idLieuArrivee, dateDepart);
            
            // Filtrer les vols avec suffisamment de places disponibles et récupérer les tarifs
            List<Vol> volsDisponibles = new ArrayList<>();
            Map<Integer, Map<String, Integer>> tarifsParVol = new HashMap<>();
            Map<Integer, Map<String, Integer>> placesReserveesParVol = new HashMap<>();

            for (Vol vol : vols) {
                if (vol.getPlaces_libres_economique() >= passagers || 
                    vol.getPlaces_libres_business() >= passagers) {
                    
                   
                    int placesPrisesBusiness = vol.getBusiness_class_pris();
                    int placesPrisesEconomique = vol.getEconomique_class_pris();
                    
                    
System.out.println("Business places taken: " + placesPrisesBusiness);
System.out.println("Economique places taken: " + placesPrisesEconomique);

                    // Récupérer les tarifs correspondants
                    int tarifBusiness = TarifClasseDao.getTarifByPlacesPrises(
                        vol.getId(), "business", placesPrisesBusiness);
                    
                    int tarifEconomique = TarifClasseDao.getTarifByPlacesPrises(
                        vol.getId(), "economique", placesPrisesEconomique);
                    
                    System.out.println("Pris du business " + tarifBusiness);
System.out.println("Pris economique: " + tarifEconomique);

                    // Stocker les informations
                    Map<String, Integer> tarifs = new HashMap<>();
                    tarifs.put("business", tarifBusiness);
                    tarifs.put("economique", tarifEconomique);
                    tarifsParVol.put(vol.getId(), tarifs);

                    Map<String, Integer> placesReservees = new HashMap<>();
                    placesReservees.put("business", placesPrisesBusiness);
                    placesReservees.put("economique", placesPrisesEconomique);
                    placesReserveesParVol.put(vol.getId(), placesReservees);

                    volsDisponibles.add(vol);
                }
            }

            req.setAttribute("vols", volsDisponibles);
            req.setAttribute("tarifsParVol", tarifsParVol);
            req.setAttribute("placesReserveesParVol", placesReserveesParVol);
            
            // Récupérer les lieux pour les selects
            List<Lieu> lieux = LieuDao.findAll();
            req.setAttribute("lieux", lieux);
            
            // Récupérer les destinations populaires
            List<Dest_populaire> destinations = Dest_populaireDao.findAll();
            req.setAttribute("destinations", destinations);

        } catch (Exception e) {
            req.setAttribute("error", "Erreur lors de la recherche : " + e.getMessage());
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("View/Listevol.jsp");
        dispatcher.forward(req, res);
    }
}