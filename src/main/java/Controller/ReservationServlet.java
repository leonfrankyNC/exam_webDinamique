package Controller;

import Model.*;
import dao.*;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.*;


public class ReservationServlet extends HttpServlet {
    
    // Gestion des requêtes GET (pour afficher le formulaire)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Récupérer l'ID du vol depuis les paramètres
            int idVol = Integer.parseInt(request.getParameter("id_vol"));
            request.setAttribute("id_vol", idVol);
            
            int nb_passagers = 1; // valeur par défaut
        if (request.getParameter("nb_passagers") != null) {
            nb_passagers = Integer.parseInt(request.getParameter("nb_passagers"));
        }
        request.setAttribute("nb_passagers", nb_passagers);
            
             List<Lieu> lieux = LieuDao.findAll(); 
            request.setAttribute("lieux", lieux);
            
            // Ajouter d'autres données nécessaires au formulaire si besoin
            Vol vol = VolDao.getVolById(idVol);
            request.setAttribute("vol", vol);
            
            int placesPrisesBusiness = VolDao.getPlacesPrisesBusiness(idVol);
            int placesPrisesEconomique = VolDao.getPlacesPrisesEconomique(idVol);
            
            int tarifBusiness = TarifClasseDao.getTarifByPlacesPrises(
                        idVol, "business", placesPrisesBusiness);
                    
                    int tarifEconomique = TarifClasseDao.getTarifByPlacesPrises(
                        idVol, "economique", placesPrisesEconomique);

            request.setAttribute("tarifBusiness", tarifBusiness);
                  request.setAttribute("tarifEconomique", tarifEconomique);
                    
            
            // Afficher le formulaire de réservation
            RequestDispatcher dispatcher = request.getRequestDispatcher("/View/reservation.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            request.setAttribute("erreur", "Erreur lors du chargement du formulaire: " + e.getMessage());
            request.getRequestDispatcher("/View/erreur.jsp").forward(request, response);
        }
    }
    
    // Gestion des requêtes POST (pour traiter la réservation)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
             // 1. Récupération des paramètres
        int idVol = Integer.parseInt(request.getParameter("id_vol"));
        String classe = request.getParameter("classe");
        int nbPassagers = Integer.parseInt(request.getParameter("nb_passagers"));

        // 2. Vérification disponibilité
        int placesDisponibles = VolDao.getPlacesDisponibles(idVol, classe);
        if (placesDisponibles < nbPassagers) {
            throw new Exception("Pas assez de places disponibles (" + placesDisponibles + " restantes)");
        }

            // 3. Collecte des informations des passagers
            List<Passager> passagers = new ArrayList<>();
            for (int i = 1; i <= nbPassagers; i++) {
                String nom = request.getParameter("nom_" + i);
                String prenom = request.getParameter("prenom_" + i);
                String passeport = request.getParameter("passeport_" + i);

                if (nom == null || nom.trim().isEmpty() ||
                    prenom == null || prenom.trim().isEmpty() ||
                    passeport == null || passeport.trim().isEmpty()) {
                    throw new IllegalArgumentException("Informations manquantes pour le passager " + i);
                }

                Passager passager = new Passager();
                passager.setNom(nom.trim());
                passager.setPrenom(prenom.trim());
                passager.setNumeroPasseport(passeport.trim());
                // id and idBillet are not set, as they will be assigned after payment
                passagers.add(passager);
            }

            HttpSession session = request.getSession();
        session.setAttribute("passagers", passagers);
        session.setAttribute("idVol", idVol);
        session.setAttribute("classe", classe);
        session.setAttribute("nbPassagers", nbPassagers);

        // 5. Création de la réservation
Reservation reservation = new Reservation();
reservation.setIdVol(idVol);
reservation.setIdClient(1); // À adapter avec l'ID du client connecté
reservation.setNombrePersonne(nbPassagers);

String paiementEffectue = request.getParameter("paiement_effectue");
if (paiementEffectue != null && paiementEffectue.equals("true")) {
    reservation.setStatus("payé");
       int placesPrisesBusiness = VolDao.getPlacesPrisesBusiness(idVol);
            int placesPrisesEconomique = VolDao.getPlacesPrisesEconomique(idVol);
            
            
            int tarifBusiness = TarifClasseDao.getTarifByPlacesPrises(
                        idVol, "business", placesPrisesBusiness);
                    
                    int tarifEconomique = TarifClasseDao.getTarifByPlacesPrises(
                        idVol, "economique", placesPrisesEconomique);

            request.setAttribute("tarifBusiness", tarifBusiness);
                  request.setAttribute("tarifEconomique", tarifEconomique);

    if ("business".equals(classe)) {
        reservation.setPrix(tarifBusiness * nbPassagers);
    } else {
        reservation.setPrix(tarifEconomique * nbPassagers);
    }
} else {
    reservation.setStatus("Attente");
    int placesPrisesBusiness = VolDao.getPlacesPrisesBusiness(idVol);
    int placesPrisesEconomique = VolDao.getPlacesPrisesEconomique(idVol);
    int tarifBusiness = TarifClasseDao.getTarifByPlacesPrises(
                idVol, "business", placesPrisesBusiness);
            
            int tarifEconomique = TarifClasseDao.getTarifByPlacesPrises(
                idVol, "economique", placesPrisesEconomique);
    request.setAttribute("tarifBusiness", tarifBusiness);
          request.setAttribute("tarifEconomique", tarifEconomique);

if ("business".equals(classe)) {
reservation.setPrix(tarifBusiness * nbPassagers);
} else {
reservation.setPrix(tarifEconomique * nbPassagers);
} // Ou un prix estimé
}

reservation.setDate_reservation(LocalDate.now());
reservation.setDateFinPayement(LocalDate.now().plusDays(2));
reservation.setClasse(classe);

        // 7. Mise à jour des places disponibles ET places prises
        VolDao.updatePlacesDisponibles(idVol, classe, nbPassagers);
        
        // Nouveau: Mise à jour des places prises selon la classe
        if ("business".equals(classe)) {
            // Récupérer le nombre actuel de places prises en business
            Vol vol = VolDao.getVolById(idVol);
            int placesPrisesActuelles = vol.getBusiness_class_pris();
            
            // Mettre à jour avec le nouveau total
            VolDao.updatePlacesPrisesBusiness(idVol, placesPrisesActuelles + nbPassagers);
        } else {
            // Récupérer le nombre actuel de places prises en économique
            Vol vol = VolDao.getVolById(idVol);
            int placesPrisesActuelles = vol.getEconomique_class_pris();
            
            // Mettre à jour avec le nouveau total
            VolDao.updatePlacesPrisesEconomique(idVol, placesPrisesActuelles + nbPassagers);
        }
            ReservationDao.save(reservation);
            request.setAttribute("reservationId", reservation.getId());
            request.setAttribute("nbPassagers", nbPassagers);
            request.setAttribute("reservationId", reservation.getId());
            request.setAttribute("date_reservation", reservation.getDate_reservation());
            request.setAttribute("date_fin_reservation", reservation.getDateFinPayement());
            request.setAttribute("status", reservation.getStatus());
            request.setAttribute("prix", reservation.getPrix());
         
            request.getRequestDispatcher("View/confirmation.jsp").forward(request, response);

        } catch (Exception e) {
            // Gestion des erreurs
            request.setAttribute("id_vol", request.getParameter("id_vol"));
            request.setAttribute("classe", request.getParameter("classe"));
            request.setAttribute("nb_passagers", request.getParameter("adulte"));
            request.setAttribute("erreur", "Erreur: " + e.getMessage());
            request.getRequestDispatcher("View/confirmation.jsp").forward(request, response);
        }
    }
}





