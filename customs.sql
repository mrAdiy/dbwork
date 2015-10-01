-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.6.26 - MySQL Community Server (GPL)
-- ОС Сервера:                   Win64
-- HeidiSQL Версия:              9.3.0.4992
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры базы данных customs
CREATE DATABASE IF NOT EXISTS `customs` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `customs`;


-- Дамп структуры для таблица customs.buyers
CREATE TABLE IF NOT EXISTS `buyers` (
  `id_buyer` int(11) NOT NULL AUTO_INCREMENT,
  `buyer_name` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Имя',
  `buyer_interests` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Что покупают',
  PRIMARY KEY (`id_buyer`),
  CONSTRAINT `FK_buyers_carriers` FOREIGN KEY (`id_buyer`) REFERENCES `carriers` (`id_carrier`),
  CONSTRAINT `FK_buyers_providers` FOREIGN KEY (`id_buyer`) REFERENCES `providers` (`id_provider`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Покупатели';

-- Дамп данных таблицы customs.buyers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `buyers` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyers` ENABLE KEYS */;


-- Дамп структуры для таблица customs.carriers
CREATE TABLE IF NOT EXISTS `carriers` (
  `id_carrier` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_name` varchar(50) DEFAULT NULL COMMENT 'Имя перевозчика',
  `carrier_specialization` varchar(50) DEFAULT NULL COMMENT 'Специализация',
  PRIMARY KEY (`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Перевозчики';

-- Дамп данных таблицы customs.carriers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `carriers` DISABLE KEYS */;
/*!40000 ALTER TABLE `carriers` ENABLE KEYS */;


-- Дамп структуры для таблица customs.checkpoint
CREATE TABLE IF NOT EXISTS `checkpoint` (
  `id_checkpoint` int(11) NOT NULL AUTO_INCREMENT,
  `checkpoint_name` varchar(50) DEFAULT NULL COMMENT 'Имя ПП',
  PRIMARY KEY (`id_checkpoint`),
  CONSTRAINT `FK_checkpoint_country` FOREIGN KEY (`id_checkpoint`) REFERENCES `country` (`id_country`),
  CONSTRAINT `FK_checkpoint_delivery` FOREIGN KEY (`id_checkpoint`) REFERENCES `delivery` (`id_delivery`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Пропускной пункт';

-- Дамп данных таблицы customs.checkpoint: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `checkpoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `checkpoint` ENABLE KEYS */;


-- Дамп структуры для таблица customs.country
CREATE TABLE IF NOT EXISTS `country` (
  `id_country` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) DEFAULT NULL COMMENT 'Название страны',
  PRIMARY KEY (`id_country`),
  CONSTRAINT `FK_country_buyers` FOREIGN KEY (`id_country`) REFERENCES `buyers` (`id_buyer`),
  CONSTRAINT `FK_country_providers` FOREIGN KEY (`id_country`) REFERENCES `providers` (`id_provider`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Страна: к какой стране какой поставщик принадлежит, а так же граничащий с ней ПП';

-- Дамп данных таблицы customs.country: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;


-- Дамп структуры для таблица customs.delivery
CREATE TABLE IF NOT EXISTS `delivery` (
  `id_delivery` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_time` int(11) DEFAULT NULL,
  `delivery_total_weight` int(11) DEFAULT NULL,
  `delivery_total_volume` int(11) DEFAULT NULL,
  `delivery_total_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_delivery`),
  CONSTRAINT `FK_delivery_ratio_goods_delivery` FOREIGN KEY (`id_delivery`) REFERENCES `ratio_goods_delivery` (`id_ratio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Поставки';

-- Дамп данных таблицы customs.delivery: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;


-- Дамп структуры для таблица customs.duty
CREATE TABLE IF NOT EXISTS `duty` (
  `duty_default_size` int(11) NOT NULL,
  `diff_size` int(11) NOT NULL COMMENT 'Дифференцирование пошлины',
  `duty_total_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`diff_size`),
  KEY `FK_duty_goods` (`duty_default_size`),
  CONSTRAINT `FK_duty_goods` FOREIGN KEY (`duty_default_size`) REFERENCES `goods` (`id_good`),
  CONSTRAINT `FK_duty_goods_2` FOREIGN KEY (`diff_size`) REFERENCES `goods` (`good_volume`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Пошлины';

-- Дамп данных таблицы customs.duty: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `duty` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty` ENABLE KEYS */;


-- Дамп структуры для таблица customs.goods
CREATE TABLE IF NOT EXISTS `goods` (
  `id_good` int(11) NOT NULL AUTO_INCREMENT,
  `good_name` varchar(50) DEFAULT NULL COMMENT 'Название груза',
  `good_weight` int(11) DEFAULT NULL COMMENT 'Вес груза',
  `good_volume` int(11) NOT NULL COMMENT 'Объём груза',
  PRIMARY KEY (`id_good`),
  KEY `FK_goods_differentation` (`good_volume`),
  CONSTRAINT `FK_goods_ratio_goods_delivery` FOREIGN KEY (`id_good`) REFERENCES `ratio_goods_delivery` (`id_ratio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Грузы';

-- Дамп данных таблицы customs.goods: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;


-- Дамп структуры для таблица customs.providers
CREATE TABLE IF NOT EXISTS `providers` (
  `id_provider` int(11) NOT NULL AUTO_INCREMENT,
  `provider_name` varchar(50) DEFAULT NULL COMMENT 'Имя поставщика',
  `provider_specialization` varchar(50) DEFAULT NULL COMMENT 'Специализация поставщика',
  PRIMARY KEY (`id_provider`),
  CONSTRAINT `FK_providers_goods` FOREIGN KEY (`id_provider`) REFERENCES `goods` (`id_good`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Поставщики';

-- Дамп данных таблицы customs.providers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;


-- Дамп структуры для таблица customs.ratio_goods_delivery
CREATE TABLE IF NOT EXISTS `ratio_goods_delivery` (
  `id_ratio` int(11) NOT NULL AUTO_INCREMENT,
  `good_id` int(11) DEFAULT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ratio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Для связи "многие-ко-многим"';

-- Дамп данных таблицы customs.ratio_goods_delivery: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ratio_goods_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratio_goods_delivery` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
