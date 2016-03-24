SELECT duty_and_delivery.*, duty.duty_total_size
FROM duty_and_delivery, duty WHERE duty_and_delivery.DAD_duty = duty.id_duty;