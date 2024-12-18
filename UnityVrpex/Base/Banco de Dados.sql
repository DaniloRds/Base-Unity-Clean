-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.27-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para vrp
DROP DATABASE IF EXISTS `vrp`;
CREATE DATABASE IF NOT EXISTS `vrp` /*!40100 DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci */;
USE `vrp`;

-- Copiando estrutura para tabela vrp.vrp_banco
DROP TABLE IF EXISTS `vrp_banco`;
CREATE TABLE IF NOT EXISTS `vrp_banco` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `extrato` varchar(255) DEFAULT NULL,
  `data` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Copiando estrutura para tabela vrp.vrp_business
DROP TABLE IF EXISTS `vrp_business`;
CREATE TABLE IF NOT EXISTS `vrp_business` (
  `user_id` int(11) NOT NULL,
  `capital` int(11) DEFAULT NULL,
  `laundered` int(11) DEFAULT NULL,
  `reset_timestamp` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_business_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_estoque
DROP TABLE IF EXISTS `vrp_estoque`;
CREATE TABLE IF NOT EXISTS `vrp_estoque` (
  `vehicle` varchar(100) NOT NULL,
  `estoque` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

INSERT INTO `vrp_estoque` (`vehicle`, `estoque`, `user_id`) VALUES
	('blista', 9, 1),
	('brioso', 9, 2),
	('emperor', 9, 3),
	('emperor2', 9, 4),
	('dilettante', 9, 5),
	('issi2', 9, 6),
	('panto', 11, 7),
	('prairie', 11, 8),
	('rhapsody', 10, 9),
	('cogcabrio', 10, 10),
	('exemplar', 10, 11),
	('ingot', 10, 14),
	('jackal', 10, 15),
	('oracle', 10, 16),
	('oracle2', 10, 17),
	('sentinel', 9, 18),
	('windsor', 10, 20),
	('windsor2', 10, 21),
	('zion', 10, 22),
	('zion2', 12, 23),
	('blade', 10, 24),
	('buccaneer', 10, 25),
	('buccaneer2', 10, 26),
	('primo', 10, 27),
	('chino', 10, 28),
	('coquette3', 10, 29),
	('dukes', 10, 30),
	('faction', 10, 31),
	('faction3', 10, 32),
	('gauntlet', 10, 33),
	('gauntlet2', 10, 34),
	('hermes', 10, 35),
	('hotknife', 10, 36),
	('moonbeam', 10, 37),
	('moonbeam2', 10, 38),
	('nightshade', 10, 39),
	('picador', 10, 40),
	('slamvan', 10, 44),
	('slamvan3', 10, 45),
	('stalion', 10, 46),
	('stalion2', 10, 47),
	('tampa', 10, 48),
	('vigero', 10, 49),
	('virgo', 10, 50),
	('virgo2', 10, 51),
	('virgo3', 10, 52),
	('voodoo', 10, 53),
	('voodoo2', 10, 54),
	('yosemite', 10, 55),
	('bfinjection', 10, 56),
	('bifta', 10, 57),
	('trophytruck', 10, 60),
	('trophytruck2', 10, 61),
	('dubsta3', 10, 62),
	('mesa3', 10, 63),
	('rancherxl', 10, 64),
	('rebel2', 10, 65),
	('dloader', 10, 67),
	('sandking', 10, 68),
	('baller', 10, 70),
	('baller2', 9, 71),
	('baller3', 10, 72),
	('baller4', 4, 73),
	('baller5', 2, 74),
	('baller6', 2, 75),
	('cavalcade', 10, 77),
	('cavalcade2', 10, 78),
	('dubsta', 10, 79),
	('dubsta2', 10, 80),
	('granger', 10, 82),
	('gresley', 10, 83),
	('habanero', 10, 84),
	('xls', 10, 87),
	('xls2', 10, 88),
	('asea', 10, 89),
	('asterope', 10, 90),
	('cognoscenti', 10, 92),
	('cognoscenti2', 10, 93),
	('stratum', 10, 95),
	('surge', 10, 96),
	('warrener', 10, 98),
	('alpha', 9, 100),
	('banshee', 10, 101),
	('bestiagts', 10, 102),
	('blista2', 10, 103),
	('blista3', 10, 104),
	('buffalo', 10, 105),
	('buffalo2', 10, 106),
	('buffalo3', 10, 107),
	('carbonizzare', 10, 108),
	('comet2', 10, 109),
	('comet3', 10, 110),
	('comet5', 10, 111),
	('coquette', 10, 112),
	('elegy', 10, 113),
	('elegy2', 10, 114),
	('feltzer2', 10, 115),
	('fusilade', 10, 117),
	('futo', 10, 118),
	('jester', 10, 119),
	('khamelion', 10, 120),
	('kuruma', 10, 121),
	('massacro', 10, 122),
	('massacro2', 10, 123),
	('ninef', 10, 124),
	('ninef2', 10, 125),
	('omnis', 5, 126),
	('pariah', 10, 127),
	('penumbra', 10, 128),
	('raiden', 10, 129),
	('rapidgt', 10, 131),
	('rapidgt2', 10, 132),
	('ruston', 10, 133),
	('schafter3', 10, 134),
	('schafter4', 10, 135),
	('schafter5', 10, 136),
	('schwarzer', 10, 137),
	('sentinel3', 8, 138),
	('seven70', 10, 139),
	('specter', 10, 140),
	('specter2', 10, 141),
	('streiter', 10, 142),
	('sultan', 11, 143),
	('surano', 10, 144),
	('tampa2', 10, 145),
	('tropos', 10, 146),
	('verlierer2', 10, 147),
	('coquette2', 10, 152),
	('feltzer3', 10, 153),
	('infernus2', 10, 155),
	('manana', 10, 158),
	('monroe', 10, 159),
	('peyote', 10, 160),
	('pigalle', 10, 161),
	('rapidgt3', 10, 162),
	('retinue', 10, 163),
	('torero', 10, 166),
	('tornado2', 10, 167),
	('tornado6', 10, 168),
	('tornado', 10, 169),
	('turismo2', 10, 170),
	('ztype', 10, 171),
	('autarch', 5, 173),
	('banshee2', 5, 174),
	('bullet', 5, 175),
	('entityxf', 5, 177),
	('infernus', 10, 180),
	('nero', 10, 181),
	('nero2', 10, 182),
	('osiris', 9, 183),
	('penetrator', 10, 184),
	('reaper', 10, 186),
	('sultanrs', 10, 188),
	('t20', 3, 189),
	('tempesta', 10, 190),
	('turismor', 10, 191),
	('tyrus', 10, 192),
	('vacca', 10, 193),
	('visione', 5, 194),
	('voltic', 10, 195),
	('zentorno', 5, 196),
	('sadler', 10, 197),
	('bison', 10, 198),
	('bison2', 10, 199),
	('burrito', 10, 201),
	('burrito2', 10, 202),
	('burrito4', 10, 203),
	('mule4', 10, 204),
	('rallytruck', 10, 205),
	('minivan', 10, 206),
	('minivan2', 10, 207),
	('paradise', 10, 208),
	('rumpo', 10, 211),
	('rumpo2', 10, 212),
	('rumpo3', 10, 213),
	('surfer', 10, 214),
	('youga', 10, 215),
	('huntley', 10, 216),
	('mesa', 10, 218),
	('patriot', 10, 219),
	('tyrant', 5, 222),
	('entity2', 5, 223),
	('hotring', 10, 225),
	('jester3', 10, 226),
	('fagaloa', 10, 230),
	('dominator', 10, 231),
	('dominator2', 10, 232),
	('dominator3', 10, 233),
	('issi3', 10, 234),
	('stretch', 10, 237),
	('guardian', 10, 238),
	('kamacho', 10, 239),
	('neon', 10, 240),
	('vagner', 5, 244),
	('xa21', 1, 245),
	('prototipo', 3, 247),
	('patriot2', 10, 248),
	('swinger', 10, 249),
	('clique', 10, 250),
	('deveste', 2, 251),
	('deviant', 10, 252),
	('impaler', 10, 253),
	('schlagen', 10, 256),
	('tulip', 10, 257),
	('fugitive', 10, 260),
	('glendale', 10, 261),
	('intruder', 10, 262),
	('le7b', 10, 263),
	('lurcher', 10, 264),
	('phoenix', 10, 266),
	('premier', 10, 267),
	('akuma', 10, 271),
	('avarus', 10, 272),
	('bagger', 10, 273),
	('bati', 10, 274),
	('bati2', 10, 275),
	('bf400', 10, 276),
	('chimera', 10, 278),
	('cliffhanger', 10, 279),
	('daemon2', 10, 280),
	('diablous', 10, 282),
	('diablous2', 10, 283),
	('double', 10, 284),
	('enduro', 10, 285),
	('faggio', 10, 287),
	('faggio2', 10, 288),
	('faggio3', 10, 289),
	('hakuchou', 5, 293),
	('hakuchou2', 5, 294),
	('hexer', 10, 295),
	('innovation', 10, 296),
	('lectro', 10, 297),
	('manchez', 10, 298),
	('nemesis', 10, 299),
	('nightblade', 10, 300),
	('pcj', 10, 301),
	('ruffian', 10, 302),
	('sanchez', 10, 303),
	('sanchez2', 10, 304),
	('sovereign', 10, 305),
	('vindicator', 10, 308),
	('vortex', 10, 309),
	('wolfsbane', 10, 310),
	('zombiea', 10, 311),
	('zombieb', 10, 312),
	('shotaro', 10, 313);

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_lojavip
DROP TABLE IF EXISTS `vrp_lojavip`;
CREATE TABLE IF NOT EXISTS `vrp_lojavip` (
  `vehicle` varchar(100) NOT NULL,
  `estoque` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_homes_permissions
DROP TABLE IF EXISTS `vrp_homes_permissions`;
CREATE TABLE IF NOT EXISTS `vrp_homes_permissions` (
  `owner` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `garage` int(11) NOT NULL,
  `home` varchar(100) NOT NULL DEFAULT '',
  `tax` varchar(24) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_priority
DROP TABLE IF EXISTS `vrp_priority`;
CREATE TABLE IF NOT EXISTS `vrp_priority` (
  `steam` int(11) unsigned NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_srv_data
DROP TABLE IF EXISTS `vrp_srv_data`;
CREATE TABLE IF NOT EXISTS `vrp_srv_data` (
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`dkey`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_users
DROP TABLE IF EXISTS `vrp_users`;
CREATE TABLE IF NOT EXISTS `vrp_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_login` varchar(255) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `whitelisted` tinyint(1) DEFAULT NULL,
  `banned` tinyint(1) DEFAULT NULL,
  `pet` varchar(50) DEFAULT NULL,
  `moedas` int(30) NOT NULL DEFAULT 0,
  `garagem` int(30) NOT NULL DEFAULT 2,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_user_data
DROP TABLE IF EXISTS `vrp_user_data`;
CREATE TABLE IF NOT EXISTS `vrp_user_data` (
  `user_id` int(11) NOT NULL,
  `dkey` varchar(100) NOT NULL,
  `dvalue` text DEFAULT NULL,
  PRIMARY KEY (`user_id`,`dkey`),
  CONSTRAINT `fk_user_data_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_user_homes
DROP TABLE IF EXISTS `vrp_user_homes`;
CREATE TABLE IF NOT EXISTS `vrp_user_homes` (
  `user_id` int(11) NOT NULL,
  `home` varchar(255) NOT NULL,
  `number` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`,`home`),
  CONSTRAINT `fk_user_homes_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_user_identities
DROP TABLE IF EXISTS `vrp_user_identities`;
CREATE TABLE IF NOT EXISTS `vrp_user_identities` (
  `user_id` int(11) NOT NULL,
  `registration` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `foragido` int(11) NOT NULL,
  `foto` varchar(1500) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `registration` (`registration`),
  KEY `phone` (`phone`),
  CONSTRAINT `fk_user_identities_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_user_ids
DROP TABLE IF EXISTS `vrp_user_ids`;
CREATE TABLE IF NOT EXISTS `vrp_user_ids` (
  `identifier` varchar(100) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  KEY `fk_user_ids_users` (`user_id`),
  CONSTRAINT `fk_user_ids_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_user_moneys
DROP TABLE IF EXISTS `vrp_user_moneys`;
CREATE TABLE IF NOT EXISTS `vrp_user_moneys` (
  `user_id` int(11) NOT NULL,
  `wallet` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `coin` int(11) DEFAULT NULL,
  `paypal` int(11) DEFAULT 0,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_user_moneys_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_user_vehicles
DROP TABLE IF EXISTS `vrp_user_vehicles`;
CREATE TABLE IF NOT EXISTS `vrp_user_vehicles` (
  `user_id` int(11) NOT NULL,
  `vehicle` varchar(100) NOT NULL,
  `detido` int(1) NOT NULL DEFAULT 0,
  `time` varchar(24) NOT NULL DEFAULT '0',
  `engine` int(4) NOT NULL DEFAULT 1000,
  `body` int(4) NOT NULL DEFAULT 1000,
  `fuel` int(3) NOT NULL DEFAULT 100,
  `damage_state` varchar(500) NOT NULL,
  `ipva` int(11) NOT NULL,
  `alugado` tinyint(4) NOT NULL DEFAULT 0,
  `data_alugado` text DEFAULT NULL,
  `in_road` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`,`vehicle`),
  CONSTRAINT `fk_user_vehicles_users` FOREIGN KEY (`user_id`) REFERENCES `vrp_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

-- Copiando estrutura para tabela vrp.vrp_vips
DROP TABLE IF EXISTS `vrp_vips`;
CREATE TABLE IF NOT EXISTS `vrp_vips` (
  `user_id` int(11) NOT NULL,
  `vipName` varchar(50) DEFAULT NULL,
  `data_contrat` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `vipName` (`vipName`),
  KEY `data_contrat` (`data_contrat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- Exportação de dados foi desmarcado.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
