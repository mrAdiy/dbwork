delimiter //

CREATE DEFINER=`root`@`localhost` PROCEDURE `dynamic_transit`(IN `chk_date` DATE)
BEGIN

SELECT goods.good_name, count(goods.good_name) AS number_of_goods, QUARTER(delivery.delivery_time)
FROM goods, ratio_goods_delivery, delivery
#Для начала - не забываем про связь многие-ко-многим.
WHERE goods.id_good=ratio_goods_delivery.GD_good_id AND ratio_goods_delivery.delivery_id=delivery.id_delivery
#Потом - задаём ограничения: год д.б. между указанным в параметре и годом ранее.
AND (YEAR(delivery.delivery_time)<=YEAR(chk_date) AND YEAR(delivery.delivery_time)>=(YEAR(chk_date)-1))
GROUP BY goods.good_name, QUARTER(delivery.delivery_time)
ORDER BY goods.good_name, QUARTER(delivery.delivery_time); 

END//

delimiter ;
