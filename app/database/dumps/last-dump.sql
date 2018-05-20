-- phpMyAdmin SQL Dump
-- version 4.7.9
-- https://www.phpmyadmin.net/
--
-- Host: mysql:3306
-- Generation Time: May 20, 2018 at 05:16 PM
-- Server version: 5.7.21
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `makeitsaas`
--

-- --------------------------------------------------------

--
-- Table structure for table `domain`
--

CREATE TABLE `domain` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `pattern` varchar(255) NOT NULL,
  `position` int(6) UNSIGNED NOT NULL DEFAULT '0',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `domain`
--

INSERT INTO `domain` (`id`, `project_id`, `pattern`, `position`, `date_create`) VALUES
(1, 1, '.basic.duwab.com', 0, '2018-05-12 16:13:44');

-- --------------------------------------------------------

--
-- Table structure for table `environment`
--

CREATE TABLE `environment` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `subdomain` varchar(255) NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `environment`
--

INSERT INTO `environment` (`id`, `project_id`, `subdomain`, `date_create`) VALUES
(1, 1, 'prod', '2018-05-12 16:15:02'),
(2, 1, 'staging', '2018-05-12 16:15:02'),
(3, 1, 'dev-1', '2018-05-12 16:15:02'),
(4, 1, 'dev-2', '2018-05-12 16:15:02');

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `position` int(6) UNSIGNED NOT NULL DEFAULT '0',
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`id`, `name`, `position`, `date_create`) VALUES
(1, 'Basic Application', 0, '2018-05-12 16:12:32');

-- --------------------------------------------------------

--
-- Table structure for table `route`
--

CREATE TABLE `route` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `domain_id` bigint(20) UNSIGNED NOT NULL,
  `parent_route_id` bigint(20) UNSIGNED DEFAULT NULL,
  `target_service_id` bigint(20) UNSIGNED DEFAULT NULL,
  `pattern` varchar(255) NOT NULL,
  `position` int(6) UNSIGNED NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `service`
--

CREATE TABLE `service` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` enum('repository','cdn','database','faas','other') NOT NULL DEFAULT 'repository',
  `repository_url` varchar(255) DEFAULT NULL,
  `position` int(6) UNSIGNED NOT NULL,
  `date_create` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service`
--

INSERT INTO `service` (`id`, `project_id`, `name`, `type`, `repository_url`, `position`, `date_create`) VALUES
(1, 1, 'API', 'repository', NULL, 0, '2018-05-12 16:16:09'),
(2, 1, 'Database', 'database', NULL, 1, '2018-05-12 16:16:09');

-- --------------------------------------------------------

--
-- Table structure for table `service_branch`
--

CREATE TABLE `service_branch` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `cluster_reference_id` varchar(255) NOT NULL,
  `environment_id` bigint(20) UNSIGNED DEFAULT NULL,
  `service_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service_branch`
--

INSERT INTO `service_branch` (`id`, `cluster_reference_id`, `environment_id`, `service_id`) VALUES
(1, 'basic-prod-api-cluster', 1, 1),
(2, 'basic-prod-database-cluster', 1, 2),
(3, 'basic-staging-api-cluster', 2, 1),
(4, 'basic-staging-database-cluster', 2, 2),
(5, 'basic-dev-1-api-cluster', 3, 1),
(6, 'basic-dev-1-database-cluster', 3, 2),
(7, 'basic-dev-2-api-cluster', 4, 1),
(8, 'basic-dev-2-database-cluster', 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `service_branch_event`
--

CREATE TABLE `service_branch_event` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_branch_id` bigint(20) UNSIGNED NOT NULL,
  `type` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `service_branch_migration`
--

CREATE TABLE `service_branch_migration` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_branch_id` bigint(20) UNSIGNED NOT NULL,
  `service_migration_id` bigint(20) UNSIGNED NOT NULL,
  `applied` tinyint(1) NOT NULL DEFAULT '0',
  `failed` tinyint(1) NOT NULL DEFAULT '0',
  `ignore_it` tinyint(1) NOT NULL DEFAULT '0',
  `pending_request` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service_branch_migration`
--

INSERT INTO `service_branch_migration` (`id`, `service_branch_id`, `service_migration_id`, `applied`, `failed`, `ignore_it`, `pending_request`) VALUES
(7, 6, 1, 1, 0, 0, NULL),
(8, 8, 2, 1, 0, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `service_migration`
--

CREATE TABLE `service_migration` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `service_id` bigint(20) UNSIGNED NOT NULL,
  `type` enum('SQL','git') NOT NULL,
  `content` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `service_migration`
--

INSERT INTO `service_migration` (`id`, `service_id`, `type`, `content`) VALUES
(1, 2, 'SQL', 'CREATE TABLE `table_product` (\r\n  `id` bigint(20) NOT NULL\r\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\r\nCOMMIT;\r\n'),
(2, 2, 'SQL', 'CREATE TABLE `table_forum` (\r\n  `id` bigint(20) NOT NULL\r\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;\r\nCOMMIT;\r\n');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `domain`
--
ALTER TABLE `domain`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `environment`
--
ALTER TABLE `environment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `route`
--
ALTER TABLE `route`
  ADD PRIMARY KEY (`id`),
  ADD KEY `domain_id` (`domain_id`),
  ADD KEY `parent_route_id` (`parent_route_id`),
  ADD KEY `target_service_id` (`target_service_id`);

--
-- Indexes for table `service`
--
ALTER TABLE `service`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `service_branch`
--
ALTER TABLE `service_branch`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `reference` (`cluster_reference_id`),
  ADD KEY `environment_id` (`environment_id`),
  ADD KEY `service_id` (`service_id`);

--
-- Indexes for table `service_branch_event`
--
ALTER TABLE `service_branch_event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instance_id` (`service_branch_id`);

--
-- Indexes for table `service_branch_migration`
--
ALTER TABLE `service_branch_migration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `instance_id` (`service_branch_id`),
  ADD KEY `service_migration_id` (`service_migration_id`);

--
-- Indexes for table `service_migration`
--
ALTER TABLE `service_migration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `service_id` (`service_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `domain`
--
ALTER TABLE `domain`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `environment`
--
ALTER TABLE `environment`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `project`
--
ALTER TABLE `project`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `route`
--
ALTER TABLE `route`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service`
--
ALTER TABLE `service`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `service_branch`
--
ALTER TABLE `service_branch`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `service_branch_event`
--
ALTER TABLE `service_branch_event`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `service_branch_migration`
--
ALTER TABLE `service_branch_migration`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `service_migration`
--
ALTER TABLE `service_migration`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `domain`
--
ALTER TABLE `domain`
  ADD CONSTRAINT `domain_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `environment`
--
ALTER TABLE `environment`
  ADD CONSTRAINT `environment_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `route`
--
ALTER TABLE `route`
  ADD CONSTRAINT `route_ibfk_1` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `route_ibfk_2` FOREIGN KEY (`parent_route_id`) REFERENCES `route` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `route_ibfk_3` FOREIGN KEY (`target_service_id`) REFERENCES `service` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `service`
--
ALTER TABLE `service`
  ADD CONSTRAINT `service_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `service_branch`
--
ALTER TABLE `service_branch`
  ADD CONSTRAINT `service_branch_ibfk_1` FOREIGN KEY (`environment_id`) REFERENCES `environment` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `service_branch_ibfk_2` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `service_branch_event`
--
ALTER TABLE `service_branch_event`
  ADD CONSTRAINT `service_branch_event_ibfk_1` FOREIGN KEY (`service_branch_id`) REFERENCES `service_branch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `service_branch_migration`
--
ALTER TABLE `service_branch_migration`
  ADD CONSTRAINT `service_branch_migration_ibfk_1` FOREIGN KEY (`service_branch_id`) REFERENCES `service_branch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `service_branch_migration_ibfk_2` FOREIGN KEY (`service_migration_id`) REFERENCES `service_migration` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `service_migration`
--
ALTER TABLE `service_migration`
  ADD CONSTRAINT `service_migration_ibfk_1` FOREIGN KEY (`service_id`) REFERENCES `service` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
