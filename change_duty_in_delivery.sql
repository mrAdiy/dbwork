delimiter //

DROP PROCEDURE IF EXISTS `change_duty_in_delivery`//
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_duty_in_delivery`(IN `changed_good_ID` INT(11), IN `addition` INT(11))

BEGIN

IF changed_good_ID IN (SELECT goods.id_good FROM goods, ratio_goods_delivery, delivery WHERE 
								(delivery.id_delivery = ratio_goods_delivery.delivery_id AND ratio_goods_delivery.GD_good_id = changed_good_ID)) THEN
			BEGIN
				UPDATE delivery SET delivery.deliverys_duty = delivery.deliverys_duty + addition;
			END;
END IF;

END//

delimiter ;
