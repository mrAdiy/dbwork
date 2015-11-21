SELECT goods.good_name, SUM(duty.duty_total_size) FROM duty, ratio_duty_goods, goods,  delivery, ratio_goods_delivery
#Сначала связываем товар с пошлиной,
WHERE duty.id_duty = ratio_duty_goods.duty_id AND ratio_duty_goods.good_id = goods.id_good
#потом - товар с поставкой.
AND ratio_goods_delivery.GD_good_id = goods.id_good AND ratio_goods_delivery.delivery_id = delivery.id_delivery
#Задаём время.
AND (DATE(delivery_time) BETWEEN '2010-01-01' AND '2015-12-30')
#ЗАГЛУШКА!!! Иначе оооочень долго
AND ratio_goods_delivery.id_ratio_gd < 200
GROUP BY goods.good_name #Группируем по имени
HAVING SUM(duty.duty_total_size)>0
ORDER BY SUM(duty.duty_total_size) DESC
LIMIT 10; #Выводим всего 10