package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model.Connexion;
import Model.Lieu;

public class LieuDao {
    public static List<Lieu> findAll() throws Exception {
        String sql = "SELECT * FROM lieu";

        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Lieu> lieux = new ArrayList<>();

        try {
            c = Connexion.getConnection();
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Lieu lieu = new Lieu();
                lieu.setId(rs.getInt("id"));
                lieu.setNom(rs.getString("nom"));
                lieux.add(lieu);
            }

        } catch (Exception e) {
            throw new Exception("Erreur lors de la récupération des lieux : " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (c != null) c.close();
        }

        return lieux;
    }
}