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

-- Дамп структуры базы данных customs_zero
CREATE DATABASE IF NOT EXISTS `customs_zero` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `customs_zero`;


-- Дамп структуры для таблица customs_zero.buyers
CREATE TABLE IF NOT EXISTS `buyers` (
  `id_buyer` int(11) NOT NULL AUTO_INCREMENT,
  `buyer_name` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Имя',
  `buyer_interests` varchar(50) NOT NULL DEFAULT '0' COMMENT 'Что покупают',
  PRIMARY KEY (`id_buyer`),
  CONSTRAINT `FK_buyers_carriers` FOREIGN KEY (`id_buyer`) REFERENCES `carriers` (`id_carrier`),
  CONSTRAINT `FK_buyers_providers` FOREIGN KEY (`id_buyer`) REFERENCES `providers` (`id_provider`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Покупатели';

-- Дамп данных таблицы customs_zero.buyers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `buyers` DISABLE KEYS */;
/*!40000 ALTER TABLE `buyers` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.carriers
CREATE TABLE IF NOT EXISTS `carriers` (
  `id_carrier` int(11) NOT NULL AUTO_INCREMENT,
  `carrier_name` varchar(50) DEFAULT NULL COMMENT 'Имя перевозчика',
  `carrier_specialization` varchar(50) DEFAULT NULL COMMENT 'Специализация',
  PRIMARY KEY (`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Перевозчики';

-- Дамп данных таблицы customs_zero.carriers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `carriers` DISABLE KEYS */;
/*!40000 ALTER TABLE `carriers` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.checkpoint
CREATE TABLE IF NOT EXISTS `checkpoint` (
  `id_checkpoint` int(11) NOT NULL AUTO_INCREMENT,
  `checkpoint_name` varchar(50) DEFAULT NULL COMMENT 'Имя ПП',
  PRIMARY KEY (`id_checkpoint`),
  CONSTRAINT `FK_checkpoint_country` FOREIGN KEY (`id_checkpoint`) REFERENCES `country` (`id_country`),
  CONSTRAINT `FK_checkpoint_delivery` FOREIGN KEY (`id_checkpoint`) REFERENCES `delivery` (`id_delivery`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Пропускной пункт';

-- Дамп данных таблицы customs_zero.checkpoint: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `checkpoint` DISABLE KEYS */;
/*!40000 ALTER TABLE `checkpoint` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.country
CREATE TABLE IF NOT EXISTS `country` (
  `id_country` int(11) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(50) DEFAULT NULL COMMENT 'Название страны',
  PRIMARY KEY (`id_country`),
  CONSTRAINT `FK_country_buyers` FOREIGN KEY (`id_country`) REFERENCES `buyers` (`id_buyer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Страна: к какой стране какой поставщик принадлежит, а так же граничащий с ней ПП';

-- Дамп данных таблицы customs_zero.country: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.delivery
CREATE TABLE IF NOT EXISTS `delivery` (
  `id_delivery` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_time` date DEFAULT NULL,
  `delivery_total_weight` int(11) DEFAULT NULL,
  `delivery_total_volume` int(11) DEFAULT NULL,
  `delivery_total_number` int(11) DEFAULT NULL,
  `deliverys_duty` int(11) DEFAULT NULL COMMENT 'Фактическая пошлина',
  PRIMARY KEY (`id_delivery`),
  CONSTRAINT `FK_delivery_ratio_goods_delivery` FOREIGN KEY (`id_delivery`) REFERENCES `ratio_goods_delivery` (`id_ratio_gd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Поставки';

-- Дамп данных таблицы customs_zero.delivery: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `delivery` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.duty
CREATE TABLE IF NOT EXISTS `duty` (
  `id_duty` int(11) NOT NULL AUTO_INCREMENT,
  `duty_default_size` int(11) NOT NULL,
  `duty_total_size` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_duty`),
  CONSTRAINT `FK_duty_ratio_duty_goods` FOREIGN KEY (`id_duty`) REFERENCES `ratio_duty_goods` (`id_ratio_dg`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Пошлины';

-- Дамп данных таблицы customs_zero.duty: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `duty` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.goods
CREATE TABLE IF NOT EXISTS `goods` (
  `id_good` int(11) NOT NULL AUTO_INCREMENT,
  `good_name` varchar(50) DEFAULT NULL COMMENT 'Название груза',
  `good_weight` int(11) DEFAULT NULL COMMENT 'Вес груза',
  `good_amount` int(11) NOT NULL COMMENT 'Кол-во товара',
  `good_volume` int(11) NOT NULL COMMENT 'Объём груза',
  PRIMARY KEY (`id_good`),
  KEY `FK_goods_differentation` (`good_volume`,`good_amount`),
  CONSTRAINT `FK_goods_ratio_duty_goods` FOREIGN KEY (`id_good`) REFERENCES `ratio_duty_goods` (`id_ratio_dg`),
  CONSTRAINT `FK_goods_ratio_goods_delivery` FOREIGN KEY (`id_good`) REFERENCES `ratio_goods_delivery` (`id_ratio_gd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Грузы';

-- Дамп данных таблицы customs_zero.goods: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `goods` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.providers
CREATE TABLE IF NOT EXISTS `providers` (
  `id_provider` int(11) NOT NULL AUTO_INCREMENT,
  `provider_name` varchar(50) DEFAULT NULL COMMENT 'Имя поставщика',
  `provider_specialization` varchar(50) DEFAULT NULL COMMENT 'Специализация поставщика',
  PRIMARY KEY (`id_provider`),
  CONSTRAINT `FK_providers_goods` FOREIGN KEY (`id_provider`) REFERENCES `goods` (`id_good`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Поставщики';

-- Дамп данных таблицы customs_zero.providers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.ratio_duty_goods
CREATE TABLE IF NOT EXISTS `ratio_duty_goods` (
  `id_ratio_dg` int(11) NOT NULL AUTO_INCREMENT,
  `duty_id` int(11) DEFAULT NULL,
  `good_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ratio_dg`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Определяет пошлину по товару';

-- Дамп данных таблицы customs_zero.ratio_duty_goods: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ratio_duty_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratio_duty_goods` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.ratio_goods_delivery
CREATE TABLE IF NOT EXISTS `ratio_goods_delivery` (
  `id_ratio_gd` int(11) NOT NULL AUTO_INCREMENT,
  `good_id` int(11) DEFAULT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ratio_gd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Для связи "многие-ко-многим"';

-- Дамп данных таблицы customs_zero.ratio_goods_delivery: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ratio_goods_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratio_goods_delivery` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
