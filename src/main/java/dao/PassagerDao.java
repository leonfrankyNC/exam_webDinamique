package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import Model.Connexion;
import Model.Passager;

public class PassagerDao {
public static void create(Passager passager) throws Exception {
    Connection con = null;
    PreparedStatement ps = null;
    
    try {
        con = Connexion.getConnection();
        String sql = "INSERT INTO passager (id_billet, nom, prenom, numero_passeport) VALUES (?, ?, ?, ?)";
        ps = con.prepareStatement(sql);
        ps.setInt(1, passager.getIdBillet());
        ps.setString(2, passager.getNom());
        ps.setString(3, passager.getPrenom());
        ps.setString(4, passager.getNumeroPasseport());
        ps.executeUpdate();
    } finally {
        if (ps != null) try { ps.close(); } catch (SQLException e) {}
        if (con != null) try { con.close(); } catch (SQLException e) {}
    }
}
}
