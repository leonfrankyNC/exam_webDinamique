<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Vol" %>
<%@ page import="Model.Lieu" %>
<%@ page import="java.time.LocalTime" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier le vol</title>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .reservation-container {
            width: 100%;
            max-width: 800px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.15);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(to right, #004080, #0077b6);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 32px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .header p {
            font-size: 18px;
            opacity: 0.9;
        }
        
        .form-content {
            padding: 40px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: #004080;
            font-size: 16px;
            display: flex;
            align-items: center;
        }
        
        .form-group label:before {
            content: "•";
            margin-right: 8px;
            color: #004080;
            font-size: 20px;
        }
        
        .form-control {
            width: 100%;
            padding: 15px;
            border: 2px solid #e1e5eb;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background-color: #f8fafc;
        }
        
        .form-control:focus {
            outline: none;
            border-color: #004080;
            box-shadow: 0 0 0 4px rgba(0, 64, 128, 0.1);
        }
        
        select.form-control {
            appearance: none;
            background-image: url('data:image/svg+xml;utf8,<svg fill="%23004080" height="24" viewBox="0 0 24 24" width="24" xmlns="http://www.w3.org/2000/svg"><path d="M7 10l5 5 5-5z"/></svg>');
            background-repeat: no-repeat;
            background-position: right 15px center;
            background-size: 16px;
            padding-right: 45px;
        }
        
        .submit-btn {
            background: linear-gradient(to right, #004080, #0077b6);
            color: white;
            border: none;
            border-radius: 12px;
            padding: 16px 40px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 30px auto 0;
            box-shadow: 0 4px 15px rgba(0, 64, 128, 0.25);
        }
        
        .submit-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 20px rgba(0, 64, 128, 0.35);
            background: linear-gradient(to right, #003366, #0066a6);
        }
        
        @media (max-width: 768px) {
            .reservation-container {
                border-radius: 15px;
            }
            
            .form-content {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="reservation-container">
        <div class="header">
            <h1>Modifier le vol</h1>
            <p>Complétez les informations pour modifier un vol</p>
        </div>
        
       <div class="form-content">
    <% 
        Vol vol = (Vol) request.getAttribute("vol");
        List<Lieu> lieux = (List<Lieu>) request.getAttribute("lieux");
        if (vol == null) {
    %>
            <p style="color: red;">Erreur : Le vol spécifié n'existe pas ou une erreur s'est produite.</p>
            <a href="liste_admin_vol">Retour à la liste des vols</a>
    <% } else { %>
            <form action="vol" method="post">
                <input type="hidden" name="id" value="<%= vol.getId() %>">
                <input type="hidden" name="action" value="update">
                
                <div class="form-group">
                    <label for="id_avion">ID Avion</label>
                    <input type="number" name="id_avion" id="id_avion" class="form-control" 
                           value="<%= vol.getId_avion() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="id_pilote">ID Pilote</label>
                    <input type="number" name="id_pilote" id="id_pilote" class="form-control" 
                           value="<%= vol.getId_pilote() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="lieu_depart">Lieu de départ</label>
                    <select name="lieu_depart" id="lieu_depart" class="form-control" required>
                        <option value="">-- Sélectionnez un lieu --</option>
                        <% if (lieux != null) { 
                            for (Lieu lieu : lieux) { %>
                                <option value="<%= lieu.getId() %>" 
                                        <%= vol.getId_lieu_depart() == lieu.getId() ? "selected" : "" %>>
                                    <%= lieu.getName() %>
                                </option>
                        <% } } %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="lieu_arrivee">Lieu d'arrivée</label>
                    <select name="lieu_arrivee" id="lieu_arrivee" class="form-control" required>
                        <option value="">-- Sélectionnez un lieu --</option>
                        <% if (lieux != null) { 
                            for (Lieu lieu : lieux) { %>
                                <option value="<%= lieu.getId() %>" 
                                        <%= vol.getId_lieu_arriver() == lieu.getId() ? "selected" : "" %>>
                                    <%= lieu.getName() %>
                                </option>
                        <% } } %>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="heure_depart">Heure de départ</label>
                    <input type="time" name="heure_depart" id="heure_depart" class="form-control" 
                           value="<%= vol.getHeure_depart() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="heure_arrivee">Heure d'arrivée</label>
                    <input type="time" name="heure_arrivee" id="heure_arrivee" class="form-control" 
                           value="<%= vol.getHeure_arrivee() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="date_depart">Date de départ</label>
                    <input type="date" name="date_depart" id="date_depart" class="form-control" 
                           value="<%= vol.getDate_depart() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="date_arrivee">Date d'arrivée</label>
                    <input type="date" name="date_arrivee" id="date_arrivee" class="form-control" 
                           value="<%= vol.getDate_arrivee() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="distance_trajet">Distance du trajet (km)</label>
                    <input type="number" name="distance_trajet" id="distance_trajet" class="form-control" 
                           value="<%= vol.getDistance_trajet() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="date_resilience_ticket_business_class">Date résilience ticket Business</label>
                    <input type="date" name="date_resilience_ticket_business_class" id="date_resilience_ticket_business_class" 
                           class="form-control" value="<%= vol.getDate_resilience_ticket_business_class() != null ? vol.getDate_resilience_ticket_business_class() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="date_resilience_ticket_economique_class">Date résilience ticket Économique</label>
                    <input type="date" name="date_resilience_ticket_economique_class" id="date_resilience_ticket_economique_class" 
                           class="form-control" value="<%= vol.getDate_resilience_ticket_economique_class() != null ? vol.getDate_resilience_ticket_economique_class() : "" %>">
                </div>
                
                <div class="form-group">
                    <label for="places_libres_business">Places libres Business</label>
                    <input type="number" name="places_libres_business" id="places_libres_business" class="form-control" 
                           value="<%= vol.getPlaces_libres_business() %>" required>
                </div>
                
                <div class="form-group">
                    <label for="places_libres_economique">Places libres Économique</label>
                    <input type="number" name="places_libres_economique" id="places_libres_economique" class="form-control" 
                           value="<%= vol.getPlaces_libres_economique() %>" required>
                </div>

                <button type="submit" class="submit-btn">Modifier le vol</button>
            </form>
    <% } %>
</div>
    </div>
</body>
</html>