TYPE=VIEW
query=select `customs_zero`.`goods`.`good_name` AS `good_name`,sum(`customs_zero`.`duty`.`duty_total_size`) AS `SUM(duty.duty_total_size)` from `customs_zero`.`duty` join `customs_zero`.`ratio_duty_goods` join `customs_zero`.`goods` join `customs_zero`.`delivery` join `customs_zero`.`ratio_goods_delivery` where ((`customs_zero`.`duty`.`id_duty` = `customs_zero`.`ratio_duty_goods`.`duty_id`) and (`customs_zero`.`ratio_duty_goods`.`good_id` = `customs_zero`.`goods`.`id_good`) and (`customs_zero`.`ratio_goods_delivery`.`GD_good_id` = `customs_zero`.`goods`.`id_good`) and (`customs_zero`.`ratio_goods_delivery`.`delivery_id` = `customs_zero`.`delivery`.`id_delivery`) and (cast(`customs_zero`.`delivery`.`delivery_time` as date) between \'2010-01-01\' and \'2015-12-30\') and (`customs_zero`.`ratio_goods_delivery`.`id_ratio_gd` < 200)) group by `customs_zero`.`goods`.`good_name` having (sum(`customs_zero`.`duty`.`duty_total_size`) > 0) order by sum(`customs_zero`.`duty`.`duty_total_size`) desc limit 10
md5=d89e2feacebebfc36e27e47845c1d699
updatable=0
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2015-11-20 15:48:12
create-version=1
source=SELECT goods.good_name, SUM(duty.duty_total_size) FROM duty, ratio_duty_goods, goods,  delivery, ratio_goods_delivery\n#Сначала связываем товар с пошлиной,\nWHERE duty.id_duty = ratio_duty_goods.duty_id AND ratio_duty_goods.good_id = goods.id_good\n#потом - товар с поставкой.\nAND ratio_goods_delivery.GD_good_id = goods.id_good AND ratio_goods_delivery.delivery_id = delivery.id_delivery\n#Задаём время.\nAND (DATE(delivery_time) BETWEEN \'2010-01-01\' AND \'2015-12-30\')\n#ЗАГЛУШКА!!! Иначе оооочень долго\nAND ratio_goods_delivery.id_ratio_gd < 200\nGROUP BY goods.good_name #Группируем по имени\nHAVING SUM(duty.duty_total_size)>0\nORDER BY SUM(duty.duty_total_size) DESC\nLIMIT 10
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `customs_zero`.`goods`.`good_name` AS `good_name`,sum(`customs_zero`.`duty`.`duty_total_size`) AS `SUM(duty.duty_total_size)` from `customs_zero`.`duty` join `customs_zero`.`ratio_duty_goods` join `customs_zero`.`goods` join `customs_zero`.`delivery` join `customs_zero`.`ratio_goods_delivery` where ((`customs_zero`.`duty`.`id_duty` = `customs_zero`.`ratio_duty_goods`.`duty_id`) and (`customs_zero`.`ratio_duty_goods`.`good_id` = `customs_zero`.`goods`.`id_good`) and (`customs_zero`.`ratio_goods_delivery`.`GD_good_id` = `customs_zero`.`goods`.`id_good`) and (`customs_zero`.`ratio_goods_delivery`.`delivery_id` = `customs_zero`.`delivery`.`id_delivery`) and (cast(`customs_zero`.`delivery`.`delivery_time` as date) between \'2010-01-01\' and \'2015-12-30\') and (`customs_zero`.`ratio_goods_delivery`.`id_ratio_gd` < 200)) group by `customs_zero`.`goods`.`good_name` having (sum(`customs_zero`.`duty`.`duty_total_size`) > 0) order by sum(`customs_zero`.`duty`.`duty_total_size`) desc limit 10
