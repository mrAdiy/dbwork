SELECT YEAR(delivery.delivery_time), MONTH(delivery.delivery_time), goods.good_volume  
FROM ratio_goods_delivery, goods, delivery
WHERE ratio_goods_delivery.GD_good_id = goods.id_good AND ratio_goods_delivery.delivery_id = delivery.id_delivery
AND goods.good_name = 'Good_7' #Задаём товар, по которому собираем статистику
ORDER BY YEAR(delivery.delivery_time), MONTH(delivery.delivery_time);