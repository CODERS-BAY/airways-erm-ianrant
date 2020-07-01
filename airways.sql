-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 01, 2020 at 10:25 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `airways`
--

-- --------------------------------------------------------

--
-- Table structure for table `AIRCRAFT`
--

CREATE TABLE `AIRCRAFT` (
  `aircraft_id` int(11) NOT NULL,
  `aircraft_registration` varchar(30) DEFAULT NULL,
  `aircraft_name` varchar(50) DEFAULT NULL,
  `aircraft_operational_since` date DEFAULT NULL,
  `airline_id` int(11) DEFAULT NULL,
  `aircraft_type_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `AIRCRAFT_TYPE`
--

CREATE TABLE `AIRCRAFT_TYPE` (
  `aircraft_type_id` int(11) NOT NULL,
  `aircraft_type_name` varchar(50) DEFAULT NULL,
  `aircraft_type_manufacturer` varchar(50) DEFAULT NULL,
  `aircraft_type_range` int(11) DEFAULT NULL,
  `aircraft_type_capacity` int(11) DEFAULT NULL,
  `aircraft_type_smoking` bit(1) DEFAULT NULL,
  `seating_section_nr` int(11) DEFAULT NULL,
  `seating_row_nr` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `airline`
--

CREATE TABLE `airline` (
  `airline_id` int(11) NOT NULL,
  `airline_alias` varchar(3) DEFAULT NULL,
  `airline_name` varchar(50) DEFAULT NULL,
  `airline_headquarter` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `AIRPORT`
--

CREATE TABLE `AIRPORT` (
  `airport_id` int(11) NOT NULL,
  `airport_alias` varchar(3) DEFAULT NULL,
  `airport_name` varchar(50) DEFAULT NULL,
  `airport_location_city` varchar(50) DEFAULT NULL,
  `airport_location_country` varchar(50) DEFAULT NULL,
  `airport_vehicle_capacity` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `AIRPORT_DISTANCE`
--

CREATE TABLE `AIRPORT_DISTANCE` (
  `airport_distance_id` int(11) NOT NULL,
  `airport_departure_id` int(11) DEFAULT NULL,
  `airport_destination_id` int(11) DEFAULT NULL,
  `distance_between_airports` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `BOARDING_CARD`
--

CREATE TABLE `BOARDING_CARD` (
  `boarding_card_id` int(11) NOT NULL,
  `boarding_card_number` int(11) DEFAULT NULL,
  `boarding_card_date` date DEFAULT NULL,
  `passenger_id` int(11) DEFAULT NULL,
  `ticked_id` int(11) DEFAULT NULL,
  `seating_section_nr` int(11) DEFAULT NULL,
  `seating_row_nr` int(11) DEFAULT NULL,
  `aircraft_type_id` int(11) DEFAULT NULL,
  `flightplan_item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `FLIGHT`
--

CREATE TABLE `FLIGHT` (
  `flight_id` int(11) NOT NULL,
  `boarding_card_id` int(11) DEFAULT NULL,
  `flightplan_item_id` int(11) DEFAULT NULL,
  `airport_distance_id` int(11) DEFAULT NULL,
  `aircraft_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `FLIGHTPLAN`
--

CREATE TABLE `FLIGHTPLAN` (
  `flightplan_item_id` int(11) NOT NULL,
  `pilot_flight_id` int(11) DEFAULT NULL,
  `airplane_id` int(11) DEFAULT NULL,
  `travel_time_data_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `passenger`
--

CREATE TABLE `passenger` (
  `passenger_number` int(11) NOT NULL,
  `passenger_name` varchar(50) DEFAULT NULL,
  `passenger_gender` varchar(50) DEFAULT NULL,
  `passenger_title` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `SEATING`
--

CREATE TABLE `SEATING` (
  `seating_section_nr` int(11) NOT NULL,
  `seating_row_nr` int(11) NOT NULL,
  `aircraft_type_id` int(11) NOT NULL,
  `flight_date` date DEFAULT NULL,
  `flight_id` int(11) DEFAULT NULL,
  `boarding_card_id` int(11) DEFAULT NULL,
  `flightplan_item_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `TICKET`
--

CREATE TABLE `TICKET` (
  `ticket_id` int(11) NOT NULL,
  `ticket_date_of_issue` date DEFAULT NULL,
  `ticket_price` int(11) DEFAULT NULL,
  `ticket_currency` varchar(10) DEFAULT NULL,
  `ticket_sales_office` varchar(50) DEFAULT NULL,
  `passenger_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `TRAVEL_TIME_DATA`
--

CREATE TABLE `TRAVEL_TIME_DATA` (
  `travel_time_data_id` int(11) NOT NULL,
  `flightplan_item_id` int(11) DEFAULT NULL,
  `date_departure_sched` date DEFAULT NULL,
  `time_departure_sched` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `date_arrival_sched` date DEFAULT NULL,
  `time_arrival_sched` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_departure_act` date DEFAULT NULL,
  `time_departure_act` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `date_arrival_act` date DEFAULT NULL,
  `time_arrival_act` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AIRCRAFT`
--
ALTER TABLE `AIRCRAFT`
  ADD PRIMARY KEY (`aircraft_id`),
  ADD UNIQUE KEY `airline_id` (`airline_id`,`aircraft_type_id`),
  ADD KEY `aircraft_type_id` (`aircraft_type_id`);

--
-- Indexes for table `AIRCRAFT_TYPE`
--
ALTER TABLE `AIRCRAFT_TYPE`
  ADD PRIMARY KEY (`aircraft_type_id`),
  ADD UNIQUE KEY `seating_section_nr` (`seating_section_nr`,`seating_row_nr`);

--
-- Indexes for table `airline`
--
ALTER TABLE `airline`
  ADD PRIMARY KEY (`airline_id`);

--
-- Indexes for table `AIRPORT`
--
ALTER TABLE `AIRPORT`
  ADD PRIMARY KEY (`airport_id`);

--
-- Indexes for table `AIRPORT_DISTANCE`
--
ALTER TABLE `AIRPORT_DISTANCE`
  ADD PRIMARY KEY (`airport_distance_id`),
  ADD UNIQUE KEY `airport_departure_id` (`airport_departure_id`,`airport_destination_id`),
  ADD KEY `airport_destination_id` (`airport_destination_id`);

--
-- Indexes for table `BOARDING_CARD`
--
ALTER TABLE `BOARDING_CARD`
  ADD PRIMARY KEY (`boarding_card_id`),
  ADD UNIQUE KEY `passenger_name` (`passenger_id`,`ticked_id`,`seating_section_nr`,`seating_row_nr`,`aircraft_type_id`,`flightplan_item_id`),
  ADD UNIQUE KEY `passenger_id` (`passenger_id`),
  ADD KEY `ticked_id` (`ticked_id`),
  ADD KEY `seating_section_nr` (`seating_section_nr`),
  ADD KEY `aircraft_type_id` (`aircraft_type_id`),
  ADD KEY `flightplan_item_id` (`flightplan_item_id`);

--
-- Indexes for table `FLIGHT`
--
ALTER TABLE `FLIGHT`
  ADD PRIMARY KEY (`flight_id`),
  ADD UNIQUE KEY `flightplan_item_id` (`flightplan_item_id`,`airport_distance_id`,`aircraft_id`),
  ADD UNIQUE KEY `boarding_card_id` (`boarding_card_id`),
  ADD KEY `airport_distance_id` (`airport_distance_id`),
  ADD KEY `aircraft_id` (`aircraft_id`);

--
-- Indexes for table `FLIGHTPLAN`
--
ALTER TABLE `FLIGHTPLAN`
  ADD PRIMARY KEY (`flightplan_item_id`),
  ADD UNIQUE KEY `pilot_flight_id` (`pilot_flight_id`,`airplane_id`,`travel_time_data_id`),
  ADD KEY `travel_time_data_id` (`travel_time_data_id`);

--
-- Indexes for table `passenger`
--
ALTER TABLE `passenger`
  ADD PRIMARY KEY (`passenger_number`);

--
-- Indexes for table `SEATING`
--
ALTER TABLE `SEATING`
  ADD PRIMARY KEY (`seating_section_nr`,`seating_row_nr`,`aircraft_type_id`),
  ADD UNIQUE KEY `aircraft_type_id` (`aircraft_type_id`,`boarding_card_id`,`flightplan_item_id`),
  ADD KEY `boarding_card_id` (`boarding_card_id`),
  ADD KEY `flightplan_item_id` (`flightplan_item_id`);

--
-- Indexes for table `TICKET`
--
ALTER TABLE `TICKET`
  ADD PRIMARY KEY (`ticket_id`),
  ADD UNIQUE KEY `passenger_id` (`passenger_id`);

--
-- Indexes for table `TRAVEL_TIME_DATA`
--
ALTER TABLE `TRAVEL_TIME_DATA`
  ADD PRIMARY KEY (`travel_time_data_id`),
  ADD UNIQUE KEY `flightplan_item_id` (`flightplan_item_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AIRCRAFT`
--
ALTER TABLE `AIRCRAFT`
  MODIFY `aircraft_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `AIRCRAFT_TYPE`
--
ALTER TABLE `AIRCRAFT_TYPE`
  MODIFY `aircraft_type_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `airline`
--
ALTER TABLE `airline`
  MODIFY `airline_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `AIRPORT`
--
ALTER TABLE `AIRPORT`
  MODIFY `airport_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `AIRPORT_DISTANCE`
--
ALTER TABLE `AIRPORT_DISTANCE`
  MODIFY `airport_distance_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `BOARDING_CARD`
--
ALTER TABLE `BOARDING_CARD`
  MODIFY `boarding_card_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `FLIGHT`
--
ALTER TABLE `FLIGHT`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `FLIGHTPLAN`
--
ALTER TABLE `FLIGHTPLAN`
  MODIFY `flightplan_item_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `passenger`
--
ALTER TABLE `passenger`
  MODIFY `passenger_number` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `TICKET`
--
ALTER TABLE `TICKET`
  MODIFY `ticket_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `TRAVEL_TIME_DATA`
--
ALTER TABLE `TRAVEL_TIME_DATA`
  MODIFY `travel_time_data_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `AIRCRAFT`
--
ALTER TABLE `AIRCRAFT`
  ADD CONSTRAINT `aircraft_ibfk_1` FOREIGN KEY (`aircraft_type_id`) REFERENCES `AIRCRAFT_TYPE` (`aircraft_type_id`),
  ADD CONSTRAINT `aircraft_ibfk_2` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`);

--
-- Constraints for table `AIRCRAFT_TYPE`
--
ALTER TABLE `AIRCRAFT_TYPE`
  ADD CONSTRAINT `aircraft_type_ibfk_1` FOREIGN KEY (`seating_section_nr`) REFERENCES `SEATING` (`seating_section_nr`);

--
-- Constraints for table `AIRPORT_DISTANCE`
--
ALTER TABLE `AIRPORT_DISTANCE`
  ADD CONSTRAINT `airport_distance_ibfk_1` FOREIGN KEY (`airport_departure_id`) REFERENCES `AIRCRAFT_TYPE` (`aircraft_type_id`),
  ADD CONSTRAINT `airport_distance_ibfk_2` FOREIGN KEY (`airport_destination_id`) REFERENCES `AIRCRAFT_TYPE` (`aircraft_type_id`);

--
-- Constraints for table `BOARDING_CARD`
--
ALTER TABLE `BOARDING_CARD`
  ADD CONSTRAINT `boarding_card_ibfk_1` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`passenger_number`),
  ADD CONSTRAINT `boarding_card_ibfk_2` FOREIGN KEY (`ticked_id`) REFERENCES `TICKET` (`ticket_id`),
  ADD CONSTRAINT `boarding_card_ibfk_3` FOREIGN KEY (`seating_section_nr`) REFERENCES `SEATING` (`seating_section_nr`),
  ADD CONSTRAINT `boarding_card_ibfk_4` FOREIGN KEY (`aircraft_type_id`) REFERENCES `SEATING` (`aircraft_type_id`),
  ADD CONSTRAINT `boarding_card_ibfk_5` FOREIGN KEY (`flightplan_item_id`) REFERENCES `FLIGHTPLAN` (`flightplan_item_id`);

--
-- Constraints for table `FLIGHT`
--
ALTER TABLE `FLIGHT`
  ADD CONSTRAINT `flight_ibfk_1` FOREIGN KEY (`boarding_card_id`) REFERENCES `BOARDING_CARD` (`boarding_card_id`),
  ADD CONSTRAINT `flight_ibfk_2` FOREIGN KEY (`flightplan_item_id`) REFERENCES `FLIGHTPLAN` (`flightplan_item_id`),
  ADD CONSTRAINT `flight_ibfk_3` FOREIGN KEY (`airport_distance_id`) REFERENCES `AIRPORT_DISTANCE` (`airport_distance_id`),
  ADD CONSTRAINT `flight_ibfk_4` FOREIGN KEY (`aircraft_id`) REFERENCES `AIRCRAFT` (`aircraft_id`);

--
-- Constraints for table `FLIGHTPLAN`
--
ALTER TABLE `FLIGHTPLAN`
  ADD CONSTRAINT `flightplan_ibfk_1` FOREIGN KEY (`travel_time_data_id`) REFERENCES `TRAVEL_TIME_DATA` (`travel_time_data_id`);

--
-- Constraints for table `SEATING`
--
ALTER TABLE `SEATING`
  ADD CONSTRAINT `seating_ibfk_1` FOREIGN KEY (`boarding_card_id`) REFERENCES `BOARDING_CARD` (`boarding_card_id`),
  ADD CONSTRAINT `seating_ibfk_2` FOREIGN KEY (`flightplan_item_id`) REFERENCES `FLIGHTPLAN` (`flightplan_item_id`);

--
-- Constraints for table `TICKET`
--
ALTER TABLE `TICKET`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`passenger_number`);

--
-- Constraints for table `TRAVEL_TIME_DATA`
--
ALTER TABLE `TRAVEL_TIME_DATA`
  ADD CONSTRAINT `travel_time_data_ibfk_1` FOREIGN KEY (`flightplan_item_id`) REFERENCES `FLIGHTPLAN` (`flightplan_item_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
