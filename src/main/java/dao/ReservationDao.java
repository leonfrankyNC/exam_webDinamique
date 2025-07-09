package dao;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import Model.Connexion;
import Model.Reservation;

public class ReservationDao {

    public static List<Reservation> findAll() throws Exception {
        List<Reservation> reservations = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = Connexion.getConnection();
            String sql = "SELECT * FROM reservation";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Reservation reservation = new Reservation();
                reservation.setId(rs.getInt("id"));
                reservation.setIdVol(rs.getInt("id_vol"));
                reservation.setIdClient(rs.getInt("id_client"));
                reservation.setNombrePersonne(rs.getInt("nombre_personne"));
                reservation.setPrix(rs.getInt("prix"));
                reservation.setStatus(rs.getString("status"));
                 reservation.setDate_reservation(
                rs.getDate("date_reservation") != null ? 
                rs.getDate("date_reservation").toLocalDate() : null);
                reservation.setDateFinPayement(
                    rs.getDate("date_fin_payement") != null ? 
                    rs.getDate("date_fin_payement").toLocalDate() : null);
                reservation.setClasse(rs.getString("classe"));
                reservations.add(reservation);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return reservations;
    }

    public static Reservation findById(int id) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        Reservation reservation = null;

        try {
            con = Connexion.getConnection();
            String sql = "SELECT * FROM reservation WHERE id = ?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                reservation = new Reservation();
                reservation.setId(rs.getInt("id"));
                reservation.setIdVol(rs.getInt("id_vol"));
                reservation.setIdClient(rs.getInt("id_client"));
                reservation.setNombrePersonne(rs.getInt("nombre_personne"));
                reservation.setPrix(rs.getInt("prix"));
                reservation.setStatus(rs.getString("status"));
                 reservation.setDate_reservation(
                rs.getDate("date_reservation") != null ? 
                rs.getDate("date_reservation").toLocalDate() : null);
                reservation.setDateFinPayement(
                    rs.getDate("date_fin_payement") != null ? 
                    rs.getDate("date_fin_payement").toLocalDate() : null);
                reservation.setClasse(rs.getString("classe"));
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return reservation;
    }

     public static void save(Reservation reservation) throws Exception {
    Connection con = null;
    PreparedStatement ps = null;

    try {
        con = Connexion.getConnection();
        String sql = "INSERT INTO reservation (id_vol, id_client, nombre_personne, prix, status, date_reservation, date_fin_payement,classe) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        
        ps.setInt(1, reservation.getIdVol());
        ps.setInt(2, reservation.getIdClient());
        ps.setInt(3, reservation.getNombrePersonne());
        ps.setInt(4, reservation.getPrix());
        ps.setString(5, reservation.getStatus());
        ps.setDate(6, reservation.getDate_reservation() != null ? 
                   Date.valueOf(reservation.getDate_reservation()) : null);
        ps.setDate(7, reservation.getDateFinPayement() != null ? 
                   Date.valueOf(reservation.getDateFinPayement()) : null);
        ps.setString(8, reservation.getClasse());
        
        ps.executeUpdate();
        
        // Retrieve generated ID
        try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
            if (generatedKeys.next()) {
                reservation.setId(generatedKeys.getInt(1));
            }
        }
    } finally {
        if (ps != null) ps.close();
        if (con != null) con.close();
    }
}

public static void update(Reservation reservation) throws Exception {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = Connexion.getConnection();
        con.setAutoCommit(false);

        // 1. Récupérer l'ancienne réservation
        String sqlSelect = "SELECT nombre_personne, classe FROM reservation WHERE id = ?";
        ps = con.prepareStatement(sqlSelect);
        ps.setInt(1, reservation.getId());
        rs = ps.executeQuery();

        if (rs.next()) {
            int ancienNombrePersonne = rs.getInt("nombre_personne");
            String ancienneClasse = rs.getString("classe");

            // 2. Mettre à jour la réservation
            String sqlUpdate = "UPDATE reservation SET id_vol = ?, id_client = ?, nombre_personne = ?, prix = ?, " +
                               "status = ?, date_reservation = ?, date_fin_payement = ?, classe = ? WHERE id = ?";
            ps = con.prepareStatement(sqlUpdate);
            
            ps.setInt(1, reservation.getIdVol());
            ps.setInt(2, reservation.getIdClient());
            ps.setInt(3, reservation.getNombrePersonne());
            ps.setInt(4, reservation.getPrix());
            ps.setString(5, reservation.getStatus());
            ps.setDate(6, reservation.getDate_reservation() != null ? 
                       Date.valueOf(reservation.getDate_reservation()) : null);
            ps.setDate(7, reservation.getDateFinPayement() != null ? 
                       Date.valueOf(reservation.getDateFinPayement()) : null);
            ps.setString(8, reservation.getClasse());
            ps.setInt(9, reservation.getId());
            
            ps.executeUpdate();

            // 3. Mettre à jour les places si nécessaire
            if (!ancienneClasse.equals(reservation.getClasse()) || 
                ancienNombrePersonne != reservation.getNombrePersonne()) {
                
                // Remettre les anciennes places
                if ("business".equalsIgnoreCase(ancienneClasse)) {
                    VolDao.incrementerPlacesBusiness(reservation.getIdVol(), ancienNombrePersonne);
                } else {
                    VolDao.incrementerPlacesEconomique(reservation.getIdVol(), ancienNombrePersonne);
                }

                // Enlever les nouvelles places
                if ("business".equalsIgnoreCase(reservation.getClasse())) {
                    VolDao.decrementerPlacesBusiness(reservation.getIdVol(), reservation.getNombrePersonne());
                } else {
                    VolDao.decrementerPlacesEconomique(reservation.getIdVol(), reservation.getNombrePersonne());
                }
            }

            con.commit();
        }
    } catch (SQLException e) {
        if (con != null) {
            con.rollback();
        }
        throw e;
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) {
            con.setAutoCommit(true);
            con.close();
        }
    }
}

    public static void delete(int id) throws Exception {
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = Connexion.getConnection();
        con.setAutoCommit(false); // Désactive l'autocommit pour la transaction

        // 1. Récupérer les infos de la réservation avant suppression
        String sqlSelect = "SELECT id_vol, nombre_personne, classe FROM reservation WHERE id = ?";
        ps = con.prepareStatement(sqlSelect);
        ps.setInt(1, id);
        rs = ps.executeQuery();

        if (rs.next()) {
            int idVol = rs.getInt("id_vol");
            int nombrePersonne = rs.getInt("nombre_personne");
            String classe = rs.getString("classe");

     
            String sqlDelete = "DELETE FROM reservation WHERE id = ?";
            ps = con.prepareStatement(sqlDelete);
            ps.setInt(1, id);
            ps.executeUpdate();

         
            if ("business".equalsIgnoreCase(classe)) {
                VolDao.incrementerPlacesBusiness(idVol, nombrePersonne);
            } else {
                VolDao.incrementerPlacesEconomique(idVol, nombrePersonne);
            }

            con.commit(); 
        }
    } catch (SQLException e) {
        if (con != null) {
            con.rollback(); 
        }
        throw e;
    } finally {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) {
            con.setAutoCommit(true);
            con.close();
        }
    }
}

public static int countPlacesReservees(int idVol, String classe) throws SQLException {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int totalPlaces = 0;

        try {
            con = Connexion.getConnection();
            String sql = "SELECT SUM(nombre_personne) AS total FROM reservation WHERE id_vol = ? AND classe = ? AND status != 'annulee'";
            ps = con.prepareStatement(sql);
            ps.setInt(1, idVol);
            ps.setString(2, classe);
            rs = ps.executeQuery();

            if (rs.next()) {
                totalPlaces = rs.getInt("total"); // SUM peut retourner NULL si aucune réservation
                if (rs.wasNull()) {
                    totalPlaces = 0; 
                }
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (con != null) con.close();
        }
        return totalPlaces;
    }
    
    public static List<Reservation> findExpiredReservations(LocalDate currentDate) throws SQLException {
    String sql = "SELECT * FROM reservation WHERE status = 'Attente' AND date_fin_payement < ?";
    List<Reservation> reservations = new ArrayList<>();
    
    try (Connection conn = Connexion.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setDate(1, Date.valueOf(currentDate));
        
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Reservation reservation = new Reservation();
            reservation.setId(rs.getInt("id"));
            reservation.setIdVol(rs.getInt("id_vol"));
            reservation.setIdClient(rs.getInt("id_client"));
            reservation.setNombrePersonne(rs.getInt("nombre_personne"));
            reservation.setPrix(rs.getInt("prix"));
            reservation.setStatus(rs.getString("status"));
            reservation.setClasse(rs.getString("classe"));
            reservation.setDate_reservation(rs.getDate("date_reservation").toLocalDate());
            reservation.setDateFinPayement(rs.getDate("date_fin_payement").toLocalDate());
            
            reservations.add(reservation);
        }
    }
    return reservations;
}
  
}