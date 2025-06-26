-- phpMyAdmin SQL Dump
-- Version : 5.2.1
-- Serveur : 127.0.0.1
-- Base de données : garage

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE DATABASE IF NOT EXISTS `garage`;
USE `garage`;

-- --------------------------------------------------------
-- Table : app_user
-- --------------------------------------------------------

CREATE TABLE `app_user` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `password` VARCHAR(255) DEFAULT NULL,
  `username` VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : roles
-- --------------------------------------------------------

CREATE TABLE `roles` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : permission
-- --------------------------------------------------------

CREATE TABLE `permission` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL UNIQUE,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : app_user_roles
-- --------------------------------------------------------

CREATE TABLE `app_user_roles` (
  `user_id` BIGINT(20) NOT NULL,
  `role_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  FOREIGN KEY (`user_id`) REFERENCES `app_user`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : app_user_permissions
-- --------------------------------------------------------

CREATE TABLE `app_user_permissions` (
  `app_user_id` BIGINT(20) NOT NULL,
  `permissions_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`app_user_id`, `permissions_id`),
  FOREIGN KEY (`app_user_id`) REFERENCES `app_user`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`permissions_id`) REFERENCES `permission`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : roles_permissions
-- --------------------------------------------------------

CREATE TABLE `roles_permissions` (
  `role_id` BIGINT(20) NOT NULL,
  `permission_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`permission_id`) REFERENCES `permission`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : garage
-- --------------------------------------------------------

CREATE TABLE `garage` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `location` VARCHAR(255) DEFAULT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : mechanic
-- --------------------------------------------------------

CREATE TABLE `mechanic` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) DEFAULT NULL,
  `specialty` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : garage_mechanic
-- --------------------------------------------------------

CREATE TABLE `garage_mechanic` (
  `garage_id` BIGINT(20) NOT NULL,
  `mechanic_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`garage_id`, `mechanic_id`),
  FOREIGN KEY (`garage_id`) REFERENCES `garage`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`mechanic_id`) REFERENCES `mechanic`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : car
-- --------------------------------------------------------

CREATE TABLE `car` (
  `immatriculation` VARCHAR(255) NOT NULL,
  `etat` VARCHAR(50) DEFAULT NULL,
  `marque` VARCHAR(50) DEFAULT NULL,
  `modele` VARCHAR(50) DEFAULT NULL,
  `garage_id` BIGINT(20) DEFAULT NULL,
  `estimated_completion_date` DATETIME(6) DEFAULT NULL,
  `statut` VARCHAR(255) DEFAULT NULL,
  `user_id` BIGINT(20) DEFAULT NULL,
  `status` ENUM('DELAI_PROLONGE','EN_ATTENTE','EN_COURS','TERMINE') DEFAULT NULL,
  PRIMARY KEY (`immatriculation`),
  FOREIGN KEY (`garage_id`) REFERENCES `garage`(`id`) ON DELETE SET NULL,
  FOREIGN KEY (`user_id`) REFERENCES `app_user`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : owner
-- --------------------------------------------------------

CREATE TABLE `owner` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) DEFAULT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  `car_id` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`car_id`) REFERENCES `car`(`immatriculation`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : users (legacy)
-- --------------------------------------------------------

CREATE TABLE `users` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `enabled` BIT(1) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `username` VARCHAR(255) NOT NULL,
  `role` VARCHAR(255) DEFAULT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------
-- Table : user_roles (legacy)
-- --------------------------------------------------------

CREATE TABLE `user_roles` (
  `user_id` BIGINT(20) NOT NULL,
  `role_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
  FOREIGN KEY (`role_id`) REFERENCES `roles`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ==========================
-- Données initiales
-- ==========================

-- Roles
INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'ADMIN'),
(2, 'MANAGER'),
(3, 'USER');

-- Permissions
INSERT INTO `permission` (`id`, `name`) VALUES
(2, 'CAN_VIEW_CARS'),
(3, 'CAN_CREATE_CARS'),
(4, 'CAN_UPDATE_CARS'),
(5, 'CAN_DELETE_CARS');

-- App Users
INSERT INTO `app_user` (`id`, `email`, `password`, `username`) VALUES
(18, 'johndoe@example1.com', '$2a$10$E0ZkWUkyigLAirGtiSgUkuOVR6NWyMEO22zOfuHkoB2On0QgtfLhK', 'johndoe1'),
(19, 'user1@u.fr', '$2a$10$2V83b4X34HkZ8Yl0P538pe2f/.XgC2SBKcSoLpNaXFkbUbMop55yy', 'user1'),
(20, 'boubacar@vde.fr', '$2a$10$927W.crgiMZxuyWZhePCYONtOgfgLrVwur.cciccVGFReWVqPNGTu', 'Boubacar1'),
(23, 'admin@gmail.com', '$2a$10$t8d60q4ywKlIGqZgyhLOwuY3mlwLh7t7oiyG9t5li3PVa2xE0wCx6', 'admin'),
(24, 'admin1@vde.com', '$2a$10$VBW30UvmDNG7iMkepCs7hOZR2fHv5WtUHVx3LS25SiQqOnAXXmDlu', 'admin1'),
(36, 'manager1@vde.fr', '$2a$10$E9axSl9W3kq8oyrlkFRCeuxC.z008405t9pW2WATyTnTrPDMDBaOy', 'manager1'),
(37, 'test@vde.fr', '$2a$10$r.3G8kSLhiv1RluiJhpuK.YjwTfSpNvxT5oN1t6QV3NwPKLKHfyoW', 'test'),
(38, 'test2@vde.fr', '$2a$10$RRLGtqdK8AyvUFn8/PZCJe2jmSdU5q3k6JNw5iL76Ly8hhgULJftO', 'test2');

-- App User Roles
INSERT INTO `app_user_roles` (`user_id`, `role_id`) VALUES
(18, 1),
(19, 3),
(20, 1),
(23, 3),
(24, 1),
(36, 2),
(37, 1),
(38, 1);

-- Garage
INSERT INTO `garage` (`id`, `location`, `name`) VALUES
(1, 'Paris', 'Garage1'),
(2, 'Paris', 'Garage2');

-- Mechanic
INSERT INTO `mechanic` (`id`, `name`, `specialty`) VALUES
(1, 'Zoel', 'Electrique');

-- Garage Mechanic
INSERT INTO `garage_mechanic` (`garage_id`, `mechanic_id`) VALUES
(1, 1);

-- Car
INSERT INTO `car` (`etat`, `marque`, `modele`, `immatriculation`, `garage_id`, `estimated_completion_date`, `statut`, `user_id`, `status`) VALUES
('NeuveM', 'Wols55', 'W2055', 'AZ-568-K0', 1, NULL, 'TERMINE', NULL, NULL),
('Neuve', 'Wols2', 'W2025', 'AZ-568-KL', 1, NULL, 'TERMINE', NULL, NULL),
('Bon', 'Morgan', 'MPRX', 'BM-568-RE', 2, NULL, 'EN_COURS', NULL, NULL),
('Neuve', 'Toyota', 'Yaris40', 'CZ-568-U9', 2, NULL, 'TERMINE', NULL, NULL),
('Neuve', 'WolsBSD', 'W2025BSD', 'DZ-568-K0', 1, NULL, 'EN_COURS', NULL, NULL);

-- Owner
INSERT INTO `owner` (`id`, `email`, `name`, `car_id`) VALUES
(1, 'paul@gmail.com', 'Paul', NULL),
(4, 'henry@gmail.com', 'Henry', 'DZ-568-K0');

COMMIT;
