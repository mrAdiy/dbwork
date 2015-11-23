delimiter //
DROP TRIGGER IF EXISTS `upd_amount_in_delivery`//
CREATE TRIGGER `upd_amount_in_delivery` AFTER INSERT ON `ratio_goods_delivery` FOR EACH ROW 
BEGIN

SET @current_good_amount = (SELECT good_amount FROM goods WHERE goods.id_good = NEW.GD_good_id);

IF NEW.delivery_id IN (SELECT id_delivery FROM delivery, ratio_goods_delivery, goods WHERE
goods.id_good = ratio_goods_delivery.GD_good_id AND ratio_goods_delivery.delivery_id = delivery.id_delivery
AND goods.id_good = NEW.GD_good_id AND delivery.id_delivery = NEW.delivery_id GROUP BY delivery.id_delivery)
THEN
	BEGIN
	UPDATE delivery SET delivery.delivery_total_number = delivery.delivery_total_number + @current_good_amount
	WHERE delivery.id_delivery = NEW.delivery_id;
	END;
END IF;

END//
delimiter ;
