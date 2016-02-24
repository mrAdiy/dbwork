SELECT goods.good_name, SUM(duty.duty_total_size)
FROM goods
#Сначала связываем товар с пошлиной,
INNER JOIN  ratio_duty_goods
ON goods.id_good = ratio_duty_goods.good_id
LEFT JOIN duty
ON ratio_duty_goods.duty_id = duty.id_duty
#потом связываем товар с поставкой.
INNER JOIN  ratio_goods_delivery
ON goods.id_good = ratio_goods_delivery.GD_good_id
LEFT JOIN delivery
ON ratio_goods_delivery.delivery_id = delivery.id_delivery
#Уточняем время
WHERE (DATE(delivery_time) BETWEEN '2010-01-01' AND '2015-12-30')
GROUP BY goods.good_name #Группируем по имени
HAVING SUM(duty.duty_total_size)>0
ORDER BY SUM(duty.duty_total_size) DESC
LIMIT 10; #Выводим всего 10
