ALTER TABLE `delivery` ADD COLUMN `byuer` INT(11) NOT NULL AFTER `deliverys_duty`;
ALTER TABLE `delivery` ADD COLUMN `provider` INT(11) NOT NULL AFTER `byuer`;
ALTER TABLE `delivery` ADD COLUMN `carrier` INT(11) NOT NULL AFTER `provider`;
ALTER TABLE `duty` ADD COLUMN `diff_size_by_volume` INT(11) NOT NULL AFTER `duty_default_size`;
ALTER TABLE `duty` ADD COLUMN `diff_size_by_amount` INT(11) NOT NULL AFTER `diff_size_by_volume`;
