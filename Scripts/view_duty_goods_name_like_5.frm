TYPE=VIEW
query=select `customs_zero`.`duty`.`id_duty` AS `id_duty`,`customs_zero`.`duty`.`duty_default_size` AS `duty_default_size`,`customs_zero`.`duty`.`diff_size_by_volume` AS `diff_size_by_volume`,`customs_zero`.`duty`.`diff_size_by_amount` AS `diff_size_by_amount`,`customs_zero`.`duty`.`duty_total_size` AS `duty_total_size`,`customs_zero`.`goods`.`id_good` AS `id_good`,`customs_zero`.`goods`.`good_name` AS `good_name`,`customs_zero`.`goods`.`good_weight` AS `good_weight`,`customs_zero`.`goods`.`good_amount` AS `good_amount`,`customs_zero`.`goods`.`good_volume` AS `good_volume`,`customs_zero`.`ratio_duty_goods`.`id_ratio_dg` AS `id_ratio_dg`,`customs_zero`.`ratio_duty_goods`.`duty_id` AS `duty_id`,`customs_zero`.`ratio_duty_goods`.`good_id` AS `good_id` from `customs_zero`.`duty` join `customs_zero`.`goods` join `customs_zero`.`ratio_duty_goods` where ((`customs_zero`.`goods`.`id_good` = `customs_zero`.`ratio_duty_goods`.`good_id`) and (`customs_zero`.`ratio_duty_goods`.`duty_id` = `customs_zero`.`duty`.`id_duty`) and (`customs_zero`.`goods`.`good_name` like \'%5\'))
md5=a743041f5e0add778dba829e87488952
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=2015-11-20 13:20:02
create-version=1
source=SELECT * FROM duty, goods, ratio_duty_goods\nWHERE (goods.id_good = ratio_duty_goods.good_id AND ratio_duty_goods.duty_id = duty.id_duty) AND (goods.good_name LIKE \'%5\')
client_cs_name=utf8mb4
connection_cl_name=utf8mb4_general_ci
view_body_utf8=select `customs_zero`.`duty`.`id_duty` AS `id_duty`,`customs_zero`.`duty`.`duty_default_size` AS `duty_default_size`,`customs_zero`.`duty`.`diff_size_by_volume` AS `diff_size_by_volume`,`customs_zero`.`duty`.`diff_size_by_amount` AS `diff_size_by_amount`,`customs_zero`.`duty`.`duty_total_size` AS `duty_total_size`,`customs_zero`.`goods`.`id_good` AS `id_good`,`customs_zero`.`goods`.`good_name` AS `good_name`,`customs_zero`.`goods`.`good_weight` AS `good_weight`,`customs_zero`.`goods`.`good_amount` AS `good_amount`,`customs_zero`.`goods`.`good_volume` AS `good_volume`,`customs_zero`.`ratio_duty_goods`.`id_ratio_dg` AS `id_ratio_dg`,`customs_zero`.`ratio_duty_goods`.`duty_id` AS `duty_id`,`customs_zero`.`ratio_duty_goods`.`good_id` AS `good_id` from `customs_zero`.`duty` join `customs_zero`.`goods` join `customs_zero`.`ratio_duty_goods` where ((`customs_zero`.`goods`.`id_good` = `customs_zero`.`ratio_duty_goods`.`good_id`) and (`customs_zero`.`ratio_duty_goods`.`duty_id` = `customs_zero`.`duty`.`id_duty`) and (`customs_zero`.`goods`.`good_name` like \'%5\'))
