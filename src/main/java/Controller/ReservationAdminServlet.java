package Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import Model.*;

public class ReservationAdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("id") != null && "modifier".equals(request.getParameter("action"))) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Reservation reservation = ReservationDao.findById(id);
                
                if (reservation == null) {
                    request.setAttribute("error", "Réservation avec l'ID " + id + " non trouvée.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("View/liste_admin_reservation.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
                
                List<Vol> vols = VolDao.findAll();
                request.setAttribute("reservation", reservation);
                request.setAttribute("vols", vols);
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("View/editreservation.jsp");
                dispatcher.forward(request, response);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Erreur : " + e.getMessage());
            }
        }

        if (request.getParameter("id") != null && "delete".equals(request.getParameter("action"))) {
           try {
                int id = Integer.parseInt(request.getParameter("id"));
                Reservation reservation = ReservationDao.findById(id);
                if (reservation != null) {
                    
                //     int placesPrisesActuelles = reservation.getClasse().equals("business") ? 
                //     VolDao.getPlacesPrisesBusiness(reservation.getIdVol()) : 
                //     VolDao.getPlacesPrisesEconomique(reservation.getIdVol());
                
                // int tarifActuel = TarifClasseDao.getTarifByPlacesPrises(
                //     reservation.getIdVol(), 
                //     reservation.getClasse(), 
                //     placesPrisesActuelles
                // );
                
                //       int nouvelleTrancheFin = tarifActuel.getTrancheFin() + reservation.getNombrePersonne();
                
                //           TarifClasseDao.ajusterTrancheTarifaire(tarifActuel.getId(), nouvelleTrancheFin);
                    TarifClasseDao.ajusterTranchesApresAnnulation(reservation.getIdVol(), reservation.getClasse(), reservation.getNombrePersonne());
                    Vol vol = VolDao.findById(reservation.getIdVol());
                    
                    if (reservation.getClasse().equals("business")) {
                    ReservationDao.delete(reservation.getId());
                    } else {
                    ReservationDao.delete(reservation.getId());
                    }
                    VolDao.update(vol);
                    reservation.setStatus("Annule");
                    ReservationDao.update(reservation);
                }
                response.sendRedirect("liste_admin_reservation");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Erreur : " + e.getMessage());
            }
        }

        try {
            List<Reservation> reservations = ReservationDao.findAll();
            request.setAttribute("reservations", reservations);
            
            List<Vol> vols = VolDao.findAll();
            request.setAttribute("vols", vols);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur : " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("View/liste_admin_reservation.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        if (request.getParameter("id") != null && !request.getParameter("id").isEmpty()) {
            // Mise à jour d'une réservation existante
            try {
                Reservation reservation = new Reservation();
                reservation.setId(Integer.parseInt(request.getParameter("id")));
                reservation.setIdVol(Integer.parseInt(request.getParameter("id_vol")));
                reservation.setIdClient(Integer.parseInt(request.getParameter("id_client")));
                reservation.setNombrePersonne(Integer.parseInt(request.getParameter("nombre_personne")));
                reservation.setPrix(Integer.parseInt(request.getParameter("prix")));
                reservation.setStatus(request.getParameter("status"));
                reservation.setClasse(request.getParameter("classe"));
                
                if (request.getParameter("date_reservation") != null && !request.getParameter("date_reservation").isEmpty()) {
                    reservation.setDate_reservation(LocalDate.parse(request.getParameter("date_reservation")));
                }
                
                if (request.getParameter("date_fin_payement") != null && !request.getParameter("date_fin_payement").isEmpty()) {
                    reservation.setDateFinPayement(LocalDate.parse(request.getParameter("date_fin_payement")));
                }
                
                ReservationDao.update(reservation);
                response.sendRedirect("liste_admin_reservation");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Erreur lors de la mise à jour : " + e.getMessage());
            }
        // } else {
        //     // Création d'une nouvelle réservation
        //     try {
        //         Reservation reservation = new Reservation();
        //         reservation.setIdVol(Integer.parseInt(request.getParameter("id_vol")));
        //         reservation.setIdClient(Integer.parseInt(request.getParameter("id_client")));
        //         reservation.setNombrePersonne(Integer.parseInt(request.getParameter("nombre_personne")));
        //         reservation.setPrix(Integer.parseInt(request.getParameter("prix")));
        //         reservation.setStatus(request.getParameter("status"));
        //         reservation.setDate_reservation(LocalDate.now()); // Date de réservation automatique
                
        //         if (request.getParameter("date_fin_payement") != null && !request.getParameter("date_fin_payement").isEmpty()) {
        //             reservation.setDateFinPayement(LocalDate.parse(request.getParameter("date_fin_payement")));
        //         }
                
        //         ReservationDao.save(reservation);
        //         response.sendRedirect("liste_admin_reservation");
        //         return;
        //     } catch (Exception e) {
        //         e.printStackTrace();
        //         request.setAttribute("error", "Erreur lors de la création : " + e.getMessage());
        //     }
        // }
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("View/liste_admin_reservation.jsp");
        dispatcher.forward(request, response);
    }
}