ALTER TABLE `duty_and_delivery`
ADD CONSTRAINT `FK_duty_and_delivery_duty` FOREIGN KEY (`DAD_duty`) REFERENCES `duty` (`id_duty`);
ALTER TABLE `duty_and_delivery`
ADD CONSTRAINT `FK_duty_and_delivery_delivery` FOREIGN KEY (`DAD_delivery`) REFERENCES `delivery` (`id_delivery`);
