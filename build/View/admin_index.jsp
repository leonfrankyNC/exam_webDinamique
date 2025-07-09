<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>AirTravel - Connexion Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --danger: #ef4444;
            --danger-dark: #dc2626;
            --success: #10b981;
            --warning: #f59e0b;
            --light: #f8fafc;
            --dark: #1e293b;
            --gray: #64748b;
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
        }

        .login-container {
            width: 100%;
            max-width: 500px;
            padding: 40px;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .logo {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            margin-bottom: 30px;
        }

        .logo i {
            font-size: 32px;
            color: var(--primary);
        }

        .logo h1 {
            font-size: 24px;
            font-weight: 700;
            color: var(--dark);
        }

        .login-title {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-title h2 {
            font-size: 22px;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .login-title p {
            color: var(--gray);
            font-size: 15px;
        }

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

        .input-field {
            position: relative;
        }

        .input-field input {
            width: 100%;
            padding: 14px 16px 14px 44px;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            font-size: 15px;
            transition: all 0.3s ease;
        }

        .input-field input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
            outline: none;
        }

        .input-field i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
            font-size: 18px;
        }

        .login-btn {
            width: 100%;
            padding: 14px;
            background-color: var(--primary);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .login-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            color: var(--gray);
            font-size: 14px;
        }

        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container {
            animation: fadeIn 0.6s ease-out;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .login-container {
                padding: 30px;
                margin: 20px;
            }
        }

        @media (max-width: 576px) {
            .login-container {
                padding: 25px 20px;
            }
            
            .logo h1 {
                font-size: 20px;
            }
            
            .login-title h2 {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo">
            <i class="fas fa-plane-departure"></i>
            <h1>AirTravel</h1>
        </div>
        
        <div class="login-title">
            <h2>Connexion Administrateur</h2>
            <p>Veuillez entrer vos identifiants pour accéder au tableau de bord</p>
        </div>
        
        <form action="admin_login" method="POST">
            <div class="form-group">
                <label for="nom">Nom d'utilisateur</label>
                <div class="input-field">
                    <i class="fas fa-user"></i>
                    <input type="text" id="nom" name="nom" placeholder="Entrez votre nom d'utilisateur" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="mdp">Mot de passe</label>
                <div class="input-field">
                    <i class="fas fa-lock"></i>
                    <input type="password" id="mdp" name="mdp" placeholder="Entrez votre mot de passe" required>
                </div>
            </div>
            
            <button type="submit" class="login-btn">
                <i class="fas fa-sign-in-alt"></i>
                <span>Se connecter</span>
            </button>
        </form>
        
        <div class="footer">
            <p>&copy; 2025 MansTravel. Tous droits réservés.</p>
        </div>
    </div>
</body>
</html>