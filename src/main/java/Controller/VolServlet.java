package Controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.*;
import Model.*;

public class VolServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("id") != null && "modifier".equals(request.getParameter("action"))) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Vol vol = VolDao.findById(id);
                
                if (vol == null) {
                    request.setAttribute("error", "Vol avec l'ID " + id + " non trouvé.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("View/liste_admin_vol.jsp");
                    dispatcher.forward(request, response);
                    return;
                }
                List<Lieu> lieux = LieuDao.findAll();
                request.setAttribute("vol", vol);
                request.setAttribute("lieux", lieux);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Erreur : " + e.getMessage());
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("View/editvol.jsp");
            dispatcher.forward(request, response);
            return;
        }

        if (request.getParameter("id") != null && "delete".equals(request.getParameter("action"))) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                VolDao.delete(id);
                response.sendRedirect("liste_admin_vol");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Erreur : " + e.getMessage());
            }
        }

        try {
            List<Vol> vols = VolDao.findAll();
            request.setAttribute("vols", vols);
            
            List<Lieu> lieux = LieuDao.findAll();
            request.setAttribute("lieux", lieux);
        } catch (Exception e) {
            request.setAttribute("error", "Erreur : " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("View/liste_admin_vol.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Vol vol = new Vol();
            List<Lieu> lieux = LieuDao.findAll();
            request.setAttribute("lieux", lieux);

            // Paramètres obligatoires
            vol.setId_avion(Integer.parseInt(request.getParameter("id_avion")));
            vol.setId_pilote(Integer.parseInt(request.getParameter("id_pilote")));
            vol.setId_lieu_depart(Integer.parseInt(request.getParameter("lieu_depart")));
            vol.setId_lieu_arriver(Integer.parseInt(request.getParameter("lieu_arrivee")));
            vol.setHeure_depart(LocalTime.parse(request.getParameter("heure_depart")));
            vol.setHeure_arrivee(LocalTime.parse(request.getParameter("heure_arrivee")));
            vol.setDate_depart(LocalDate.parse(request.getParameter("date_depart")));
            vol.setDate_arrivee(LocalDate.parse(request.getParameter("date_arrivee")));
            vol.setDistance_trajet(Integer.parseInt(request.getParameter("distance_trajet")));
            
            // Nouveaux champs pour les places
            vol.setNombre_place_business_class(Integer.parseInt(request.getParameter("nombre_place_business_class")));
            vol.setNombre_place_economique_class(Integer.parseInt(request.getParameter("nombre_place_economique_class")));
            vol.setBusiness_class_pris(0); // Initialisé à 0 par défaut
            vol.setEconomique_class_pris(0); // Initialisé à 0 par défaut
            
            // Calcul des places libres
            // int placesLibresBusiness = vol.getNombre_place_business_class() - vol.getBusiness_class_pris();
            // int placesLibresEconomique = vol.getNombre_place_economique_class() - vol.getEconomique_class_pris();
            vol.setPlaces_libres_business(Integer.parseInt(request.getParameter("nombre_place_business_class")));
            vol.setPlaces_libres_economique(Integer.parseInt(request.getParameter("nombre_place_economique_class")));

            if ("update".equals(request.getParameter("action")) && request.getParameter("id") != null) {
                vol.setId(Integer.parseInt(request.getParameter("id")));
                VolDao.update(vol);
            } else {
                VolDao.save(vol);
            }

            response.sendRedirect("liste_admin_vol");
            return;
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur : " + e.getMessage());
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("View/liste_admin_vol.jsp");
        dispatcher.forward(request, response);
    }
}