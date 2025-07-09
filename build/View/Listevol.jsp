<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Vol" %>
<%@ page import="Model.Dest_populaire" %>
<%@ page import="Model.Lieu" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MansTravel - Liste des vols</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --danger: #ef4444;
            --success: #10b981;
            --warning: #f59e0b;
            --light: #f8fafc;
            --dark: #1e293b;
            --gray: #64748b;
            --sidebar-width: 280px;
            --border: #e2e8f0;
            --radius: 12px;
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
            border-radius: var(--radius);
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
        .page-header {
            padding: 20px 40px;
            background: white;
            border-bottom: 1px solid var(--border);
        }

        .page-header h1 {
            font-size: 24px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .page-header h1 i {
            color: var(--primary);
        }

        /* Formulaire de recherche */
        .search-form {
            background-color: white;
            border-radius: var(--radius);
            padding: 25px;
            margin: 30px auto;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
            max-width: 900px;
            width: 90%;
        }

        .search-form h2 {
            text-align: center;
            margin-bottom: 20px;
            font-size: 1.25rem;
            color: var(--dark);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 6px;
            font-weight: 500;
            color: var(--dark);
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .form-group select, 
        .form-group input {
            width: 100%;
            padding: 10px 12px;
            border-radius: var(--radius);
            border: 1px solid var(--border);
            background: white;
            color: var(--dark);
            font-size: 14px;
            transition: all 0.2s ease;
        }

        .form-group select:focus, 
        .form-group input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .search-button {
            grid-column: 1 / -1;
            background-color: var(--primary);
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            border-radius: var(--radius);
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 5px;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .search-button:hover {
            background-color: var(--primary-dark);
        }

        /* Slider destinations */
        .destinations-slider {
            margin: 40px auto;
            width: 90%;
            max-width: 1200px;
        }

        .slider-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .slider-header h2 {
            font-size: 1.25rem;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .slider-controls {
            display: flex;
            gap: 10px;
        }

        .slider-btn {
            background: white;
            border: none;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            transition: all 0.3s ease;
            color: var(--primary);
        }

        .slider-btn:hover {
            background: var(--primary);
            color: white;
        }

        .slider-track {
            display: flex;
            gap: 15px;
            overflow-x: auto;
            padding-bottom: 10px;
            scrollbar-width: none; /* Firefox */
        }

        .slider-track::-webkit-scrollbar {
            display: none; /* Chrome/Safari */
        }

        .destination-item {
            flex: 0 0 180px;
            border-radius: var(--radius);
            overflow: hidden;
            position: relative;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .destination-item:hover {
            transform: translateY(-5px);
        }

        .destination-item img {
            width: 100%;
            height: 120px;
            object-fit: cover;
        }

        .destination-overlay {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            background: linear-gradient(to top, rgba(0,0,0,0.7), transparent);
            color: white;
            padding: 15px;
            font-weight: 500;
            font-size: 14px;
        }

        /* Liste des vols */
        .vols-container {
            flex-grow: 1;
            padding: 30px 40px;
            background-color: #f8fafc;
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(400px, 1fr));
            gap: 20px;
        }

        .vol-card {
            background-color: white;
            border-radius: var(--radius);
            padding: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
            transition: all 0.3s ease;
        }

        .vol-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .vol-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 12px;
        }

        .vol-info-item {
            padding: 12px;
            background-color: #f9fafb;
            border-radius: 8px;
            border: 1px solid var(--border);
            font-size: 14px;
        }

        .vol-info-item span:first-child {
            display: flex;
            align-items: center;
            gap: 6px;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 6px;
            font-size: 14px;
        }

        .vol-actions {
            grid-column: 1 / -1;
            text-align: center;
            padding-top: 12px;
        }

        .reserve-btn {
            background-color: var(--primary);
            color: white;
            padding: 10px 24px;
            border: none;
            border-radius: var(--radius);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 14px;
        }

        .reserve-btn:hover {
            background-color: var(--primary-dark);
        }

        /* Messages */
        .no-vols {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: var(--radius);
            margin: 40px auto;
            max-width: 800px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
        }

        .no-vols i {
            font-size: 48px;
            color: var(--gray);
            margin-bottom: 20px;
        }

        .no-vols p {
            font-size: 16px;
            color: var(--gray);
            margin-bottom: 20px;
        }

        .error-message {
            background-color: rgba(239, 68, 68, 0.1);
            border-left: 4px solid var(--danger);
            padding: 16px;
            border-radius: 0 var(--radius) var(--radius) 0;
            margin: 20px auto;
            color: var(--danger);
            display: flex;
            align-items: center;
            gap: 10px;
            max-width: 1200px;
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
            
            .vols-container {
                grid-template-columns: 1fr;
                padding: 20px;
            }
        }

        @media (max-width: 768px) {
            body {
                flex-direction: column;
            }

            .sidebar {
                width: 100%;
                height: auto;
                position: static;
                flex-direction: row;
                align-items: center;
                padding: 15px;
            }

            .logo {
                padding: 0;
                border-bottom: none;
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

            .vol-info {
                grid-template-columns: 1fr;
            }

            .destination-item {
                flex: 0 0 160px;
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
        
        <nav class="nav-links">
            <a href="index" class="active">
                <i class="fas fa-home"></i>
                <span>Accueil</span>
            </a>
            <a href="admin_index">
                <i class="fas fa-lock"></i>
                <span>Espace Admin</span>
            </a>
        </nav>
    </aside>

    <!-- Contenu principal -->
    <main class="main-content">
        <header class="page-header">
            <h1><i class="fas fa-plane"></i> Rechercher un vol</h1>
        </header>
        
        <!-- Affichage des erreurs -->
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i>
                <span><%= error %></span>
            </div>
        <% } %>

        <!-- Formulaire de recherche -->
        <form action="listevol" method="get" class="search-form">
            <h2><i class="fas fa-search"></i> Critères de recherche</h2>
            <div class="form-grid">
                <div class="form-group">
                    <label for="depart"><i class="fas fa-plane-departure"></i> Départ</label>
                    <select id="depart" name="depart" required>
                        <option value="">-- Sélectionnez --</option>
                        <% List<Lieu> lieux = (List<Lieu>) request.getAttribute("lieux"); %>
                        <% if (lieux != null && !lieux.isEmpty()) { %>
                            <% for (Lieu lieu : lieux) { %>
                                <option value="<%= lieu.getId() %>"><%= lieu.getName() %></option>
                            <% } %>
                        <% } else { %>
                            <option value="">Aucun lieu disponible</option>
                        <% } %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="arrivee"><i class="fas fa-plane-arrival"></i> Arrivée</label>
                    <select id="arrivee" name="arrivee" required>
                        <option value="">-- Sélectionnez --</option>
                        <% if (lieux != null) { %>
                            <% for (Lieu lieu : lieux) { %>
                                <option value="<%= lieu.getId() %>"><%= lieu.getName() %></option>
                            <% } %>
                        <% } %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="nb_passagers
                    "><i class="fas fa-users"></i> Adultes </label>
                    <input type="number" id="nb_passagers" name="nb_passagers" min="1" max="10" value="1" required>
                </div>
                
                <div class="form-group">
                    <label for="date"><i class="fas fa-calendar-alt"></i> Date de départ</label>
                    <input type="date" id="date" name="date" required>
                </div>
                
                <button type="submit" class="search-button">
                    <i class="fas fa-search"></i> Rechercher
                </button>
            </div>
        </form>

        <!-- Slider des destinations -->
        <div class="destinations-slider">
            <div class="slider-header">
                <h2><i class="fas fa-map-marked-alt"></i> Destinations populaires</h2>
                <div class="slider-controls">
                    <button class="slider-btn prev-btn" aria-label="Précédent">
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <button class="slider-btn next-btn" aria-label="Suivant">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
            
            <div class="slider-track">
                <% List<Dest_populaire> destinations = (List<Dest_populaire>) request.getAttribute("destinations"); %>
                <% if (destinations != null) { %>
                    <% for (Dest_populaire dest : destinations) { %>
                        <div class="destination-item">
                            <img src="<%= request.getContextPath() + "/" + dest.getPath_image() %>" alt="<%= dest.getName() %>">
                            <div class="destination-overlay"><%= dest.getName() %></div>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </div>

        <!-- Liste des vols -->
        <% List<Vol> vols = (List<Vol>) request.getAttribute("vols"); %>
        <% Map<Integer, Map<String, Integer>> tarifsParVol = (Map<Integer, Map<String, Integer>>) request.getAttribute("tarifsParVol"); %>
        
        <% if (vols != null && !vols.isEmpty()) { %>
            <div class="vols-container">
                <% for (Vol vol : vols) { 
                    Lieu lieuDepart = null;
                    Lieu lieuArrivee = null;
                    
                    if (lieux != null) {
                        for (Lieu lieu : lieux) {
                            if (lieu.getId() == vol.getId_lieu_depart()) {
                                lieuDepart = lieu;
                            }
                            if (lieu.getId() == vol.getId_lieu_arriver()) {
                                lieuArrivee = lieu;
                            }
                        }
                    }
                    
                    Map<String, Integer> tarifs = tarifsParVol != null ? tarifsParVol.get(vol.getId()) : null;
                %>
                    <div class="vol-card">
                        <div class="vol-info">
                            <!-- Section Départ -->
                            <div class="vol-info-item">
                                <span><i class="fas fa-plane-departure"></i> Départ</span>
                                <%= lieuDepart != null ? lieuDepart.getName() : "Inconnu" %>
                            </div>
                            
                            <!-- Section Arrivée -->
                            <div class="vol-info-item">
                                <span><i class="fas fa-plane-arrival"></i> Arrivée</span>
                                <%= lieuArrivee != null ? lieuArrivee.getName() : "Inconnu" %>
                            </div>
                            
                            <!-- Dates et heures -->
                            <div class="vol-info-item">
                                <span><i class="far fa-calendar-alt"></i> Date départ</span>
                                <%= vol.getDate_depart() != null ? vol.getDate_depart() : "N/A" %>
                            </div>
                            
                            <div class="vol-info-item">
                                <span><i class="far fa-clock"></i> Heure départ</span>
                                <%= vol.getHeure_depart() != null ? vol.getHeure_depart() : "N/A" %>
                            </div>
                            
                            <div class="vol-info-item">
                                <span><i class="fas fa-calendar-day"></i> Date arrivée</span>
                                <%= vol.getDate_arrivee() != null ? vol.getDate_arrivee() : "N/A" %>
                            </div>
                            
                            <div class="vol-info-item">
                                <span><i class="fas fa-clock"></i> Heure arrivée</span>
                                <%= vol.getHeure_arrivee() != null ? vol.getHeure_arrivee() : "N/A" %>
                            </div>
                            
                            
                            <% if (tarifs != null && tarifs.containsKey("business")) { %>
                                <div class="vol-info-item">
                                    <span><i class="fas fa-business-time"></i> Business</span>
                                    <%= vol.getPlaces_libres_business() %> places à <%= tarifs.get("business") %> €
                                </div>
                            <% } else { %>
                                <div class="vol-info-item">
                                    <span><i class="fas fa-business-time"></i> Business</span>
                                    Tarif non disponible
                                </div>
                            <% } %>
                            
                            <% if (tarifs != null && tarifs.containsKey("economique")) { %>
                                <div class="vol-info-item">
                                    <span><i class="fas fa-users"></i> Économique</span>
                                    <%= vol.getPlaces_libres_economique() %> places à <%= tarifs.get("economique") %> €
                                </div>
                            <% } else { %>
                                <div class="vol-info-item">
                                    <span><i class="fas fa-users"></i> Économique</span>
                                    Tarif non disponible
                                </div>
                            <% } %>
                            
                            <!-- Distance -->
                            <div class="vol-info-item">
                                <span><i class="fas fa-route"></i> Distance</span>
                                <%= vol.getDistance_trajet() %> km
                            </div>
                            
                            <!-- Bouton de réservation -->
                            <div class="vol-actions">
                                <a href="reservation?id_vol=<%= vol.getId() %>&nb_passagers=<%= request.getParameter("nb_passagers") != null ? request.getParameter("nb_passagers") : "1" %>" class="reserve-btn">
                                    <i class="fas fa-ticket-alt"></i> Réserver ce vol
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="no-vols">
                <i class="fas fa-plane-slash"></i>
                <p>Aucun vol disponible pour ces critères de recherche.</p>
                <% if (request.getParameter("depart") != null || request.getParameter("arrivee") != null) { %>
                    <a href="listevol" class="reserve-btn">
                        <i class="fas fa-undo"></i> Voir tous les vols
                    </a>
                <% } %>
            </div>
        <% } %>

        <!-- Footer -->
        <footer class="footer">
            <p>&copy; 2025 MansTravel. Tous droits réservés. Votre compagnie aérienne de confiance.</p>
        </footer>
    </main>

    <script>
        // Définir la date minimale comme aujourd'hui
        document.getElementById('date').min = new Date().toISOString().split('T')[0];
        
        // Empêcher la sélection du même aéroport pour départ et arrivée
        document.getElementById('depart').addEventListener('change', function() {
            const arriveeSelect = document.getElementById('arrivee');
            if (this.value === arriveeSelect.value) {
                arriveeSelect.value = '';
            }
        });
        
        document.getElementById('arrivee').addEventListener('change', function() {
            const departSelect = document.getElementById('depart');
            if (this.value === departSelect.value) {
                departSelect.value = '';
            }
        });

        // Slider des destinations
        const track = document.querySelector('.slider-track');
        const prevBtn = document.querySelector('.prev-btn');
        const nextBtn = document.querySelector('.next-btn');
        let currentPosition = 0;

        nextBtn.addEventListener('click', () => {
            currentPosition += 200;
            track.style.transform = `translateX(-${currentPosition}px)`;
            updateButtons();
        });

        prevBtn.addEventListener('click', () => {
            currentPosition = Math.max(0, currentPosition - 200);
            track.style.transform = `translateX(-${currentPosition}px)`;
            updateButtons();
        });

        function updateButtons() {
            prevBtn.disabled = currentPosition === 0;
            // Pour simplifier, on désactive next après un certain nombre de clics
            // En réalité, il faudrait calculer la largeur totale du contenu
            nextBtn.disabled = currentPosition > 1000;
        }

        updateButtons();
    </script>
</body>
</html>