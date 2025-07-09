package dao;

import Model.Admin;
import Model.Connexion;

import java.sql.*;

public class AdminDao {
    public static Admin findByCredentials(String nom, String mdp) {
        Admin admin = null;
        String sql = "SELECT * FROM admin WHERE nom = ? AND mdp = ?";
        
        try (Connection connection = Connexion.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            
            statement.setString(1, nom);
            statement.setString(2, mdp);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    admin = new Admin();
                    admin.setId(resultSet.getInt("id"));
                    admin.setNom(resultSet.getString("nom"));
                    admin.setMdp(resultSet.getString("mdp"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admin;
    }
}