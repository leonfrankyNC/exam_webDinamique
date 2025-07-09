<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Erreur - Système de réservation</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f8f9fa;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        
        .error-container {
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 30px;
            max-width: 600px;
            width: 100%;
            text-align: center;
        }
        
        .error-icon {
            font-size: 64px;
            color: #dc3545;
            margin-bottom: 20px;
        }
        
        h1 {
            color: #dc3545;
            margin-top: 0;
            margin-bottom: 20px;
        }
        
        .error-message {
            background-color: #fff3f4;
            border-left: 4px solid #dc3545;
            padding: 15px;
            margin: 20px 0;
            text-align: left;
            font-family: monospace;
            white-space: pre-wrap;
            overflow-x: auto;
        }
        
        .actions {
            margin-top: 30px;
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        
        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }
        
        .error-details {
            margin-top: 30px;
            text-align: left;
            font-size: 14px;
            color: #6c757d;
            border-top: 1px solid #e9ecef;
            padding-top: 20px;
        }
        
        .error-stack {
            max-height: 200px;
            overflow-y: auto;
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
            font-family: monospace;
            font-size: 12px;
            white-space: pre-wrap;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">⚠️</div>
        <h1>Une erreur s'est produite</h1>
        
        <% 
        // Récupération des messages d'erreur
        String erreurMessage = (String) request.getAttribute("erreur");
        String errorCode = request.getParameter("code");
        
        // Messages d'erreur prédéfinis
        if (errorCode != null) {
            switch (errorCode) {
                case "404":
                    erreurMessage = "Page non trouvée";
                    break;
                case "500":
                    erreurMessage = "Erreur interne du serveur";
                    break;
            }
        }
        
        if (erreurMessage != null && !erreurMessage.isEmpty()) { 
        %>
            <div class="error-message">
                <%= erreurMessage %>
            </div>
        <% } else if (exception != null) { %>
            <div class="error-message">
                <%= exception.getMessage() %>
            </div>
        <% } else { %>
            <div class="error-message">
                Une erreur inattendue est survenue. Veuillez réessayer plus tard.
            </div>
        <% } %>
        
        <div class="actions">
            <button class="btn btn-primary" onclick="history.back()">Retour</button>
            <button class="btn btn-secondary" onclick="location.href='<%= request.getContextPath() %>/index'">
                Accueil
            </button>
        </div>
        
        <% if (exception != null) { %>
            <div class="error-details">
                <h3>Détails techniques :</h3>
                <div class="error-stack">
                    <% 
                    java.io.PrintWriter pw = new java.io.PrintWriter(out);
                    exception.printStackTrace(pw);
                    %>
                </div>
            </div>
        <% } %>
    </div>
</body>
</html>