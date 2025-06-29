-- Suppression des tables existantes pour éviter les conflits
DROP TABLE IF EXISTS roles_permissions;
DROP TABLE IF EXISTS app_user_roles;
DROP TABLE IF EXISTS app_user_permissions;
DROP TABLE IF EXISTS permission;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS owner;
DROP TABLE IF EXISTS garage_mechanic;
DROP TABLE IF EXISTS mechanic;
DROP TABLE IF EXISTS garage;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS app_user;

-- Table des utilisateurs
CREATE TABLE app_user (
  id BIGINT NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

-- Table des rôles
CREATE TABLE roles (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

-- Table des permissions
CREATE TABLE permission (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  PRIMARY KEY (id)
);

-- Liaison utilisateur-rôles (Many-to-Many)
CREATE TABLE app_user_roles (
  app_user_id BIGINT NOT NULL,
  role_id BIGINT NOT NULL,
  PRIMARY KEY (app_user_id, role_id),
  FOREIGN KEY (app_user_id) REFERENCES app_user(id) ON DELETE CASCADE,
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- Liaison utilisateur-permissions (Many-to-Many)
CREATE TABLE app_user_permissions (
  app_user_id BIGINT NOT NULL,
  permission_id BIGINT NOT NULL,
  PRIMARY KEY (app_user_id, permission_id),
  FOREIGN KEY (app_user_id) REFERENCES app_user(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permission(id) ON DELETE CASCADE
);

-- Liaison rôles-permissions (Many-to-Many)
CREATE TABLE roles_permissions (
  role_id BIGINT NOT NULL,
  permission_id BIGINT NOT NULL,
  PRIMARY KEY (role_id, permission_id),
  FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE,
  FOREIGN KEY (permission_id) REFERENCES permission(id) ON DELETE CASCADE
);

-- Table des voitures
CREATE TABLE car (
  immatriculation VARCHAR(20) NOT NULL,
  marque VARCHAR(50) NOT NULL,
  modele VARCHAR(50) NOT NULL,
  etat VARCHAR(50) NOT NULL,
  status ENUM('EN_ATTENTE', 'EN_COURS', 'TERMINE') NOT NULL,
  estimated_completion_date DATE,
  PRIMARY KEY (immatriculation)
);

-- Table des garages
CREATE TABLE garage (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  location VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);

-- Table des mécaniciens
CREATE TABLE mechanic (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  specialty VARCHAR(100),
  PRIMARY KEY (id)
);

-- Liaison garage-mécanicien (Many-to-Many)
CREATE TABLE garage_mechanic (
  garage_id BIGINT NOT NULL,
  mechanic_id BIGINT NOT NULL,
  PRIMARY KEY (garage_id, mechanic_id),
  FOREIGN KEY (garage_id) REFERENCES garage(id) ON DELETE CASCADE,
  FOREIGN KEY (mechanic_id) REFERENCES mechanic(id) ON DELETE CASCADE
);

-- Table des propriétaires
CREATE TABLE owner (
  id BIGINT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL,
  car_id VARCHAR(20),
  PRIMARY KEY (id),
  FOREIGN KEY (car_id) REFERENCES car(immatriculation) ON DELETE SET NULL
);

-- =====================
-- ==== INSERTIONS ====
-- =====================

-- Rôles
INSERT INTO roles (name) VALUES ('ADMIN'), ('MANAGER'), ('USER');

-- Permissions
INSERT INTO permission (name) VALUES
('CAN_VIEW_CARS'),
('CAN_CREATE_CARS'),
('CAN_UPDATE_CARS'),
('CAN_DELETE_CARS');

-- Association rôles  permissions
INSERT INTO roles_permissions (role_id, permission_id) VALUES
(1, 1), (1, 2), (1, 3), (1, 4), -- ADMIN : tout
(2, 1), (2, 2), (2, 3),         -- MANAGER : view, create, update
(3, 1);                         -- USER : seulement view

-- Utilisateurs
INSERT INTO app_user (username, email, password) VALUES
('admin', 'admin@example.com', 'adminpassword'),
('manager', 'manager@example.com', 'managerpassword'),
('user', 'user@example.com', 'userpassword');

-- Association utilisateurs  rôles
INSERT INTO app_user_roles (app_user_id, role_id) VALUES
(1, 1), -- admin ->ADMIN
(2, 2), -- manager -> MANAGER
(3, 3); -- user ->USER

-- Voitures
INSERT INTO car (immatriculation, marque, modele, etat, status, estimated_completion_date) VALUES
('AB-123-CD', 'Toyota', 'Corolla', 'Bon', 'EN_ATTENTE', '2025-07-10'),
('EF-456-GH', 'Peugeot', '208', 'Moyen', 'EN_COURS', '2025-07-15'),
('IJ-789-KL', 'Renault', 'Clio', 'Neuf', 'TERMINE', '2025-07-05');

-- Garages
INSERT INTO garage (name, location) VALUES
('Garage Central', 'Paris'),
('Garage Sud', 'Lyon');

-- Mécaniciens
INSERT INTO mechanic (name, specialty) VALUES
('Jean Dupont', 'Moteur'),
('Marie Curie', 'Électronique');

-- Association garage  mécaniciens
INSERT INTO garage_mechanic (garage_id, mechanic_id) VALUES
(1, 1),
(1, 2),
(2, 2);

-- Propriétaires
INSERT INTO owner (name, email, car_id) VALUES
('Alice Martin', 'alice@example.com', 'AB-123-CD'),
('Bob Durand', 'bob@example.com', 'EF-456-GH');
