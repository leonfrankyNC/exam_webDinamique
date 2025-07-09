<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Reservation" %>
<%@ page import="Model.Vol" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
    <title>Modifier la réservation</title>
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
            <h1>Modifier la réservation</h1>
            <p>Complétez les informations pour modifier une réservation</p>
        </div>
        
        <div class="form-content">
            <% 
                Reservation reservation = (Reservation) request.getAttribute("reservation");
                List<Vol> vols = (List<Vol>) request.getAttribute("vols");
                if (reservation == null) {
            %>
                <p style="color: red;">Erreur : La réservation spécifiée n'existe pas ou une erreur s'est produite.</p>
                <a href="liste_admin_reservation">Retour à la liste des réservations</a>
            <% } else { %>
                <form action="liste_admin_reservation" method="post">
                    <input type="hidden" name="id" value="<%= reservation.getId() %>">
                    
                    <div class="form-group">
                        <label for="id_vol">Vol</label>
                        <select name="id_vol" id="id_vol" class="form-control" required>
                            <option value="">-- Sélectionnez un vol --</option>
                            <% if (vols != null) { 
                                for (Vol vol : vols) { %>
                                    <option value="<%= vol.getId() %>" 
                                            <%= reservation.getIdVol() == vol.getId() ? "selected" : "" %>>
                                        Vol #<%= vol.getId() %> (<%= vol.getDate_depart() %>)
                                    </option>
                            <% } } %>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="id_client">ID Client</label>
                        <input type="number" name="id_client" id="id_client" class="form-control" 
                               value="<%= reservation.getIdClient() %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="nombre_personne">Nombre de personnes</label>
                        <input type="number" name="nombre_personne" id="nombre_personne" class="form-control" 
                               value="<%= reservation.getNombrePersonne() %>" required min="1">
                    </div>
                    
                    <div class="form-group">
                        <label for="prix">Prix total</label>
                        <input type="number" name="prix" id="prix" class="form-control" 
                               value="<%= reservation.getPrix() %>" required min="0" step="0.01">
                    </div>
                    
                    <div class="form-group">
                        <label for="status">Statut</label>
                        <select name="status" id="status" class="form-control" required>
                            <option value="confirmée" <%= "confirmée".equals(reservation.getStatus()) ? "selected" : "" %>>Confirmée</option>
                            <option value="en attente" <%= "en attente".equals(reservation.getStatus()) ? "selected" : "" %>>En attente</option>
                            <option value="annulée" <%= "annulée".equals(reservation.getStatus()) ? "selected" : "" %>>Annulée</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="classe">Classe</label>
                        <select name="classe" id="classe" class="form-control" required>
                            <option value="business" <%= "business".equals(reservation.getClasse()) ? "selected" : "" %>>Business</option>
                            <option value="economique" <%= "economique".equals(reservation.getClasse()) ? "selected" : "" %>>Économique</option>
                        </select>
                    </div>
                    
                    <div class="form-group">
                        <label for="date_reservation">Date de réservation</label>
                        <input type="date" name="date_reservation" id="date_reservation" class="form-control" 
                               value="<%= reservation.getDate_reservation() != null ? reservation.getDate_reservation() : "" %>" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="date_fin_payement">Date limite de paiement</label>
                        <input type="date" name="date_fin_payement" id="date_fin_payement" class="form-control" 
                               value="<%= reservation.getDateFinPayement() != null ? reservation.getDateFinPayement() : "" %>">
                    </div>

                    <button type="submit" class="submit-btn">Modifier la réservation</button>
                </form>
            <% } %>
        </div>
    </div>
</body>
</html>