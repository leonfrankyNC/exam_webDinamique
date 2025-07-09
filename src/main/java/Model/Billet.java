package Model;

import java.time.LocalDate;

public class Billet {
    private int id;
    private int idClient;
    private int idVol;
    private String classe; 
    private LocalDate dateReservation;
    private String reference; 
    private double prixTotal;

 
    public Billet() {}

    public Billet(int idClient, int idVol, String classe, LocalDate dateReservation) {
        this.idClient = idClient;
        this.idVol = idVol;
        this.classe = classe;
        this.dateReservation = dateReservation;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getIdClient() { return idClient; }
    public void setIdClient(int idClient) { this.idClient = idClient; }
    
    public int getIdVol() { return idVol; }
    public void setIdVol(int idVol) { this.idVol = idVol; }
    
    public String getClasse() { return classe; }
    public void setClasse(String classe) { this.classe = classe; }
    
    public LocalDate getDateReservation() { return dateReservation; }
    public void setDateReservation(LocalDate dateReservation) { this.dateReservation = dateReservation; }
    
    public String getReference() { return reference; }
    public void setReference(String reference) { this.reference = reference; }
    
    public double getPrixTotal() { return prixTotal; }
    public void setPrixTotal(double prixTotal) { this.prixTotal = prixTotal; }

    @Override
    public String toString() {
        return "Billet [id=" + id + ", reference=" + reference + ", classe=" + classe + "]";
    }
}