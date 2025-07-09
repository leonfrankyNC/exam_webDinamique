CREATE DATABASE ticket_avion;
USE ticket_avion;

CREATE TABLE avion (
    id INT PRIMARY KEY AUTO_INCREMENT,
    compagnie VARCHAR(255),
    reference VARCHAR(255)
);



CREATE TABLE pilote (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom CHAR(255),
    date_naissance DATE
);

CREATE TABLE client (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom CHAR(255),
    prenom CHAR(255),
    email CHAR(255)
);

CREATE TABLE lieu (
    id INT PRIMARY KEY AUTO_INCREMENT ,
    nom CHAR(255)
);

CREATE TABLE vol (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_avion INT,
    id_pilote INT, 
    id_lieu_depart INT ,
    id_lieu_arriver INT ,
    heure_depart TIME,
    heure_arrivee TIME,
    date_depart DATE,
    date_arrivee DATE,
    distance_trajet INT,
    nombre_place_business_class INT,
    nombre_place_economique_class INT,
    business_class_pris INT ,
    economique_class_pris INT ,
    places_libres_business INT NOT NULL DEFAULT 0 ,
    places_libres_economique INT NOT NULL DEFAULT 0 ,
    FOREIGN KEY (id_avion) REFERENCES avion(id),
    FOREIGN KEY (id_pilote) REFERENCES pilote(id),
    FOREIGN KEY (id_lieu_depart) REFERENCES lieu(id),
    FOREIGN KEY (id_lieu_arriver) REFERENCES lieu(id) 
);

-- Structure de table ajustée avec le champ 'type' pour adulte/enfant
CREATE TABLE tarif_classe (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_vol INT,
    type ENUM('adulte', 'enfant'), -- type de passager
    classe ENUM('business', 'economique'), -- type de classe
    tranche_debut INT,              -- ex : 1
    tranche_fin INT,                -- ex : 10
    tarif INT,                      -- ex : 600
    FOREIGN KEY (id_vol) REFERENCES vol(id)
);

CREATE TABLE reservation (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_vol INT,
    id_client INT ,
    nombre_personne INT NOT NULL DEFAULT 0 ,
    prix INT ,
    status VARCHAR(255),
    date_reservation DATE ,
    date_fin_payement DATE,  
    FOREIGN KEY(id_vol) REFERENCES vol(id),
    FOREIGN KEY(id_client) REFERENCES client(id)
);

ALTER TABLE reservation ADD COLUMN classe VARCHAR(255);

CREATE TABLE billet (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_client INT ,
    id_vol INT,
    classe ENUM('business', 'economique'),
    date_reservation DATE,
    FOREIGN KEY (id_client) REFERENCES client(id),
    FOREIGN KEY (id_vol) REFERENCES vol(id)
);
  ALTER TABLE billet ADD COLUMN reference VARCHAR(20) UNIQUE;

 ALTER TABLE billet MODIFY COLUMN id_client INT AUTO_INCREMENT;

CREATE TABLE Liste_destination_populaire (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nom CHAR(255),
    image_endroit VARCHAR(255)
);

CREATE TABLE passager (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_billet INT,
    nom VARCHAR(255),
    prenom VARCHAR(255),
    numero_passeport VARCHAR(50),
    FOREIGN KEY (id_billet) REFERENCES billet(id)
);

CREATE TABLE admin (
    id INT PRIMARY KEY AUTO_INCREMENT ,
    nom VARCHAR(255) ,
    mdp VARCHAR(255)
);

INSERT INTO admin (nom,mdp) VALUES
("Mano","mans123");

INSERT INTO avion (compagnie, reference) VALUES
('Air France', 'A320-214'),
('Air France', 'B787-9'),
('Emirates', 'A380-861'),
('Emirates', 'B777-300ER'),
('Lufthansa', 'A350-941'),
('Lufthansa', 'A319-132'),
('Delta Air Lines', 'B737-900ER'),
('Delta Air Lines', 'A330-323'),
('British Airways', 'B747-436'),
('British Airways', 'A321-231'),
('Qatar Airways', 'B777-200LR'),
('Qatar Airways', 'A350-1000'),
('Singapore Airlines', 'B787-10'),
('Singapore Airlines', 'A380-841'),
('American Airlines', 'B737 MAX 8'),
('American Airlines', 'B777-200ER'),
('Air Canada', 'A220-300'),
('Air Canada', 'B767-300ER'),
('Cathay Pacific', 'A330-343'),
('Cathay Pacific', 'B777-367');


INSERT INTO Liste_destination_populaire (nom, image_endroit)
VALUES 
('Paris', 'images/paris.jpg'),
('New York', 'images/image1.jpg'),
('Tokyo', 'images/image2.jpg'),
('Rome', 'images/image3.jpg'),
('Londres', 'images/image4.jpg'),
('Marrakech', 'images/image5.jpg'),
('Sydney', 'images/image6.jpg');



INSERT INTO pilote (nom, date_naissance)
VALUES
('Jean Dupont', '1978-03-15'),
('Alice Moreau', '1982-07-22'),
('Karim El Amrani', '1975-11-02');

INSERT INTO client (nom, prenom, email)
VALUES
('Martin', 'Lucie', 'lucie.martin@example.com'),
('Durand', 'Paul', 'paul.durand@example.com'),
('Nguyen', 'Thierry', 'thierry.nguyen@example.com'),
('Smith', 'Anna', 'anna.smith@example.com');


INSERT INTO lieu (nom) VALUES
('France - Aéroport Charles de Gaulle (CDG)'),
('France - Aéroport de Paris-Orly (ORY)'),
('France - Aéroport de Lyon-Saint-Exupéry (LYS)'),
('Italie - Aéroport de Rome-Fiumicino (FCO)'),
('États-Unis - Aéroport international John F. Kennedy (JFK)');

INSERT INTO tarif_classe (id_vol, type, classe, tranche_debut, tranche_fin, tarif) VALUES
-- Vol 1 - Tarifs adultes
(1, 'adulte', 'business', 1, 10, 1000),
(1, 'adulte', 'economique', 1, 10, 500),
(1, 'adulte', 'business', 11, 20, 1100),
(1, 'adulte', 'economique', 11, 20, 600), -- +10% par rapport à la tranche 1-10

-- Vol 1 - Tarifs enfants (exemple: 30% de réduction)
(1, 'enfant', 'business', 1, 10, 700),   -- 1000 * 0.7
(1, 'enfant', 'economique', 1, 10, 350), -- 500 * 0.7

-- Vol 2 - Tarifs adultes
(2, 'adulte', 'business', 1, 10, 1200),
(2, 'adulte', 'economique', 1, 10, 600),

-- Vol 3 - Tarifs adultes
(3, 'adulte', 'business', 1, 10, 1000),
(3, 'adulte', 'economique', 1, 10, 500),
(3, 'adulte', 'business', 11, 20, 1100),

-- Vol 3 - Tarifs enfants
(3, 'enfant', 'business', 1, 10, 700),
(3, 'enfant', 'economique', 1, 10, 350);





INSERT INTO vol (
    id_avion, id_pilote, id_lieu_depart, id_lieu_arriver,
    heure_depart, heure_arrivee, date_depart, date_arrivee,
    distance_trajet, nombre_place_business_class, nombre_place_economique_class,
    business_class_pris, economique_class_pris,
    places_libres_business, places_libres_economique
) VALUES
-- Vol 1: Paris CDG -> New York JFK
(1, 1, 1, 5, '08:00:00', '10:30:00', '2025-07-15', '2025-07-15', 
 5834, 12, 150, 0, 0, 12, 150),

-- Vol 2: Paris ORY -> Rome FCO
(2, 2, 2, 4, '10:15:00', '12:00:00', '2025-07-16', '2025-07-16', 
 1107, 8, 120, 0, 0, 8, 120),

-- Vol 3: Lyon -> Paris CDG
(3, 3, 3, 1, '14:30:00', '15:15:00', '2025-07-17', '2025-07-17', 
 417, 4, 80, 0, 0, 4, 80),

-- Vol 4: Rome FCO -> Paris CDG
(4, 1, 4, 1, '18:45:00', '20:30:00', '2025-07-18', '2025-07-18', 
 1107, 8, 120, 0, 0, 8, 120),

-- Vol 5: New York JFK -> Paris CDG
(5, 2, 5, 1, '22:00:00', '11:30:00', '2025-07-19', '2025-07-20', 
 5834, 16, 200, 0, 0, 16, 200),

-- Vol 6: Paris CDG -> Lyon
(1, 3, 1, 3, '07:30:00', '08:15:00', '2025-07-21', '2025-07-21', 
 417, 12, 150, 0, 0, 12, 150),

-- Vol 7: Paris ORY -> Rome FCO
(2, 1, 2, 4, '13:20:00', '15:05:00', '2025-07-22', '2025-07-22', 
 1107, 8, 120, 0, 0, 8, 120),

-- Vol 8: Lyon -> New York JFK
(3, 2, 3, 5, '16:45:00', '19:15:00', '2025-07-23', '2025-07-23', 
 6251, 4, 80, 0, 0, 4, 80);




SET FOREIGN_KEY_CHECKS = 0;