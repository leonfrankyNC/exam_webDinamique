<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MansTravel - Accueil</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --secondary: #7c3aed;
            --accent: #f97316;
            --light: #f8fafc;
            --dark: #1e293b;
            --gray: #64748b;
            --sidebar-width: 280px;
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
            color: var(--accent);
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

        /* Hero Section */
        .hero {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 60px 40px;
            max-width: 800px;
            margin: 0 auto;
            position: relative;
        }

        .hero h1 {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 24px;
            color: var(--dark);
            line-height: 1.2;
        }

        .hero p {
            font-size: 1.1rem;
            line-height: 1.8;
            margin-bottom: 30px;
            color: var(--gray);
            max-width: 700px;
        }

        .cta-button {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            background: var(--primary);
            color: white;
            padding: 14px 32px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            border-radius: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
        }

        .cta-button:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
        }

        .cta-button i {
            font-size: 18px;
        }

        /* Footer */
        .footer {
            text-align: center;
            padding: 30px;
            background: white;
            border-top: 1px solid var(--border);
            margin-top: auto;
        }

        .footer p {
            font-size: 14px;
            color: var(--gray);
            margin-top: 20px;
        }

        .social-links {
            display: flex;
            justify-content: center;
            gap: 16px;
            margin-top: 20px;
        }

        .social-links a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            background: var(--light);
            border-radius: 50%;
            color: var(--gray);
            font-size: 16px;
            transition: all 0.3s ease;
        }

        .social-links a:hover {
            background: var(--primary);
            color: white;
            transform: scale(1.1);
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .hero {
            animation: fadeIn 0.6s ease-out;
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            :root {
                --sidebar-width: 240px;
            }
            
            .hero h1 {
                font-size: 2.4rem;
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
            
            .nav-links {
                flex-direction: row;
                padding: 0 15px;
                flex-wrap: wrap;
                justify-content: flex-end;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .hero {
                padding: 40px 20px;
            }
            
            .hero h1 {
                font-size: 2rem;
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
            
            .hero h1 {
                font-size: 1.8rem;
            }
            
            .cta-button {
                padding: 12px 24px;
                font-size: 0.95rem;
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
            <a href="listevol" class="active">
                <i class="fas fa-list"></i>
                <span>Liste des vols</span>
            </a>
            <a href="admin_index">
                <i class="fas fa-lock"></i>
                <span>Espace Admin</span>
            </a>
        </nav>
    </aside>

    <!-- Contenu principal -->
    <main class="main-content">
        <section class="hero">
            <h1>Voyagez avec confiance, voyagez avec nous</h1>
            <p>Nous sommes ravis de vous accompagner dans la préparation de vos voyages. Que ce soit pour affaires, pour les vacances ou une aventure de dernière minute, notre plateforme vous propose les meilleures options de vols aux meilleurs prix, en toute simplicité et sécurité.</p>
            <p>Préparez vos valises, le monde vous attend !</p>
            <a href="listevol" class="cta-button">
                <i class="fas fa-search"></i>
                <span>Rechercher un vol</span>
            </a>
        </section>
        
        <footer class="footer">
            <div class="social-links">
                <a href="#"><i class="fab fa-facebook-f"></i></a>
                <a href="#"><i class="fab fa-twitter"></i></a>
                <a href="#"><i class="fab fa-instagram"></i></a>
                <a href="#"><i class="fab fa-linkedin-in"></i></a>
            </div>
            <p>&copy; 2023 MansTravel. Tous droits réservés. Votre compagnie aérienne de confiance.</p>
        </footer>
    </main>
</body>
</html>