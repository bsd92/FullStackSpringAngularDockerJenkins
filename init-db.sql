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

CREATE TABLE `app-user` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `app-user`
--

INSERT INTO `app-user` (`id`, `email`, `password`, `username`) VALUES
(18, 'johndoe@example1.com', '$2a$10$E0ZkWUkyigLAirGtiSgUkuOVR6NWyMEO22zOfuHkoB2On0QgtfLhK', 'johndoe1'),
(19, 'user1@u.fr', '$2a$10$2V83b4X34HkZ8Yl0P538pe2f/.XgC2SBKcSoLpNaXFkbUbMop55yy', 'user1'),
(20, 'boubacar@vde.fr', '$2a$10$927W.crgiMZxuyWZhePCYONtOgfgLrVwur.cciccVGFReWVqPNGTu', 'Boubacar1'),
(23, 'admin@gmail.com', '$2a$10$t8d60q4ywKlIGqZgyhLOwuY3mlwLh7t7oiyG9t5li3PVa2xE0wCx6', 'admin'),
(24, 'admin1@vde.com', '$2a$10$VBW30UvmDNG7iMkepCs7hOZR2fHv5WtUHVx3LS25SiQqOnAXXmDlu', 'admin1'),
(36, 'manager1@vde.fr', '$2a$10$E9axSl9W3kq8oyrlkFRCeuxC.z008405t9pW2WATyTnTrPDMDBaOy', 'manager1'),
(37, 'test@vde.fr', '$2a$10$r.3G8kSLhiv1RluiJhpuK.YjwTfSpNvxT5oN1t6QV3NwPKLKHfyoW', 'test'),
(38, 'test2@vde.fr', '$2a$10$RRLGtqdK8AyvUFn8/PZCJe2jmSdU5q3k6JNw5iL76Ly8hhgULJftO', 'test2');

-- --------------------------------------------------------

--
-- Structure de la table `app-user_permissions`
--

CREATE TABLE `app-user_permissions` (
  `app_user_id` bigint(20) NOT NULL,
  `permissions_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `app-user_roles`
--

CREATE TABLE `app-user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `app-user_roles`
--

INSERT INTO `app-user_roles` (`user_id`, `role_id`) VALUES
(18, 1),
(19, 3),
(20, 1),
(23, 3),
(24, 1),
(36, 2),
(37, 1),
(38, 1);

-- --------------------------------------------------------

--
-- Structure de la table `app_user`
--

CREATE TABLE `app_user` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
-- Structure de la table `car`
--

CREATE TABLE `car` (
  `etat` varchar(50) DEFAULT NULL,
  `marque` varchar(50) DEFAULT NULL,
  `modele` varchar(50) DEFAULT NULL,
  `immatriculation` varchar(255) NOT NULL,
  `garage_id` bigint(20) DEFAULT NULL,
  `estimated_completion_date` datetime(6) DEFAULT NULL,
  `statut` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `status` enum('DELAI_PROLONGE','EN_ATTENTE','EN_COURS','TERMINE') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `car`
--

INSERT INTO `car` (`etat`, `marque`, `modele`, `immatriculation`, `garage_id`, `estimated_completion_date`, `statut`, `user_id`, `status`) VALUES
('NeuveM', 'Wols55', 'W2055', 'AZ-568-K0', NULL, NULL, 'TERMINE', NULL, NULL),
('Neuve', 'Wols2', 'W2025', 'AZ-568-Kl', NULL, NULL, 'TERMINE', NULL, NULL),
('Bon', 'Morgan', 'MPRX', 'BM-568-RE', NULL, NULL, 'EN_COURS', NULL, NULL),
('Neuve', 'Toyota', 'Yaris40', 'CZ-568-U9', NULL, NULL, 'TERMINE', NULL, NULL),
('Neuve', 'WolsBSD', 'W2025BSD', 'DZ-568-K0', NULL, NULL, 'EN_COURS', NULL, NULL);

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
  `permission_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `enabled` bit(1) NOT NULL,
  `password` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `role` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `enabled`, `password`, `username`, `role`, `email`) VALUES
(1, b'1', '$2a$10$PRVcu8efTrIPd3yR9zMz/ue5c3UwQL3a/IgGEorMvimkeCbbJJIEi', 'Boubacar1', NULL, NULL),
(2, b'1', '$2a$10$qHjDXSKOY13tRwmSpigcceFmPYn8wS/gM7z6nABMt8BxjYmLQnEYK', 'Boubacar2', NULL, NULL),
(3, b'1', '$2a$10$eP8Do2v0Tk4MkWkcKjL8EeG7keNd02Gz2i5uH31S7yleENRVaAQQ2', 'Boubacar3', NULL, NULL),
(4, b'1', '$2a$10$7lxFNTp9kW6aF5jXOw9AkOyvg0rI4RsZNhi.54M7NtfvkZFCVARam', 'Boubacar4', NULL, 'boubacarhb92@gmail.com'),
(5, b'1', '$2a$10$4sJPW3Mm5.ULP2saBEaVW.HBjWlRBYUUcBQPmbml24dkBFfi13bMW', 'Boubacar5', NULL, 'boubacarbeaulieu@gmail.com'),
(6, b'1', '$2a$10$b6swzIHdQQ0y3GSdYsVireH09I/AWwkitawn4FRhzbMPm0gKysqhC', 'Boubacar6', NULL, 'boubacarhb92@gmail');

-- --------------------------------------------------------

--
-- Structure de la table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) NOT NULL,
  `role_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `app-user`
--
ALTER TABLE `app-user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UK5iyma8vmo1ki719nliq5egjmq` (`email`),
  ADD UNIQUE KEY `UK577xavekri3thaxr916r5c79b` (`username`);

--
-- Index pour la table `app-user_permissions`
--
ALTER TABLE `app-user_permissions`
  ADD PRIMARY KEY (`app_user_id`,`permissions_id`),
  ADD KEY `FKdw6t3bkjufxv45apygmtop8bh` (`permissions_id`);

--
-- Index pour la table `app-user_roles`
--
ALTER TABLE `app-user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `FKqty5eh5gll2a7mcgmomb9auhs` (`role_id`);

--
-- Index pour la table `app_user`
--
ALTER TABLE `app_user`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `app_user_permissions`
--
ALTER TABLE `app_user_permissions`
  ADD PRIMARY KEY (`app_user_id`,`permissions_id`),
  ADD KEY `FKhx21dcah5ghrbn871wxx979v0` (`permissions_id`);

--
-- Index pour la table `car`
--
ALTER TABLE `car`
  ADD PRIMARY KEY (`immatriculation`),
  ADD KEY `FK1u9tthhrqs56l6cxxcyhulcfy` (`garage_id`),
  ADD KEY `FK2t76u58xhsnwnb4ieu0qafprg` (`user_id`);

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
-- Index pour la table `roles_permissions`
--
ALTER TABLE `roles_permissions`
  ADD PRIMARY KEY (`role_id`,`permission_id`),
  ADD KEY `FKboeuhl31go7wer3bpy6so7exi` (`permission_id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UKr43af9ap4edm43mmtq01oddj6` (`username`);

--
-- Index pour la table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `FKh8ciramu9cc9q3qcqiv4ue8a6` (`role_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `app-user`
--
ALTER TABLE `app-user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT pour la table `app_user`
--
ALTER TABLE `app_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

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
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `app-user_permissions`
--
ALTER TABLE `app-user_permissions`
  ADD CONSTRAINT `FK77s2uclux9l7rslhvc9tj0kcc` FOREIGN KEY (`app_user_id`) REFERENCES `app-user` (`id`),
  ADD CONSTRAINT `FKdw6t3bkjufxv45apygmtop8bh` FOREIGN KEY (`permissions_id`) REFERENCES `permission` (`id`);

--
-- Contraintes pour la table `app-user_roles`
--
ALTER TABLE `app-user_roles`
  ADD CONSTRAINT `FKkuuplo1cr5yqqkmh54ds2129i` FOREIGN KEY (`user_id`) REFERENCES `app-user` (`id`),
  ADD CONSTRAINT `FKqty5eh5gll2a7mcgmomb9auhs` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Contraintes pour la table `app_user_permissions`
--
ALTER TABLE `app_user_permissions`
  ADD CONSTRAINT `FK3xagfc9k59sltr0dc1xb3g0q8` FOREIGN KEY (`app_user_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `FKhx21dcah5ghrbn871wxx979v0` FOREIGN KEY (`permissions_id`) REFERENCES `permission` (`id`);

--
-- Contraintes pour la table `car`
--
ALTER TABLE `car`
  ADD CONSTRAINT `FK1u9tthhrqs56l6cxxcyhulcfy` FOREIGN KEY (`garage_id`) REFERENCES `garage` (`id`),
  ADD CONSTRAINT `FK2t76u58xhsnwnb4ieu0qafprg` FOREIGN KEY (`user_id`) REFERENCES `app-user` (`id`);

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

--
-- Contraintes pour la table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `FKh8ciramu9cc9q3qcqiv4ue8a6` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`),
  ADD CONSTRAINT `FKhfh9dx7w3ubf1co1vdev94g3f` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
