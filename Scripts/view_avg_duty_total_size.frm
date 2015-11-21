TYPE=VIEW
query=select avg(`customs_zero`.`duty`.`duty_total_size`) AS `AVG(duty.duty_total_size)` from `customs_zero`.`duty` join `customs_zero`.`goods` join `customs_zero`.`ratio_duty_goods` where ((`customs_zero`.`goods`.`id_good` = `customs_zero`.`ratio_duty_goods`.`good_id`) and (`customs_zero`.`ratio_duty_goods`.`duty_id` = `customs_zero`.`duty`.`id_duty`) and (`customs_zero`.`goods`.`good_name` like \'%5\'))
md5=9bad0e2e39c3081da052c5124c49b5e5
updatable=0
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2015-11-20 13:10:06
create-version=1
source=SELECT AVG(duty.duty_total_size) FROM duty, goods, ratio_duty_goods\nWHERE (goods.id_good = ratio_duty_goods.good_id AND ratio_duty_goods.duty_id = duty.id_duty) AND (goods.good_name LIKE \'%5\')
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select avg(`customs_zero`.`duty`.`duty_total_size`) AS `AVG(duty.duty_total_size)` from `customs_zero`.`duty` join `customs_zero`.`goods` join `customs_zero`.`ratio_duty_goods` where ((`customs_zero`.`goods`.`id_good` = `customs_zero`.`ratio_duty_goods`.`good_id`) and (`customs_zero`.`ratio_duty_goods`.`duty_id` = `customs_zero`.`duty`.`id_duty`) and (`customs_zero`.`goods`.`good_name` like \'%5\'))
