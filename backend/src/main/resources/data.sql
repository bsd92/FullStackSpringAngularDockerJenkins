-- src/main/resources/data.sql
INSERT INTO app_user(username, email) VALUES ('johndoe', 'john@example.com');

INSERT INTO car(marque, modele, statut, conducteur_id) VALUES
('Peugeot', '208', 'DISPONIBLE', 1),
('Renault', 'Clio', 'EN_ATTENTE', 1);
