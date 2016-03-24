ALTER TABLE providers AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/providers_data.txt" INTO TABLE providers fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE carriers AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/carriers_data.txt" INTO TABLE carriers fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE buyers AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/buyers_data.txt" INTO TABLE buyers fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE goods AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/goods_data.txt" INTO TABLE goods fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE delivery AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/delivery_data.txt" INTO TABLE delivery fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE duty AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/duty_data.txt" INTO TABLE duty fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE ratio_goods_delivery AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/ratio_goods_delivery.txt" INTO TABLE ratio_goods_delivery fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE ratio_duty_goods AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/ratio_duty_goods.txt" INTO TABLE ratio_duty_goods fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE country AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/country_data.txt" INTO TABLE country fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE checkpoint AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/checkpoint_data.txt" INTO TABLE checkpoint fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE `delivery` ADD COLUMN `del_status` varchar(50) NOT NULL DEFAULT 'wait' AFTER `carrier`;
