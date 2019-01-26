-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 25, 2019 at 09:02 PM
-- Server version: 5.7.25-0ubuntu0.18.04.2
-- PHP Version: 7.2.10-0ubuntu0.18.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `wireless_stats`
--

-- --------------------------------------------------------

--
-- Table structure for table `reporting_device`
--

CREATE TABLE `reporting_device` (
  `id` int(11) NOT NULL,
  `uuid` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `bt_mac_address` bigint(20) NOT NULL,
  `wifi_mac_address` bigint(20) NOT NULL,
  `ipv4_address` int(11) NOT NULL,
  `ipv6_address` varbinary(16) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `longitude` float NOT NULL,
  `latitude` float NOT NULL,
  `OS` varchar(255) NOT NULL,
  `battery_life` float NOT NULL,
  `has_cellular_internet` tinyint(1) NOT NULL,
  `has_wifi_internet` tinyint(1) NOT NULL,
  `cellular_throughput` float NOT NULL,
  `wifi_throughput` float NOT NULL,
  `cellular_ping` int(11) NOT NULL,
  `wifi_ping` int(11) NOT NULL,
  `cellular_operator` varchar(255) NOT NULL,
  `cellular_network_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `reporting_device`
--
ALTER TABLE `reporting_device`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `reporting_device`
--
ALTER TABLE `reporting_device`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
