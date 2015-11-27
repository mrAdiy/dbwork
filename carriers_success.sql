delimiter //

DROP PROCEDURE IF EXISTS `carriers_success`//

CREATE DEFINER=`root`@`localhost` PROCEDURE `carriers_success`(IN `max_value` INT(11), IN `date_1` DATE, IN `date_2` DATE)
BEGIN

SET @date_diff = (SELECT DATEDIFF(date_1, date_2))-1; #Сначала мЕньшая дата, потом большая - нам нужно отр. число
SET @date_3 = DATE_ADD(date_1, INTERVAL @date_diff DAY);
SET @date_4 = DATE_ADD(date_1, INTERVAL -1 DAY);

SELECT date_1, date_2, T1.*, @date_3, @date_4, T2.*, T1.DTS_1-T2.DTS_2 AS success FROM 

(SELECT carrier, SUM(delivery_total_weight) AS DTS_1
FROM delivery
WHERE (DATE(delivery_time) BETWEEN date_1 AND date_2)
GROUP BY carrier
ORDER BY carrier DESC)T1,

(SELECT carrier, SUM(delivery_total_weight) AS DTS_2
FROM delivery
WHERE (DATE(delivery_time) BETWEEN @date_3 AND @date_4)
GROUP BY carrier
ORDER BY carrier DESC)T2

WHERE T1.carrier=T2.carrier
HAVING success>=max_value
ORDER BY T1.carrier DESC;

END//

delimiter ;
