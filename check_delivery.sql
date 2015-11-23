delimiter //
DROP TRIGGER IF EXISTS `check_delivery`//
CREATE TRIGGER `check_delivery` AFTER DELETE ON `checkpoint` FOR EACH ROW 
BEGIN

DELETE FROM delivery WHERE delivery.id_delivery = OLD.id_checkpoint;

END//
delimiter ;
