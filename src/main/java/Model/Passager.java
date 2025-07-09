package Model;

public class Passager {

    private int id;
    private int idBillet;
    private String nom;
    private String prenom;
    private String numeroPasseport;

    public int getId() {
        return id;
    }

    public int getIdBillet() {
        return idBillet;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public String getNumeroPasseport() {
        return numeroPasseport;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setIdBillet(int idBillet) {
        this.idBillet = idBillet;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setPrenom(String prenom) {
        this.prenom = prenom;
    }

    public void setNumeroPasseport(String numeroPasseport) {
        this.numeroPasseport = numeroPasseport;
    }
}
