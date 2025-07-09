<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="Model.Vol" %>
<%@ page import="Model.Dest_populaire" %>
<%@ page import="Model.Lieu" %>
<%@ page import="java.time.LocalTime" %>

<!DOCTYPE html>
<html>
<head>
    <title>Réservation de vol</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        /* Reset et base */
        :root {
            --primary: #3a86ff;
            --primary-dark: #2667cc;
            --secondary: #8338ec;
            --light: #f8f9fa;
            --dark: #212529;
            --gray: #6c757d;
            --border: #dee2e6;
            --success: #28a745;
            --error: #dc3545;
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
        }
        
        body {
            background-color: #f5f7ff;
            color: var(--dark);
            line-height: 1.6;
            padding: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        /* Layout principal */
        .reservation-container {
            width: 100%;
            max-width: 1000px;
            margin: 40px auto;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            position: relative;
        }
        
        /* En-tête */
        .header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 30px 40px;
            position: relative;
            overflow: hidden;
        }
        
        .header::before {
            content: "";
            position: absolute;
            top: -50px;
            right: -50px;
            width: 200px;
            height: 200px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
        }
        
        .header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
            position: relative;
        }
        
        .header p {
            font-size: 16px;
            opacity: 0.9;
            font-weight: 400;
        }
        
        /* Contenu du formulaire */
        .form-content {
            padding: 40px;
        }
        
        /* Informations du vol */
        .flight-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            background: var(--light);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 30px;
            border: 1px solid var(--border);
        }
        
        .flight-info div {
            text-align: center;
        }
        
        .flight-info .title {
            font-size: 13px;
            color: var(--gray);
            margin-bottom: 8px;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .flight-info .value {
            font-size: 16px;
            font-weight: 600;
            color: var(--dark);
        }
        
        /* Groupes de formulaire */
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark);
            font-size: 14px;
        }
        
        .form-control {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.2s ease;
            background-color: white;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(58, 134, 255, 0.1);
        }
        
        select.form-control {
            appearance: none;
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='16' height='16' fill='%236c757d' viewBox='0 0 16 16'%3E%3Cpath d='M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 12px center;
            background-size: 16px;
            padding-right: 36px;
        }
        
        /* Section passagers */
        .passengers-section {
            background-color: rgba(58, 134, 255, 0.05);
            border-radius: 12px;
            padding: 25px;
            margin-top: 40px;
            border: 1px dashed rgba(58, 134, 255, 0.3);
        }
        
        .passengers-section h2 {
            color: var(--primary);
            margin-bottom: 20px;
            font-size: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .passengers-section h2::before {
            content: "👥";
            font-size: 18px;
        }
        
        .passenger-card {
            background: white;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.03);
            border: 1px solid var(--border);
            transition: transform 0.2s ease;
        }
        
        .passenger-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }
        
        .passenger-card h3 {
            color: var(--primary-dark);
            margin-bottom: 15px;
            font-size: 16px;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .passenger-card h3::before {
            content: "✈";
            font-size: 14px;
        }
        
        /* Bouton de soumission */
        .submit-btn {
            background: linear-gradient(to right, var(--primary), var(--secondary));
            color: white;
            border: none;
            border-radius: 8px;
            padding: 14px 30px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: block;
            width: 100%;
            max-width: 300px;
            margin: 40px auto 0;
            box-shadow: 0 4px 15px rgba(58, 134, 255, 0.3);
            position: relative;
            overflow: hidden;
        }
        
        .submit-btn::after {
            content: "";
            position: absolute;
            top: -50%;
            left: -60%;
            width: 50px;
            height: 200%;
            background: rgba(255, 255, 255, 0.2);
            transform: rotate(30deg);
            transition: all 0.3s;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(58, 134, 255, 0.4);
        }
        
        .submit-btn:hover::after {
            left: 120%;
        }
        
        /* Icônes */
        .icon {
            margin-right: 8px;
            font-size: 14px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .reservation-container {
                margin: 20px;
                border-radius: 12px;
            }
            
            .header {
                padding: 25px;
            }
            
            .form-content {
                padding: 25px;
            }
            
            .flight-info {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .passengers-section {
                padding: 20px;
            }
        }
        
        @media (max-width: 480px) {
            .flight-info {
                grid-template-columns: 1fr;
                gap: 15px;
            }
            
            .submit-btn {
                max-width: 100%;
            }
        }
        
        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .passenger-card {
            animation: fadeIn 0.3s ease forwards;
        }
        
        .passenger-card:nth-child(1) { animation-delay: 0.1s; }
        .passenger-card:nth-child(2) { animation-delay: 0.2s; }
        .passenger-card:nth-child(3) { animation-delay: 0.3s; }
        .passenger-card:nth-child(4) { animation-delay: 0.4s; }
        .passenger-card:nth-child(5) { animation-delay: 0.5s; }

          .payment-section {
        margin: 20px 0;
        padding: 15px;
        border: 1px solid #ddd;
        border-radius: 5px;
    }
    .checkbox-container {
        display: flex;
        align-items: center;
    }
    .checkbox-container input[type="checkbox"] {
        margin-right: 10px;
    }
    </style>
</head>
<body>
    <div class="reservation-container">
        <div class="header">
            <h1><i class="fas fa-ticket-alt icon"></i>Réservation de vol</h1>
            <p>Complétez les informations pour finaliser votre réservation</p>
        </div>
        
        <div class="form-content">
            <div class="flight-info">
                <div>
                    <div class="title">Vol ID</div>
                    <div class="value">${param.id_vol}</div>
                </div>
                <div>
                    <div class="title">Départ</div>
                    <div class="value">
                        <% 
                            Vol vol = (Vol) request.getAttribute("vol");
                            List<Lieu> lieux = (List<Lieu>) request.getAttribute("lieux");
                            if (lieux != null && vol != null) {
                                for (Lieu lieu : lieux) {
                                    if (lieu.getId() == vol.getId_lieu_depart()) {
                                        out.print(lieu.getName());
                                        break;
                                    }
                                }
                            }
                        %>
                    </div>
                </div>
                <div>
                    <div class="title">Arrivée</div>
                    <div class="value">
                        <%
                            if (lieux != null && vol != null) {
                                for (Lieu lieu : lieux) {
                                    if (lieu.getId() == vol.getId_lieu_arriver()) {
                                        out.print(lieu.getName());
                                        break;
                                    }
                                }
                            }
                        %>
                    </div>
                </div>
                <div>
                    <div class="title">Date</div>
                    <div class="value">${vol.date_depart}</div>
                </div>
                <div>
                    <div class="title">Heure</div>
                    <div class="value">${vol.heure_depart}</div>
                </div>

                <div>
                    <div class="title">Prix economique </div>
                    <div class="value">${tarifEconomique}</div>
                </div>

                     <div>
                    <div class="title">Prix business </div>
                    <div class="value">${tarifBusiness}</div>
                </div>
            </div>
            
            <form action="reservation" method="post">
                <input type="hidden" name="id_vol" value="${param.id_vol}">
                <input type="hidden" name="nb_passagers" value="${param.nb_passagers}">
                
                <div class="form-group">
                    <label for="classe"><i class="fas fa-chair icon"></i>Classe</label>
                    <select name="classe" id="classe" class="form-control" required>
                        <option value="">-- Sélectionnez une classe --</option>
                        <option value="economique">Économique (${vol.places_libres_economique} places)</option>
                        <option value="business">Business (${vol.places_libres_business} places)</option>
                    </select>
                </div>

                <div class="passengers-section">
                    <h2>Informations des passagers</h2>
                    <div id="passagers_form">
                        <%
                            int nbPassagers = 1;
                            if (request.getParameter("nb_passagers") != null) {
                                try {
                                    nbPassagers = Integer.parseInt(request.getParameter("nb_passagers"));
                                    nbPassagers = Math.max(1, Math.min(10, nbPassagers));
                                } catch (NumberFormatException e) {
                                    nbPassagers = 1;
                                }
                            }
                            
                            for (int i = 1; i <= nbPassagers; i++) {
                        %>
                        <div class="passenger-card">
                            <h3>Passager <%= i %></h3>
                            <div class="form-group">
                                <input type="text" name="nom_<%= i %>" class="form-control" placeholder="Nom" required>
                            </div>
                            <div class="form-group">
                                <input type="text" name="prenom_<%= i %>" class="form-control" placeholder="Prénom" required>
                            </div>
                            <div class="form-group">
                                <input type="text" name="passeport_<%= i %>" class="form-control" placeholder="Numéro de passeport" required>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                    <div class="payment-section">
    <h2>Paiement</h2>
    <div class="form-group">
        <div class="checkbox-container">
            <input type="checkbox" name="paiement_effectue" id="paiement_effectue" value="true">
            <label for="paiement_effectue">Paiement effectué</label>
        </div>
    </div>
</div>
                </div>

                <button type="submit" class="submit-btn">
                    <i class="fas fa-check-circle icon"></i>Confirmer la réservation
                </button>
            </form>
        </div>
    </div>
</body>
</html>