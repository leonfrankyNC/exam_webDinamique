package Model;

public class Admin {
    private int id;
    private String nom;
    private String mdp;

    // Constructeurs
    public Admin() {}

    public Admin(String nom, String mdp) {
        this.nom = nom;
        this.mdp = mdp;
    }

    // Getters et setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }
}