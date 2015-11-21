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


-- Дамп структуры для процедура customs_zero.add_some_data
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_some_data`(IN `zero` INT(11), IN `one` INT(11))
BEGIN

SET FOREIGN_KEY_CHECKS=zero;

ALTER TABLE buyers AUTO_INCREMENT = 0;
REPLACE INTO buyers (id_buyer, buyer_name, buyer_interests) VALUES ('\N', 'Buyer_new', 'Interest_new');

ALTER TABLE carriers AUTO_INCREMENT = 0;
REPLACE INTO carriers (id_carrier, carrier_name, carrier_specialization) VALUES ('\N', 'Carrier_new', 'Specialization_new');

ALTER TABLE providers AUTO_INCREMENT = 0;
REPLACE INTO providers (id_provider, provider_name, provider_specialization) VALUES ('\N', 'Provider_new', 'Provider_specialization_new');

ALTER TABLE goods AUTO_INCREMENT = 0;
REPLACE INTO goods (id_good, good_name, good_weight, good_amount, good_volume) VALUES ('\N', 'Good_new', 1, 2, 3);

ALTER TABLE ratio_duty_goods AUTO_INCREMENT = 0;
REPLACE INTO ratio_duty_goods (id_ratio_dg, duty_id, good_id) VALUES ('\N', 100001, 100001);

ALTER TABLE duty AUTO_INCREMENT = 0;
REPLACE INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size) VALUES ('\N', 35, 1, 1, 33);

ALTER TABLE ratio_goods_delivery AUTO_INCREMENT = 0;
REPLACE INTO ratio_goods_delivery (id_ratio_gd, GD_good_id, delivery_id) VALUES ('\N', 100001, 100001);

ALTER TABLE delivery AUTO_INCREMENT = 0;
REPLACE INTO delivery (id_delivery, delivery_time, delivery_total_weight, delivery_total_volume, delivery_total_number, deliverys_duty,
byuer, provider, carrier) VALUES ('\N', '2011-01-11', 1, 2, 3, 33, 100001, 100001, 100001);

SET FOREIGN_KEY_CHECKS=one;

END//
DELIMITER ;


-- Дамп структуры для процедура customs_zero.add_update
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_update`(IN `max_id` INT(11))
BEGIN

UPDATE goods SET goods.good_weight = goods.good_weight + 1, goods.good_amount = goods.good_amount + 3 WHERE goods.id_good < max_id;

END//
DELIMITER ;


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
  `carrier_name` varchar(50) NOT NULL COMMENT 'Имя перевозчика',
  `carrier_specialization` varchar(50) NOT NULL COMMENT 'Специализация',
  PRIMARY KEY (`id_carrier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Перевозчики';

-- Дамп данных таблицы customs_zero.carriers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `carriers` DISABLE KEYS */;
/*!40000 ALTER TABLE `carriers` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.checkpoint
CREATE TABLE IF NOT EXISTS `checkpoint` (
  `id_checkpoint` int(11) NOT NULL AUTO_INCREMENT,
  `checkpoint_name` varchar(50) NOT NULL COMMENT 'Имя ПП',
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
  `country_name` varchar(50) NOT NULL COMMENT 'Название страны',
  PRIMARY KEY (`id_country`),
  CONSTRAINT `FK_country_buyers` FOREIGN KEY (`id_country`) REFERENCES `buyers` (`id_buyer`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Страна: к какой стране какой поставщик принадлежит, а так же граничащий с ней ПП';

-- Дамп данных таблицы customs_zero.country: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
/*!40000 ALTER TABLE `country` ENABLE KEYS */;


-- Дамп структуры для процедура customs_zero.delete_biggest_id_in_goods
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_biggest_id_in_goods`(IN `zero` INT(11), IN `one` INT(11))
BEGIN

SET FOREIGN_KEY_CHECKS=zero;
DELETE FROM goods ORDER BY goods.id_good DESC LIMIT 1;
SET FOREIGN_KEY_CHECKS=one;

END//
DELIMITER ;


-- Дамп структуры для процедура customs_zero.delete_unused
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_unused`()
BEGIN

DELETE FROM goods
WHERE id_good NOT IN (SELECT id_provider FROM providers);
SELECT * FROM goods LIMIT 100010;

END//
DELIMITER ;


-- Дамп структуры для таблица customs_zero.delivery
CREATE TABLE IF NOT EXISTS `delivery` (
  `id_delivery` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_time` date NOT NULL,
  `delivery_total_weight` int(11) NOT NULL,
  `delivery_total_volume` int(11) NOT NULL,
  `delivery_total_number` int(11) NOT NULL,
  `deliverys_duty` int(11) NOT NULL COMMENT 'Фактическая пошлина',
  `byuer` int(11) NOT NULL,
  `provider` int(11) NOT NULL,
  `carrier` int(11) NOT NULL,
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
  `diff_size_by_volume` int(11) NOT NULL,
  `diff_size_by_amount` int(11) NOT NULL,
  `duty_total_size` int(11) NOT NULL,
  PRIMARY KEY (`id_duty`),
  CONSTRAINT `FK_duty_ratio_duty_goods` FOREIGN KEY (`id_duty`) REFERENCES `ratio_duty_goods` (`id_ratio_dg`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Пошлины';

-- Дамп данных таблицы customs_zero.duty: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `duty` DISABLE KEYS */;
/*!40000 ALTER TABLE `duty` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.goods
CREATE TABLE IF NOT EXISTS `goods` (
  `id_good` int(11) NOT NULL AUTO_INCREMENT,
  `good_name` varchar(50) NOT NULL COMMENT 'Название груза',
  `good_weight` int(11) NOT NULL COMMENT 'Вес груза',
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
  `provider_name` varchar(50) NOT NULL COMMENT 'Имя поставщика',
  `provider_specialization` varchar(50) NOT NULL COMMENT 'Специализация поставщика',
  PRIMARY KEY (`id_provider`),
  CONSTRAINT `FK_providers_goods` FOREIGN KEY (`id_provider`) REFERENCES `goods` (`id_good`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Поставщики';

-- Дамп данных таблицы customs_zero.providers: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.ratio_duty_goods
CREATE TABLE IF NOT EXISTS `ratio_duty_goods` (
  `id_ratio_dg` int(11) NOT NULL AUTO_INCREMENT,
  `duty_id` int(11) NOT NULL,
  `good_id` int(11) NOT NULL,
  PRIMARY KEY (`id_ratio_dg`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Определяет пошлину по товару';

-- Дамп данных таблицы customs_zero.ratio_duty_goods: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ratio_duty_goods` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratio_duty_goods` ENABLE KEYS */;


-- Дамп структуры для таблица customs_zero.ratio_goods_delivery
CREATE TABLE IF NOT EXISTS `ratio_goods_delivery` (
  `id_ratio_gd` int(11) NOT NULL AUTO_INCREMENT,
  `GD_good_id` int(11) NOT NULL,
  `delivery_id` int(11) NOT NULL,
  PRIMARY KEY (`id_ratio_gd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Для связи "многие-ко-многим"';

-- Дамп данных таблицы customs_zero.ratio_goods_delivery: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ratio_goods_delivery` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratio_goods_delivery` ENABLE KEYS */;


-- Дамп структуры для представление customs_zero.view_avg_duty_total_size
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_avg_duty_total_size` (
	`AVG(duty.duty_total_size)` DECIMAL(14,4) NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_delivery_by_year_month
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_delivery_by_year_month` (
	`id_delivery` INT(11) NOT NULL,
	`delivery_time` DATE NOT NULL,
	`delivery_total_weight` INT(11) NOT NULL,
	`delivery_total_volume` INT(11) NOT NULL,
	`delivery_total_number` INT(11) NOT NULL,
	`deliverys_duty` INT(11) NOT NULL COMMENT 'Фактическая пошлина',
	`byuer` INT(11) NOT NULL,
	`provider` INT(11) NOT NULL,
	`carrier` INT(11) NOT NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_duty_for_all_goods
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_duty_for_all_goods` (
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`SUM(duty.duty_total_size)` DECIMAL(32,0) NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_duty_goods_name_like_5
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_duty_goods_name_like_5` (
	`id_duty` INT(11) NOT NULL,
	`duty_default_size` INT(11) NOT NULL,
	`diff_size_by_volume` INT(11) NOT NULL,
	`diff_size_by_amount` INT(11) NOT NULL,
	`duty_total_size` INT(11) NOT NULL,
	`id_good` INT(11) NOT NULL,
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`good_weight` INT(11) NOT NULL COMMENT 'Вес груза',
	`good_amount` INT(11) NOT NULL COMMENT 'Кол-во товара',
	`good_volume` INT(11) NOT NULL COMMENT 'Объём груза',
	`id_ratio_dg` INT(11) NOT NULL,
	`duty_id` INT(11) NOT NULL,
	`good_id` INT(11) NOT NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_duty_goods_volume_bt_55
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_duty_goods_volume_bt_55` (
	`id_duty` INT(11) NOT NULL,
	`duty_default_size` INT(11) NOT NULL,
	`diff_size_by_volume` INT(11) NOT NULL,
	`diff_size_by_amount` INT(11) NOT NULL,
	`duty_total_size` INT(11) NOT NULL,
	`id_good` INT(11) NOT NULL,
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`good_weight` INT(11) NOT NULL COMMENT 'Вес груза',
	`good_amount` INT(11) NOT NULL COMMENT 'Кол-во товара',
	`good_volume` INT(11) NOT NULL COMMENT 'Объём груза',
	`id_ratio_dg` INT(11) NOT NULL,
	`duty_id` INT(11) NOT NULL,
	`good_id` INT(11) NOT NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_from_goods_in_select
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_from_goods_in_select` (
	`id_good` INT(11) NOT NULL,
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`good_weight` INT(11) NOT NULL COMMENT 'Вес груза',
	`good_amount` INT(11) NOT NULL COMMENT 'Кол-во товара',
	`good_volume` INT(11) NOT NULL COMMENT 'Объём груза'
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_group_good_by_month
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_group_good_by_month` (
	`YEAR(delivery.delivery_time)` INT(4) NULL,
	`MONTH(delivery.delivery_time)` INT(2) NULL,
	`good_volume` INT(11) NOT NULL COMMENT 'Объём груза'
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_group_ten_by_max_duty
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_group_ten_by_max_duty` (
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`SUM(duty.duty_total_size)` DECIMAL(32,0) NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_in_10_20_and_between_5_10
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_in_10_20_and_between_5_10` (
	`id_good` INT(11) NOT NULL,
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`good_weight` INT(11) NOT NULL COMMENT 'Вес груза',
	`good_amount` INT(11) NOT NULL COMMENT 'Кол-во товара',
	`good_volume` INT(11) NOT NULL COMMENT 'Объём груза'
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_like_5_and_between_5_10
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_like_5_and_between_5_10` (
	`id_good` INT(11) NOT NULL,
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`good_weight` INT(11) NOT NULL COMMENT 'Вес груза',
	`good_amount` INT(11) NOT NULL COMMENT 'Кол-во товара',
	`good_volume` INT(11) NOT NULL COMMENT 'Объём груза'
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_like_5_and_in_3_7
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_like_5_and_in_3_7` (
	`id_good` INT(11) NOT NULL,
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`good_weight` INT(11) NOT NULL COMMENT 'Вес груза',
	`good_amount` INT(11) NOT NULL COMMENT 'Кол-во товара',
	`good_volume` INT(11) NOT NULL COMMENT 'Объём груза'
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_select_all
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_select_all` (
	`id_provider` INT(11) NOT NULL,
	`provider_name` VARCHAR(50) NOT NULL COMMENT 'Имя поставщика' COLLATE 'utf8_general_ci',
	`provider_specialization` VARCHAR(50) NOT NULL COMMENT 'Специализация поставщика' COLLATE 'utf8_general_ci',
	`id_buyer` INT(11) NOT NULL,
	`buyer_name` VARCHAR(50) NOT NULL COMMENT 'Имя' COLLATE 'utf8_general_ci',
	`buyer_interests` VARCHAR(50) NOT NULL COMMENT 'Что покупают' COLLATE 'utf8_general_ci',
	`id_carrier` INT(11) NOT NULL,
	`carrier_name` VARCHAR(50) NOT NULL COMMENT 'Имя перевозчика' COLLATE 'utf8_general_ci',
	`carrier_specialization` VARCHAR(50) NOT NULL COMMENT 'Специализация' COLLATE 'utf8_general_ci',
	`id_delivery` INT(11) NOT NULL,
	`delivery_time` DATE NOT NULL,
	`delivery_total_weight` INT(11) NOT NULL,
	`delivery_total_volume` INT(11) NOT NULL,
	`delivery_total_number` INT(11) NOT NULL,
	`deliverys_duty` INT(11) NOT NULL COMMENT 'Фактическая пошлина',
	`byuer` INT(11) NOT NULL,
	`provider` INT(11) NOT NULL,
	`carrier` INT(11) NOT NULL,
	`id_duty` INT(11) NOT NULL,
	`duty_default_size` INT(11) NOT NULL,
	`diff_size_by_volume` INT(11) NOT NULL,
	`diff_size_by_amount` INT(11) NOT NULL,
	`duty_total_size` INT(11) NOT NULL,
	`id_good` INT(11) NOT NULL,
	`good_name` VARCHAR(50) NOT NULL COMMENT 'Название груза' COLLATE 'utf8_general_ci',
	`good_weight` INT(11) NOT NULL COMMENT 'Вес груза',
	`good_amount` INT(11) NOT NULL COMMENT 'Кол-во товара',
	`good_volume` INT(11) NOT NULL COMMENT 'Объём груза',
	`id_ratio_dg` INT(11) NOT NULL,
	`duty_id` INT(11) NOT NULL,
	`good_id` INT(11) NOT NULL,
	`id_ratio_gd` INT(11) NOT NULL,
	`GD_good_id` INT(11) NOT NULL,
	`delivery_id` INT(11) NOT NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_sum_as_dts_from_duty
-- Создание временной таблицы для обработки ошибок зависимостей представлений
CREATE TABLE `view_sum_as_dts_from_duty` (
	`DTS` DECIMAL(32,0) NULL
) ENGINE=MyISAM;


-- Дамп структуры для представление customs_zero.view_avg_duty_total_size
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_avg_duty_total_size`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_avg_duty_total_size` AS SELECT AVG(duty.duty_total_size) FROM duty, goods, ratio_duty_goods
WHERE (goods.id_good = ratio_duty_goods.good_id AND ratio_duty_goods.duty_id = duty.id_duty) AND (goods.good_name LIKE '%5') ;


-- Дамп структуры для представление customs_zero.view_delivery_by_year_month
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_delivery_by_year_month`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_delivery_by_year_month` AS SELECT * FROM delivery ORDER BY YEAR(delivery_time), MONTH(delivery_time) ;


-- Дамп структуры для представление customs_zero.view_duty_for_all_goods
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_duty_for_all_goods`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_duty_for_all_goods` AS SELECT goods.good_name, SUM(duty.duty_total_size) FROM duty, ratio_duty_goods, goods 
WHERE duty.id_duty = ratio_duty_goods.duty_id AND ratio_duty_goods.good_id = goods.id_good
GROUP BY goods.good_name #Разбиваем по столбцу good_name и для него выводим свой рез-тат
HAVING SUM(duty.duty_total_size)>30
ORDER BY SUM(duty.duty_total_size) ;


-- Дамп структуры для представление customs_zero.view_duty_goods_name_like_5
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_duty_goods_name_like_5`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_duty_goods_name_like_5` AS SELECT * FROM duty, goods, ratio_duty_goods
WHERE (goods.id_good = ratio_duty_goods.good_id AND ratio_duty_goods.duty_id = duty.id_duty) AND (goods.good_name LIKE '%5') ;


-- Дамп структуры для представление customs_zero.view_duty_goods_volume_bt_55
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_duty_goods_volume_bt_55`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_duty_goods_volume_bt_55` AS SELECT * FROM duty, goods, ratio_duty_goods
WHERE (goods.id_good = ratio_duty_goods.good_id AND ratio_duty_goods.duty_id = duty.id_duty) AND (goods.good_volume>55) ;


-- Дамп структуры для представление customs_zero.view_from_goods_in_select
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_from_goods_in_select`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_from_goods_in_select` AS SELECT * FROM goods WHERE id_good IN (SELECT good_id FROM ratio_duty_goods WHERE ratio_duty_goods.good_id>55) ;


-- Дамп структуры для представление customs_zero.view_group_good_by_month
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_group_good_by_month`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_group_good_by_month` AS SELECT YEAR(delivery.delivery_time), MONTH(delivery.delivery_time), goods.good_volume  
FROM ratio_goods_delivery, goods, delivery
WHERE ratio_goods_delivery.GD_good_id = goods.id_good AND ratio_goods_delivery.delivery_id = delivery.id_delivery
AND goods.good_name = 'Good_7' #Задаём товар, по которому собираем статистику
ORDER BY YEAR(delivery.delivery_time), MONTH(delivery.delivery_time) ;


-- Дамп структуры для представление customs_zero.view_group_ten_by_max_duty
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_group_ten_by_max_duty`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_group_ten_by_max_duty` AS SELECT goods.good_name, SUM(duty.duty_total_size) FROM duty, ratio_duty_goods, goods,  delivery, ratio_goods_delivery
#Сначала связываем товар с пошлиной,
WHERE duty.id_duty = ratio_duty_goods.duty_id AND ratio_duty_goods.good_id = goods.id_good
#потом - товар с поставкой.
AND ratio_goods_delivery.GD_good_id = goods.id_good AND ratio_goods_delivery.delivery_id = delivery.id_delivery
#Задаём время.
AND (DATE(delivery_time) BETWEEN '2010-01-01' AND '2015-12-30')
#ЗАГЛУШКА!!! Иначе оооочень долго
AND ratio_goods_delivery.id_ratio_gd < 200
GROUP BY goods.good_name #Группируем по имени
HAVING SUM(duty.duty_total_size)>0
ORDER BY SUM(duty.duty_total_size) DESC
LIMIT 10 ;


-- Дамп структуры для представление customs_zero.view_in_10_20_and_between_5_10
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_in_10_20_and_between_5_10`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_in_10_20_and_between_5_10` AS SELECT * FROM goods WHERE goods.good_volume IN(10, 20) AND goods.good_weight BETWEEN 5 AND 10 ;


-- Дамп структуры для представление customs_zero.view_like_5_and_between_5_10
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_like_5_and_between_5_10`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_like_5_and_between_5_10` AS SELECT * FROM goods WHERE goods.good_name LIKE '%5' AND goods.good_weight BETWEEN 5 AND 10 ;


-- Дамп структуры для представление customs_zero.view_like_5_and_in_3_7
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_like_5_and_in_3_7`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_like_5_and_in_3_7` AS SELECT * FROM goods WHERE goods.good_name LIKE '%5' AND goods.good_weight IN (3, 7) ;


-- Дамп структуры для представление customs_zero.view_select_all
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_select_all`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_select_all` AS SELECT * FROM providers, buyers, carriers, delivery, duty, goods, ratio_duty_goods, ratio_goods_delivery ;


-- Дамп структуры для представление customs_zero.view_sum_as_dts_from_duty
-- Удаление временной таблицы и создание окончательной структуры представления
DROP TABLE IF EXISTS `view_sum_as_dts_from_duty`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `view_sum_as_dts_from_duty` AS SELECT SUM(duty_total_size) AS DTS FROM duty ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
