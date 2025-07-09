<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirmation de Réservation - AirTravel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2563eb;
            --primary-light: #3b82f6;
            --secondary: #7c3aed;
            --success: #10b981;
            --light: #f8fafc;
            --dark: #1e293b;
            --gray: #64748b;
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
            justify-content: center;
            align-items: center;
            padding: 20px;
            line-height: 1.5;
        }

        .confirmation-card {
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 16px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            position: relative;
        }

        .confirmation-header {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 40px;
            text-align: center;
            position: relative;
        }

        .confirmation-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(to right, var(--success), #a5f3fc);
        }

        .confirmation-icon {
            width: 80px;
            height: 80px;
            background-color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }

        .confirmation-icon i {
            font-size: 40px;
            color: var(--success);
        }

        .confirmation-title {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .confirmation-subtitle {
            font-size: 16px;
            opacity: 0.9;
        }

        .confirmation-body {
            padding: 40px;
        }

        .reference-number {
            background-color: var(--light);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            margin-bottom: 30px;
            border: 1px dashed var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            font-size: 18px;
            font-weight: 600;
            color: var(--primary);
        }

        .confirmation-message {
            text-align: center;
            margin-bottom: 40px;
            font-size: 16px;
            color: var(--gray);
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
        }

        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .detail-item {
            background-color: var(--light);
            border-radius: 12px;
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .detail-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }

        .detail-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--primary-light), var(--primary));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            color: white;
            font-size: 20px;
        }

        .detail-label {
            font-size: 14px;
            color: var(--gray);
            margin-bottom: 8px;
            font-weight: 500;
        }

        .detail-value {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 14px 30px;
            border-radius: 8px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            transition: all 0.3s ease;
            font-size: 15px;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            box-shadow: 0 4px 15px rgba(37, 99, 235, 0.3);
        }

        .btn-primary:hover {
            background-color: var(--primary-light);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(37, 99, 235, 0.4);
        }

        .btn-outline {
            border: 1px solid var(--border);
            color: var(--dark);
            background-color: white;
        }

        .btn-outline:hover {
            background-color: var(--light);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .confirmation-footer {
            text-align: center;
            padding: 25px;
            border-top: 1px solid var(--border);
            color: var(--gray);
            font-size: 14px;
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .confirmation-card {
            animation: fadeIn 0.5s ease-out;
        }

        .detail-item {
            animation: fadeIn 0.6s ease-out forwards;
            opacity: 0;
        }

        .detail-item:nth-child(1) { animation-delay: 0.2s; }
        .detail-item:nth-child(2) { animation-delay: 0.3s; }
        .detail-item:nth-child(3) { animation-delay: 0.4s; }
        .detail-item:nth-child(4) { animation-delay: 0.5s; }

        /* Responsive */
        @media (max-width: 768px) {
            .confirmation-header {
                padding: 30px 20px;
            }
            
            .confirmation-body {
                padding: 30px 20px;
            }
            
            .details-grid {
                grid-template-columns: 1fr 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
                align-items: center;
            }
            
            .btn {
                width: 100%;
                max-width: 300px;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .details-grid {
                grid-template-columns: 1fr;
            }
            
            .confirmation-title {
                font-size: 24px;
            }
            
            .confirmation-icon {
                width: 60px;
                height: 60px;
            }
            
            .confirmation-icon i {
                font-size: 30px;
            }
        }
    </style>
</head>
<body>
    <div class="confirmation-card">
        <div class="confirmation-header">
            <div class="confirmation-icon">
                <i class="fas fa-check"></i>
            </div>
            <h1 class="confirmation-title">Réservation confirmée !</h1>
            <p class="confirmation-subtitle">Merci d'avoir choisi AirTravel</p>
        </div>
        
        <div class="confirmation-body">
            <div class="reference-number">
                <i class="fas fa-ticket-alt"></i>
                <span>Réservation N°: ${reservationId}</span>
            </div>
            
            <p class="confirmation-message">
                Votre réservation a été confirmée avec succès. Un email de confirmation avec tous les détails 
                de votre vol a été envoyé à votre adresse email. Vous pouvez payer cette réservation avant le 
                ${date_fin_reservation}.
            </p>
            
            <div class="details-grid">
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-calendar-day"></i>
                    </div>
                    <div class="detail-label">Date limite de paiement</div>
                    <div class="detail-value">${date_fin_reservation}</div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-chair"></i>
                    </div>
                    <div class="detail-label">Classe</div>
                    <div class="detail-value">${classe}</div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-calendar-alt"></i>
                    </div>
                    <div class="detail-label">Date réservation</div>
                    <div class="detail-value">${date_reservation}</div>
                </div>
                
                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="detail-label">Passagers</div>
                    <div class="detail-value">${nbPassagers}</div>
                </div>

                <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="detail-label">Statu paiement</div>
                    <div class="detail-value">${status}</div>
                </div>

                    <div class="detail-item">
                    <div class="detail-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="detail-label">Prix</div>
                    <div class="detail-value">${prix}</div>
                </div>

                
            </div>
            
            <div class="action-buttons">
                <a href="listevol" class="btn btn-outline">
                    <i class="fas fa-search"></i> Nouvelle recherche
                </a>
            </div>
        </div>
        
        <div class="confirmation-footer">
            <p>Besoin d'aide ? Contactez notre service client au <strong>01 23 45 67 89</strong></p>
            <p>&copy; 2023 MansTravel. Tous droits réservés.</p>
        </div>
    </div>
</body>
</html>