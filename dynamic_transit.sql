delimiter //
DROP PROCEDURE IF EXISTS `dynamic_transit`//
CREATE DEFINER=`root`@`localhost` PROCEDURE `dynamic_transit`(IN `chk_date` DATE)
BEGIN

SELECT T1.good_name, T1.Checked_year, T1.number_of_goods, T1.Checked_quarter,
T2.good_name, T2.Previous_year, T2.number_of_goods, T2.Checked_quarter
FROM

(SELECT goods.good_name, count(goods.good_name) AS number_of_goods, YEAR(delivery.delivery_time) AS Checked_year, QUARTER(delivery.delivery_time) AS Checked_quarter
FROM goods, ratio_goods_delivery, delivery
#Для начала - не забываем про связь многие-ко-многим.
WHERE goods.id_good=ratio_goods_delivery.GD_good_id AND ratio_goods_delivery.delivery_id=delivery.id_delivery
#Потом - задаём ограничения: год д.б. между указанным в параметре и годом ранее.
AND (YEAR(delivery.delivery_time)<=YEAR(chk_date) AND YEAR(delivery.delivery_time)>(YEAR(chk_date)-1))
GROUP BY goods.good_name, QUARTER(delivery.delivery_time)
ORDER BY goods.good_name, QUARTER(delivery.delivery_time))T1,

(SELECT goods.good_name, count(goods.good_name) AS number_of_goods, YEAR(delivery.delivery_time) AS Previous_year, QUARTER(delivery.delivery_time) AS Checked_quarter
FROM goods, ratio_goods_delivery, delivery
#Для начала - не забываем про связь многие-ко-многим.
WHERE goods.id_good=ratio_goods_delivery.GD_good_id AND ratio_goods_delivery.delivery_id=delivery.id_delivery
#Потом - задаём ограничения: год д.б. между указанным в параметре и годом ранее.
AND (YEAR(delivery.delivery_time)<=YEAR(chk_date)-1 AND YEAR(delivery.delivery_time)>(YEAR(chk_date)-2))
GROUP BY goods.good_name, QUARTER(delivery.delivery_time)
ORDER BY goods.good_name, QUARTER(delivery.delivery_time))T2

WHERE T1.good_name=T2.good_name AND T1.Checked_quarter=T2.Checked_quarter; 

END//

delimiter ;
