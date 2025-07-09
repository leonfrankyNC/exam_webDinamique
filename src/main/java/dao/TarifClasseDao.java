package dao;

import Model.Connexion;
import Model.TarifClasse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TarifClasseDao {

    // Récupérer le tarif pour une tranche donnée (par vol, type et classe)
    public static int getTarif(int idVol, String type, String classe, int trancheDebut, int trancheFin) throws SQLException {
        String sql = "SELECT tarif FROM tarif_classe WHERE id_vol = ? AND type = ? AND classe = ? AND tranche_debut = ? AND tranche_fin = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idVol);
            stmt.setString(2, type);
            stmt.setString(3, classe);
            stmt.setInt(4, trancheDebut);
            stmt.setInt(5, trancheFin);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("tarif");
            }
        }
        return 0; // Retourne 0 si aucun tarif n'est trouvé pour la tranche
    }

    // Enregistrer un nouveau tarif pour une tranche
    public static void saveTarif(TarifClasse tarifClasse) throws SQLException {
        String sql = "INSERT INTO tarif_classe (id_vol, type, classe, tranche_debut, tranche_fin, tarif) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tarifClasse.getIdVol());
            stmt.setString(2, tarifClasse.getType());
            stmt.setString(3, tarifClasse.getClasse());
            stmt.setInt(4, tarifClasse.getTrancheDebut());
            stmt.setInt(5, tarifClasse.getTrancheFin());
            stmt.setInt(6, tarifClasse.getTarif());
            stmt.executeUpdate();
        }
    }

    // Récupérer tous les tarifs pour un vol donné
    public static List<TarifClasse> findByVol(int idVol) throws SQLException {
        List<TarifClasse> tarifs = new ArrayList<>();
        String sql = "SELECT * FROM tarif_classe WHERE id_vol = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idVol);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                TarifClasse tarif = new TarifClasse(
                    rs.getInt("id_vol"),
                    rs.getString("type"),
                    rs.getString("classe"),
                    rs.getInt("tranche_debut"),
                    rs.getInt("tranche_fin"),
                    rs.getInt("tarif")
                );
                tarif.setId(rs.getInt("id"));
                tarifs.add(tarif);
            }
        }
        return tarifs;
    }

    // Récupérer le tarif initial (tranche 1-10) pour un vol, type et classe
    public static int getTarifInitial(int idVol, String type, String classe) throws SQLException {
        String sql = "SELECT tarif FROM tarif_classe WHERE id_vol = ? AND type = ? AND classe = ? AND tranche_debut = 1 AND tranche_fin = 10";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idVol);
            stmt.setString(2, type);
            stmt.setString(3, classe);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("tarif");
            }
            return 0; // Retourne 0 si aucun tarif initial n'est trouvé
        }
    }

    // Mettre à jour un tarif existant
    public static void updateTarif(TarifClasse tarifClasse) throws SQLException {
        String sql = "UPDATE tarif_classe SET id_vol = ?, type = ?, classe = ?, tranche_debut = ?, tranche_fin = ?, tarif = ? WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, tarifClasse.getIdVol());
            stmt.setString(2, tarifClasse.getType());
            stmt.setString(3, tarifClasse.getClasse());
            stmt.setInt(4, tarifClasse.getTrancheDebut());
            stmt.setInt(5, tarifClasse.getTrancheFin());
            stmt.setInt(6, tarifClasse.getTarif());
            stmt.setInt(7, tarifClasse.getId());
            stmt.executeUpdate();
        }
    }

    // Supprimer un tarif
    public static void deleteTarif(int id) throws SQLException {
        String sql = "DELETE FROM tarif_classe WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }

    // Fixed to use idVol instead of idAvion and correct string cases
   public static int getTarifByPlacesPrises(int idVol, String classe, int placesPrises) throws SQLException {
    try {
        // Determine the correct tranche
        // For 0-9 places taken: tranche 1-10
        // For 10-19 places taken: tranche 11-20, etc.
        int trancheDebut = (placesPrises / 10) * 10 + 1;
        int trancheFin = trancheDebut + 9;
        
        // Special case: when placesPrises is exactly at a tranche boundary
        // (e.g., 10 should still be in 1-10, not jump to 11-20)
        if (placesPrises % 10 == 0 && placesPrises > 0) {
            trancheDebut -= 10;
            trancheFin -= 10;
        }
        
        // Debug output
        System.out.printf("Calculating tariff for flight %d, class %s: %d places taken -> tranche %d-%d%n",
                        idVol, classe, placesPrises, trancheDebut, trancheFin);
        
        // Get tariff for this tranche
        int tarif = getTarif(idVol, "adulte", classe.toLowerCase(), trancheDebut, trancheFin);
        
        if (tarif == 0) {
            // Fallback to initial tranche if no specific tariff found
            tarif = getTarifInitial(idVol, "adulte", classe.toLowerCase());
            System.out.println("Using initial tariff as fallback: " + tarif);
        }
        
        return tarif;
    } catch (SQLException e) {
        System.err.println("Error retrieving tariff: " + e.getMessage());
        throw e;
    }
}

public static void ajusterTrancheTarifaire(int idTarif, int nouveauTrancheFin) throws SQLException {
    String sql = "UPDATE tarif_classe SET tranche_fin = ? WHERE id = ?";
    try (Connection conn = Connexion.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, nouveauTrancheFin);
        stmt.setInt(2, idTarif);
        stmt.executeUpdate();
    }
}

public static void ajusterTranchesApresAnnulation(int idVol, String classe, int placesLiberees) throws SQLException {
    Connection conn = null;
    try {
        conn = Connexion.getConnection();
        conn.setAutoCommit(false);
        
        TarifClasse trancheActuelle = trouverTrancheActuelle(conn, idVol, classe);
        if (trancheActuelle == null) return;
        
        TarifClasse trancheSuivante = trouverTrancheSuivante(conn, idVol, classe, trancheActuelle.getTrancheFin());
        
        if (trancheSuivante != null) {
            ajusterTrancheSuivante(conn, trancheSuivante, placesLiberees, trancheActuelle.getTrancheFin());
        } else {
            etendreTrancheActuelle(conn, trancheActuelle, placesLiberees);
        }
        
        conn.commit();
    } catch (SQLException e) {
        if (conn != null) conn.rollback();
        throw e;
    } finally {
        if (conn != null) {
            conn.setAutoCommit(true);
            conn.close();
        }
    }
}

// Fonction 1: Trouver la tranche actuelle
private static TarifClasse trouverTrancheActuelle(Connection conn, int idVol, String classe) throws SQLException {
    String sql = "SELECT * FROM tarif_classe WHERE id_vol = ? AND classe = ? AND ? BETWEEN tranche_debut AND tranche_fin";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idVol);
        stmt.setString(2, classe.toLowerCase());
        
        int placesPrises = classe.equalsIgnoreCase("business") ? 
            VolDao.getPlacesPrisesBusiness(idVol) : 
            VolDao.getPlacesPrisesEconomique(idVol);
        stmt.setInt(3, placesPrises);
        
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            TarifClasse tarif = new TarifClasse(
                rs.getInt("id_vol"),
                rs.getString("type"),
                rs.getString("classe"),
                rs.getInt("tranche_debut"),
                rs.getInt("tranche_fin"),
                rs.getInt("tarif")
            );
            tarif.setId(rs.getInt("id"));
            return tarif;
        }
    }
    return null;
}

private static TarifClasse trouverTrancheSuivante(Connection conn, int idVol, String classe, int trancheFinActuelle) throws SQLException {
    String sql = "SELECT * FROM tarif_classe WHERE id_vol = ? AND classe = ? AND tranche_debut > ? ORDER BY tranche_debut ASC LIMIT 1";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, idVol);
        stmt.setString(2, classe.toLowerCase());
        stmt.setInt(3, trancheFinActuelle);
        
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            TarifClasse tarif = new TarifClasse(
                rs.getInt("id_vol"),
                rs.getString("type"),
                rs.getString("classe"),
                rs.getInt("tranche_debut"),
                rs.getInt("tranche_fin"),
                rs.getInt("tarif")
            );
            tarif.setId(rs.getInt("id"));
            return tarif;
        }
    }
    return null;
}


private static void ajusterTrancheSuivante(Connection conn, TarifClasse trancheSuivante, int placesLiberees, int finTrancheActuelle) throws SQLException {
    int nouveauDebut = trancheSuivante.getTrancheDebut() + placesLiberees;
           
        String sql = "UPDATE tarif_classe SET tranche_debut = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, nouveauDebut);
            stmt.setInt(2, trancheSuivante.getId());
            stmt.executeUpdate();
        }
}

private static void etendreTrancheActuelle(Connection conn, TarifClasse trancheActuelle, int placesLiberees) throws SQLException {
    String sql = "UPDATE tarif_classe SET tranche_fin = tranche_fin + ? WHERE id = ?";
    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, placesLiberees);
        stmt.setInt(2, trancheActuelle.getId());
        stmt.executeUpdate();
    }
}




}