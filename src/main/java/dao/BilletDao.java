package dao;

import java.sql.*;
import java.util.UUID;

import Model.Billet;
import Model.Connexion;

public class BilletDao {
    
    public static int create(Billet billet) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Connexion.getConnection();
            
            // Génération d'une référence unique
            String reference = "BLT-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
            
            String sql = "INSERT INTO billet (id_client, id_vol, classe, date_reservation, reference) VALUES (?, ?, ?, ?, ?)";
            ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            ps.setInt(1, billet.getIdClient());
            ps.setInt(2, billet.getIdVol());
            ps.setString(3, billet.getClasse());
            ps.setDate(4, Date.valueOf(billet.getDateReservation()));
            ps.setString(5, reference);
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("La création du billet a échoué");
            }
            
            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1);
            } else {
                throw new SQLException("Aucun ID généré");
            }
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (ps != null) try { ps.close(); } catch (SQLException e) {}
            if (con != null) try { con.close(); } catch (SQLException e) {}
        }
    }
    
    public static Billet findById(int id) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Connexion.getConnection();
            String sql = "SELECT * FROM billet WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if (rs.next()) {
                Billet billet = new Billet();
                billet.setId(rs.getInt("id"));
                billet.setIdClient(rs.getInt("id_client"));
                billet.setIdVol(rs.getInt("id_vol"));
                billet.setClasse(rs.getString("classe"));
                billet.setDateReservation(rs.getDate("date_reservation").toLocalDate());
                billet.setReference(rs.getString("reference"));
                return billet;
            }
            return null;
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (ps != null) try { ps.close(); } catch (SQLException e) {}
            if (con != null) try { con.close(); } catch (SQLException e) {}
        }
    }
    
    public static int getPlacesDisponibles(int idVol, String classe) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = Connexion.getConnection();
            String sql = "SELECT a.nombre_place_" + classe + "_class - COUNT(b.id) AS disponibles " +
                        "FROM avion a JOIN vol v ON a.id = v.id_avion " +
                        "LEFT JOIN billet b ON v.id = b.id_vol AND b.classe = ? " +
                        "WHERE v.id = ? " +
                        "GROUP BY a.nombre_place_" + classe + "_class";
            ps = con.prepareStatement(sql);
            ps.setString(1, classe);
            ps.setInt(2, idVol);
            rs = ps.executeQuery();
            
            if (!rs.next()) {
                throw new SQLException("Impossible de récupérer les places disponibles pour le vol " + idVol);
            }
            return rs.getInt("disponibles");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) {}
            if (ps != null) try { ps.close(); } catch (SQLException e) {}
            if (con != null) try { con.close(); } catch (SQLException e) {}
        }
    }
}