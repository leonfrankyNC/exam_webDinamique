package Model;

import java.time.LocalDate;

public class Reservation {
    private int id;
    private int idVol;
    private int idClient;
    private int nombrePersonne;
    private int prix;
    private String status;
    private LocalDate date_reservation ;
    private LocalDate dateFinPayement;
    private String classe ;
    

    // Default constructor
    public Reservation() {
    }

    // Parameterized constructor
    public Reservation(int id, int idVol, int idClient, int nombrePersonne, int prix, String status, LocalDate date_reservation,  LocalDate dateFinPayement, String classe) {
        this.id = id;
        this.idVol = idVol;
        this.idClient = idClient;
        this.nombrePersonne = nombrePersonne;
        this.prix = prix;
        this.status = status;
        this.date_reservation = date_reservation ;
        this.dateFinPayement = dateFinPayement;
        this.classe = classe ;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public LocalDate getDate_reservation() {
        return date_reservation;
    }

    public void setDate_reservation(LocalDate date_reservation) {
        this.date_reservation = date_reservation;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIdVol() {
        return idVol;
    }

    public void setIdVol(int idVol) {
        this.idVol = idVol;
    }

    public int getIdClient() {
        return idClient;
    }

    public void setIdClient(int idClient) {
        this.idClient = idClient;
    }

    public int getNombrePersonne() {
        return nombrePersonne;
    }

    public void setNombrePersonne(int nombrePersonne) {
        this.nombrePersonne = nombrePersonne;
    }

    public int getPrix() {
        return prix;
    }

    public void setPrix(int prix) {
        this.prix = prix;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDate getDateFinPayement() {
        return dateFinPayement;
    }

    public void setDateFinPayement(LocalDate dateFinPayement) {
        this.dateFinPayement = dateFinPayement;
    }

    @Override
    public String toString() {
        return "Reservation{" +
               "id=" + id +
               ", idVol=" + idVol +
               ", idClient=" + idClient +
               ", nombrePersonne=" + nombrePersonne +
               ", prix=" + prix +
               ", status='" + status + '\'' +
               ", dateFinPayement=" + dateFinPayement +
               '}';
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }
}