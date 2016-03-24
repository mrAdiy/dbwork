delimiter //

DROP PROCEDURE IF EXISTS `change_amount_in_delivery`//
CREATE DEFINER=`root`@`localhost` PROCEDURE `change_amount_in_delivery`(IN `changed_good_ID` INT(11), IN `addition` INT(11))

BEGIN

UPDATE delivery SET delivery.delivery_total_amount = delivery.delivery_total_amount + addition
#Вложенный запрос IN (SELECT T FROM (SELECT )AS T ) - для защиты от error 1093
WHERE delivery.del_status = 'wait' AND delivery.id_delivery IN(SELECT T.id_delivery 
FROM(SELECT delivery.id_delivery FROM goods, ratio_goods_delivery, delivery WHERE 
(delivery.id_delivery = ratio_goods_delivery.delivery_id AND ratio_goods_delivery.GD_good_id = changed_good_ID)) AS T);

END//
 
delimiter ;
