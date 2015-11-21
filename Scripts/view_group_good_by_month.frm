TYPE=VIEW
query=select year(`customs_zero`.`delivery`.`delivery_time`) AS `YEAR(delivery.delivery_time)`,month(`customs_zero`.`delivery`.`delivery_time`) AS `MONTH(delivery.delivery_time)`,`customs_zero`.`goods`.`good_volume` AS `good_volume` from `customs_zero`.`ratio_goods_delivery` join `customs_zero`.`goods` join `customs_zero`.`delivery` where ((`customs_zero`.`ratio_goods_delivery`.`GD_good_id` = `customs_zero`.`goods`.`id_good`) and (`customs_zero`.`ratio_goods_delivery`.`delivery_id` = `customs_zero`.`delivery`.`id_delivery`) and (`customs_zero`.`goods`.`good_name` = \'Good_7\')) order by year(`customs_zero`.`delivery`.`delivery_time`),month(`customs_zero`.`delivery`.`delivery_time`)
md5=f1a40e2eb3db60ba18c6d30850c08f0b
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2015-11-20 15:48:59
create-version=1
source=SELECT YEAR(delivery.delivery_time), MONTH(delivery.delivery_time), goods.good_volume  \nFROM ratio_goods_delivery, goods, delivery\nWHERE ratio_goods_delivery.GD_good_id = goods.id_good AND ratio_goods_delivery.delivery_id = delivery.id_delivery\nAND goods.good_name = \'Good_7\' #Задаём товар, по которому собираем статистику\nORDER BY YEAR(delivery.delivery_time), MONTH(delivery.delivery_time)
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select year(`customs_zero`.`delivery`.`delivery_time`) AS `YEAR(delivery.delivery_time)`,month(`customs_zero`.`delivery`.`delivery_time`) AS `MONTH(delivery.delivery_time)`,`customs_zero`.`goods`.`good_volume` AS `good_volume` from `customs_zero`.`ratio_goods_delivery` join `customs_zero`.`goods` join `customs_zero`.`delivery` where ((`customs_zero`.`ratio_goods_delivery`.`GD_good_id` = `customs_zero`.`goods`.`id_good`) and (`customs_zero`.`ratio_goods_delivery`.`delivery_id` = `customs_zero`.`delivery`.`id_delivery`) and (`customs_zero`.`goods`.`good_name` = \'Good_7\')) order by year(`customs_zero`.`delivery`.`delivery_time`),month(`customs_zero`.`delivery`.`delivery_time`)
