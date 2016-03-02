SELECT duty_and_delivery.DAD_goods_name, SUM(duty.duty_total_size) FROM duty, duty_and_delivery, delivery
#Связываем поставку с пошлиной.
WHERE duty.id_duty = duty_and_delivery.DAD_duty AND  duty_and_delivery.DAD_delivery = delivery.id_delivery 
#Задаём время.
AND (DATE(delivery_time) BETWEEN '2010-01-01' AND '2015-12-30')
GROUP BY duty_and_delivery.DAD_goods_name #Группируем по имени
HAVING SUM(duty.duty_total_size)>0
ORDER BY SUM(duty.duty_total_size) DESC
LIMIT 10; #Выводим всего 10
