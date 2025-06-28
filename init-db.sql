-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 04 juin 2025 à 08:51
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `garage`
--

-- --------------------------------------------------------

--
-- Structure de la table `app-user`
--

CREATE TABLE `app_user` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `app-user`
--

INSERT INTO `app_user` (`id`, `email`, `password`, `username`) VALUES
(23, 'admin@gmail.com', '$2a$10$t8d60q4ywKlIGqZgyhLOwuY3mlwLh7t7oiyG9t5li3PVa2xE0wCx6', 'admin'),
(24, 'admin1@vde.com', '$2a$10$VBW30UvmDNG7iMkepCs7hOZR2fHv5WtUHVx3LS25SiQqOnAXXmDlu', 'admin1'),
(38, 'test2@vde.fr', '$2a$10$RRLGtqdK8AyvUFn8/PZCJe2jmSdU5q3k6JNw5iL76Ly8hhgULJftO', 'test2');

-- --------------------------------------------------------

--
-- Structure de la table `app_user_permissions`
--

CREATE TABLE `app_user_permissions` (
  `app_user_id` bigint(20) NOT NULL,
  `permissions_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `app_user_roles`
--

CREATE TABLE `app_user_roles` (
  `app_user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL,
  PRIMARY KEY (`app_user_id`, `role_id`),
  CONSTRAINT `fk_app_user_roles_user` FOREIGN KEY (`app_user_id`) REFERENCES `app_user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_app_user_roles_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


--
-- Déchargement des données de la table `app_user_roles`
--

INSERT INTO `app_user_roles` (`app_user_id`, `role_id`) VALUES
(23, 3),
(24, 1),
(38, 1);

-- --------------------------------------------------------

--

-- --------------------------------------------------------

--
-- Structure de la table `car`
--

CREATE TABLE `car` (
  `etat` varchar(50) DEFAULT NULL,
  `marque` varchar(50) DEFAULT NULL,
  `modele` varchar(50) DEFAULT NULL,
  `immatriculation` varchar(255)  PRIMARY KEY,
  `estimated_completion_date` datetime(6) DEFAULT NULL,
  `status` enum('DELAI_PROLONGE','EN_ATTENTE','EN_COURS','TERMINE') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `car`
--

INSERT INTO `car` (`etat`, `marque`, `modele`, `immatriculation`,  `status`, `estimated_completion_date`) VALUES
('NeuveM', 'Wols55', 'W2055', 'AZ-568-K0', 'TERMINE', NULL),
('Occasion', 'Toyota', 'T5654', 'DZ-568-KC', 'TERMINE', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `garage`
--

CREATE TABLE `garage` (
  `id` bigint(20) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `garage`
--

INSERT INTO `garage` (`id`, `location`, `name`) VALUES
(1, 'Paris', 'Garage1'),
(2, 'Paris', 'Garage2');

-- --------------------------------------------------------

--
-- Structure de la table `garage_mechanic`
--

CREATE TABLE `garage_mechanic` (
  `garage_id` bigint(20) NOT NULL,
  `mechanic_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `mechanic`
--

CREATE TABLE `mechanic` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `specialty` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `mechanic`
--

INSERT INTO `mechanic` (`id`, `name`, `specialty`) VALUES
(1, 'zoel', 'Electrique');

-- --------------------------------------------------------

--
-- Structure de la table `owner`
--

CREATE TABLE `owner` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `car_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `owner`
--

INSERT INTO `owner` (`id`, `email`, `name`, `car_id`) VALUES
(1, 'paul@gmail.com', 'Paul', NULL),
(4, 'henry@gmail.com', 'Henry', 'DZ-568-K0');

-- --------------------------------------------------------

--
-- Structure de la table `permission`
--

CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `permission`
--

INSERT INTO `permission` (`id`, `name`) VALUES
(3, 'CAN_CREATE_CARS'),
(5, 'CAN_DELETE_CARS'),
(4, 'CAN_UPDATE_CARS'),
(2, 'CAN_VIEW_CARS');

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id`, `name`) VALUES
(1, 'ADMIN'),
(2, 'MANAGER'),
(3, 'USER');

-- --------------------------------------------------------

--
-- Structure de la table `roles_permissions`
--

CREATE TABLE `roles_permissions` (
  `role_id` bigint(20) NOT NULL,
  `permission_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`, `permission_id`),
  CONSTRAINT `fk_roles_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_roles_permissions_permission` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- --------------------------------------------------------

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `app_user`
--
ALTER TABLE `app_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK5iyma8vmo1ki719nliq5egjmq` (`email`),
  ADD UNIQUE KEY `UK577xavekri3thaxr916r5c79b` (`username`);

--
-- Index pour la table `app_user_permissions`
--
ALTER TABLE `app_user_permissions`
  ADD PRIMARY KEY (`app_user_id`,`permissions_id`),
  ADD KEY `FKdw6t3bkjufxv45apygmtop8bh` (`permissions_id`);



--
-- Index pour la table `garage`
--
ALTER TABLE `garage`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `garage_mechanic`
--
ALTER TABLE `garage_mechanic`
  ADD KEY `FK1kk5xui5l1nc5f97gh11y6c19` (`mechanic_id`),
  ADD KEY `FK4aqnr9vooupanstqat62h82rs` (`garage_id`);

--
-- Index pour la table `mechanic`
--
ALTER TABLE `mechanic`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `owner`
--
ALTER TABLE `owner`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK2ouk5f9g7d6i5oqtcthel24yh` (`car_id`);

--
-- Index pour la table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK2ojme20jpga3r4r79tdso17gi` (`name`);

--
-- Index pour la table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKofx66keruapi6vyqpv6f2or37` (`name`);

--

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `app-user`
--
ALTER TABLE `app_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;


--
-- AUTO_INCREMENT pour la table `garage`
--
ALTER TABLE `garage`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `mechanic`
--
ALTER TABLE `mechanic`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `owner`
--
ALTER TABLE `owner`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `permission`
--
ALTER TABLE `permission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;


--
-- Contraintes pour la table `app_user_permissions`
--
ALTER TABLE `app_user_permissions`
  ADD CONSTRAINT `FK77s2uclux9l7rslhvc9tj0kcc` FOREIGN KEY (`app_user_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `FKdw6t3bkjufxv45apygmtop8bh` FOREIGN KEY (`permissions_id`) REFERENCES `permission` (`id`);

--
-- Contraintes pour la table `app_user_roles`
--
ALTER TABLE `app_user_roles`
  ADD CONSTRAINT `FKkuuplo1cr5yqqkmh54ds2129i` FOREIGN KEY (`app_user_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `FKqty5eh5gll2a7mcgmomb9auhs` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);


--
-- Contraintes pour la table `garage_mechanic`
--
ALTER TABLE `garage_mechanic`
  ADD CONSTRAINT `FK1kk5xui5l1nc5f97gh11y6c19` FOREIGN KEY (`mechanic_id`) REFERENCES `mechanic` (`id`),
  ADD CONSTRAINT `FK4aqnr9vooupanstqat62h82rs` FOREIGN KEY (`garage_id`) REFERENCES `garage` (`id`);

--
-- Contraintes pour la table `owner`
--
ALTER TABLE `owner`
  ADD CONSTRAINT `FK9ic1dig1d6eg92i8ajbw8um1t` FOREIGN KEY (`car_id`) REFERENCES `car` (`immatriculation`);

--
-- Contraintes pour la table `roles_permissions`
--
ALTER TABLE `roles_permissions`
  ADD CONSTRAINT `FKboeuhl31go7wer3bpy6so7exi` FOREIGN KEY (`permission_id`) REFERENCES `permission` (`id`),
  ADD CONSTRAINT `FKqi9odri6c1o81vjox54eedwyh` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
