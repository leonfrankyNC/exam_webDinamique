package Model;

import java.time.LocalDate;
import java.time.LocalTime;

public class Vol {
    private int id;
    private int id_avion;
    private int id_pilote;
    private int id_lieu_depart;
    private int id_lieu_arriver;
    private LocalTime heure_depart;
    private LocalTime heure_arrivee;
    private LocalDate date_depart;
    private LocalDate date_arrivee;
    private int distance_trajet;
    private int nombre_place_business_class;
    private int nombre_place_economique_class;
    private int business_class_pris;
    private int economique_class_pris;
    private int places_libres_business;
    private int places_libres_economique;

    // Getters
    public int getId() { return id; }
    public int getId_avion() { return id_avion; }
    public int getId_pilote() { return id_pilote; }
    public int getId_lieu_depart() { return id_lieu_depart; }
    public int getId_lieu_arriver() { return id_lieu_arriver; }
    public LocalTime getHeure_depart() { return heure_depart; }
    public LocalTime getHeure_arrivee() { return heure_arrivee; }
    public LocalDate getDate_depart() { return date_depart; }
    public LocalDate getDate_arrivee() { return date_arrivee; }
    public int getDistance_trajet() { return distance_trajet; }
    public int getNombre_place_business_class() { return nombre_place_business_class; }
    public int getNombre_place_economique_class() { return nombre_place_economique_class; }
    public int getBusiness_class_pris() { return business_class_pris; }
    public int getEconomique_class_pris() { return economique_class_pris; }
    public int getPlaces_libres_business() { return places_libres_business; }
    public int getPlaces_libres_economique() { return places_libres_economique; }

    // Setters
    public void setId(int id) { this.id = id; }
    public void setId_avion(int id_avion) { this.id_avion = id_avion; }
    public void setId_pilote(int id_pilote) { this.id_pilote = id_pilote; }
    public void setId_lieu_depart(int id_lieu_depart) { this.id_lieu_depart = id_lieu_depart; }
    public void setId_lieu_arriver(int id_lieu_arriver) { this.id_lieu_arriver = id_lieu_arriver; }
    public void setHeure_depart(LocalTime heure_depart) { this.heure_depart = heure_depart; }
    public void setHeure_arrivee(LocalTime heure_arrivee) { this.heure_arrivee = heure_arrivee; }
    public void setDate_depart(LocalDate date_depart) { this.date_depart = date_depart; }
    public void setDate_arrivee(LocalDate date_arrivee) { this.date_arrivee = date_arrivee; }
    public void setDistance_trajet(int distance_trajet) { this.distance_trajet = distance_trajet; }
    public void setNombre_place_business_class(int nombre_place_business_class) { 
        this.nombre_place_business_class = nombre_place_business_class; 
    }
    public void setNombre_place_economique_class(int nombre_place_economique_class) { 
        this.nombre_place_economique_class = nombre_place_economique_class; 
    }
    public void setBusiness_class_pris(int business_class_pris) { 
        this.business_class_pris = business_class_pris; 
    }
    public void setEconomique_class_pris(int economique_class_pris) { 
        this.economique_class_pris = economique_class_pris; 
    }
    public void setPlaces_libres_business(int places_libres_business) { 
        this.places_libres_business = places_libres_business; 
    }
    public void setPlaces_libres_economique(int places_libres_economique) { 
        this.places_libres_economique = places_libres_economique; 
    }

    @Override
    public String toString() {
        return "Vol{id=" + id + ", départ=" + id_lieu_depart + ", arrivée=" + id_lieu_arriver + "}";
    }
}