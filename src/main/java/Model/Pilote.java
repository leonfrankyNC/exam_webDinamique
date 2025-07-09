package Model;

import java.time.LocalDate;

public class Pilote {
    private int id;
    private String nom;
    private LocalDate date_naissance;

    public LocalDate getDate_naissance() {
        return date_naissance;
    }

    public int getId() {
        return id;
    }

    public String getNom() {
        return nom;
    }

    public void setDate_naissance(LocalDate date_naissance) {
        this.date_naissance = date_naissance;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
