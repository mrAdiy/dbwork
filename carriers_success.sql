delimiter //

CREATE DEFINER=`root`@`localhost` PROCEDURE `carriers_success`(IN `max_value` INT(11), IN `date_1` DATE, IN `date_2` DATE)
BEGIN

SELECT carrier, SUM(delivery_total_weight) AS DTS
FROM delivery
WHERE (DATE(delivery_time) BETWEEN date_1 AND date_2)
GROUP BY carrier
HAVING DTS>max_value
ORDER BY carrier DESC;


END//

delimiter ;
