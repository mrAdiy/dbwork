delimiter //
DROP TRIGGER IF EXISTS `upd_amount_in_delivery`//
CREATE TRIGGER `upd_amount_in_delivery` BEFORE INSERT ON `ratio_goods_delivery` FOR EACH ROW 
BEGIN

SET @addition = NEW.good_amount;

UPDATE delivery SET delivery.delivery_total_number = delivery.delivery_total_number + @addition
WHERE delivery.id_delivery = NEW.delivery_id;

END//
delimiter ;
