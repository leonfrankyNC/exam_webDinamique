<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Confirmation - Admin MansTravel</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --danger: #ef4444;
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

        /* Conteneur de confirmation */
        .form-container {
            flex-grow: 1;
            padding: 30px 40px;
            background-color: #f8fafc;
        }

        .form-card {
            background: white;
            border-radius: 12px;
            padding: 30px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }

        .form-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 20px;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 10px;
            justify-content: center;
        }

        .form-title i {
            color: var(--success);
        }

        .form-subtitle {
            font-size: 15px;
            color: var(--gray);
            margin-bottom: 30px;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background-color: var(--primary);
            color: white;
            padding: 14px 28px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 15px;
            margin-top: 20px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
            text-decoration: none;
        }

        .back-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
        }

        /* Responsive */
        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
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
            
            .form-container {
                padding: 20px;
            }
            
            .form-card {
                padding: 20px;
            }
        }

        @media (max-width: 576px) {
            .sidebar {
                flex-direction: column;
                padding: 15px;
            }
            
            .nav-links {
                justify-content: center;
                margin-top: 15px;
            }
            
            .form-title {
                font-size: 20px;
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
            <a href="liste_admin_reservation">
                <i class="fas fa-ticket-alt"></i>
                <span>Réservations</span>
            </a>
            <a href="liste_admin_vol">
                <i class="fas fa-plane"></i>
                <span>Gestion vols</span>
            </a>
            <a href="inserer_vol">
                <i class="fas fa-plus-circle"></i>
                <span>Ajouter un vol</span>
            </a>
            <a href="liste_admin_tarif" class="active">
                <i class="fas fa-dollar-sign"></i>
                <span>Gestion des tarifs</span>
            </a>
        </nav>
    </aside>

    <!-- Contenu principal -->
    <main class="main-content">
        <header class="admin-header">
            <h2><i class="fas fa-dollar-sign"></i> Gestion des tarifs</h2>
        </header>
        
        <div class="form-container">
            <div class="form-card">
                <h1 class="form-title"><i class="fas fa-check-circle"></i> Confirmation</h1>
                <p class="form-subtitle"><%= request.getAttribute("message") %></p>
                <a href="vol" class="back-btn">
                    <i class="fas fa-arrow-left"></i> Retour à la gestion des tarifs
                </a>
            </div>
        </div>
    </main>
</body>
</html>