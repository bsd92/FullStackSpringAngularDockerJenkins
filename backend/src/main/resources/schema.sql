-- Table des utilisateurs
CREATE TABLE IF NOT EXISTS app_user (
    id BIGINT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);

-- Table des voitures
CREATE TABLE IF NOT EXISTS car (
    id BIGINT PRIMARY KEY,
    marque VARCHAR(255) NOT NULL,
    modele VARCHAR(255) NOT NULL,
    statut VARCHAR(50),
    conducteur_id BIGINT,
    FOREIGN KEY (conducteur_id) REFERENCES app_user(id) ON DELETE SET NULL
);
