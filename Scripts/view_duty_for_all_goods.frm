TYPE=VIEW
query=select `customs_zero`.`goods`.`good_name` AS `good_name`,sum(`customs_zero`.`duty`.`duty_total_size`) AS `SUM(duty.duty_total_size)` from `customs_zero`.`duty` join `customs_zero`.`ratio_duty_goods` join `customs_zero`.`goods` where ((`customs_zero`.`duty`.`id_duty` = `customs_zero`.`ratio_duty_goods`.`duty_id`) and (`customs_zero`.`ratio_duty_goods`.`good_id` = `customs_zero`.`goods`.`id_good`)) group by `customs_zero`.`goods`.`good_name` having (sum(`customs_zero`.`duty`.`duty_total_size`) > 30) order by sum(`customs_zero`.`duty`.`duty_total_size`)
md5=adc33fbd80fe0a6f0bd0dce36c112e61
updatable=0
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2015-11-20 13:31:27
create-version=1
source=SELECT goods.good_name, SUM(duty.duty_total_size) FROM duty, ratio_duty_goods, goods \nWHERE duty.id_duty = ratio_duty_goods.duty_id AND ratio_duty_goods.good_id = goods.id_good\nGROUP BY goods.good_name #Разбиваем по столбцу good_name и для него выводим свой рез-тат\nHAVING SUM(duty.duty_total_size)>30\nORDER BY SUM(duty.duty_total_size)
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `customs_zero`.`goods`.`good_name` AS `good_name`,sum(`customs_zero`.`duty`.`duty_total_size`) AS `SUM(duty.duty_total_size)` from `customs_zero`.`duty` join `customs_zero`.`ratio_duty_goods` join `customs_zero`.`goods` where ((`customs_zero`.`duty`.`id_duty` = `customs_zero`.`ratio_duty_goods`.`duty_id`) and (`customs_zero`.`ratio_duty_goods`.`good_id` = `customs_zero`.`goods`.`id_good`)) group by `customs_zero`.`goods`.`good_name` having (sum(`customs_zero`.`duty`.`duty_total_size`) > 30) order by sum(`customs_zero`.`duty`.`duty_total_size`)
