delimiter //
DROP TRIGGER IF EXISTS `check_duty`//
CREATE TRIGGER `check_duty` AFTER UPDATE ON `duty` FOR EACH ROW 
BEGIN

SET @addition = NEW.duty_total_size-OLD.duty_total_size;
SET @current_good_id = (SELECT id_good FROM goods, ratio_duty_goods, duty WHERE
goods.id_good = ratio_duty_goods.good_id AND ratio_duty_goods.duty_id = duty.id_duty AND
ratio_duty_goods.duty_id = OLD.id_duty);

CALL change_duty_in_delivery(@current_good_id, @addition);

END//
delimiter ;
