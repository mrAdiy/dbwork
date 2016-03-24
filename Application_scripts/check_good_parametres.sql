delimiter //
DROP TRIGGER IF EXISTS `check_good_parametres`//
CREATE TRIGGER `check_good_parametres` AFTER UPDATE ON `goods` FOR EACH ROW
BEGIN

SET @addition_weight = NEW.good_weight-OLD.good_weight;
SET @addition_amount = NEW.good_amount-OLD.good_amount;
SET @addition_volume = NEW.good_volume-OLD.good_volume;

SET @current_good_id = (SELECT id_good FROM goods, ratio_goods_delivery, delivery WHERE
goods.id_good = ratio_goods_delivery.GD_good_id AND ratio_goods_delivery.delivery_id = delivery.id_delivery AND
ratio_goods_delivery.GD_good_id = OLD.id_good);

CALL change_weight_in_delivery(@current_good_id, @addition_weight);
CALL change_amount_in_delivery(@current_good_id, @addition_amount);
CALL change_volume_in_delivery(@current_good_id, @addition_volume);

END//
delimiter ;
