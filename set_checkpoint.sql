delimiter //
DROP TRIGGER IF EXISTS `set_checkpoint`//
CREATE TRIGGER `set_checkpoint` BEFORE INSERT ON `checkpoint` FOR EACH ROW 
BEGIN

IF (NEW.id_checkpoint IS NULL) THEN
	BEGIN
	SET NEW.id_checkpoint = '\N';
	END;
	
END IF;

END//
delimiter ;
