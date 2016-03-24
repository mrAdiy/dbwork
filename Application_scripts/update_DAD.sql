delimiter //

DROP PROCEDURE IF EXISTS `update_DAD`//
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_DAD`(IN `changed_good_ID` INT(11), IN `addition_weight` INT(11)
, IN `addition_amount` INT(11), IN `addition_volume` INT(11))

BEGIN

UPDATE duty_and_delivery SET duty_and_delivery.DAD_weight = duty_and_delivery.DAD_weight + addition_weight,
duty_and_delivery.DAD_amount = duty_and_delivery.DAD_amount + addition_amount,
duty_and_delivery.DAD_volume = duty_and_delivery.DAD_volume + addition_volume
#Вложенный запрос IN (SELECT T FROM (SELECT )AS T ) - для защиты от error 1093
WHERE duty_and_delivery.DAD_delivery IN(SELECT T.id_delivery 
FROM(SELECT delivery.id_delivery FROM duty, duty_and_delivery, delivery WHERE 
(delivery.id_delivery = duty_and_delivery.DAD_delivery AND duty_and_delivery.DAD_goods_ID = changed_good_ID
AND delivery.del_status = 'wait')) AS T);

END//
 
delimiter ;
