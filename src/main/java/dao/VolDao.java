package dao;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import Model.Connexion;
import Model.Vol;

public class VolDao {

    public static List<Vol> findAll() throws Exception {
        List<Vol> vols = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Connexion.getConnection();
            String sql = "SELECT * FROM vol";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Vol vol = new Vol();
                vol.setId(rs.getInt("id"));
                vol.setId_avion(rs.getInt("id_avion"));
                vol.setId_pilote(rs.getInt("id_pilote"));
                vol.setId_lieu_depart(rs.getInt("id_lieu_depart"));
                vol.setId_lieu_arriver(rs.getInt("id_lieu_arriver"));
                vol.setHeure_depart(rs.getTime("heure_depart").toLocalTime());
                vol.setHeure_arrivee(rs.getTime("heure_arrivee").toLocalTime());
                vol.setDate_depart(rs.getDate("date_depart").toLocalDate());
                vol.setDate_arrivee(rs.getDate("date_arrivee").toLocalDate());
                vol.setDistance_trajet(rs.getInt("distance_trajet"));
                vol.setNombre_place_business_class(rs.getInt("nombre_place_business_class"));
                vol.setNombre_place_economique_class(rs.getInt("nombre_place_economique_class"));
                vol.setBusiness_class_pris(rs.getInt("business_class_pris"));
                vol.setEconomique_class_pris(rs.getInt("economique_class_pris"));
                vol.setPlaces_libres_business(rs.getInt("places_libres_business"));
                vol.setPlaces_libres_economique(rs.getInt("places_libres_economique"));
                
                vols.add(vol);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return vols;
    }

    public static Vol getVolById(int id) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Vol vol = null;

        try {
            con = Connexion.getConnection();
            String sql = "SELECT * FROM vol WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                vol = new Vol();
                vol.setId(rs.getInt("id"));
                vol.setId_avion(rs.getInt("id_avion"));
                vol.setId_pilote(rs.getInt("id_pilote"));
                vol.setId_lieu_depart(rs.getInt("id_lieu_depart"));
                vol.setId_lieu_arriver(rs.getInt("id_lieu_arriver"));
                vol.setHeure_depart(rs.getTime("heure_depart").toLocalTime());
                vol.setHeure_arrivee(rs.getTime("heure_arrivee").toLocalTime());
                vol.setDate_depart(rs.getDate("date_depart").toLocalDate());
                vol.setDate_arrivee(rs.getDate("date_arrivee").toLocalDate());
                vol.setDistance_trajet(rs.getInt("distance_trajet"));
                vol.setNombre_place_business_class(rs.getInt("nombre_place_business_class"));
                vol.setNombre_place_economique_class(rs.getInt("nombre_place_economique_class"));
                vol.setBusiness_class_pris(rs.getInt("business_class_pris"));
                vol.setEconomique_class_pris(rs.getInt("economique_class_pris"));
                vol.setPlaces_libres_business(rs.getInt("places_libres_business"));
                vol.setPlaces_libres_economique(rs.getInt("places_libres_economique"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return vol;
    }
    
    public static List<Vol> findVolsByCriteria(Integer idLieuDepart, Integer idLieuArrivee, LocalDate dateDepart) throws Exception {
        List<Vol> vols = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Connexion.getConnection();
            StringBuilder sql = new StringBuilder("SELECT * FROM vol WHERE 1=1");
            
            if (idLieuDepart != null) {
                sql.append(" AND id_lieu_depart = ?");
            }
            if (idLieuArrivee != null) {
                sql.append(" AND id_lieu_arriver = ?");
            }
            if (dateDepart != null) {
                sql.append(" AND date_depart = ?");
            }
            
            ps = con.prepareStatement(sql.toString());
            
            int paramIndex = 1;
            if (idLieuDepart != null) {
                ps.setInt(paramIndex++, idLieuDepart);
            }
            if (idLieuArrivee != null) {
                ps.setInt(paramIndex++, idLieuArrivee);
            }
            if (dateDepart != null) {
                ps.setDate(paramIndex++, Date.valueOf(dateDepart));
            }
            
            rs = ps.executeQuery();
            
            while (rs.next()) {
                Vol vol = new Vol();
                vol.setId(rs.getInt("id"));
                vol.setId_avion(rs.getInt("id_avion"));
                vol.setId_pilote(rs.getInt("id_pilote"));
                vol.setId_lieu_depart(rs.getInt("id_lieu_depart"));
                vol.setId_lieu_arriver(rs.getInt("id_lieu_arriver"));
                vol.setHeure_depart(rs.getTime("heure_depart").toLocalTime());
                vol.setHeure_arrivee(rs.getTime("heure_arrivee").toLocalTime());
                vol.setDate_depart(rs.getDate("date_depart").toLocalDate());
                vol.setDate_arrivee(rs.getDate("date_arrivee").toLocalDate());
                vol.setDistance_trajet(rs.getInt("distance_trajet"));
                vol.setNombre_place_business_class(rs.getInt("nombre_place_business_class"));
                vol.setNombre_place_economique_class(rs.getInt("nombre_place_economique_class"));
                vol.setBusiness_class_pris(rs.getInt("business_class_pris"));
                vol.setEconomique_class_pris(rs.getInt("economique_class_pris"));
                vol.setPlaces_libres_business(rs.getInt("places_libres_business"));
                vol.setPlaces_libres_economique(rs.getInt("places_libres_economique"));
                
                vols.add(vol);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        
        return vols;
    }

    public static int getPlacesDisponibles(int idVol, String classe) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int disponibles = 0;

        try {
            con = Connexion.getConnection();
            String sql = "SELECT places_libres_" + (classe.equals("business") ? "business" : "economique") + 
                         " FROM vol WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, idVol);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                disponibles = rs.getInt(1);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return disponibles;
    }
    
    public static void updatePlacesDisponibles(int idVol, String classe, int nbPassagers) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = Connexion.getConnection();
            String sql = "UPDATE vol SET places_libres_" + (classe.equals("business") ? "business" : "economique") + 
                         " = places_libres_" + (classe.equals("business") ? "business" : "economique") + " - ? " +
                         "WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, nbPassagers);
            ps.setInt(2, idVol);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    public static Vol findById(int id) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Vol vol = null;

        try {
            con = Connexion.getConnection();
            String sql = "SELECT v.*, ld.nom as depart_name, la.nom as arrivee_name " +
                         "FROM vol v " +
                         "JOIN lieu ld ON v.id_lieu_depart = ld.id " +
                         "JOIN lieu la ON v.id_lieu_arriver = la.id " +
                         "WHERE v.id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                vol = new Vol();
                vol.setId(rs.getInt("id"));
                vol.setId_avion(rs.getInt("id_avion"));
                vol.setId_pilote(rs.getInt("id_pilote"));
                vol.setId_lieu_depart(rs.getInt("id_lieu_depart"));
                vol.setId_lieu_arriver(rs.getInt("id_lieu_arriver"));
                vol.setHeure_depart(rs.getTime("heure_depart").toLocalTime());
                vol.setHeure_arrivee(rs.getTime("heure_arrivee").toLocalTime());
                vol.setDate_depart(rs.getDate("date_depart").toLocalDate());
                vol.setDate_arrivee(rs.getDate("date_arrivee").toLocalDate());
                vol.setDistance_trajet(rs.getInt("distance_trajet"));
                vol.setNombre_place_business_class(rs.getInt("nombre_place_business_class"));
                vol.setNombre_place_economique_class(rs.getInt("nombre_place_economique_class"));
                vol.setBusiness_class_pris(rs.getInt("business_class_pris"));
                vol.setEconomique_class_pris(rs.getInt("economique_class_pris"));
                vol.setPlaces_libres_business(rs.getInt("places_libres_business"));
                vol.setPlaces_libres_economique(rs.getInt("places_libres_economique"));
            }
            else {
                System.out.println("No flight found for id: " + id);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return vol;
    }

    public static void save(Vol vol) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = Connexion.getConnection();
            String sql = "INSERT INTO vol (id_avion, id_pilote, id_lieu_depart, id_lieu_arriver, " +
                         "heure_depart, heure_arrivee, date_depart, date_arrivee, distance_trajet, " +
                         "nombre_place_business_class, nombre_place_economique_class, " +
                         "business_class_pris, economique_class_pris, " +
                         "places_libres_business, places_libres_economique) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, vol.getId_avion());
            ps.setInt(2, vol.getId_pilote());
            ps.setInt(3, vol.getId_lieu_depart());
            ps.setInt(4, vol.getId_lieu_arriver());
            ps.setTime(5, Time.valueOf(vol.getHeure_depart()));
            ps.setTime(6, Time.valueOf(vol.getHeure_arrivee()));
            ps.setDate(7, Date.valueOf(vol.getDate_depart()));
            ps.setDate(8, Date.valueOf(vol.getDate_arrivee()));
            ps.setInt(9, vol.getDistance_trajet());
            ps.setInt(10, vol.getNombre_place_business_class());
            ps.setInt(11, vol.getNombre_place_economique_class());
            ps.setInt(12, vol.getBusiness_class_pris());
            ps.setInt(13, vol.getEconomique_class_pris());
            ps.setInt(14, vol.getPlaces_libres_business());
            ps.setInt(15, vol.getPlaces_libres_economique());
            
            ps.executeUpdate();
            
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    vol.setId(generatedKeys.getInt(1));
                }
            }
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    public static void update(Vol vol) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = Connexion.getConnection();
            String sql = "UPDATE vol SET " +
                         "id_avion = ?, id_pilote = ?, id_lieu_depart = ?, id_lieu_arriver = ?, " +
                         "heure_depart = ?, heure_arrivee = ?, date_depart = ?, date_arrivee = ?, " +
                         "distance_trajet = ?, nombre_place_business_class = ?, " +
                         "nombre_place_economique_class = ?, business_class_pris = ?, " +
                         "economique_class_pris = ?, places_libres_business = ?, " +
                         "places_libres_economique = ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            
            ps.setInt(1, vol.getId_avion());
            ps.setInt(2, vol.getId_pilote());
            ps.setInt(3, vol.getId_lieu_depart());
            ps.setInt(4, vol.getId_lieu_arriver());
            ps.setTime(5, Time.valueOf(vol.getHeure_depart()));
            ps.setTime(6, Time.valueOf(vol.getHeure_arrivee()));
            ps.setDate(7, Date.valueOf(vol.getDate_depart()));
            ps.setDate(8, Date.valueOf(vol.getDate_arrivee()));
            ps.setInt(9, vol.getDistance_trajet());
            ps.setInt(10, vol.getNombre_place_business_class());
            ps.setInt(11, vol.getNombre_place_economique_class());
            ps.setInt(12, vol.getBusiness_class_pris());
            ps.setInt(13, vol.getEconomique_class_pris());
            ps.setInt(14, vol.getPlaces_libres_business());
            ps.setInt(15, vol.getPlaces_libres_economique());
            ps.setInt(16, vol.getId());
            
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

   public static void delete(int id) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = Connexion.getConnection();
            con.setAutoCommit(false); 

         
            String sqlTarif = "DELETE FROM tarif_classe WHERE id_vol = ?";
            ps = con.prepareStatement(sqlTarif);
            ps.setInt(1, id);
            int tariffsDeleted = ps.executeUpdate();
            System.out.println("[DEBUG] Nombre de tarifs supprimés pour le vol ID " + id + " : " + tariffsDeleted);

          
            String sqlReservation = "DELETE FROM reservation WHERE id_vol = ?";
            ps = con.prepareStatement(sqlReservation);
            ps.setInt(1, id);
            int reservationsDeleted = ps.executeUpdate();
            System.out.println("[DEBUG] Nombre de réservations supprimées pour le vol ID " + id + " : " + reservationsDeleted);


            String sqlVol = "DELETE FROM vol WHERE id = ?";
            ps = con.prepareStatement(sqlVol);
            ps.setInt(1, id);
            int volsDeleted = ps.executeUpdate();
            System.out.println("[DEBUG] Vol ID " + id + " supprimé : " + (volsDeleted > 0 ? "Succès" : "Échec"));

            con.commit(); 
        } catch (SQLException e) {
            if (con != null) {
                try {
                    con.rollback();
                    System.err.println("[ERREUR] Rollback effectué pour la suppression du vol ID " + id + " : " + e.getMessage());
                } catch (SQLException ex) {
                    System.err.println("[ERREUR] Échec du rollback : " + ex.getMessage());
                }
            }
            throw e;
        } finally {
            if (ps != null) ps.close();
            if (con != null) {
                con.setAutoCommit(true);
                con.close();
            }
        }
    }
    
    public static void incrementerPlacesBusiness(int idVol, int nombrePersonnes) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = Connexion.getConnection();
            String sql = "UPDATE vol SET places_libres_business = places_libres_business + ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, nombrePersonnes);
            ps.setInt(2, idVol);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    public static void incrementerPlacesEconomique(int idVol, int nombrePersonnes) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = Connexion.getConnection();
            String sql = "UPDATE vol SET places_libres_economique = places_libres_economique + ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, nombrePersonnes);
            ps.setInt(2, idVol);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    public static void decrementerPlacesBusiness(int idVol, int nombrePersonnes) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = Connexion.getConnection();
            String sql = "UPDATE vol SET places_libres_business = places_libres_business - ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, nombrePersonnes);
            ps.setInt(2, idVol);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }

    public static void decrementerPlacesEconomique(int idVol, int nombrePersonnes) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        
        try {
            con = Connexion.getConnection();
            String sql = "UPDATE vol SET places_libres_economique = places_libres_economique - ? WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, nombrePersonnes);
            ps.setInt(2, idVol);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
    }
    
 public static void updatePlacesPrisesBusiness(int idVol, int nouvellesPlacesPrises) throws SQLException {
    Connection con = null;
    PreparedStatement ps = null;
    
    try {
        con = Connexion.getConnection();
        String sql = "UPDATE vol SET business_class_pris = ? WHERE id = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, nouvellesPlacesPrises);
        ps.setInt(2, idVol);
        ps.executeUpdate();
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
}

public static void updatePlacesPrisesEconomique(int idVol, int nouvellesPlacesPrises) throws SQLException {
    Connection con = null;
    PreparedStatement ps = null;
    
    try {
        con = Connexion.getConnection();
        String sql = "UPDATE vol SET economique_class_pris = ? WHERE id = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, nouvellesPlacesPrises);
        ps.setInt(2, idVol);
        ps.executeUpdate();
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
}


public static int getPlacesPrisesBusiness(int idVol) throws SQLException {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int placesPrises = 0;

    try {
        con = Connexion.getConnection();
        String sql = "SELECT business_class_pris FROM vol WHERE id = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, idVol);
        rs = ps.executeQuery();

        if (rs.next()) {
            placesPrises = rs.getInt("business_class_pris");
        }
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
    return placesPrises;
}


public static int getPlacesPrisesEconomique(int idVol) throws SQLException {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    int placesPrises = 0;

    try {
        con = Connexion.getConnection();
        String sql = "SELECT economique_class_pris FROM vol WHERE id = ?";
        ps = con.prepareStatement(sql);
        ps.setInt(1, idVol);
        rs = ps.executeQuery();

        if (rs.next()) {
            placesPrises = rs.getInt("economique_class_pris");
        }
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
    return placesPrises;
}
}