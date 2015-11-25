#SET AUTOCOMMIT=0;
#SET FOREIGN_KEY_CHECKS = 0;
/*
#Пример транзакции
START TRANSACTION;
DELETE FROM duty WHERE id_duty = 100000;
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100000, 37, 1, 1, 35);
COMMIT;
*/

/*
#Пример READ UNCOMMITTED
SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SHOW VARIABLES LIKE '%tx_isolation%';
START TRANSACTION;
SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100001, 43, 1, 1, 41);
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100002, 43, 1, 1, 41);
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (ololo, 43, 1, 1, 41);
#Error 1054: unknown column
*/


#Пример READ COMMITTED
/*
#T1:
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100001, 43, 1, 1, 41);
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100002, 43, 1, 1, 41);
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (ololo, 43, 1, 1, 41);
#Error 1054: unknown column
*/
#SELECT * FROM duty WHERE id_duty >=100000;

#Пример REPEATABLE READ
#SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
/*
START TRANSACTION;
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100001, 43, 1, 1, 41);
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100002, 43, 1, 1, 41);
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (ololo, 43, 1, 1, 41);
#Error 1054: unknown column
*/
#SELECT * FROM duty WHERE id_duty >=100000;

#Пример SERIALAZABLE
#SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;
/*
START TRANSACTION;
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100001, 43, 1, 1, 41);
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (100002, 43, 1, 1, 41);
INSERT INTO duty (id_duty, duty_default_size, diff_size_by_volume, diff_size_by_amount, duty_total_size)
VALUES (ololo, 43, 1, 1, 41);
#Error 1054: unknown column
*/
#SELECT * FROM duty WHERE id_duty >=100000;
#ROLLBACK;