package Model;

public class TarifClasse {
    private int id;
    private int idVol;  // Changé de idAvion à idVol pour correspondre à la table
    private String type; // Ajout du type (adulte/enfant)
    private String classe;
    private int trancheDebut; // Renommé de debutPlace pour correspondre à la table
    private int trancheFin;   // Renommé de finPlace pour correspondre à la table
    private int tarif;

    // Constructeurs
    public TarifClasse() {}

    public TarifClasse(int idVol, String type, String classe, int trancheDebut, int trancheFin, int tarif) {
        this.idVol = idVol;
        this.type = type;
        this.classe = classe;
        this.trancheDebut = trancheDebut;
        this.trancheFin = trancheFin;
        this.tarif = tarif;
    }

    // Getters
    public int getId() {
        return id;
    }

    public int getIdVol() {
        return idVol;
    }

    public String getType() {
        return type;
    }

    public String getClasse() {
        return classe;
    }

    public int getTrancheDebut() {
        return trancheDebut;
    }

    public int getTrancheFin() {
        return trancheFin;
    }

    public int getTarif() {
        return tarif;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setIdVol(int idVol) {
        this.idVol = idVol;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }

    public void setTrancheDebut(int trancheDebut) {
        this.trancheDebut = trancheDebut;
    }

    public void setTrancheFin(int trancheFin) {
        this.trancheFin = trancheFin;
    }

    public void setTarif(int tarif) {
        this.tarif = tarif;
    }

    @Override
    public String toString() {
        return "TarifClasse{" +
               "id=" + id +
               ", idVol=" + idVol +
               ", type='" + type + '\'' +
               ", classe='" + classe + '\'' +
               ", trancheDebut=" + trancheDebut +
               ", trancheFin=" + trancheFin +
               ", tarif=" + tarif +
               '}';
    }
}