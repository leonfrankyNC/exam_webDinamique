package Main;
import Model.*;
import dao.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        System.out.println("Démarrage de la simulation d'annulation automatique...");
        
        // 1. Définir la date de référence pour la simulation
        LocalDate dateReference = LocalDate.of(2025, 7,31); // Date spécifique pour la simulation
        String dateTimeReference = dateReference.atStartOfDay().format(DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm"));
        
        // Pour tester avec une date spécifique, décommentez la ligne suivante:
        // dateReference = LocalDate.of(2023, 12, 25);
        
        System.out.println("Date de référence pour la simulation: " + dateReference);
        
        Connection conn = null;
        try {
            // 2. Établir la connexion à la base de données
            conn = Connexion.getConnection();
            conn.setAutoCommit(false); // Activer la gestion des transactions
            
            // 3. Récupérer les réservations expirées
            List<Reservation> reservationsExpirees = ReservationDao.findExpiredReservations(dateReference);
            
            System.out.println("Nombre de réservations expirées trouvées: " + reservationsExpirees.size());
            
            // 4. Simuler l'expiration et supprimer les réservations
            for (Reservation reservation : reservationsExpirees) {
                System.out.println("\nTraitement de la réservation #" + reservation.getId() + 
                                 " (Vol: " + reservation.getIdVol() + 
                                 ", Client: " + reservation.getIdClient() + ")");
                
                // 5. Simuler l'expiration (marquer comme expiré)
                simulateExpiration(conn, reservation, dateTimeReference);
                
                // 6. Supprimer la réservation comme dans ReservationAdminServlet
                deleteReservation(conn, reservation);
                
                System.out.println("--> Réservation annulée et supprimée avec succès");
            }
            
            conn.commit();
            System.out.println("\nSimulation terminée avec succès !");
            
        } catch (Exception e) {
            System.err.println("Erreur lors de la simulation: " + e.getMessage());
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                System.err.println("Erreur lors du rollback: " + ex.getMessage());
                ex.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                System.err.println("Erreur lors de la fermeture de la connexion: " + e.getMessage());
                e.printStackTrace();
            }
        }
    }
    
    private static void simulateExpiration(Connection conn, Reservation reservation, String dateTime) throws Exception {
        System.out.println("[DEBUG] Simulation de l'expiration pour réservation ID: " + reservation.getId());
        
        // Marquer la réservation comme expirée si elle est en attente
        if ("Attente".equalsIgnoreCase(reservation.getStatus())) {
            reservation.setStatus("Expiré");
            ReservationDao.update(reservation);
            System.out.println("[DEBUG] Statut changé: Attente -> Expiré");
        }
    }
    
    private static void deleteReservation(Connection conn, Reservation reservation) throws Exception {
        System.out.println("[DEBUG] Début suppression réservation ID: " + reservation.getId());
        
        try {
            // 1. Ajustement des tranches tarifaires
            System.out.println("[DEBUG] Ajustement tranches tarifaires pour vol: " + reservation.getIdVol());
            TarifClasseDao.ajusterTranchesApresAnnulation(
                reservation.getIdVol(), 
                reservation.getClasse(), 
                reservation.getNombrePersonne()
            );
            
            // 2. Mise à jour des places
            System.out.println("[DEBUG] Récupération du vol: " + reservation.getIdVol());
            Vol vol = VolDao.findById(reservation.getIdVol());
            
            if ("business".equalsIgnoreCase(reservation.getClasse())) {
                int anciennesPlaces = vol.getPlaces_libres_business();
                vol.setPlaces_libres_business(anciennesPlaces + reservation.getNombrePersonne());
                System.out.printf("[DEBUG] Business: %d -> %d places%n", 
                    anciennesPlaces, vol.getPlaces_libres_business());
            } else {
                int anciennesPlaces = vol.getPlaces_libres_economique();
                vol.setPlaces_libres_economique(anciennesPlaces + reservation.getNombrePersonne());
                System.out.printf("[DEBUG] Economique: %d -> %d places%n",
                    anciennesPlaces, vol.getPlaces_libres_economique());
            }
            
            VolDao.update(vol);
            
            // // 3. Suppression de la réservation
            // System.out.println("[DEBUG] Suppression de la réservation ID: " + reservation.getId());
            // ReservationDao.delete(reservation.getId());
            
            System.out.println("[DEBUG] Suppression réussie pour réservation ID: " + reservation.getId());
        } catch (Exception e) {
            System.err.println("[ERREUR] Échec suppression réservation ID: " + reservation.getId());
            e.printStackTrace();
            throw e;
        }
    }
}