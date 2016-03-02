ALTER TABLE duty_and_delivery AUTO_INCREMENT = 0;
SET FOREIGN_KEY_CHECKS=0;
LOAD DATA INFILE "D:/Server/mysql-5.6.26-winx64/data/customs/Data/DAD_data.txt" INTO TABLE duty_and_delivery fields terminated by ";";
SET FOREIGN_KEY_CHECKS=1;