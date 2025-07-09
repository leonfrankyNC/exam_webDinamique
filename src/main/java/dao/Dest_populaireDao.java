package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import Model.Connexion;
import Model.Dest_populaire;

public class Dest_populaireDao {
    public static List<Dest_populaire> findAll() throws Exception {
        String sql = "SELECT id, nom, image_endroit FROM Liste_destination_populaire";

        Connection c = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Dest_populaire> destinations = new ArrayList<>();

        try {
            c = Connexion.getConnection();
            ps = c.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Dest_populaire dest = new Dest_populaire();
                dest.setId(rs.getInt("id"));
                dest.setName(rs.getString("nom"));
                dest.setPath_image(rs.getString("image_endroit"));
                destinations.add(dest);
            }

        } catch (Exception e) {
            throw new Exception("Erreur lors de la récupération des destinations populaires : " + e.getMessage());
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (c != null) c.close();
        }

        return destinations;
    }
}
