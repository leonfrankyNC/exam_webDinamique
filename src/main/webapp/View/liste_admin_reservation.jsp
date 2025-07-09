<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Reservation" %>
<%@ page import="Model.Vol" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MansTravel - Gestion des réservations (Admin)</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --danger: #ef4444;
            --danger-dark: #dc2626;
            --success: #10b981;
            --light: #f8fafc;
            --dark: #1e293b;
            --gray: #64748b;
            --sidebar-width: 280px;
            --border: #e2e8f0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }

        body {
            background-color: #f1f5f9;
            color: var(--dark);
            min-height: 100vh;
            display: flex;
        }

        /* Navigation latérale */
        .sidebar {
            width: var(--sidebar-width);
            background: white;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            box-shadow: 4px 0 15px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            z-index: 100;
            border-right: 1px solid var(--border);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 25px;
            border-bottom: 1px solid var(--border);
        }

        .logo i {
            font-size: 28px;
            color: var(--primary);
        }

        .logo h1 {
            font-size: 22px;
            font-weight: 700;
            color: var(--dark);
        }

        .admin-info {
            padding: 20px;
            background: rgba(59, 130, 246, 0.05);
            border-bottom: 1px solid var(--border);
        }

        .admin-info p {
            font-size: 14px;
            color: var(--gray);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-links {
            padding: 20px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .nav-links a {
            color: var(--gray);
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            padding: 12px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .nav-links a:hover {
            background-color: rgba(59, 130, 246, 0.1);
            color: var(--primary-dark);
        }

        .nav-links a.active {
            background-color: var(--primary);
            color: white;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        .nav-links a i {
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        /* Contenu principal */
        .main-content {
            flex-grow: 1;
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        .admin-header {
            padding: 20px 40px;
            background: white;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .admin-header h2 {
            font-size: 20px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .admin-header h2 i {
            color: var(--primary);
        }

        .add-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            background-color: var(--primary);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .add-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        /* Tableau des réservations */
        .reservations-container {
            flex-grow: 1;
            padding: 30px 40px;
            background-color: #f8fafc;
        }

        .reservations-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 15px;
        }

        .reservations-table thead th {
            background-color: white;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: var(--gray);
            border-bottom: 2px solid var(--border);
        }

        .reservations-table tbody tr {
            background-color: white;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
        }

        .reservations-table tbody tr:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .reservations-table td {
            padding: 15px;
            vertical-align: middle;
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
        }

        .reservations-table td:first-child {
            border-left: 1px solid var(--border);
            border-top-left-radius: 8px;
            border-bottom-left-radius: 8px;
        }

        .reservations-table td:last-child {
            border-right: 1px solid var(--border);
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
        }

        .reservation-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .reservation-info i {
            color: var(--primary);
            font-size: 18px;
            width: 24px;
            text-align: center;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 50px;
            font-size: 12px;
            font-weight: 500;
        }

        .status-confirmed {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success);
        }

        .status-pending {
            background-color: rgba(245, 158, 11, 0.1);
            color: #f59e0b;
        }

        .status-cancelled {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
        }

        .action-btn {
            padding: 8px 16px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .edit-btn {
            background-color: rgba(59, 130, 246, 0.1);
            color: var(--primary);
        }

        .edit-btn:hover {
            background-color: var(--primary);
            color: white;
        }

        .delete-btn {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger);
        }

        .delete-btn:hover {
            background-color: var(--danger);
            color: white;
        }

        /* Messages */
        .no-reservations {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .no-reservations i {
            font-size: 48px;
            color: var(--gray);
            margin-bottom: 20px;
        }

        .no-reservations p {
            font-size: 16px;
            color: var(--gray);
            margin-bottom: 20px;
        }

        .error-message {
            background-color: rgba(239, 68, 68, 0.1);
            border-left: 4px solid var(--danger);
            padding: 16px;
            border-radius: 8px;
            margin-bottom: 20px;
            color: var(--danger);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 25px;
            background: white;
            border-top: 1px solid var(--border);
            color: var(--gray);
            font-size: 14px;
        }

        /* Responsive */
        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
            }
            
            .reservations-table {
                display: block;
                overflow-x: auto;
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: static;
                flex-direction: row;
                align-items: center;
                padding: 15px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
            }
            
            .logo {
                padding: 0;
                border-bottom: none;
            }
            
            .admin-info {
                display: none;
            }
            
            .nav-links {
                flex-direction: row;
                padding: 0 15px;
                flex-wrap: wrap;
                justify-content: flex-end;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .reservations-container {
                padding: 20px;
            }
            
            .reservations-table thead {
                display: none;
            }
            
            .reservations-table tbody tr {
                display: block;
                margin-bottom: 20px;
            }
            
            .reservations-table td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 15px;
                border: 1px solid var(--border);
            }
            
            .reservations-table td::before {
                content: attr(data-label);
                font-weight: 600;
                color: var(--gray);
                margin-right: 15px;
            }
            
            .reservations-table td:first-child {
                border-top-left-radius: 8px;
                border-top-right-radius: 8px;
            }
            
            .reservations-table td:last-child {
                border-bottom-left-radius: 8px;
                border-bottom-right-radius: 8px;
            }
            
            .action-buttons {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation latérale -->
    <aside class="sidebar">
        <div class="logo">
            <i class="fas fa-plane-departure"></i>
            <h1>MansTravel</h1>
        </div>
        
        <div class="admin-info">
            <p><i class="fas fa-user-shield"></i> Connecté en tant qu'admin</p>
        </div>
        
        <nav class="nav-links">
            <a href="index">
                <i class="fas fa-home"></i>
                <span>Accueil public</span>
            </a>
            <a href="admin_index">
                <i class="fas fa-tachometer-alt"></i>
                <span>Tableau de bord</span>
            </a>
            <a href="liste_admin_reservation" class="active">
                <i class="fas fa-ticket-alt"></i>
                <span>Réservations</span>
            </a>
            <a href="liste_admin_vol">
                <i class="fas fa-plane"></i>
                <span>Gestion vols</span>
            </a>
        </nav>
    </aside>

    <!-- Contenu principal -->
    <main class="main-content">
        <header class="admin-header">
            <h2><i class="fas fa-ticket-alt"></i> Gestion des réservations</h2>
        </header>
        
        <section class="reservations-container">
            <% 
                List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
                List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                String error = (String) request.getAttribute("error");
                
                if (error != null) {
            %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <span><%= error %></span>
                </div>
            <% } %>
            
            <% if (reservations != null && !reservations.isEmpty()) { %>
                <table class="reservations-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Vol</th>
                            <th>Client</th>
                            <th>Personnes</th>
                            <th>Prix</th>
                            <th>Statut</th>
                            <th>Date Réservation</th>
                            <th>Classe</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Reservation reservation : reservations) { 
                            Vol vol = null;
                            if (vols != null) {
                                for (Vol v : vols) {
                                    if (v.getId() == reservation.getIdVol()) {
                                        vol = v;
                                        break;
                                    }
                                }
                            }
                        %>
                            <tr>
                                <td data-label="ID">
                                    <div class="reservation-info">
                                        <i class="fas fa-hashtag"></i>
                                        <span><%= reservation.getId() %></span>
                                    </div>
                                </td>
                                <td data-label="Vol">
                                    <div class="reservation-info">
                                        <i class="fas fa-plane"></i>
                                        <span>
                                            <% if (vol != null) { %>
                                                Vol #<%= vol.getId() %>
                                            <% } else { %>
                                                Vol inconnu
                                            <% } %>
                                        </span>
                                    </div>
                                </td>
                                <td data-label="Client">
                                    <div class="reservation-info">
                                        <i class="fas fa-user"></i>
                                        <span><%= reservation.getIdClient() %></span>
                                    </div>
                                </td>
                                <td data-label="Personnes">
                                    <div class="reservation-info">
                                        <i class="fas fa-users"></i>
                                        <span><%= reservation.getNombrePersonne() %></span>
                                    </div>
                                </td>
                                <td data-label="Prix">
                                    <div class="reservation-info">
                                        <i class="fas fa-euro-sign"></i>
                                        <span><%= reservation.getPrix() %> €</span>
                                    </div>
                                </td>
                                <td data-label="Statut">
                                    <span class="status-badge status-<%= reservation.getStatus().toLowerCase() %>">
                                        <%= reservation.getStatus() %>
                                    </span>
                                </td>
                                <td data-label="Date Réservation">
                                    <div class="reservation-info">
                                        <i class="far fa-calendar-alt"></i>
                                        <span><%= reservation.getDate_reservation() != null ? reservation.getDate_reservation() : "N/A" %></span>
                                    </div>
                                </td>
                                <td data-label="Classe">
                                    <div class="reservation-info">
                                        <i class="fas fa-chair"></i>
                                        <span><%= reservation.getClasse() %></span>
                                    </div>
                                </td>
                                <td data-label="Actions">
                                    <div class="action-buttons">
                                        <a href="liste_admin_reservation?action=modifier&id=<%= reservation.getId() %>" 
                                           class="action-btn edit-btn">
                                            <i class="fas fa-edit"></i>
                                            <span class="desktop-text">Modifier</span>
                                        </a>
                                        <% if( "Annule".equals(reservation.getStatus()) || "paye".equals(reservation.getStatus()) ) { %> 
   
                                        <a href="#" class = "action-btn"> Reservation deja annulée ou paye </a>
                                        
                                         <% } else { %>  
                                         
   <a href="liste_admin_reservation?action=delete&id=<%= reservation.getId() %>" 
                                           class="action-btn delete-btn"
                                           onclick="return confirm('Voulez-vous vraiment supprimer cette réservation ?');">
                                            <i class="fas fa-trash"></i>
                                            <span class="desktop-text">Supprimer</span>
                                        </a>
                                         
                                         <% } %>
                                     
                                    </div>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="no-reservations">
                    <i class="fas fa-ticket-alt"></i>
                    <p>Aucune réservation disponible</p>
                </div>
            <% } %>
        </section>
        
        <footer class="footer">
            <p>&copy; 2025 MansTravel. Tous droits réservés. Plateforme d'administration</p>
        </footer>
    </main>
</body>
</html>